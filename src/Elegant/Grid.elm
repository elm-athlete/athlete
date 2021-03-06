module Elegant.Grid
    exposing
        ( GridContainerCoordinate
        , GridContainerDetails
        , GridItemCoordinate
        , GridItemDetails
        , GridItemSize(..)
        , GridTemplate
        , Repeatable(..)
        , ValType(..)
        , align
        , alignItems
        , alignItemsToCouple
        , alignSelfToCouple
        , alignToCouple
        , alignToString
        , alignWrapper
        , auto
        , autofill
        , autofit
        , center
        , columns
        , end
        , fitContent
        , fractionOfAvailableSpace
        , gap
        , gridContainerCoordinateToCouples
        , gridContainerDetailsToCouples
        , gridItemCoordinateToCouples
        , gridItemDetailsToCouples
        , gutterToCouple
        , horizontal
        , maxContent
        , minContent
        , minmax
        , placement
        , placementToCouple
        , placementToString
        , repeat
        , repeatOptionToString
        , repeatableToString
        , rows
        , simple
        , size
        , sizeToCouple
        , sizeToString
        , sizeUnitVal
        , spaceAround
        , spaceBetween
        , spaceEvenly
        , spacingToString
        , span
        , start
        , stretch
        , template
        , templateToCouple
        , untilEndOfCoordinate
        , valTypeToString
        , vertical
        , viewWidth
        )

{-|

@docs align
@docs alignItems
@docs alignItemsToCouple
@docs alignSelfToCouple
@docs alignToCouple
@docs alignToString
@docs alignWrapper
@docs auto
@docs autofill
@docs autofit
@docs center
@docs columns
@docs end
@docs fitContent
@docs fractionOfAvailableSpace
@docs gap
@docs gridContainerCoordinateToCouples
@docs gridContainerDetailsToCouples
@docs gridItemCoordinateToCouples
@docs gridItemDetailsToCouples
@docs gutterToCouple
@docs horizontal
@docs maxContent
@docs minContent
@docs minmax
@docs placement
@docs placementToCouple
@docs placementToString
@docs size
@docs sizeToCouple
@docs sizeToString
@docs repeat
@docs repeatOptionToString
@docs repeatableToString
@docs rows
@docs simple
@docs sizeUnitVal
@docs spaceAround
@docs spaceBetween
@docs spaceEvenly
@docs spacingToString
@docs span
@docs start
@docs stretch
@docs template
@docs templateToCouple
@docs untilEndOfCoordinate
@docs valTypeToString
@docs vertical
@docs viewWidth
@docs GridItemDetails
@docs GridItemCoordinate
@docs GridContainerDetails
@docs GridContainerCoordinate
@docs GridItemSize
@docs GridTemplate
@docs Repeatable
@docs ValType

-}

import Elegant.Helpers.Shared exposing (..)
import Function exposing (callOn)
import Modifiers exposing (..)


type Align
    = Start
    | Center
    | End
    | Stretch


{-| -}
start : Align
start =
    Start


{-| -}
center : Align
center =
    Center


{-| -}
end : Align
end =
    End


{-| -}
stretch : Align
stretch =
    Stretch


type Spacing
    = Around
    | Between
    | Evenly


type AlignItems
    = AlignWrapper Align
    | Space Spacing


{-| -}
type ValType
    = SizeUnitVal SizeUnit
    | Fr Int
    | Vw Int
    | MinContent
    | MaxContent
    | Auto


{-| -}
sizeUnitVal : SizeUnit -> ValType
sizeUnitVal =
    SizeUnitVal


{-| -}
fractionOfAvailableSpace : Int -> ValType
fractionOfAvailableSpace =
    Fr


{-| -}
viewWidth : Int -> ValType
viewWidth =
    Vw


{-| -}
minContent : ValType
minContent =
    MinContent


{-| -}
maxContent : ValType
maxContent =
    MaxContent


{-| -}
auto : ValType
auto =
    Auto


{-| -}
type Repeatable
    = Simple ValType
    | Minmax ValType ValType
    | FitContent ValType
    | Repeat RepeatOption (List SizeUnit)


{-| -}
simple : ValType -> Repeatable
simple =
    Simple


{-| -}
minmax : ValType -> ValType -> Repeatable
minmax =
    Minmax


{-| -}
fitContent : ValType -> Repeatable
fitContent =
    FitContent


type RepeatOption
    = RepeatAutoFill
    | RepeatAutoFit


{-| -}
autofill : RepeatOption
autofill =
    RepeatAutoFill


