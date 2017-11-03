module View exposing (..)

import Types exposing (..)
import BodyBuilder as B exposing (Node)
import BodyBuilder.Attributes as A
import BodyBuilder.Events as Events
import Elegant exposing (Modifiers, px, percent)
import Either exposing (Either(..))
import Color exposing (Color)
import Style
import Display
import Box
import Block
import Grid


view : Model -> Node Msg
view model =
    B.grid
        [ A.style
            [ Style.block [ Block.height (percent 100) ]
            , Style.gridContainerProperties
                [ Grid.columns
                    [ Grid.template
                        [ Grid.simple (Grid.fractionOfAvailableSpace 2)
                        , Grid.simple (Grid.fractionOfAvailableSpace 1)
                        ]
                    , Grid.gap (px 12)
                    , Grid.align Grid.stretch
                    , Grid.alignItems (Grid.alignWrapper Grid.center)
                    ]
                , Grid.rows
                    [ Grid.template
                        [ Grid.simple (Grid.sizeUnitVal (px 36))
                        , Grid.simple (Grid.fractionOfAvailableSpace 1)
                        , Grid.simple (Grid.fractionOfAvailableSpace 1)
                        ]
                    , Grid.gap (px 12)
                    , Grid.align Grid.stretch
                    , Grid.alignItems (Grid.alignWrapper Grid.center)
                    ]
                ]
            , Style.box [ Box.backgroundColor Color.white ]
            ]
        ]
        [ item ( 0, 0 ) ( Grid.untilEndOfCoordinate, Grid.span 1 ) [ creationView model ]
        , item ( 0, 1 ) ( Grid.span 1, Grid.untilEndOfCoordinate ) [ contentView model ]
        , item ( 1, 1 ) ( Grid.untilEndOfCoordinate, Grid.span 1 ) [ inspectorView model ]
        , item ( 1, 2 ) ( Grid.untilEndOfCoordinate, Grid.untilEndOfCoordinate ) [ treeView model ]
        ]


item :
    ( Int, Int )
    -> ( Grid.GridItemSize, Grid.GridItemSize )
    -> List (Node msg)
    -> B.GridItem msg
item ( x, y ) ( width, height ) =
    B.gridItem
        [ A.style
            [ Style.gridItemProperties
                [ Grid.horizontal
                    [ Grid.placement x (width)
                    , Grid.align Grid.stretch
                    ]
                , Grid.vertical
                    [ Grid.placement y (height)
                    , Grid.align Grid.stretch
                    ]
                ]
            , Style.box [ Box.backgroundColor (Color.rgba 0 0 0 0.1) ]
            ]
        ]


creationView : Model -> Node Msg
creationView model =
    let
        selectedElement : Maybe (Element Msg)
        selectedElement =
            getById model.selectedId model.element

        insidePossibilities =
            case selectedElement of
                Nothing ->
                    []

                Just selectedEl ->
                    case selectedEl.tree of
                        Right gridElement ->
                            []

                        Left tree ->
                            case tree of
                                Block a ->
                                    case a.tag of
                                        "div" ->
                                            [ ( CreateP, "p" )
                                            , ( CreateH1, "h1" )
                                            , ( CreateGrid, "grid" )
                                            ]

                                        "p" ->
                                            []

                                        "h1" ->
                                            []

                                        _ ->
                                            []

                                _ ->
                                    []
    in
        B.flex
            [ A.style
                [ Style.block [ Block.height (percent 100) ]
                ]
            ]
            (insidePossibilities
                |> List.map
                    (\( msg, str ) ->
                        B.flexItem []
                            [ B.button
                                [ A.style [ Style.block [ Block.height (percent 100) ] ]
                                , Events.onClick msg
                                ]
                                [ B.text str ]
                            ]
                    )
            )


contentView : Model -> Node Msg
contentView { element, selectedId } =
    B.div []
        [ contentViewEl selectedId element ]


selectOrSelected : Int -> Int -> Modifiers (A.VisibleAttributesAndEvents Msg a)
selectOrSelected id selectedId =
    if id == selectedId then
        [ A.style [ Style.box [ Box.backgroundColor (Color.rgba 180 180 240 0.4) ] ] ]
    else
        [ Events.onClick (SelectEl id) ]


