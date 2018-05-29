module Flex
    exposing
        ( Align
        , FlexContainerDetails
        , FlexDirection
        , FlexItemDetails
        , FlexWrap
        , JustifyContent
        , align
        , alignCenter
        , alignSelf
        , alignXY
        , baseline
        , basis
        , basisAuto
        , bottomCenter
        , bottomLeft
        , bottomRight
        , center
        , centerLeft
        , centerRight
        , column
        , defaultFlexContainerDetails
        , defaultFlexItemDetails
        , direction
        , flexContainerDetailsToCouples
        , flexEnd
        , flexItemDetailsToCouples
        , flexStart
        , grow
        , inherit
        , initial
        , justifyContent
        , justifyContentCenter
        , justifyContentFlexEnd
        , justifyContentFlexStart
        , noWrap
        , row
        , shrink
        , spaceAround
        , spaceBetween
        , stretch
        , topCenter
        , topLeft
        , topRight
        , wrap
        )

{-| Flex handles everything related to the flex element.

@docs FlexContainerDetails
@docs FlexItemDetails
@docs FlexDirection
@docs FlexWrap
@docs Align
@docs JustifyContent


## FlexDirection

@docs direction
@docs column
@docs row


## FlexWrap

@docs wrap
@docs noWrap


## AlignItems / AlignSelf

@docs align
@docs alignXY
@docs baseline
@docs alignCenter
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
@docs justifyContentFlexStart
@docs justifyContentFlexEnd


## Positionning

@docs topLeft
@docs topCenter
@docs topRight
@docs centerLeft
@docs center
@docs centerRight
@docs bottomLeft
@docs bottomCenter
@docs bottomRight


## Flex

@docs grow
@docs shrink
@docs basisAuto
@docs basis
@docs alignSelf

@docs defaultFlexContainerDetails
@docs defaultFlexItemDetails
@docs flexContainerDetailsToCouples
@docs flexItemDetailsToCouples

-}

import Either exposing (Either(..))
import Elegant.Setters exposing (..)
import Helpers.Shared exposing (..)
import Modifiers exposing (..)


{-| Contains all style which can be applied on a flex container.
This contains flex-direction, flex-wrap, align-items and justify-content.
-}
type alias FlexContainerDetails =
    { direction : Maybe FlexDirection
    , wrap : Maybe FlexWrap
    , align : Maybe Align
    , justifyContent : Maybe JustifyContent
    }


{-| -}
defaultFlexContainerDetails : FlexContainerDetails
defaultFlexContainerDetails =
    FlexContainerDetails Nothing Nothing Nothing Nothing


{-| Represents a flex direction.
Can be column or row.
-}
type FlexDirection
    = FlexDirectionColumn
    | FlexDirectionRow


{-| Accepts a flex-direction and modifies the flex container accordingly.
-}
direction : FlexDirection -> Modifier FlexContainerDetails
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
wrap : Modifier FlexContainerDetails
wrap =
    setWrap <| Just FlexWrapWrap


{-| Modifies the flex-wrap to no-wrap.
-}
noWrap : Modifier FlexContainerDetails
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
align : Align -> Modifier FlexContainerDetails
align =
    setAlign << Just


{-| Generates a baseline alignment.
-}
baseline : Align
baseline =
    AlignBaseline


{-| Generates a center alignment.
-}
alignCenter : Align
alignCenter =
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
    | JustifyContentFlexStart
    | JustifyContentFlexEnd


{-| Accepts a justify-content and modifies the flex container accordingly.
-}
justifyContent : JustifyContent -> Modifier FlexContainerDetails
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


{-| Defines the justify-content flex-start.
-}
justifyContentFlexStart : JustifyContent
justifyContentFlexStart =
    JustifyContentFlexStart


{-| Defines the justify-content flex-end.
-}
justifyContentFlexEnd : JustifyContent
justifyContentFlexEnd =
    JustifyContentFlexEnd


{-| Contains all style which can be used on a flex item.
This contains flex-grow, flex-shrink, flex-basis and align-self.
-}
type alias FlexItemDetails =
    { grow : Maybe Int
    , shrink : Maybe Int
    , basis : Maybe (Either SizeUnit Auto)
    , alignSelf : Maybe Align
    }


{-| -}
defaultFlexItemDetails : FlexItemDetails
defaultFlexItemDetails =
    FlexItemDetails Nothing Nothing Nothing Nothing


{-| Accepts an int and sets the flex-grow accordingly.
-}
grow : Int -> Modifier FlexItemDetails
grow =
    setGrow << Just


{-| Accepts an int and sets the flex-shrink accordingly.
-}
shrink : Int -> Modifier FlexItemDetails
shrink =
    setShrink << Just


{-| Sets the flex-basis as auto.
-}
basisAuto : Modifier FlexItemDetails
basisAuto =
    setBasis <| Just <| Right Auto


{-| Accepts a size and sets the flex-basis accordingly.
-}
basis : SizeUnit -> Modifier FlexItemDetails
basis =
    setBasis << Just << Left


