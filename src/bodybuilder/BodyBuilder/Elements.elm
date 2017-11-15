module BodyBuilder.Elements exposing (..)

import Elegant exposing (..)
import BodyBuilder exposing (..)
import BodyBuilder.Attributes as Attributes
import Style
import Function
import Dimensions
import Display
import Box
import Position


stickyView :
    List (Box.Box -> Box.Box)
    -> String
    -> List (Node msg)
    -> Node msg
stickyView sectionStyle sectionName elements =
    node []
        [ node
            [ Attributes.style
                [ Style.block
                    [ Display.dimensions [ Dimensions.width (percent 100) ] ]
                , Style.box
                    [ Box.position <|
                        Position.sticky [ Position.top (px 0) ]
                    , sectionStyle |> Function.compose
                    ]
                ]
            ]
            [ text sectionName ]
        , node [] elements
        ]
