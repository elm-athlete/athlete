module Main exposing (..)

import Html exposing (Html)
import Html.Attributes
import Elegant exposing (px)
import Layout
import Typography
import Typography.Character
import BoxShadow
import Border
import Color exposing (Color)
import Corner
import Margin
import Padding
import Cursor
import Outline
import Background
import Position


main : Html msg
main =
    Html.div
        [ toStyle <| mainStyle ]
        [ Html.text "Just a text." ]


mainStyle : Elegant.DisplayBox
mainStyle =
    Elegant.displayBlock []
        [ Layout.typography
            [ Elegant.color Color.blue
            , Typography.character
                [ Typography.Character.weight 900
                , Typography.Character.size (px 100)
                , Typography.Character.italic
                ]
            ]
        , Layout.padding
            [ Padding.all (px 30) ]
        , Layout.boxShadow
            [ BoxShadow.standard (px 30) Color.black ( px 3, px 3 )
            , BoxShadow.inset True
            ]
        , Layout.border
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
        , Layout.corner
            [ Corner.circular Corner.all (px 200) ]
        , Layout.margin
            [ Margin.top <| Margin.width (px 40)
            , Margin.vertical <| Margin.width (px 30)
            , Margin.bottom Margin.auto
            ]
        , Layout.visibility Layout.visible
        , Layout.opacity 0.9
        , Layout.zIndex 1000
        , Layout.cursor Cursor.default
        , Layout.outline
            [ Outline.none ]
        , Layout.background
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
        , Layout.position Position.static
        , Layout.position <|
            Position.fixed
                [ Position.top (px 30)
                , Position.bottom (px 20)
                ]
        ]


toStyle : Elegant.DisplayBox -> Html.Attribute msg
toStyle =
    Just
        >> flip Elegant.style []
        >> Elegant.toInlineStyles
        >> Debug.log "after compiling"
        >> Html.Attributes.style
