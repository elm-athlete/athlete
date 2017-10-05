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


main : Html msg
main =
    Html.div
        [ Elegant.displayBlock []
            [ Elegant.typography
                [ Elegant.color Color.blue
                , Typography.character
                    [ Typography.Character.weight 900
                    , Typography.Character.size (px 100)
                    , Typography.Character.italic
                    ]
                ]
            , Elegant.padding (px 30)
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
                ]
            ]
            |> Just
            |> flip Elegant.style []
            |> Elegant.toInlineStyles
            |> Debug.log "after compiling"
            |> Html.Attributes.style
        ]
        [ Html.text "Just a text." ]
