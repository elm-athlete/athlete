module BodyBuilder.Elements exposing (..)

import BodyBuilder exposing (..)
import BodyBuilder.Attributes as Attributes
import Dimensions
import Elegant exposing (..)
import Elegant.Box
import Elegant.Display
import Function
import Position
import Style


stickyView :
    List (Box.Box -> Box.Box)
    -> String
    -> List (NodeWithStyle msg)
    -> NodeWithStyle msg
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
