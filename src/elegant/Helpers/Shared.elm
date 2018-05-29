module Helpers.Shared exposing (..)

{-| -}

import Color exposing (Color)
import Color.Convert
import Function
import Maybe.Extra
import ParseInt


parseInt : String -> Int
parseInt =
    ParseInt.parseInt >> Result.withDefault 0


parseColor : String -> Color
parseColor =
    Color.Convert.hexToColor >> Result.withDefault Color.white


unwrapEmptyList : (a -> List b) -> Maybe a -> List b
unwrapEmptyList =
    Maybe.Extra.unwrap []


unwrapMaybeAttribute : (a -> b) -> Maybe a -> List b
unwrapMaybeAttribute fun =
    Maybe.Extra.unwrap [] (fun >> List.singleton)


type SizeUnit
    = Px Int
    | Pt Int
    | Percent Float
    | Vh Float
    | Vw Float
    | Em Float
    | Rem Float


type Auto
    = Auto


{-| Represents an angle. Can be either radiant or degree.
-}
type Angle
    = Rad Radiant
    | Deg Degree


{-| Represents a radiant.
-}
type alias Radiant =
    Float


{-| Represents a degree.
-}
type alias Degree =
    Float


{-| Generates an angle in radiant from Float.
-}
rad : Float -> Angle
rad =
    Rad


{-| Generates an angle in degree from Float.
-}
degree : Float -> Angle
degree =
    Deg


concatNumberWithString : number -> String -> String
concatNumberWithString number str =
    -- TODO : (toString number) ++ str
    str


angleToString : Angle -> String
angleToString angle =
    case angle of
        Rad a ->
            concatNumberWithString a "rad"

        Deg a ->
            concatNumberWithString a "deg"


sizeUnitToString : SizeUnit -> String
sizeUnitToString val =
    case val of
        Px x ->
            concatNumberWithString x "px"

        Pt x ->
            concatNumberWithString x "pt"

        Percent x ->
            concatNumberWithString x "%"

        Vh x ->
            concatNumberWithString x "vh"

        Vw x ->
            concatNumberWithString x "vw"

        Em x ->
            concatNumberWithString x "em"

        Rem x ->
            concatNumberWithString x "rem"


sizeUnitCoupleToString : ( SizeUnit, SizeUnit ) -> String
sizeUnitCoupleToString ( x, y ) =
    [ x, y ]
        |> List.map sizeUnitToString
        |> String.join " "


modifiedElementOrNothing : a -> List (a -> a) -> Maybe a
modifiedElementOrNothing default modifiers =
    if List.isEmpty modifiers then
        Nothing
    else
        default
            |> Function.compose modifiers
            |> Just


keepJustValues : List ( String, Maybe a ) -> List ( String, a )
keepJustValues =
    List.concatMap keepJustValue


keepJustValue : ( String, Maybe a ) -> List ( String, a )
keepJustValue ( property, value ) =
    case value of
        Nothing ->
            []

        Just val ->
            [ ( property, val ) ]



-- TODO move in Function


call : (a -> b) -> a -> b
call fun =
    fun


callOn : a -> (a -> b) -> b
callOn var fun =
    fun var


colorToCouple : Color -> ( String, String )
colorToCouple color =
    ( "color", Color.Convert.colorToCssRgba color )


unwrapToCouple : (a -> Maybe b) -> (b -> ( String, String )) -> a -> List ( String, String )
unwrapToCouple getter function =
    getter
        >> Maybe.map function
        >> Maybe.map List.singleton
        >> Maybe.withDefault []


unwrapToCouples : (a -> Maybe b) -> (b -> List ( String, String )) -> a -> List ( String, String )
unwrapToCouples getter function =
    getter
        >> Maybe.map function
        >> Maybe.withDefault []


getModifyAndSet : (b -> Maybe a) -> (b -> Maybe a -> c) -> a -> List (a -> a) -> b -> c
getModifyAndSet getter setterIn default modifiers record =
    record
        |> getter
        |> Maybe.withDefault default
        |> Function.compose modifiers
        |> Just
        |> setterIn record


modifiersFrom : a -> List (b -> a)
modifiersFrom val =
    [ \value -> val ]


setMaybeValue : (Maybe a -> b) -> a -> b
setMaybeValue setter =
    Just >> setter
