module Shadow
    exposing
        ( Shadow
        , default
        , inset
        , spreadRadius
        , blurRadius
        , offset
        , standard
        , plain
        , boxShadowToCouple
        )

{-| Shadow contains everything about boxShadow.


# Types

@docs Shadow


# Default box shadow

@docs default


# Shadow modifiers

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
import Elegant.Setters exposing (..)
import Elegant.Helpers as Helpers


{-| The Shadow record contains everything about box shadow.
You probably won't use it as is, but instead using `Elegant.boxShadow`
which automatically generate an empty `Shadow` record. You
can then use modifiers. I.E.

    Elegant.boxShadow
        [ Shadow.inset True
        , Shadow.spreadRadius (px 30)
        ]

-}
type alias Shadow =
    { inset : Bool
    , spreadRadius : Maybe SizeUnit
    , blurRadius : Maybe SizeUnit
    , color : Maybe Color
    , offset : ( SizeUnit, SizeUnit )
    }


{-| Generate an empty `Shadow` record, with every field equal to Nothing except inset (to `False`) and offset (to `( 0, 0 )`).
You are free to use it as you wish, but it is instanciated automatically by `Elegant.boxShadow`.
-}
default : Shadow
default =
    Shadow False Nothing Nothing Nothing ( Px 0, Px 0 )


{-| Set the inset of the Shadow.
-}
inset : Bool -> Modifier Shadow
inset =
    setInset


{-| Set the spreadRadius of the Shadow.
-}
spreadRadius : SizeUnit -> Modifier Shadow
spreadRadius =
    setSpreadRadius << Just


{-| Set the blurRadius of the Shadow.
-}
blurRadius : SizeUnit -> Modifier Shadow
blurRadius =
    setBlurRadius << Just


{-| Set the offset of the Shadow.
-}
offset : ( SizeUnit, SizeUnit ) -> Modifier Shadow
offset =
    setOffset


{-| Defines a standard boxShadow.
-}
standard : SizeUnit -> Color -> ( SizeUnit, SizeUnit ) -> Modifier Shadow
standard size color offset =
    blurRadius size
        >> setColor (Just color)
        >> setOffset offset


{-| Creates a plain boxShadow.
-}
plain : ( SizeUnit, SizeUnit ) -> Color -> Modifier Shadow
plain offset color =
    setOffset offset
        >> setColor (Just color)


{-| Compiles a `Shadow` record to the corresponding CSS tuple.
Compiles only parts which are defined, ignoring `Nothing` fields.
-}
boxShadowToCouple : Shadow -> ( String, String )
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
    Maybe.map Color.Convert.colorToCssRgba
        >> Maybe.map List.singleton
        >> Maybe.withDefault []


insetToStringList : Bool -> List String
insetToStringList inset =
    if inset then
        [ "inset" ]
    else
        []


boxShadowToString : Shadow -> String
boxShadowToString { inset, offset, spreadRadius, color, blurRadius } =
    ([ offsetToStringList offset
     , blurAndSpreadRadiusToStringList blurRadius spreadRadius
     , maybeColorToStringList color
     , insetToStringList inset
     ]
        |> List.concat
        |> String.join " "
    )
