module BodyBuilder.Elements exposing (..)

import BodyBuilder exposing (..)
import BodyBuilder.Attributes as Attributes
import BodyBuilder.Style as Style
import Elegant exposing (..)
import Elegant.Box as Box
import Elegant.Dimensions as Dimensions
import Elegant.Display as Display
import Elegant.Position as Position
import Function


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
