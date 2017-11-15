module TheGrid exposing (..)

import BodyBuilder as Builder exposing (Node)
import BodyBuilder.Attributes as Attributes
import Color exposing (Color)
import Elegant exposing (px, vh, percent)
import Style
import Grid
import Grid.Extra
import Box
import Block
import Flex


alignedCellWithPurpleBackground : ( Int, Int ) -> ( Int, Int ) -> ( Flex.Align, Flex.JustifyContent ) -> List (Node msg) -> Builder.GridItem msg
alignedCellWithPurpleBackground =
    Grid.Extra.alignedCell [ Style.box [ Box.backgroundColor Color.purple ] ]


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
        [ alignedCellWithPurpleBackground ( 0, 0 ) ( 2, 1 ) ( Flex.flexStart, Flex.flexEnd ) [ content "bottom left" ]
        , alignedCellWithPurpleBackground ( 2, 0 ) ( 1, 2 ) Flex.center [ content "center" ]
        , alignedCellWithPurpleBackground ( 1, 2 ) ( 2, 1 ) Flex.topRight [ content "top right" ]
        , alignedCellWithPurpleBackground ( 0, 1 ) ( 1, 2 ) Flex.centerRight [ content "center right" ]
        ]


content str =
    Builder.div [ Attributes.style [ Style.box [ Box.backgroundColor Color.yellow, Box.paddingAll (px 24) ] ] ] [ Builder.text str ]


main : Node msg
main =
    example
