module Flex
    exposing
        ( GridContainerDetails
        , GridItemDetails
        , FlexWrap
          -- , wrap
          -- , noWrap
          -- , Align
          -- , align
          -- , baseline
          -- , center
          -- , flexStart
          -- , flexEnd
          -- , inherit
          -- , initial
          -- , stretch
          -- , JustifyContent
          -- , justifyContent
          -- , spaceBetween
          -- , spaceAround
          -- , justifyContentCenter
          -- , grow
          -- , shrink
          -- , basisAuto
          -- , basis
          -- , alignSelf
        , gridItemDetailsToCouples
        , gridContainerDetailsToCouples
        , defaultGridContainerDetails
        , defaultGridItemDetails
        )

{-| Flex handles everything related to the flex element.


@docs GridContainerDetails
@docs GridItemDetails
@docs FlexDirection
@docs FlexWrap
@docs Align
@docs JustifyContent


## FlexWrap

@docs wrap
@docs noWrap


## AlignItems / AlignSelf

@docs align
@docs baseline
@docs center
@docs flexStart
@docs flexEnd
@docs inherit
@docs initial
@docs stretch


## JustifyContent

@docs justifyContent
@docs spaceBetween
@docs spaceAround
@docs justifyContentCenter


## Flex

@docs grow
@docs shrink
@docs basisAuto
@docs basis
@docs alignSelf

@docs defaultGridContainerDetails
@docs defaultGridItemDetails
@docs gridContainerDetailsToCouples
@docs gridItemDetailsToCouples
-}

import Either exposing (Either(..))
import Helpers.Shared exposing (..)
import Elegant.Setters exposing (..)


{-| Contains all style which can be applied on a flex container.
This contains flex-direction, flex-wrap, align-items and justify-content.
-}
type alias GridContainerDetails =
    { wrap : Maybe FlexWrap
    , align : Maybe Align
    , justifyContent : Maybe JustifyContent
    }


{-|
-}
defaultGridContainerDetails : GridContainerDetails
defaultGridContainerDetails =
    GridContainerDetails Nothing Nothing Nothing


{-| Represents a flex direction.
Can be column or row.
-}
type FlexDirection
    = FlexDirectionColumn
    | FlexDirectionRow


{-| Accepts a flex-direction and modifies the flex container accordingly.
-}
direction : FlexDirection -> Modifier GridContainerDetails
direction =
    setDirection << Just


{-| Defines the flex direction column.
-}
column : FlexDirection
column =
    FlexDirectionColumn


{-| Defines the flex direction row.
-}
row : FlexDirection
row =
    FlexDirectionRow


{-| Represents a flex wrap.
Can be wrap or no-wrap.
-}
type FlexWrap
    = FlexWrapWrap
    | FlexWrapNoWrap


{-| Modifies the flex-wrap to wrap.
-}
wrap : Modifier GridContainerDetails
wrap =
    setWrap <| Just FlexWrapWrap


{-| Modifies the flex-wrap to no-wrap.
-}
noWrap : Modifier GridContainerDetails
noWrap =
    setWrap <| Just FlexWrapNoWrap


{-| Represents the alignment in flex.
Can be baseline, center, flex-start, flex-end, inherit, initial or stretch.
-}
type Align
    = AlignBaseline
    | AlignCenter
    | AlignFlexStart
    | AlignFlexEnd
    | AlignInherit
    | AlignInitial
    | AlignStretch


{-| Accepts an Align, and modifies the flex container accordingly.
-}
align : Align -> Modifier GridContainerDetails
align =
    setAlign << Just


{-| Generates a baseline alignment.
-}
baseline : Align
baseline =
    AlignBaseline


{-| Generates a center alignment.
-}
center : Align
center =
    AlignCenter


{-| Generates a flex-start alignment.
-}
flexStart : Align
flexStart =
    AlignFlexStart


{-| Generates a flex-end alignment.
-}
flexEnd : Align
flexEnd =
    AlignFlexEnd


{-| Generates a inherit alignment.
-}
inherit : Align
inherit =
    AlignInherit


{-| Generates a initial alignment.
-}
initial : Align
initial =
    AlignInitial


{-| Generates a stretch alignment.
-}
stretch : Align
stretch =
    AlignStretch


