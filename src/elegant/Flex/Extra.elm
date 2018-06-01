module Flex.Extra
    exposing
        ( alignedContent
        )

{-|

@docs alignedContent

-}

import Block
import BodyBuilder as Builder exposing (NodeWithStyle)
import BodyBuilder.Attributes as Attributes
import Flex
import Style


{-| alignedContent is a way to align content inside a container.
-}
alignedContent : ( Flex.Align, Flex.JustifyContent ) -> List (NodeWithStyle msg) -> NodeWithStyle msg
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
