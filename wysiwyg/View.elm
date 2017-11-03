module View exposing (..)

import Types exposing (..)
import BodyBuilder as B exposing (Node)
import BodyBuilder.Attributes as A
import BodyBuilder.Events as Events
import Elegant exposing (Modifier, Modifiers, px, percent)
import Either exposing (Either(..))
import Color exposing (Color)
import Style as S
import Display
import Box
import Block
import Grid
import Flex


view : Model -> Node Msg
view model =
    B.grid
        [ A.style
            [ S.block [ Block.height (percent 100) ]
            , S.gridContainerProperties
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
            , S.box [ Box.backgroundColor Color.white ]
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
            [ S.gridItemProperties
                [ Grid.horizontal
                    [ Grid.placement x width
                    , Grid.align Grid.stretch
                    ]
                , Grid.vertical
                    [ Grid.placement y height
                    , Grid.align Grid.stretch
                    ]
                ]
            , S.box [ Box.backgroundColor (Color.rgba 0 0 0 0.1) ]
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
                [ S.block [ Block.height (percent 100) ]
                ]
            ]
            (insidePossibilities
                |> List.map
                    (\( msg, str ) ->
                        B.flexItem []
                            [ B.button
                                [ A.style [ S.block [ Block.height (percent 100) ] ]
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
        [ A.style [ S.box [ Box.backgroundColor (Color.rgba 180 180 240 0.4) ] ] ]
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


extractTemplateFromGridContainer :
    (Grid.GridContainerDetails -> Maybe Grid.GridContainerCoordinate)
    -> Grid.GridContainerDetails
    -> Maybe (List Grid.Repeatable)
extractTemplateFromGridContainer getter gridContainer =
    gridContainer
        |> getter
        |> Maybe.andThen .template


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


extractGridTemplateFromStyle :
    (Grid.GridContainerDetails -> Maybe Grid.GridContainerCoordinate)
    -> Elegant.CommonStyle
    -> Maybe (List Grid.Repeatable)
extractGridTemplateFromStyle getter =
    extractGridContainerDetailsFromStyle >> Maybe.andThen (extractTemplateFromGridContainer getter)


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


gridEditor :
    { attributes : { style : Elegant.CommonStyle }, children : List (Element Msg) }
    -> Node Msg
gridEditor ({ attributes, children } as grid) =
    let
        xTemplate =
            extractGridTemplateFromStyle .x attributes.style |> Maybe.withDefault []

        yTemplate =
            extractGridTemplateFromStyle .y attributes.style |> Maybe.withDefault []
    in
        B.grid
            [ A.style
                [ S.gridContainerProperties
                    [ Grid.columns
                        [ Grid.template
                            [ Grid.simple (Grid.sizeUnitVal (px 50))
                            , Grid.simple (Grid.fractionOfAvailableSpace 1)
                            , Grid.simple (Grid.sizeUnitVal (px 50))
                            ]
                        , Grid.gap (px 10)
                        ]
                    , Grid.rows
                        [ Grid.template
                            [ Grid.simple (Grid.sizeUnitVal (px 50))
                            , Grid.simple (Grid.fractionOfAvailableSpace 1)
                            , Grid.simple (Grid.sizeUnitVal (px 50))
                            ]
                        , Grid.gap (px 10)
                        ]
                    ]
                ]
            ]
            [ item ( 1, 0 ) ( Grid.span 1, Grid.span 1 ) [ arrowSelection xTemplate Grid.columns "v" ]
            , item ( 0, 1 ) ( Grid.span 1, Grid.span 1 ) [ arrowSelection yTemplate Grid.rows ">" ]
            , item ( 1, 1 ) ( Grid.span 1, Grid.span 1 ) [ gridView grid xTemplate yTemplate ]
            , item ( 2, 1 ) ( Grid.span 1, Grid.span 1 ) [ addButton Flex.column ]
            , item ( 1, 2 ) ( Grid.span 1, Grid.span 1 ) [ addButton Flex.row ]
            ]


gridView :
    { c | attributes : { a | style : Elegant.CommonStyle }, children : b }
    -> List d
    -> List e
    -> Node msg
gridView { attributes, children } xTemplate yTemplate =
    B.grid
        [ attributes.style |> Elegant.commonStyleToStyle |> A.rawStyle ]
        ((List.foldr
            (\element ( beginning, result ) ->
                ( beginning + 1, result ++ [ item ( beginning, 0 ) ( Grid.span 1, Grid.untilEndOfCoordinate ) [] ] )
            )
            ( 0, [] )
            xTemplate
            |> Tuple.second
         )
            ++ (List.foldr
                    (\element ( beginning, result ) ->
                        ( beginning + 1, result ++ [ item ( 0, beginning ) ( Grid.untilEndOfCoordinate, Grid.span 1 ) [] ] )
                    )
                    ( 0, [] )
                    yTemplate
                    |> Tuple.second
               )
        )


arrowSelection :
    List Grid.Repeatable
    -> (Modifiers Grid.GridContainerCoordinate -> Modifier Grid.GridContainerDetails)
    -> String
    -> Node Msg
arrowSelection repeatables selector text =
    B.grid
        [ A.style
            [ S.gridContainerProperties
                [ selector
                    [ Grid.template repeatables ]
                ]
            ]
        ]
        (B.gridItem [] [ B.text text ] |> List.repeat (List.length repeatables))


addButton : Flex.FlexDirection -> Node Msg
addButton orientation =
    B.flex
        [ A.style [ S.flexContainerProperties [ Flex.direction orientation ] ] ]
        [ B.flexItem [] [ B.text "+" ] ]


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
                        , case tree of
                            Left (Grid grid) ->
                                gridEditor grid

                            _ ->
                                B.text ""
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
        >> B.div [ A.style [ S.box [ Box.paddingLeft (px 12) ] ] ]
        >> List.singleton


displayTreeView : Int -> Element msg -> Node Msg
displayTreeView selectedId { id, tree } =
    B.div [] <|
        case tree of
            Left treeType ->
                case treeType of
                    Text content ->
                        [ B.div [ A.style [ S.box [ Box.paddingLeft (px 12) ] ] ]
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