{-| Represents the value of justify-content.
Can be space-between, space-around or center.
-}
type JustifyContent
    = JustifyContentSpaceBetween
    | JustifyContentSpaceAround
    | JustifyContentCenter


{-| Accepts a justify-content and modifies the flex container accordingly.
-}
justifyContent : JustifyContent -> Modifier GridContainerDetails
justifyContent =
    setJustifyContent << Just


{-| Defines the justify-content space-between.
-}
spaceBetween : JustifyContent
spaceBetween =
    JustifyContentSpaceBetween


{-| Defines the justify-content space-around.
-}
spaceAround : JustifyContent
spaceAround =
    JustifyContentSpaceAround


{-| Defines the justify-content center.
-}
justifyContentCenter : JustifyContent
justifyContentCenter =
    JustifyContentCenter


{-| Contains all style which can be used on a flex item.
This contains flex-grow, flex-shrink, flex-basis and align-self.
-}
type alias GridItemDetails =
    { grow : Maybe Int
    , shrink : Maybe Int
    , basis : Maybe (Either SizeUnit Auto)
    , alignSelf : Maybe Align
    }


{-|
-}
defaultGridItemDetails : GridItemDetails
defaultGridItemDetails =
    GridItemDetails Nothing Nothing Nothing Nothing


{-| Accepts an int and sets the flex-grow accordingly.
-}
grow : Int -> Modifier GridItemDetails
grow =
    setGrow << Just


{-| Accepts an int and sets the flex-shrink accordingly.
-}
shrink : Int -> Modifier GridItemDetails
shrink =
    setShrink << Just


{-| Sets the flex-basis as auto.
-}
basisAuto : Modifier GridItemDetails
basisAuto =
    setBasis <| Just <| Right Auto


{-| Accepts a size and sets the flex-basis accordingly.
-}
basis : SizeUnit -> Modifier GridItemDetails
basis =
    setBasis << Just << Left


{-| Accepts an align and modifies the flex item accordingly.
-}
alignSelf : Align -> Modifier GridItemDetails
alignSelf =
    setAlignSelf << Just


alignItemsToCouple : Align -> ( String, String )
alignItemsToCouple =
    (,) "align-items" << alignToString


alignSelfToCouple : Align -> ( String, String )
alignSelfToCouple =
    (,) "align-self" << alignToString


alignToString : Align -> String
alignToString align =
    case align of
        AlignBaseline ->
            "baseline"

        AlignCenter ->
            "center"

        AlignFlexStart ->
            "flex-start"

        AlignFlexEnd ->
            "flex-end"

        AlignInherit ->
            "flex-end"

        AlignInitial ->
            "initial"

        AlignStretch ->
            "stretch"


{-|
-}
gridItemDetailsToCouples : GridItemDetails -> List ( String, String )
gridItemDetailsToCouples gridContainerDetails =
    [ unwrapToCouple .grow growToCouple
    , unwrapToCouple .shrink shrinkToCouple
    , unwrapToCouple .basis basisToCouple
    , unwrapToCouple .alignSelf alignSelfToCouple
    ]
        |> List.concatMap (callOn gridContainerDetails)


{-|
-}
gridContainerDetailsToCouples : GridContainerDetails -> List ( String, String )
gridContainerDetailsToCouples gridContainerDetails =
    [ unwrapToCouple .direction directionToCouple
    , unwrapToCouple .wrap flexWrapToCouple
    , unwrapToCouple .align alignItemsToCouple
    , unwrapToCouple .justifyContent justifyContentToCouple
    ]
        |> List.concatMap (callOn gridContainerDetails)


justifyContentToCouple : JustifyContent -> ( String, String )
justifyContentToCouple =
    (,) "justify-content" << justifyContentToString


justifyContentToString : JustifyContent -> String
justifyContentToString val =
    case val of
        JustifyContentSpaceBetween ->
            "space-between"

        JustifyContentSpaceAround ->
            "space-around"

        JustifyContentCenter ->
            "center"


flexWrapToCouple : FlexWrap -> ( String, String )
flexWrapToCouple =
    (,) "flex-wrap" << flexWrapToString


flexWrapToString : FlexWrap -> String
flexWrapToString val =
    case val of
        FlexWrapWrap ->
            "wrap"

        FlexWrapNoWrap ->
            "nowrap"
