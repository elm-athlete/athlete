module BodyBuilder.Elements exposing (..)

import Elegant exposing (..)
import BodyBuilder exposing (..)
import Function exposing (..)


stickyView : List (Elegant.Style -> Elegant.Style) -> String -> List (Node interactiveContent phrasingContent Spanning NotListElement msg) -> Node interactiveContent phrasingContent Spanning NotListElement msg
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
