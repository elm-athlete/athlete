module Shared exposing (..)

{-| -}

import Function


type SizeUnit
    = Px Int
    | Pt Int
    | Percent Float
    | Vh Float
    | Em Float
    | Rem Float


concatNumberWithString : number -> String -> String
concatNumberWithString number str =
    (number |> toString) ++ str


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

        Em x ->
            concatNumberWithString x "em"

        Rem x ->
            concatNumberWithString x "rem"


type alias Modifier a =
    a -> a


type alias Modifiers a =
    List (Modifier a)


unwrapToCouple : (a -> Maybe b) -> (b -> ( String, String )) -> a -> List ( String, String )
unwrapToCouple getter function aMaybe =
    aMaybe
        |> getter
        |> Maybe.map function
        |> Maybe.map List.singleton
        |> Maybe.withDefault []


unwrapToCouples : (a -> Maybe b) -> (b -> List ( String, String )) -> a -> List ( String, String )
unwrapToCouples getter function aMaybe =
    aMaybe
        |> getter
        |> Maybe.map function
        |> Maybe.withDefault []


getModifyAndSet : (b -> Maybe a) -> (b -> Maybe a -> c) -> a -> List (a -> a) -> b -> c
getModifyAndSet getter setterIn default modifiers record =
    record
        |> getter
        |> Maybe.withDefault default
        |> Function.compose modifiers
        |> Just
        |> setterIn record
