module Flex.Extra exposing (..)

import BodyBuilder as Builder exposing (Node)
import BodyBuilder.Attributes as Attributes
import Style
import Block
import Flex


alignedContent : ( Flex.Align, Flex.JustifyContent ) -> List (Node msg) -> Node msg
alignedContent alignment content =
    Builder.flex
        [ Attributes.style
            [ Style.flexContainerProperties
                [ Flex.alignXY alignment
                ]
            , Style.block
                [ Block.fullHeight
                ]
            ]
        ]
        [ Builder.flexItem [] content
        ]