contentViewGridItem : Int -> Element Msg -> List (B.GridItem Msg)
contentViewGridItem selectedId { tree, id } =
    case tree of
        Left treeType ->
            []

        Right (GridItem gridItem) ->
            [ B.gridItem
                ([ A.class [ Elegant.commonStyleToCss gridItem.attributes.style ] ] ++ selectOrSelected id selectedId)
                (List.map (contentViewEl selectedId) gridItem.children)
            ]


contentViewEl : Int -> Element Msg -> Node Msg
contentViewEl selectedId { tree, id } =
    case tree of
        Left treeType ->
            case treeType of
                Grid grid ->
                    B.grid
                        ([ A.class [ Elegant.commonStyleToCss grid.attributes.style ] ] ++ selectOrSelected id selectedId)
                        (List.concatMap (contentViewGridItem selectedId) grid.children)

                Block block ->
                    block.constructor
                        ([ A.class [ Elegant.commonStyleToCss block.attributes.style ] ] ++ selectOrSelected id selectedId)
                        (List.map (contentViewEl selectedId) block.children)

                Text content ->
                    B.text content

        Right gridItem ->
            B.text ""



-- type InsideDisplay
--     = Flow
--     | FlexContainer (Maybe Flex.FlexContainerDetails)
--     | GridContainer (Maybe Grid.GridContainerDetails)


extractGridContainerDetailsFromStyle : Elegant.CommonStyle -> Maybe Grid.GridContainerDetails
extractGridContainerDetailsFromStyle style =
    case style.display of
        Just display ->
            case display of
                Display.None ->
                    Nothing

                Display.ContentsWrapper { insideDisplay } ->
                    case insideDisplay of
                        Display.GridContainer gridContainer ->
                            gridContainer

                        _ ->
                            Nothing

        Nothing ->
            Nothing



-- { gutter : Maybe SizeUnit
-- , align : Maybe Align
-- , alignItems : Maybe AlignItems
-- , template : Maybe GridTemplate
-- }


extractTemplateLengthFromGridContainer :
    (Grid.GridContainerDetails -> Maybe Grid.GridContainerCoordinate)
    -> Grid.GridContainerDetails
    -> Maybe Int
extractTemplateLengthFromGridContainer getter gridContainer =
    gridContainer
        |> getter
        |> Maybe.andThen .template
        |> Maybe.map (List.length)


extractGridGapFromGridContainer :
    (Grid.GridContainerDetails -> Maybe Grid.GridContainerCoordinate)
    -> Grid.GridContainerDetails
    -> Maybe Elegant.SizeUnit
extractGridGapFromGridContainer getter gridContainer =
    gridContainer
        |> getter
        |> Maybe.andThen .gutter


extractGridGapFromStyle :
    (Grid.GridContainerDetails -> Maybe Grid.GridContainerCoordinate)
    -> Elegant.CommonStyle
    -> Maybe Elegant.SizeUnit
extractGridGapFromStyle getter =
    extractGridContainerDetailsFromStyle >> Maybe.andThen (extractGridGapFromGridContainer getter)


extractGridTemplateLengthFromStyle :
    (Grid.GridContainerDetails -> Maybe Grid.GridContainerCoordinate)
    -> Elegant.CommonStyle
    -> Maybe Int
extractGridTemplateLengthFromStyle getter =
    extractGridContainerDetailsFromStyle >> Maybe.andThen (extractTemplateLengthFromGridContainer getter)


extractColorFromStyle : Elegant.CommonStyle -> Maybe Color
extractColorFromStyle style =
    case style.display of
        Nothing ->
            Nothing

        Just display ->
            case display of
                Display.None ->
                    Nothing

                Display.ContentsWrapper contents ->
                    contents.maybeBox
                        |> Maybe.andThen .background
                        |> Maybe.andThen .color