{-| Accepts an align and modifies the flex item accordingly.
-}
alignSelf : Align -> Modifier FlexItemDetails
alignSelf =
    setAlignSelf << Just


alignItemsToCouple : Align -> ( String, String )
alignItemsToCouple =
    Tuple.pair "align-items" << alignToString


alignSelfToCouple : Align -> ( String, String )
alignSelfToCouple =
    Tuple.pair "align-self" << alignToString


alignToString : Align -> String
alignToString align_ =
    case align_ of
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


{-| -}
alignXY : ( Align, JustifyContent ) -> FlexContainerDetails -> FlexContainerDetails
alignXY ( x, y ) =
    align x >> justifyContent y


{-| -}
topLeft : FlexContainerDetails -> FlexContainerDetails
topLeft =
    alignXY ( AlignFlexStart, JustifyContentFlexStart )


{-| -}
topCenter : FlexContainerDetails -> FlexContainerDetails
topCenter =
    alignXY ( AlignCenter, JustifyContentFlexStart )


{-| -}
topRight : FlexContainerDetails -> FlexContainerDetails
topRight =
    alignXY ( AlignFlexEnd, JustifyContentFlexStart )


{-| -}
centerLeft : FlexContainerDetails -> FlexContainerDetails
centerLeft =
    alignXY ( AlignFlexStart, JustifyContentCenter )


{-| -}
center : FlexContainerDetails -> FlexContainerDetails
center =
    alignXY ( AlignCenter, JustifyContentCenter )


{-| -}
centerRight : FlexContainerDetails -> FlexContainerDetails
centerRight =
    alignXY ( AlignFlexEnd, JustifyContentCenter )


{-| -}
bottomLeft : FlexContainerDetails -> FlexContainerDetails
bottomLeft =
    alignXY ( AlignFlexStart, JustifyContentFlexEnd )


{-| -}
bottomCenter : FlexContainerDetails -> FlexContainerDetails
bottomCenter =
    alignXY ( AlignCenter, JustifyContentFlexEnd )


{-| -}
bottomRight : FlexContainerDetails -> FlexContainerDetails
bottomRight =
    alignXY ( AlignFlexEnd, JustifyContentFlexEnd )


{-| -}
flexItemDetailsToCouples : FlexItemDetails -> List ( String, String )
flexItemDetailsToCouples flexContainerDetails =
    [ unwrapToCouple .grow growToCouple
    , unwrapToCouple .shrink shrinkToCouple
    , unwrapToCouple .basis basisToCouple
    , unwrapToCouple .alignSelf alignSelfToCouple
    ]
        |> List.concatMap (callOn flexContainerDetails)


{-| -}
flexContainerDetailsToCouples : FlexContainerDetails -> List ( String, String )
flexContainerDetailsToCouples flexContainerDetails =
    [ unwrapToCouple .direction directionToCouple
    , unwrapToCouple .wrap flexWrapToCouple
    , unwrapToCouple .align alignItemsToCouple
    , unwrapToCouple .justifyContent justifyContentToCouple
    ]
        |> List.concatMap (callOn flexContainerDetails)


directionToCouple : FlexDirection -> ( String, String )
directionToCouple =
    Tuple.pair "flex-direction" << directionToString


directionToString : FlexDirection -> String
directionToString direction_ =
    case direction_ of
        FlexDirectionColumn ->
            "column"

        FlexDirectionRow ->
            "row"


growToCouple : Int -> ( String, String )
growToCouple =
    Tuple.pair "flex-grow" << String.fromInt


shrinkToCouple : Int -> ( String, String )
shrinkToCouple =
    Tuple.pair "flex-shrink" << String.fromInt


basisToCouple : Either SizeUnit Auto -> ( String, String )
basisToCouple =
    Tuple.pair "flex-basis" << basisToString


basisToString : Either SizeUnit Auto -> String
basisToString autoSizeUnitEither =
    case autoSizeUnitEither of
        Left su ->
            sizeUnitToString su

        Right _ ->
            "auto"


justifyContentToCouple : JustifyContent -> ( String, String )
justifyContentToCouple =
    Tuple.pair "justify-content" << justifyContentToString


justifyContentToString : JustifyContent -> String
justifyContentToString val =
    case val of
        JustifyContentSpaceBetween ->
            "space-between"

        JustifyContentSpaceAround ->
            "space-around"

        JustifyContentCenter ->
            "center"

        JustifyContentFlexStart ->
            "flex-start"

        JustifyContentFlexEnd ->
            "flex-end"


flexWrapToCouple : FlexWrap -> ( String, String )
flexWrapToCouple =
    Tuple.pair "flex-wrap" << flexWrapToString


flexWrapToString : FlexWrap -> String
flexWrapToString val =
    case val of
        FlexWrapWrap ->
            "wrap"

        FlexWrapNoWrap ->
            "nowrap"


flexDirectionToCouple : FlexDirection -> ( String, String )
flexDirectionToCouple =
    Tuple.pair "flex-direction" << flexDirectionToString


flexDirectionToString : FlexDirection -> String
flexDirectionToString val =
    case val of
        FlexDirectionColumn ->
            "column"

        FlexDirectionRow ->
            "row"
