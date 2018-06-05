module Main exposing (..)

import BodyBuilder as Builder exposing (NodeWithStyle)
import BodyBuilder.Attributes as Attributes
import BodyBuilder.Style as Style
import Color exposing (Color)
import Elegant exposing (percent, px, vh)
import Elegant.Block as Block
import Elegant.Box as Box
import Elegant.Flex as Flex
import Elegant.Grid as Grid
import Elegant.Grid.Extra as GridExtra


alignedCellWithPurpleBackground : ( Int, Int ) -> ( Int, Int ) -> ( Flex.Align, Flex.JustifyContent ) -> List (NodeWithStyle msg) -> Builder.GridItem msg
alignedCellWithPurpleBackground =
    GridExtra.alignedCell [ Style.box [ Box.backgroundColor Color.purple ] ]


example : NodeWithStyle msg
example =
    Builder.grid
        [ Attributes.style
            [ Style.block [ Block.height (vh 100) ]
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
        [ alignedCellWithPurpleBackground ( 0, 0 ) ( 2, 1 ) ( Flex.flexEnd, Flex.justifyContentFlexStart ) [ content "bottom left" ]
        , alignedCellWithPurpleBackground ( 2, 0 ) ( 1, 2 ) ( Flex.alignCenter, Flex.justifyContentCenter ) [ content "center" ]
        , alignedCellWithPurpleBackground ( 1, 2 ) ( 2, 1 ) ( Flex.flexStart, Flex.justifyContentFlexEnd ) [ content "top right" ]
        , alignedCellWithPurpleBackground ( 0, 1 ) ( 1, 2 ) ( Flex.alignCenter, Flex.justifyContentFlexEnd ) [ content "center right" ]
        ]


content : String -> NodeWithStyle msg
content str =
    Builder.div [ Attributes.style [ Style.box [ Box.backgroundColor Color.yellow, Box.paddingAll (px 24) ] ] ] [ Builder.text str ]


main =
    Builder.staticPage example
