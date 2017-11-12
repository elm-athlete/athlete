module Grid.Extra exposing (..)

import BodyBuilder as Builder exposing (Node)
import BodyBuilder.Attributes as Attributes
import Color exposing (Color)
import Elegant exposing (px, vh, percent)
import Style
import Grid
import Box
import Block
import Flex


top =
    -1


left =
    -1


right =
    1


center =
    0


bottom =
    1


cell cellStyle ( x, y ) ( width, height ) alignment content =
    Builder.gridItem
        [ Attributes.style
            ([ Style.gridItemProperties
                [ Grid.horizontal
                    [ Grid.placement x
                    , Grid.size (Grid.span width)
                    , Grid.align Grid.stretch
                    ]
                , Grid.vertical
                    [ Grid.placement y
                    , Grid.size (Grid.span height)
                    , Grid.align Grid.stretch
                    ]
                ]
             ]
                ++ cellStyle
            )
        ]
        [ Builder.flex
            [ Attributes.style
                [ Style.flexContainerProperties
                    [ Flex.alignXY alignment
                    ]
                , Style.block
                    [ Block.height (percent 100)
                    ]
                ]
            ]
            [ Builder.flexItem [] content
            ]
        ]
