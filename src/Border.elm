module Border exposing (..)

import Color exposing (Color)
import Shared exposing (..)
import Setters exposing (..)
import Surrounded exposing (Surrounded)


type alias Border =
    { color : Maybe Color
    , thickness : Maybe SizeUnit
    , style : Maybe BorderStyle
    }


default : Border
default =
    Border Nothing Nothing Nothing


type BorderStyle
    = BorderStyleSolid
    | BorderStyleDashed


solid : Modifier Border
solid =
    setStyle <| Just BorderStyleSolid


dashed : Modifier Border
dashed =
    setStyle <| Just BorderStyleDashed


thickness : SizeUnit -> Modifier Border
thickness =
    setThickness << Just


top : Modifiers Border -> Modifier (Surrounded Border)
top =
    Surrounded.top default


bottom : Modifiers Border -> Modifier (Surrounded Border)
bottom =
    Surrounded.bottom default


left : Modifiers Border -> Modifier (Surrounded Border)
left =
    Surrounded.left default


right : Modifiers Border -> Modifier (Surrounded Border)
right =
    Surrounded.right default


horizontal : Modifiers Border -> Modifier (Surrounded Border)
horizontal =
    Surrounded.horizontal default


vertical : Modifiers Border -> Modifier (Surrounded Border)
vertical =
    Surrounded.vertical default


all : Modifiers Border -> Modifier (Surrounded Border)
all =
    Surrounded.all default


borderToCouples : Surrounded Border -> List ( String, String )
borderToCouples =
    Surrounded.surroundedToCouples "border" borderSideToCouples



-- Internals


borderSideToCouples : Border -> List ( String, String )
borderSideToCouples border =
    [ unwrapToCouple .thickness thicknessToCouple
    , unwrapToCouple .style styleToCouple
    , unwrapToCouple .color colorToCouple
    ]
        |> List.concatMap (callOn border)


thicknessToCouple : SizeUnit -> ( String, String )
thicknessToCouple value =
    ( "width", sizeUnitToString value )


styleToCouple : BorderStyle -> ( String, String )
styleToCouple style =
    ( "style", styleToString style )


styleToString : BorderStyle -> String
styleToString val =
    case val of
        BorderStyleSolid ->
            "solid"

        BorderStyleDashed ->
            "dashed"
