module ViewHelpers exposing (..)

-- import Form

import BodyBuilder as B exposing (NodeWithStyle)
import BodyBuilder.Attributes as A
import BodyBuilder.Events as E
import BodyBuilder.Extra as Layout
import BodyBuilder.Style as Style
import Browser
import Browser.Navigation as Nav
import Color
import DateFormat
import DateTime
import Dict
import Elegant exposing (px)
import Elegant.Background as Background
import Elegant.Block as Block
import Elegant.Border as Border
import Elegant.Box as Box
import Elegant.Constants as Constants
import Elegant.Display as Display
import Elegant.Extra
    exposing
        ( alignCenter
        , block
        , blockProperties
        , blockWithWidth
        , bold
        , border
        , box
        , cursorPointer
        , displayBlock
        , fillHeight
        , fontSize
        , gridContainerProperties
        , grow
        , padding
        , paddingAll
        , paddingBottom
        , paddingHorizontal
        , paddingTop
        , paddingVertical
        , textColor
        , typoSize
        , typography
        )
import Elegant.Grid as Grid
import Elegant.Margin as Margin
import Elegant.Overflow as Overflow
import Elegant.Padding as Padding
import Elegant.Position as Position
import Elegant.Shadow as Shadow
import Elegant.Typography as Typography
import Html
import Json.Decode
import Json.Encode
import List.Extra
import Modifiers exposing (Modifier)
import Task
import Time exposing (Weekday(..))
import Url
import Url.Parser exposing ((</>), (<?>))
import Url.Parser.Query


transparent =
    Color.rgba 0 0 0 0


borderStandard thickness color =
    [ Border.thickness (px thickness), Border.color color, Border.solid ]


transparentBorder =
    borderStandard 1 transparent


targetBlank =
    A.target "_blank"


mailtoLink : String -> String -> String
mailtoLink subject content =
    "mailto:?subject="
        ++ subject
        ++ "&body="
        ++ (content |> String.replace "\n" "%0D%0A")


linkTo : Color.Color -> String -> String -> NodeWithStyle msg
linkTo color label url =
    B.a
        [ A.href url
        , textColor <| color
        , typography [ Typography.noDecoration ]
        ]
        [ B.text label
        ]


externalLinkTo : Color.Color -> String -> String -> NodeWithStyle msg
externalLinkTo color label url =
    B.a
        [ A.href url
        , textColor <| color
        , targetBlank
        , typography [ Typography.noDecoration ]
        ]
        [ B.text label
        ]


linkToMsg : Color.Color -> String -> msg -> NodeWithStyle msg
linkToMsg color label msg =
    B.span
        [ textColor <| color
        , typography [ Typography.noDecoration ]
        , E.onClick msg
        , cursorPointer
        ]
        [ B.text label ]



-- ORIENTED LAYOUT


type alias Cell msg =
    { valType : Grid.ValType
    , attrs : List (A.GridItemAttributes msg -> A.GridItemAttributes msg)
    , content : NodeWithStyle msg
    }


centeredContent : Grid.GridContainerCoordinate -> Grid.GridContainerCoordinate
centeredContent =
    Grid.alignItems (Grid.alignWrapper Grid.center)


rowWithOptions : List (Grid.GridContainerCoordinate -> Grid.GridContainerCoordinate) -> List (A.GridContainerAttributes msg -> A.GridContainerAttributes msg) -> List (Cell msg) -> NodeWithStyle msg
rowWithOptions gridAttrs attrs gridItems =
    B.grid
        ([ displayBlock
         , fillHeight
         , gridContainerProperties
            [ Grid.columns
                ([ Grid.template
                    (gridItems
                        |> List.map .valType
                        |> List.map Grid.simple
                    )
                 , Grid.align Grid.stretch
                 ]
                    ++ gridAttrs
                )
            ]
         ]
            ++ attrs
        )
        (gridItems |> List.map (\gridItem -> B.gridItem gridItem.attrs [ gridItem.content ]))


rowCentered :
    List
        (A.GridContainerAttributes msg
         -> A.GridContainerAttributes msg
        )
    -> List (Cell msg)
    -> NodeWithStyle msg
rowCentered =
    rowWithOptions [ centeredContent ]


row :
    List
        (A.GridContainerAttributes msg
         -> A.GridContainerAttributes msg
        )
    -> List (Cell msg)
    -> NodeWithStyle msg
row =
    rowWithOptions []


columnWithOptions : List (Grid.GridContainerCoordinate -> Grid.GridContainerCoordinate) -> List (A.GridContainerAttributes msg -> A.GridContainerAttributes msg) -> List (Cell msg) -> NodeWithStyle msg
columnWithOptions gridAttrs attrs gridItems =
    B.grid
        ([ displayBlock
         , fillHeight
         , gridContainerProperties
            [ Grid.rows
                ([ Grid.template
                    (gridItems
                        |> List.map .valType
                        |> List.map Grid.simple
                    )
                 , Grid.alignItems Grid.spaceBetween
                 , Grid.align Grid.stretch
                 ]
                    ++ gridAttrs
                )
            ]
         ]
            ++ attrs
        )
        (gridItems |> List.map (\gridItem -> B.gridItem gridItem.attrs [ gridItem.content ]))


centeredColumn :
    List
        (A.GridContainerAttributes msg
         -> A.GridContainerAttributes msg
        )
    -> List (Cell msg)
    -> NodeWithStyle msg
centeredColumn =
    columnWithOptions [ centeredContent ]


column :
    List
        (A.GridContainerAttributes msg
         -> A.GridContainerAttributes msg
        )
    -> List (Cell msg)
    -> NodeWithStyle msg
column =
    columnWithOptions []


cell valType attrs content =
    Cell valType attrs content


pxCell pxSize =
    cell (Grid.sizeUnitVal (px pxSize))


fractionCell =
    cell << Grid.fractionOfAvailableSpace


fillCell =
    fractionCell 1


autoCell =
    cell Grid.auto


fill : Cell msg
fill =
    fillCell [] B.none


mediumGap =
    Grid.gap Constants.medium


largeGap =
    Grid.gap Constants.large


horizontallyCentered content =
    columnWithOptions
        [ Grid.alignItems (Grid.alignWrapper Grid.center)
        ]
        []
        [ autoCell [] content ]


type alias CellResponsive msg =
    { repeatable : Grid.Repeatable
    , attrs : List (A.GridItemAttributes msg -> A.GridItemAttributes msg)
    , content : NodeWithStyle msg
    }


horizontalLayoutResponsiveWithDetails : List (Grid.GridContainerCoordinate -> Grid.GridContainerCoordinate) -> List (A.GridContainerAttributes msg -> A.GridContainerAttributes msg) -> List (CellResponsive msg) -> NodeWithStyle msg
horizontalLayoutResponsiveWithDetails gridAttrs attrs gridItems =
    B.grid
        ([ displayBlock
         , fillHeight
         , gridContainerProperties
            [ Grid.columns
                ([ Grid.template
                    (gridItems
                        |> List.map .repeatable
                    )
                 , Grid.align Grid.stretch
                 ]
                    ++ gridAttrs
                )
            ]
         ]
            ++ attrs
        )
        (gridItems |> List.map (\gridItem -> B.gridItem gridItem.attrs [ gridItem.content ]))


cellResponsive valType attrs content =
    CellResponsive valType attrs content


minMaxCell val1 val2 =
    cellResponsive (Grid.minmax val1 val2)
