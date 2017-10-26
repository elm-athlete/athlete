module Grid2 exposing (..)

import BodyBuilder as Builder exposing (Node)
import BodyBuilder.Attributes as Attributes
import Style
import Grid


-- import Display
-- import Box
-- import Border
-- import Color
-- import Elegant exposing (px)
-- import Padding
-- import Constants
-- import Dimensions


example =
    Builder.grid
        [ Attributes.style
            [ Style.block []
            , Style.gridContainerProperties
                [ Grid.columns
                    [ Grid.template Grid.noRepeat
                        [ Grid.simple (Grid.fractionOfAvailableSpace 1)
                        , Grid.simple (Grid.sizeUnitVal (px 200))
                        ]
                    , Grid.gap (px 10)
                    , Grid.align Grid.center
                    , Grid.alignItems (Grid.alignWrapper Grid.center)
                    ]
                , Grid.rows
                    [ Grid.template Grid.noRepeat
                        [ Grid.simple (Grid.fractionOfAvailableSpace 1)
                        , Grid.simple (Grid.sizeUnitVal (px 200))
                        ]
                    , Grid.gap (px 10)
                    , Grid.align Grid.center
                    , Grid.alignItems (Grid.alignWrapper Grid.center)
                    ]
                ]
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
                        [ Grid.placement 1 Grid.untilEndOfCoordinate
                        ]
                    ]
                ]
            ]
            []
        ]
