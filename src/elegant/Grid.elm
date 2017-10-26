module Grid exposing (..)

import Helpers.Shared exposing (..)


type Align
    = Start
    | Center
    | End
    | Stretch


start : Align
start =
    Start


center : Align
center =
    Center


end : Align
end =
    End


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


type ValType
    = SizeUnitVal SizeUnit
    | Fr Int
    | Vw Int
    | MinContent
    | MaxContent
    | Auto


sizeUnitVal : SizeUnit -> ValType
sizeUnitVal =
    SizeUnitVal


fractionOfAvailableSpace : Int -> ValType
fractionOfAvailableSpace =
    Fr


viewWidth : Int -> ValType
viewWidth =
    Vw


minContent : ValType
minContent =
    MinContent


maxContent : ValType
maxContent =
    MaxContent


auto : ValType
auto =
    Auto


type Repeatable
    = Simple ValType
    | Minmax ValType ValType
    | FitContent ValType


simple : ValType -> Repeatable
simple =
    Simple


minmax : ValType -> ValType -> Repeatable
minmax =
    Minmax


fitContent : ValType -> Repeatable
fitContent =
    FitContent


type Template
    = RepeatAutoFill
    | RepeatAutoFit
    | NoRepeat


autofill : Template
autofill =
    RepeatAutoFill


autofit : Template
autofit =
    RepeatAutoFit


noRepeat : Template
noRepeat =
    NoRepeat


type GridTemplate
    = TemplateWrapper Template (List Repeatable)


type alias GridContainerCoordinate =
    { gutter : Maybe SizeUnit
    , align : Maybe Align
    , alignItems : Maybe AlignItems
    , template : Maybe GridTemplate
    }


type GridItemSize
    = UntilEndOfCoordinate
    | Span Int


untilEndOfCoordinate : GridItemSize
untilEndOfCoordinate =
    UntilEndOfCoordinate


span : Int -> GridItemSize
span =
    Span


type alias GridItemCoordinate =
    { placement : Maybe ( Int, GridItemSize )
    , align : Maybe Align
    }


type alias GridContainerDetails =
    { x : Maybe GridContainerCoordinate
    , y : Maybe GridContainerCoordinate
    }


type alias GridItemDetails =
    { x : Maybe GridItemCoordinate
    , y : Maybe GridItemCoordinate
    }


columns : Modifiers GridContainerCoordinate -> Modifier GridContainerDetails
columns modifiers gridContainerDetails =
    { gridContainerDetails | x = modifiedElementOrNothing (GridContainerCoordinate Nothing Nothing Nothing Nothing) modifiers }


rows : Modifiers GridContainerCoordinate -> Modifier GridContainerDetails
rows modifiers gridContainerDetails =
    { gridContainerDetails | y = modifiedElementOrNothing (GridContainerCoordinate Nothing Nothing Nothing Nothing) modifiers }


horizontal : Modifiers GridItemCoordinate -> Modifier GridItemDetails
horizontal modifiers gridItemDetails =
    { gridItemDetails | x = modifiedElementOrNothing (GridItemCoordinate Nothing Nothing) modifiers }


vertical : Modifiers GridItemCoordinate -> Modifier GridItemDetails
vertical modifiers gridItemDetails =
    { gridItemDetails | y = modifiedElementOrNothing (GridItemCoordinate Nothing Nothing) modifiers }


template : Template -> List Repeatable -> Modifier GridContainerCoordinate
template temp repeatable gridContainerCoordinate =
    { gridContainerCoordinate | template = Just (TemplateWrapper temp repeatable) }


gap : SizeUnit -> Modifier GridContainerCoordinate
gap value gridContainerCoordinate =
    { gridContainerCoordinate | gutter = Just value }


align : Align -> Modifier { a | align : Maybe Align }
align value gridContainerCoordinate =
    { gridContainerCoordinate | align = Just value }


alignItems : AlignItems -> Modifier GridContainerCoordinate
alignItems value gridContainerCoordinate =
    { gridContainerCoordinate | alignItems = Just value }


alignWrapper : Align -> AlignItems
alignWrapper =
    AlignWrapper


spaceAround : AlignItems
spaceAround =
    Space Around


spaceBetween : AlignItems
spaceBetween =
    Space Between


spaceEvenly : AlignItems
spaceEvenly =
    Space Evenly


placement : Int -> GridItemSize -> Modifier GridItemCoordinate
placement value itemSize gridItemCoordinate =
    { gridItemCoordinate | placement = Just ( value, itemSize ) }


{-| -}
gridItemDetailsToCouples : GridItemDetails -> List ( String, String )
gridItemDetailsToCouples gridContainerDetails =
    []
        |> List.concatMap (callOn gridContainerDetails)


{-| -}
gridContainerDetailsToCouples : GridContainerDetails -> List ( String, String )
gridContainerDetailsToCouples gridContainerDetails =
    []
        |> List.concatMap (callOn gridContainerDetails)