{-| -}
autofit : RepeatOption
autofit =
    RepeatAutoFit


{-| -}
repeat : RepeatOption -> List SizeUnit -> Repeatable
repeat =
    Repeat


{-| -}
type alias GridTemplate =
    List Repeatable


{-| -}
type alias GridContainerCoordinate =
    { gutter : Maybe SizeUnit
    , align : Maybe Align
    , alignItems : Maybe AlignItems
    , template : Maybe GridTemplate
    }


{-| -}
type GridItemSize
    = UntilEndOfCoordinate
    | Span Int


{-| -}
untilEndOfCoordinate : GridItemSize
untilEndOfCoordinate =
    UntilEndOfCoordinate


{-| -}
span : Int -> GridItemSize
span =
    Span


{-| -}
type alias GridItemCoordinate =
    { placement : Maybe Int
    , size : Maybe GridItemSize
    , align : Maybe Align
    }


{-| -}
type alias GridContainerDetails =
    { x : Maybe GridContainerCoordinate
    , y : Maybe GridContainerCoordinate
    }


{-| -}
type alias GridItemDetails =
    { x : Maybe GridItemCoordinate
    , y : Maybe GridItemCoordinate
    }


{-| -}
columns : Modifiers GridContainerCoordinate -> Modifier GridContainerDetails
columns modifiers gridContainerDetails =
    { gridContainerDetails | x = modifiedElementOrNothing (GridContainerCoordinate Nothing Nothing Nothing Nothing) modifiers }


{-| -}
rows : Modifiers GridContainerCoordinate -> Modifier GridContainerDetails
rows modifiers gridContainerDetails =
    { gridContainerDetails | y = modifiedElementOrNothing (GridContainerCoordinate Nothing Nothing Nothing Nothing) modifiers }


{-| -}
horizontal : Modifiers GridItemCoordinate -> Modifier GridItemDetails
horizontal modifiers gridItemDetails =
    { gridItemDetails | x = modifiedElementOrNothing (GridItemCoordinate Nothing Nothing Nothing) modifiers }


{-| -}
vertical : Modifiers GridItemCoordinate -> Modifier GridItemDetails
vertical modifiers gridItemDetails =
    { gridItemDetails | y = modifiedElementOrNothing (GridItemCoordinate Nothing Nothing Nothing) modifiers }


{-| -}
template : List Repeatable -> Modifier GridContainerCoordinate
template repeatable gridContainerCoordinate =
    { gridContainerCoordinate | template = Just repeatable }


{-| -}
gap : SizeUnit -> Modifier GridContainerCoordinate
gap value gridContainerCoordinate =
    { gridContainerCoordinate | gutter = Just value }


{-| -}
align : Align -> Modifier { a | align : Maybe Align }
align value gridContainerCoordinate =
    { gridContainerCoordinate | align = Just value }


{-| -}
alignItems : AlignItems -> Modifier GridContainerCoordinate
alignItems value gridContainerCoordinate =
    { gridContainerCoordinate | alignItems = Just value }


{-| -}
alignWrapper : Align -> AlignItems
alignWrapper =
    AlignWrapper


{-| -}
spaceAround : AlignItems
spaceAround =
    Space Around


{-| -}
spaceBetween : AlignItems
spaceBetween =
    Space Between


{-| -}
spaceEvenly : AlignItems
spaceEvenly =
    Space Evenly


{-| -}
placement : Int -> Modifier GridItemCoordinate
placement value gridItemCoordinate =
    { gridItemCoordinate | placement = Just (value + 1) }


{-| -}
size : GridItemSize -> Modifier GridItemCoordinate
size itemSize gridItemCoordinate =
    { gridItemCoordinate | size = Just itemSize }


{-| -}
gridContainerDetailsToCouples : GridContainerDetails -> List ( String, String )
gridContainerDetailsToCouples gridContainerDetails =
    [ unwrapToCouples .x (gridContainerCoordinateToCouples "column" "align")
    , unwrapToCouples .y (gridContainerCoordinateToCouples "row" "justify")
    ]
        |> List.concatMap (callOn gridContainerDetails)


{-| -}
gridContainerCoordinateToCouples : String -> String -> GridContainerCoordinate -> List ( String, String )
gridContainerCoordinateToCouples columnRow alignJustify gridContainerCoordinate =
    [ unwrapToCouple .gutter (gutterToCouple columnRow)
    , unwrapToCouple .align (alignToCouple alignJustify)
    , unwrapToCouple .alignItems (alignItemsToCouple alignJustify)
    , unwrapToCouple .template (templateToCouple columnRow)
    ]
        |> List.concatMap (callOn gridContainerCoordinate)


