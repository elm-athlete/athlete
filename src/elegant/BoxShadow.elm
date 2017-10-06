module BoxShadow
    exposing
        ( BoxShadow
        , default
        , inset
        , spreadRadius
        , blurRadius
        , offset
        , standard
        , plain
        , boxShadowToCouple
        )

{-| BoxShadow contains everything about boxShadow.


# Types

@docs BoxShadow


# Default box shadow

@docs default


# BoxShadow modifiers

@docs inset
@docs blurRadius
@docs spreadRadius
@docs offset
@docs standard
@docs plain


# Compilation

@docs boxShadowToCouple

-}

import Color exposing (Color)
import Color.Convert
import Helpers.Shared exposing (..)
import Helpers.Setters exposing (..)
import Elegant.Helpers as Helpers


{-| The BoxShadow record contains everything about box shadow.
You probably won't use it as is, but instead using `Elegant.boxShadow`
which automatically generate an empty `BoxShadow` record. You
can then use modifiers. I.E.

    Elegant.boxShadow
        [ BoxShadow.inset True
        , BoxShadow.spreadRadius (px 30)
        ]

-}
type alias BoxShadow =
    { inset : Bool
    , spreadRadius : Maybe SizeUnit
    , blurRadius : Maybe SizeUnit
    , color : Maybe Color
    , offset : ( SizeUnit, SizeUnit )
    }


{-| Generate an empty `BoxShadow` record, with every field equal to Nothing except inset (to `False`) and offset (to `( 0, 0 )`).
You are free to use it as you wish, but it is instanciated automatically by `Elegant.boxShadow`.
-}
default : BoxShadow
default =
    BoxShadow False Nothing Nothing Nothing ( Px 0, Px 0 )


{-| Set the inset of the BoxShadow.
-}
inset : Bool -> Modifier BoxShadow
inset =
    setInset


{-| Set the spreadRadius of the BoxShadow.
-}
spreadRadius : SizeUnit -> Modifier BoxShadow
spreadRadius =
    setSpreadRadius << Just


{-| Set the blurRadius of the BoxShadow.
-}
blurRadius : SizeUnit -> Modifier BoxShadow
blurRadius =
    setBlurRadius << Just


{-| Set the offset of the BoxShadow.
-}
offset : ( SizeUnit, SizeUnit ) -> Modifier BoxShadow
offset =
    setOffset


{-| Defines a standard boxShadow.
-}
standard : SizeUnit -> Color -> ( SizeUnit, SizeUnit ) -> Modifier BoxShadow
standard size color offset =
    blurRadius size
        >> setColor (Just color)
        >> setOffset offset


{-| Creates a plain boxShadow.
-}
plain : ( SizeUnit, SizeUnit ) -> Color -> Modifier BoxShadow
plain offset color =
    setOffset offset
        >> setColor (Just color)


{-| Compiles a `BoxShadow` record to the corresponding CSS tuple.
Compiles only parts which are defined, ignoring `Nothing` fields.
-}
boxShadowToCouple : BoxShadow -> ( String, String )
boxShadowToCouple boxShadow =
    ( "box-shadow", boxShadowToString boxShadow )



-- Internals


offsetToStringList : ( SizeUnit, SizeUnit ) -> List String
offsetToStringList ( x, y ) =
    [ x, y ]
        |> List.map sizeUnitToString


blurAndSpreadRadiusToStringList : Maybe SizeUnit -> Maybe SizeUnit -> List String
blurAndSpreadRadiusToStringList blurRadius spreadRadius =
    [ blurRadius
    , spreadRadius
    ]
        |> List.concatMap (Helpers.emptyListOrApply sizeUnitToString)


maybeColorToStringList : Maybe Color -> List String
maybeColorToStringList =
    Maybe.map Color.Convert.colorToCssRgb
        >> Maybe.map List.singleton
        >> Maybe.withDefault []


insetToStringList : Bool -> List String
insetToStringList inset =
    if inset then
        [ "inset" ]
    else
        []


boxShadowToString : BoxShadow -> String
boxShadowToString { inset, offset, spreadRadius, color, blurRadius } =
    [ offsetToStringList offset
    , blurAndSpreadRadiusToStringList blurRadius spreadRadius
    , maybeColorToStringList color
    , insetToStringList inset
    ]
        |> List.concat
        |> String.join " "
