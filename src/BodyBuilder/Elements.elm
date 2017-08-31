module BodyBuilder.Elements exposing (..)

import Elegant exposing (..)
import BodyBuilder exposing (..)
import Function exposing (..)
import Color exposing (..)


stickyView : List (Elegant.Style -> Elegant.Style) -> String -> List (Node msg) -> Node msg
stickyView sectionStyle sectionName elements =
    div []
        [ div
            [ style
                [ Elegant.positionSticky
                , Elegant.top (Px 0)
                , Elegant.fullWidth
                , sectionStyle |> compose
                ]
            ]
            [ text sectionName ]
        , div [] elements
        ]


invertableButton :
    Color
    -> Color
    -> { a | style : StyleAttribute }
    -> { a | style : StyleAttribute }
invertableButton bg fg =
    [ style [ textColor bg, backgroundColor fg, button ]
    , hoverStyle [ textColor fg, backgroundColor bg ]
    ]
        |> compose


button : Style -> Style
button =
    [ cursorPointer ]
        |> compose