{-| -}
gutterToCouple : String -> SizeUnit -> ( String, String )
gutterToCouple columnRow =
    Tuple.pair ("grid-" ++ columnRow ++ "-gap") << sizeUnitToString


{-| -}
alignToCouple : String -> Align -> ( String, String )
alignToCouple alignJustify =
    Tuple.pair (alignJustify ++ "-content") << alignToString


{-| -}
alignToString : Align -> String
alignToString align_ =
    case align_ of
        Start ->
            "start"

        Center ->
            "center"

        Stretch ->
            "stretch"

        End ->
            "end"


{-| -}
alignItemsToCouple : String -> AlignItems -> ( String, String )
alignItemsToCouple alignJustify_ alignItems_ =
    ( alignJustify_ ++ "-items"
    , case alignItems_ of
        AlignWrapper align_ ->
            alignToString align_

        Space spacing ->
            spacingToString spacing
    )


{-| -}
spacingToString : Spacing -> String
spacingToString spacing =
    case spacing of
        Around ->
            "space-around"

        Between ->
            "space-between"

        Evenly ->
            "space-evenly"


{-| -}
templateToCouple : String -> GridTemplate -> ( String, String )
templateToCouple columnRow repeatable =
    ( "grid-template-" ++ columnRow ++ "s"
    , repeatable
        |> List.map repeatableToString
        |> String.join " "
    )


{-| -}
repeatableToString : Repeatable -> String
repeatableToString repeatable =
    case repeatable of
        Simple valType ->
            valTypeToString valType

        Minmax val1 val2 ->
            "minmax(" ++ valTypeToString val1 ++ ", " ++ valTypeToString val2 ++ ")"

        FitContent valType ->
            "fit-content(" ++ valTypeToString valType ++ ")"

        Repeat repeatOption sizes ->
            "repeat(" ++ repeatOptionToString repeatOption ++ (List.map sizeUnitToString sizes |> String.join " ") ++ ")"


{-| -}
repeatOptionToString : RepeatOption -> String
repeatOptionToString repeatOption =
    case repeatOption of
        RepeatAutoFill ->
            "auto-fill, "

        RepeatAutoFit ->
            "auto-fit, "


{-| -}
valTypeToString : ValType -> String
valTypeToString valType =
    case valType of
        Auto ->
            "auto"

        SizeUnitVal val ->
            sizeUnitToString val

        Fr val ->
            String.fromInt val ++ "fr"

        Vw val ->
            String.fromInt val ++ "vw"

        MinContent ->
            "min-content"

        MaxContent ->
            "max-content"


{-| -}
gridItemDetailsToCouples : GridItemDetails -> List ( String, String )
gridItemDetailsToCouples gridItemDetails =
    [ unwrapToCouples .x (gridItemCoordinateToCouples "column" "align")
    , unwrapToCouples .y (gridItemCoordinateToCouples "row" "justify")
    ]
        |> List.concatMap (callOn gridItemDetails)


{-| -}
gridItemCoordinateToCouples : String -> String -> GridItemCoordinate -> List ( String, String )
gridItemCoordinateToCouples columnRow alignJustify gridItemCoordinate =
    [ unwrapToCouple .placement (placementToCouple columnRow)
    , unwrapToCouple .size (sizeToCouple columnRow)
    , unwrapToCouple .align (alignSelfToCouple alignJustify)
    ]
        |> List.concatMap (callOn gridItemCoordinate)


{-| -}
placementToCouple : String -> Int -> ( String, String )
placementToCouple columnRow placement_ =
    ( "grid-" ++ columnRow ++ "-start", placementToString placement_ )


{-| -}
placementToString : Int -> String
placementToString beginning =
    String.fromInt beginning


{-| -}
sizeToCouple : String -> GridItemSize -> ( String, String )
sizeToCouple columnRow size_ =
    ( "grid-" ++ columnRow ++ "-end", sizeToString size_ )


{-| -}
sizeToString : GridItemSize -> String
sizeToString itemSize =
    case itemSize of
        UntilEndOfCoordinate ->
            "-1"

        Span val ->
            "span " ++ String.fromInt val


{-| -}
alignSelfToCouple : String -> Align -> ( String, String )
alignSelfToCouple alignJustify alignSelf =
    ( alignJustify ++ "-self", alignToString alignSelf )
