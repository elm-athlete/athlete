module Flex exposing (..)

import Elegant exposing (..)


type Either a b
    = Left a
    | Right b


type FlexWrap
    = FlexWrapWrap
    | FlexWrapNoWrap


type FlexDirection
    = FlexDirectionColumn
    | FlexDirectionRow


type Align
    = AlignBaseline
    | AlignCenter
    | AlignFlexStart
    | AlignFlexEnd
    | AlignInherit
    | AlignInitial
    | AlignStretch


type JustifyContent
    = JustifyContentSpaceBetween
    | JustifyContentSpaceAround
    | JustifyContentCenter


type alias FlexContainerDetails =
    { direction : Maybe FlexDirection
    , wrap : Maybe FlexWrap
    , align : Maybe Align
    , justifyContent : Maybe JustifyContent
    }


type alias FlexItemDetails =
    { grow : Maybe Int
    , shrink : Maybe Int
    , basis : Maybe (Either SizeUnit Auto)
    , alignSelf : Maybe Align
    }


alignItemsToString : Maybe Align -> Maybe String
alignItemsToString =
    nothingOrJust
        (\val ->
            case val of
                AlignBaseline ->
                    "baseline"

                AlignCenter ->
                    "center"

                AlignFlexStart ->
                    "flex-start"

                AlignFlexEnd ->
                    "flex-end"

                AlignInherit ->
                    "inherit"

                AlignInitial ->
                    "initial"

                AlignStretch ->
                    "stretch"
        )


defaultFlexContainerDetails =
    FlexContainerDetails Nothing Nothing Nothing Nothing


flexContainerDetailsDirection val el =
    { el | direction = Just val }


flexContainerDetailsWrap val el =
    { el | wrap = Just val }


flexContainerDetailsalign val el =
    { el | align = Just val }


flexContainerDetailsJustify val el =
    { el | justifyContent = Just val }


flexWrap : FlexWrap -> Style -> Style
flexWrap val (Style style) =
    Style { style | flexWrap = Just val }


{-| -}
flexWrapWrap : Style -> Style
flexWrapWrap =
    flexWrap FlexWrapWrap


{-| -}
flexWrapNoWrap : Style -> Style
flexWrapNoWrap =
    flexWrap FlexWrapNoWrap


flexDirection : FlexDirection -> Style -> Style
flexDirection value (Style style) =
    Style { style | flexDirection = Just value }


{-| -}
flexDirectionColumn : Style -> Style
flexDirectionColumn =
    flexDirection FlexDirectionColumn


{-| -}
flexDirectionRow : Style -> Style
flexDirectionRow =
    flexDirection FlexDirectionRow


flexWrapToString : Maybe FlexWrap -> Maybe String
flexWrapToString =
    nothingOrJust
        (\val ->
            case val of
                FlexWrapWrap ->
                    "wrap"

                FlexWrapNoWrap ->
                    "nowrap"
        )


flexDirectionToString : Maybe FlexDirection -> Maybe String
flexDirectionToString =
    nothingOrJust
        (\val ->
            case val of
                FlexDirectionColumn ->
                    "column"

                FlexDirectionRow ->
                    "row"
        )
