module Grid2 exposing (..)

import BodyBuilder as Builder exposing (Node)
import BodyBuilder.Attributes as Attributes
import Color exposing (Color)
import Elegant exposing (px)
import Style
import Grid
import Box


example : Node msg
example =
    Builder.grid
        [ Attributes.style
            [ Style.block []
            , Style.gridContainerProperties
                [ Grid.columns
                    [ Grid.template
                        [ --Grid.repeat Grid.autofit [ px 100 ]
                          Grid.simple (Grid.sizeUnitVal (px 500))
                        , Grid.simple (Grid.sizeUnitVal (px 500))
                        ]
                    , Grid.gap (px 30)
                    , Grid.align Grid.center
                    , Grid.alignItems (Grid.alignWrapper Grid.center)
                    ]
                , Grid.rows
                    [ Grid.template
                        [ Grid.simple (Grid.sizeUnitVal (px 500))
                        , Grid.simple (Grid.sizeUnitVal (px 500))
                        ]
                    , Grid.gap (px 30)
                    , Grid.align Grid.center
                    , Grid.alignItems (Grid.alignWrapper Grid.center)
                    ]
                ]
            , Style.box [ Box.backgroundColor Color.lightPurple ]
            ]
        ]
        [ Builder.gridItem
            [ Attributes.style
                [ Style.gridItemProperties
                    [ Grid.horizontal
                        [ Grid.placement 1 (Grid.span 1)
                        , Grid.align Grid.center
                        ]
                    , Grid.vertical
                        [ Grid.placement 2 Grid.untilEndOfCoordinate
                        ]
                    ]

                -- , Style.box [ Box.backgroundColor Color.black ]
                ]
            ]
            [ Builder.text "FirstItem"
            , Builder.text "SecondItem"
            , Builder.text "ThirdItem"
            ]
        , Builder.gridItem
            [ Attributes.style
                [ Style.gridItemProperties
                    [ Grid.horizontal
                        [ Grid.placement 1 (Grid.span 1)
                        , Grid.align Grid.center
                        ]
                    , Grid.vertical
                        [ Grid.placement 1 Grid.untilEndOfCoordinate
                        ]
                    ]

                -- , Style.box [ Box.backgroundColor Color.black ]
                ]
            ]
            [ Builder.text "FirstThing"
            , Builder.text "SecondThing"
            , Builder.text "ThirdThing"
            ]
        ]


main : Node msg
main =
    example
