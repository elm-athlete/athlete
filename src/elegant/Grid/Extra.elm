module Grid.Extra exposing (..)

import BodyBuilder as Builder exposing (Node)
import BodyBuilder.Attributes as Attributes
import Color exposing (Color)
import Elegant exposing (px, vh, percent)
import Style
import Grid
import Box
import Block
import Flex.Extra


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


alignedCell cellStyle ( x, y ) ( width, height ) alignment content =
    cell cellStyle ( x, y ) ( width, height ) [ Flex.Extra.alignedContent alignment content ]


cell cellStyle ( x, y ) ( width, height ) =
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
