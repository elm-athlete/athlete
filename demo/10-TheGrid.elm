module TheGrid exposing (..)

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


cell : ( Int, Int ) -> ( Int, Int ) -> ( Int, Int ) -> List (Node msg) -> Builder.GridItem msg
cell ( x, y ) ( width, height ) alignment content =
    Builder.gridItem
        [ Attributes.style
            [ Style.gridItemProperties
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
            , Style.box [ Box.backgroundColor Color.purple ]
            ]
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


example : Node msg
example =
    Builder.grid
        [ Attributes.style
            [ Style.block [ Block.height (percent 100) ]
            , Style.gridContainerProperties
                [ Grid.columns
                    [ Grid.template
                        [ Grid.simple (Grid.fractionOfAvailableSpace 1)
                        , Grid.simple (Grid.fractionOfAvailableSpace 1)
                        , Grid.simple (Grid.fractionOfAvailableSpace 1)
                        ]
                    , Grid.gap (px 30)
                    , Grid.align Grid.stretch
                    , Grid.alignItems (Grid.alignWrapper Grid.center)
                    ]
                , Grid.rows
                    [ Grid.template
                        [ Grid.simple (Grid.fractionOfAvailableSpace 1)
                        , Grid.simple (Grid.fractionOfAvailableSpace 1)
                        , Grid.simple (Grid.fractionOfAvailableSpace 1)
                        ]
                    , Grid.gap (px 30)
                    , Grid.align Grid.stretch
                    , Grid.alignItems (Grid.alignWrapper Grid.center)
                    ]
                ]
            , Style.box [ Box.backgroundColor Color.lightPurple ]
            ]
        ]
        [ cell ( 0, 0 ) ( 2, 1 ) ( bottom, left ) [ Builder.text "1" ]
        , cell ( 2, 0 ) ( 1, 2 ) ( center, center ) [ Builder.text "2" ]
        , cell ( 1, 2 ) ( 2, 1 ) ( top, right ) [ Builder.text "3" ]
        , cell ( 0, 1 ) ( 1, 2 ) ( center, right ) [ Builder.text "4" ]
        ]


main : Node msg
main =
    example