gridEditor : Either (Tree Msg) (GridItem Msg) -> Node Msg
gridEditor item =
    case item of
        Right _ ->
            B.text ""

        Left tree ->
            case tree of
                Grid grid ->
                    B.div []
                        [ B.h1 [] [ B.text "Grid" ]
                        , B.grid
                            [ A.style
                                [ Style.box [ Box.backgroundColor Color.red ]
                                , Style.gridContainerProperties
                                    [ Grid.columns <|
                                        case extractGridTemplateLengthFromStyle .x grid.attributes.style of
                                            Nothing ->
                                                []

                                            Just number ->
                                                [ Grid.template
                                                    ([ Grid.simple (Grid.sizeUnitVal (px 12)) ]
                                                        ++ (List.repeat number (Grid.simple (Grid.sizeUnitVal (px 50))))
                                                        ++ [ Grid.simple (Grid.sizeUnitVal (px 60)) ]
                                                    )
                                                , Grid.gap (Maybe.withDefault (px 0) (extractGridGapFromStyle .x grid.attributes.style))
                                                ]
                                    , Grid.rows <|
                                        case extractGridTemplateLengthFromStyle .y grid.attributes.style of
                                            Nothing ->
                                                []

                                            Just number ->
                                                [ Grid.template
                                                    ([ Grid.simple (Grid.sizeUnitVal (px 12)) ]
                                                        ++ (List.repeat number (Grid.simple (Grid.sizeUnitVal (px 50))))
                                                        ++ [ Grid.simple (Grid.sizeUnitVal (px 60)) ]
                                                    )
                                                , Grid.gap (Maybe.withDefault (px 0) (extractGridGapFromStyle .y grid.attributes.style))
                                                ]
                                    ]
                                ]
                            ]
                            []
                        ]

                _ ->
                    B.text ""


inspectorView : Model -> Node Msg
inspectorView model =
    let
        selectedElement : Maybe (Element Msg)
        selectedElement =
            model.element
                |> getById model.selectedId
    in
        case selectedElement of
            Nothing ->
                B.div [] [ B.text "Nothing" ]

            Just { id, tree } ->
                let
                    color : Color.Color
                    color =
                        getColorFromTree tree
                in
                    B.div []
                        [ B.h1 [] [ B.text "Inspector" ]
                        , B.div []
                            [ B.text "Box Attributes" ]
                        , B.div []
                            [ B.text "Box color" ]
                        , B.div []
                            [ B.inputColor [ Events.onInput ChangeBoxColor, A.value color ] ]
                        , gridEditor tree
                        ]


treeView : Model -> Node Msg
treeView { selectedId, element } =
    B.div []
        [ B.h1 [] [ B.text "Tree view" ]
        , displayTreeView selectedId element
        ]


treeViewElement : Int -> Int -> String -> List (Element msg) -> List (Node Msg)
treeViewElement id selectedId tag =
    List.map (displayTreeView selectedId)
        >> (::) (B.div (selectOrSelected id selectedId) [ B.text tag ])
        >> B.div [ A.style [ Style.box [ Box.paddingLeft (px 12) ] ] ]
        >> List.singleton


displayTreeView : Int -> Element msg -> Node Msg
displayTreeView selectedId { id, tree } =
    B.div [] <|
        case tree of
            Left treeType ->
                case treeType of
                    Text content ->
                        [ B.div [ A.style [ Style.box [ Box.paddingLeft (px 12) ] ] ]
                            [ B.div (selectOrSelected id selectedId) [ B.text "text" ] ]
                        ]

                    Block content ->
                        treeViewElement id selectedId content.tag content.children

                    Grid content ->
                        treeViewElement id selectedId "bb-grid" content.children

            Right (GridItem gridItem) ->
                treeViewElement id selectedId "bb-grid-item" gridItem.children


getById : Int -> Element msg -> Maybe (Element msg)
getById id element =
    getByIdHelp id element
        |> List.head


getByIdHelp : Int -> Element msg -> List (Element msg)
getByIdHelp id element =
    if id == element.id then
        [ element ]
    else
        case element.tree of
            Left treeType ->
                case treeType of
                    Block { children } ->
                        List.concatMap (getByIdHelp id) children

                    Grid { children } ->
                        List.concatMap (getByIdHelp id) children

                    Text content ->
                        []

            Right (GridItem gridItem) ->
                List.concatMap (getByIdHelp id) gridItem.children


getColorFromTree : Either (Tree Msg) (GridItem Msg) -> Color.Color
getColorFromTree tree =
    Maybe.withDefault Color.black <|
        case tree of
            Left treeType ->
                case treeType of
                    Block { attributes } ->
                        extractColorFromStyle attributes.style

                    Grid { attributes } ->
                        extractColorFromStyle attributes.style

                    Text content ->
                        Nothing

            Right (GridItem { attributes }) ->
                extractColorFromStyle attributes.style
