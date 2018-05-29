module BodyBuilder.Convert exposing (..)

import BodyBuilder.Attributes as Attributes
import BodyBuilder.Setters exposing (..)
import Box
import Dict exposing (Dict)
import Display
import Elegant
import Flex
import Function
import Grid
import List.Extra
import Maybe.Extra
import Modifiers exposing (..)


type alias StyleComponents =
    { flexContainer : Maybe Flex.FlexContainerDetails
    , flexItem : Maybe Flex.FlexItemDetails
    , gridContainer : Maybe Grid.GridContainerDetails
    , gridItem : Maybe Grid.GridItemDetails
    , block : Maybe Display.BlockDetails
    , box : Maybe Box.Box
    }


defaultStyleComponents : StyleComponents
defaultStyleComponents =
    StyleComponents Nothing Nothing Nothing Nothing Nothing Nothing


toElegantStyle :
    Maybe (List ( Modifiers Flex.FlexContainerDetails, Attributes.StyleSelector ))
    -> Maybe (List ( Modifiers Flex.FlexItemDetails, Attributes.StyleSelector ))
    -> Maybe (List ( Modifiers Grid.GridContainerDetails, Attributes.StyleSelector ))
    -> Maybe (List ( Modifiers Grid.GridItemDetails, Attributes.StyleSelector ))
    -> Maybe (List ( Modifiers Display.BlockDetails, Attributes.StyleSelector ))
    -> List ( Modifiers Box.Box, Attributes.StyleSelector )
    -> List Elegant.Style
toElegantStyle flexModifiers flexItemModifiers gridModifiers gridItemModifiers blockModifiers boxModifiers =
    let
        computedFlexContainerDetails : Maybe (List ( Attributes.StyleSelector, Flex.FlexContainerDetails ))
        computedFlexContainerDetails =
            flexModifiers
                |> Maybe.map
                    (groupByStyleSelectorAndCompute
                        (Flex.FlexContainerDetails Nothing Nothing Nothing Nothing)
                    )

        computedFlexItemDetails : Maybe (List ( Attributes.StyleSelector, Flex.FlexItemDetails ))
        computedFlexItemDetails =
            flexItemModifiers
                |> Maybe.map
                    (groupByStyleSelectorAndCompute
                        (Flex.FlexItemDetails Nothing Nothing Nothing Nothing)
                    )

        computedGridContainerDetails : Maybe (List ( Attributes.StyleSelector, Grid.GridContainerDetails ))
        computedGridContainerDetails =
            gridModifiers
                |> Maybe.map
                    (groupByStyleSelectorAndCompute
                        (Grid.GridContainerDetails Nothing Nothing)
                    )

        computedGridItemDetails : Maybe (List ( Attributes.StyleSelector, Grid.GridItemDetails ))
        computedGridItemDetails =
            gridItemModifiers
                |> Maybe.map
                    (groupByStyleSelectorAndCompute
                        (Grid.GridItemDetails Nothing Nothing)
                    )

        computedBlockDetails : Maybe (List ( Attributes.StyleSelector, Display.BlockDetails ))
        computedBlockDetails =
            blockModifiers
                |> Maybe.map
                    (groupByStyleSelectorAndCompute
                        (Display.BlockDetails Nothing Nothing Nothing Nothing Nothing)
                    )

        computedBoxDetails : List ( Attributes.StyleSelector, Box.Box )
        computedBoxDetails =
            boxModifiers |> groupByStyleSelectorAndCompute Box.default

        key =
            ( computedFlexContainerDetails
            , computedFlexItemDetails
            , computedGridContainerDetails
            , computedGridItemDetails
            , computedBlockDetails
            , computedBoxDetails
            )
    in
    []



-- Native.BodyBuilder.fetchDisplayStyle key
--     |> Maybe.withDefault
--         (separatedComponentsToElegantStyle
--             computedFlexContainerDetails
--             computedFlexItemDetails
--             computedGridContainerDetails
--             computedGridItemDetails
--             computedBlockDetails
--             computedBoxDetails
--             |> Native.BodyBuilder.addDisplayStyle key
--         )


