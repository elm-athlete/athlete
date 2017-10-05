module Border exposing (..)

import Color exposing (Color)
import Shared exposing (..)
import Setters exposing (..)
import Surrounded exposing (Surrounded)


type alias Border =
    { color : Maybe Color
    , width : Maybe SizeUnit
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



-- Internals


borderStyleToString : BorderStyle -> String
borderStyleToString val =
    case val of
        BorderStyleSolid ->
            "solid"

        BorderStyleDashed ->
            "dashed"
