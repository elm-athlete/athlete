module BodyBuilder.Convert exposing (..)

import Helpers.Shared exposing (Modifiers)
import BodyBuilder.Setters exposing (..)
import Elegant
import Display
import Box
import BodyBuilder.Attributes as Attributes
import List.Extra
import Dict exposing (Dict)
import Maybe.Extra


type alias MediaQueriesStyled =
    { flexContainer : Maybe Display.FlexContainerDetails
    , flexItem : Maybe Display.FlexItemDetails
    , block : Maybe Display.BlockDetails
    , box : Maybe Box.Box
    }


defaultMediaQueriesStyled : MediaQueriesStyled
defaultMediaQueriesStyled =
    MediaQueriesStyled Nothing Nothing Nothing Nothing


toElegantStyle : Bool -> List ( Attributes.StyleSelector, MediaQueriesStyled ) -> Elegant.Style
toElegantStyle isFlex components =
    let
        suffix =
            case List.head components of
                Nothing ->
                    Nothing

                Just ( styleSelector, _ ) ->
                    styleSelector.pseudoClass

        computedDisplay =
            List.map (toDisplayBox isFlex) components

        baseStyle =
            case List.Extra.find (\( media, display ) -> media == Nothing) computedDisplay of
                Nothing ->
                    Elegant.emptyStyle
                        |> (Maybe.map (Elegant.setSuffix) suffix |> Maybe.withDefault identity)

                Just ( _, display ) ->
                    Elegant.style display
                        |> (Maybe.map (Elegant.setSuffix) suffix |> Maybe.withDefault identity)
    in
        baseStyle
            |> Elegant.withScreenWidth (List.concatMap toScreenWidth computedDisplay)


toScreenWidth : ( Maybe Attributes.MediaQuery, Display.DisplayBox ) -> List { min : Maybe Int, max : Maybe Int, style : Display.DisplayBox }
toScreenWidth ( mediaQuery, display ) =
    case mediaQuery of
        Nothing ->
            []

        Just mediaQuery_ ->
            case mediaQuery_ of
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


toDisplayBox : Bool -> ( Attributes.StyleSelector, MediaQueriesStyled ) -> ( Maybe Attributes.MediaQuery, Display.DisplayBox )
toDisplayBox isFlex ( { media }, { flexContainer, flexItem, block, box } ) =
    let
        displayInside =
            case flexItem of
                Just _ ->
                    Display.Flow

                Nothing ->
                    case flexContainer of
                        Just modifiers ->
                            Display.FlexContainer (Just modifiers)

                        Nothing ->
                            if isFlex then
                                Display.FlexContainer Nothing
                            else
                                Display.Flow

        displayOutside =
            case flexItem of
                Just modifiers ->
                    Display.FlexItem (Just modifiers) block

                Nothing ->
                    case block of
                        Just modifiers ->
                            Display.Block (Just modifiers)

                        Nothing ->
                            Display.Inline
    in
        ( media, Display.ContentsWrapper (Display.Contents displayOutside displayInside box) )


displayStyle :
    Maybe (List ( Attributes.StyleSelector, Display.FlexContainerDetails ))
    -> Maybe (List ( Attributes.StyleSelector, Display.FlexItemDetails ))
    -> Maybe (List ( Attributes.StyleSelector, Display.BlockDetails ))
    -> List ( Attributes.StyleSelector, Box.Box )
    -> List Elegant.Style
displayStyle flexModifiers flexItemModifiers blockModifiers boxModifiers =
    Dict.empty
        |> addModifiers flexModifiers setFlexContainer
        |> addModifiers flexItemModifiers setFlexItem
        |> addModifiers blockModifiers setMediaBlock
        |> addModifiers (Just boxModifiers) setMediaBox
        |> Dict.values
        |> List.Extra.groupWhile (\x y -> (Tuple.first >> .pseudoClass) x == (Tuple.first >> .pseudoClass) y)
        |> List.map (toElegantStyle (Maybe.Extra.isJust flexModifiers))


addModifiers :
    Maybe (List ( Attributes.StyleSelector, a ))
    -> (a -> MediaQueriesStyled -> MediaQueriesStyled)
    -> Dict String ( Attributes.StyleSelector, MediaQueriesStyled )
    -> Dict String ( Attributes.StyleSelector, MediaQueriesStyled )
addModifiers modifiers setterInMediaQuery result =
    case modifiers of
        Nothing ->
            result

        Just modifiers_ ->
            modifiers_
                |> List.foldr (addInResults setterInMediaQuery) result


mergeModifiers : List ( Modifiers a, Attributes.StyleSelector ) -> List ( Attributes.StyleSelector, Modifiers a )
mergeModifiers styles =
    case List.head styles of
        Nothing ->
            []

        Just ( _, styleSelector ) ->
            styles
                |> List.foldr concatModifiers []
                |> (,) styleSelector
                |> List.singleton


concatModifiers : ( Modifiers a, b ) -> Modifiers a -> Modifiers a
concatModifiers ( modifiers, _ ) acc =
    acc ++ modifiers


addInResults :
    (a -> MediaQueriesStyled -> MediaQueriesStyled)
    -> ( Attributes.StyleSelector, a )
    -> Dict String ( Attributes.StyleSelector, MediaQueriesStyled )
    -> Dict String ( Attributes.StyleSelector, MediaQueriesStyled )
addInResults setter ( styleSelector, elem ) results =
    let
        key =
            toString styleSelector
    in
        case Dict.get key results of
            Nothing ->
                defaultMediaQueriesStyled
                    |> setter elem
                    |> (,) styleSelector
                    |> flip (Dict.insert key) results

            Just mediaQueries ->
                mediaQueries
                    |> Tuple.mapSecond (setter elem)
                    |> flip (Dict.insert key) results