groupByStyleSelectorAndCompute : a -> List ( Modifiers a, Attributes.StyleSelector ) -> List ( Attributes.StyleSelector, a )
groupByStyleSelectorAndCompute default =
    List.Extra.groupWhile (\x y -> Tuple.second x == Tuple.second y)
        >> List.concatMap mergeModifiersAndSwap
        >> List.map (Tuple.mapSecond (\modifiers -> Function.compose modifiers default))


mergeModifiersAndSwap : List ( Modifiers a, Attributes.StyleSelector ) -> List ( Attributes.StyleSelector, Modifiers a )
mergeModifiersAndSwap styles =
    case List.head styles of
        Nothing ->
            []

        Just ( _, styleSelector ) ->
            styles
                |> List.foldr (Tuple.first >> (++)) []
                |> (,) styleSelector
                |> List.singleton


separatedComponentsToElegantStyle :
    Maybe (List ( Attributes.StyleSelector, Flex.FlexContainerDetails ))
    -> Maybe (List ( Attributes.StyleSelector, Flex.FlexItemDetails ))
    -> Maybe (List ( Attributes.StyleSelector, Grid.GridContainerDetails ))
    -> Maybe (List ( Attributes.StyleSelector, Grid.GridItemDetails ))
    -> Maybe (List ( Attributes.StyleSelector, Display.BlockDetails ))
    -> List ( Attributes.StyleSelector, Box.Box )
    -> List Elegant.Style
separatedComponentsToElegantStyle flexModifiers flexItemModifiers gridModifiers gridItemModifiers blockModifiers boxModifiers =
    Dict.empty
        |> insertStyleComponents flexModifiers setFlexContainer
        |> insertStyleComponents flexItemModifiers setFlexItem
        |> insertStyleComponents gridModifiers setGridContainer
        |> insertStyleComponents gridItemModifiers setGridItem
        |> insertStyleComponents blockModifiers setMediaBlock
        |> insertStyleComponents (Just boxModifiers) setMediaBox
        |> Dict.values
        |> List.Extra.groupWhile samePseudoClass
        |> List.map (componentsToElegantStyle (Maybe.Extra.isJust blockModifiers) (Maybe.Extra.isJust flexModifiers) (Maybe.Extra.isJust gridModifiers))


insertStyleComponents :
    Maybe (List ( Attributes.StyleSelector, a ))
    -> (a -> StyleComponents -> StyleComponents)
    -> Dict String ( Attributes.StyleSelector, StyleComponents )
    -> Dict String ( Attributes.StyleSelector, StyleComponents )
insertStyleComponents modifiers setterInMediaQuery result =
    modifiers
        |> Maybe.map (List.foldr (appendInStyleComponent setterInMediaQuery) result)
        |> Maybe.withDefault result


appendInStyleComponent :
    (a -> StyleComponents -> StyleComponents)
    -> ( Attributes.StyleSelector, a )
    -> Dict String ( Attributes.StyleSelector, StyleComponents )
    -> Dict String ( Attributes.StyleSelector, StyleComponents )
appendInStyleComponent setter ( styleSelector, elem ) results =
    let
        key =
            toString styleSelector
    in
    Dict.get key results
        |> Maybe.Extra.unwrap
            (defaultStyleComponents
                |> setter elem
                |> (,) styleSelector
            )
            (Tuple.mapSecond (setter elem))
        |> Function.flip (Dict.insert key) results


samePseudoClass :
    ( Attributes.StyleSelector, StyleComponents )
    -> ( Attributes.StyleSelector, StyleComponents )
    -> Bool
samePseudoClass x y =
    (Tuple.first >> .pseudoClass) x == (Tuple.first >> .pseudoClass) y


componentsToElegantStyle :
    Bool
    -> Bool
    -> Bool
    -> List ( Attributes.StyleSelector, StyleComponents )
    -> Elegant.Style
