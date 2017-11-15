module Main exposing (..)

import Html exposing (Html)
import Elegant exposing (px)
import BodyBuilder exposing (node, text)
import BodyBuilder.Attributes as Attributes
import Box
import Typography
import Character
import Shadow
import Border
import Color exposing (Color)
import Corner
import Margin
import Padding
import Cursor
import Outline
import Background
import Position
import Display
import Overflow
import Dimensions
import Style


main : Html msg
main =
    node
        [ Attributes.style mainStyle ]
        [ text "Just a text." ]


mainStyle =
    [ Style.block
        [ Display.overflow
            [ Overflow.overflowX Overflow.hidden
            , Overflow.overflowY Overflow.visible
            ]
        , Display.dimensions
            [ Dimensions.width (px 30)
            , Dimensions.height (px 40)
            ]
        , Display.textOverflowEllipsis
        , Display.alignment Display.left
        , Display.listStyleCircle
        ]
    , Style.box
        [ Box.typography
            [ Elegant.color Color.blue
            , Typography.character
                [ Character.weight 900
                , Character.size (px 100)
                , Character.italic
                ]
            ]
        , Box.padding
            [ Padding.all (px 30) ]
        , Box.boxShadow
            [ Shadow.standard (px 30) Color.black ( px 3, px 3 )
            , Shadow.inset True
            ]
        , Box.border
            [ Border.all
                [ Elegant.color Color.blue
                , Border.solid
                , Border.thickness (px 200)
                ]
            , Border.horizontal
                [ Elegant.color Color.black ]
            , Border.right
                [ Elegant.color Color.lightOrange ]
            ]
        , Box.corner
            [ Corner.circular Corner.all (px 200) ]
        , Box.margin
            [ Margin.top <| Margin.width (px 40)
            , Margin.vertical <| Margin.width (px 30)
            , Margin.bottom Margin.auto
            ]
        , Box.visibility Box.visible
        , Box.opacity 0.9
        , Box.zIndex 1000
        , Box.cursor Cursor.default
        , Box.outline
            [ Outline.none ]
        , Box.background
            [ Elegant.color Color.blue
            , Background.images
                [ Background.image "https://hackage.haskell.org/package/elm-reactor-0.3.1/src/assets/favicon.ico"
                    |> Background.at ( px 5, px 5 )
                , Background.linear (Background.degree 90)
                    (Background.colorStop Color.blue |> Background.at (px 4))
                    (Background.colorStop Color.black)
                    |> Background.intermediateColors [ Background.colorStop Color.red ]
                    |> Background.gradient
                    |> Background.at ( px 30, px 30 )
                , Background.radial
                    (Background.colorStop Color.black |> Background.at (px 200))
                    (Background.colorStop Color.blue)
                    |> Background.gradient
                ]
            ]
        , Box.position Position.static
        , Box.position <|
            Position.fixed
                [ Position.top (px 30)
                , Position.bottom (px 20)
                ]
        ]
    ]
