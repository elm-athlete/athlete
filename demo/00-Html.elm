module Main exposing (..)

import Html exposing (Html)
import Html.Attributes
import Elegant exposing (px)
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


main : Html msg
main =
    Html.div
        [ toStyle <| mainStyle ]
        [ Html.text "Just a text." ]


mainStyle : Elegant.DisplayBox
mainStyle =
    Elegant.displayBlock []
        [ Elegant.typography
            [ Elegant.color Color.blue
            , Typography.character
                [ Typography.Character.weight 900
                , Typography.Character.size (px 100)
                , Typography.Character.italic
                ]
            ]
        , Elegant.padding
            [ Padding.all (px 30) ]
        , Elegant.boxShadow
            [ BoxShadow.standard (px 30) Color.black ( px 3, px 3 )
            , BoxShadow.inset True
            ]
        , Elegant.border
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
        , Elegant.corner
            [ Corner.circular Corner.all (px 200) ]
        , Elegant.margin
            [ Margin.top <| Margin.width (px 40)
            , Margin.vertical <| Margin.width (px 30)
            , Margin.bottom Margin.auto
            ]
        , Elegant.visibility Elegant.visible
        , Elegant.opacity 0.9
        , Elegant.zIndex 1000
        , Elegant.cursor Cursor.default
        , Elegant.outline
            [ Outline.none ]
        ]


toStyle : Elegant.DisplayBox -> Html.Attribute msg
toStyle =
    Just
        >> flip Elegant.style []
        >> Elegant.toInlineStyles
        >> Debug.log "after compiling"
        >> Html.Attributes.style