componentsToElegantStyle isBlock isFlex isGrid components =
    let
        suffix =
            components
                |> List.head
                |> Maybe.Extra.unwrap Nothing (Tuple.first >> .pseudoClass)

        computedDisplay =
            List.map (componentsToParameteredDisplayBox isBlock isFlex isGrid) components
    in
    computedDisplay
        |> List.Extra.find noMediaQueries
        |> Maybe.Extra.unwrap Elegant.emptyStyle (Tuple.second >> Elegant.style)
        |> Maybe.Extra.unwrap identity Elegant.setSuffix suffix
        |> Elegant.withScreenWidth (List.concatMap toScreenWidth computedDisplay)


componentsToParameteredDisplayBox :
    Bool
    -> Bool
    -> Bool
    -> ( Attributes.StyleSelector, StyleComponents )
    -> ( Maybe Attributes.MediaQuery, Display.DisplayBox )
componentsToParameteredDisplayBox isBlock isFlex isGrid ( { media }, { flexContainer, flexItem, gridContainer, gridItem, block, box } ) =
    box
        |> Display.Contents
            (computeOutsideDisplay flexItem gridItem block isBlock)
            (computeInsideDisplay flexItem flexContainer gridItem gridContainer isFlex isGrid)
        |> Display.ContentsWrapper
        |> (,) media


computeOutsideDisplay :
    Maybe Flex.FlexItemDetails
    -> Maybe Grid.GridItemDetails
    -> Maybe Display.BlockDetails
    -> Bool
    -> Display.OutsideDisplay
computeOutsideDisplay flexItem gridItem block isBlock =
    case flexItem of
        Just modifiers ->
            Display.FlexItem (Just modifiers) block

        Nothing ->
            case gridItem of
                Just modifiers ->
                    Display.GridItem (Just modifiers) block

                Nothing ->
                    case block of
                        Just modifiers ->
                            Display.Block (Just modifiers)

                        Nothing ->
                            if isBlock then
                                Display.Block Nothing
                            else
                                Display.Inline


computeInsideDisplay :
    Maybe Flex.FlexItemDetails
    -> Maybe Flex.FlexContainerDetails
    -> Maybe Grid.GridItemDetails
    -> Maybe Grid.GridContainerDetails
    -> Bool
    -> Bool
    -> Display.InsideDisplay
computeInsideDisplay flexItem flexContainer gridItem gridContainer isFlex isGrid =
    case flexItem of
        Just _ ->
            Display.Flow

        Nothing ->
            case gridItem of
                Just _ ->
                    Display.Flow

                Nothing ->
                    case flexContainer of
                        Just modifiers ->
                            Display.FlexContainer (Just modifiers)

                        Nothing ->
                            case gridContainer of
                                Just modifiers ->
                                    Display.GridContainer (Just modifiers)

                                Nothing ->
                                    if isFlex then
                                        Display.FlexContainer Nothing
                                    else if isGrid then
                                        Display.GridContainer Nothing
                                    else
                                        Display.Flow


noMediaQueries : ( Maybe a, b ) -> Bool
noMediaQueries =
    Tuple.first >> Maybe.Extra.isNothing


toScreenWidth :
    ( Maybe Attributes.MediaQuery, Display.DisplayBox )
    -> List { min : Maybe Int, max : Maybe Int, style : Display.DisplayBox }
toScreenWidth ( mediaQuery, display ) =
    Maybe.Extra.unwrap [] (mediaQueryToScreenWidth display) mediaQuery


mediaQueryToScreenWidth :
    Display.DisplayBox
    -> Attributes.MediaQuery
    -> List { min : Maybe Int, max : Maybe Int, style : Display.DisplayBox }
mediaQueryToScreenWidth display mediaQuery =
    case mediaQuery of
        Attributes.Greater x ->
            [ { min = Just x
              , max = Nothing
              , style = display
              }
            ]

        Attributes.Lesser x ->
            [ { min = Nothing
              , max = Just x
              , style = display
              }
            ]

        Attributes.Between x y ->
            [ { min = Just x
              , max = Just y
              , style = display
              }
            ]
