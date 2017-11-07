module Main exposing (..)

import BodyBuilder as B exposing (Node)
import BodyBuilder.Attributes as A
import BodyBuilder.Events as E
import Style as S
import Color exposing (Color)
import Elegant exposing (px, vh, percent, Modifiers, Modifier)
import Box
import Block
import Background
import Display
import Update
import Grid
import Flex


init : ( Model, Cmd Msg )
init =
    { element = defaultDiv 1
    , selectedId = 1
    , autoIncrement = 2
    }
        ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    Update.identity <|
        case msg of
            CreateP ->
                defaultP |> putElementAsChildIntoModel model

            CreateH1 ->
                defaultH1 |> putElementAsChildIntoModel model

            CreateGrid ->
                defaultGrid |> putElementAsChildIntoModel model

            CreateDiv ->
                defaultDiv |> putElementAsChildIntoModel model

            CreateText ->
                defaultText "Change me" |> putElementAsChildIntoModel model

            CreateSpan ->
                defaultSpan |> putElementAsChildIntoModel model

            SelectEl id ->
                model |> setSelectedId id

            ChangeBoxColor color ->
                model |> changeBoxColorOfCurrentElement color

            ChangeText text ->
                model |> changeTextOfCurrentElement text

            AddColumn ->
                model |> addColumnInGrid

            AddRow ->
                model


addChildToTree : Element msg -> Tree msg -> Tree msg
addChildToTree child parent =
    case parent of
        Block block ->
            block
                |> .children
                |> flip List.append [ child ]
                |> setChildrenIn block
                |> Block

        Inline inline ->
            inline
                |> .children
                |> flip List.append [ child ]
                |> setChildrenIn inline
                |> Inline

        Grid grid ->
            grid
                |> .children
                |> flip List.append [ child ]
                |> setChildrenIn grid
                |> Grid

        GridItem gridItem ->
            gridItem
                |> .children
                |> flip List.append [ child ]
                |> setChildrenIn gridItem
                |> GridItem

        Text content ->
            Text content


addChildToElement : Element msg -> Element msg -> Element msg
addChildToElement ({ tree } as parent) child =
    tree
        |> addChildToTree child
        |> setTreeIn parent


changeBoxColorOfCurrentElement : Color.Color -> Model -> Model
changeBoxColorOfCurrentElement color ({ element, selectedId } as model) =
    element
        |> changeOnlyCurrentElementColor color selectedId
        |> setElementIn model


putElementAsChildIntoModel : Model -> (Int -> Element Msg) -> Model
putElementAsChildIntoModel ({ selectedId, element, autoIncrement } as model) childCreator =
    element
        |> putElementAsChildIntoSelectedElement selectedId (childCreator autoIncrement)
        |> setElementIn model
        |> setSelectedId autoIncrement
        |> setAutoIncrement (autoIncrement + 1)


putElementAsChildIntoSelectedElement : Int -> Element msg -> Element msg -> Element msg
putElementAsChildIntoSelectedElement selectedId child ({ id, tree } as parent) =
    if id == selectedId then
        tree
            |> addChildToTree child
            |> setTreeIn parent
    else
        tree
            |> addChildToChildren (putElementAsChildIntoSelectedElement selectedId child)
            |> setTreeIn parent


addChildToChildren : (Element msg -> Element msg) -> Tree msg -> Tree msg
addChildToChildren elementModifier tree =
    case tree of
        Block block ->
            block
                |> .children
                |> List.map elementModifier
                |> setChildrenIn block
                |> Block

        Inline inline ->
            inline
                |> .children
                |> List.map elementModifier
                |> setChildrenIn inline
                |> Inline

        Grid grid ->
            grid
                |> .children
                |> List.map elementModifier
                |> setChildrenIn grid
                |> Grid

        GridItem gridItem ->
            gridItem
                |> .children
                |> List.map elementModifier
                |> setChildrenIn gridItem
                |> GridItem

        Text content ->
            Text content


addColumnInGrid : Model -> Model
addColumnInGrid model =
    model


changeOnlyCurrentElementColor : Color.Color -> Int -> Element msg -> Element msg
changeOnlyCurrentElementColor color selectedId ({ id, tree } as element) =
    if id == selectedId then
        tree
            |> changeColor color
            |> setTreeIn element
    else
        case tree of
            Block heading ->
                heading
                    |> .children
                    |> List.map (changeOnlyCurrentElementColor color selectedId)
                    |> setChildrenIn heading
                    |> Block
                    |> setTreeIn element

            Inline inline ->
                inline
                    |> .children
                    |> List.map (changeOnlyCurrentElementColor color selectedId)
                    |> setChildrenIn inline
                    |> Inline
                    |> setTreeIn element

            Grid grid ->
                grid
                    |> .children
                    |> List.map (changeOnlyCurrentElementColor color selectedId)
                    |> setChildrenIn grid
                    |> Grid
                    |> setTreeIn element

            GridItem gridItem ->
                gridItem
                    |> .children
                    |> List.map (changeOnlyCurrentElementColor color selectedId)
                    |> setChildrenIn gridItem
                    |> GridItem
                    |> setTreeIn element

            Text content ->
                element


changeColorInAttributes :
    Color
    -> { a | style : Elegant.CommonStyle }
    -> { a | style : Elegant.CommonStyle }
changeColorInAttributes color attributes =
    attributes.style
        |> changeColorOfStyle color
        |> setStyleIn attributes


changeColor : Color.Color -> Tree msg -> Tree msg
changeColor color tree =
    case tree of
        Block heading ->
            heading
                |> .attributes
                |> changeColorInAttributes color
                |> setAttributesIn heading
                |> Block

        Inline inline ->
            inline
                |> .attributes
                |> changeColorInAttributes color
                |> setAttributesIn inline
                |> Inline

        Grid grid ->
            grid
                |> .attributes
                |> changeColorInAttributes color
                |> setAttributesIn grid
                |> Grid

        GridItem gridItem ->
            gridItem
                |> .attributes
                |> changeColorInAttributes color
                |> setAttributesIn gridItem
                |> GridItem

        Text content ->
            Text content


changeColorOfStyle : Color.Color -> Elegant.CommonStyle -> Elegant.CommonStyle
changeColorOfStyle color ({ display } as style) =
    display
        |> Maybe.map (modifyColor color >> Just >> setDisplayIn style)
        |> Maybe.withDefault (commonStyle Display.None)


modifyColor : Color.Color -> Display.DisplayBox -> Display.DisplayBox
modifyColor color display =
    case display of
        Display.None ->
            Display.None

        Display.ContentsWrapper ({ maybeBox } as contents) ->
            maybeBox
                |> Maybe.map (\box -> (changeColorInBox color (Maybe.withDefault Background.default box.background) box))
                |> Maybe.withDefault (changeColorInBox color Background.default Box.default)
                |> Just
                |> setMaybeBoxIn contents
                |> Display.ContentsWrapper


changeColorInBox : Color.Color -> Background.Background -> Box.Box -> Box.Box
changeColorInBox color background box =
    color
        |> Just
        |> setColorIn background
        |> Just
        |> setBackgroundIn box


changeTextOfCurrentElement : String -> Model -> Model
changeTextOfCurrentElement text ({ element, selectedId } as model) =
    element
        |> changeOnlyCurrentElementText text selectedId
        |> setElementIn model


changeOnlyCurrentElementText : String -> Int -> Element msg -> Element msg
changeOnlyCurrentElementText text selectedId ({ id, tree } as element) =
    if id == selectedId then
        text
            |> Text
            |> setTreeIn element
    else
        case tree of
            Block heading ->
                heading
                    |> .children
                    |> List.map (changeOnlyCurrentElementText text selectedId)
                    |> setChildrenIn heading
                    |> Block
                    |> setTreeIn element

            Inline inline ->
                inline
                    |> .children
                    |> List.map (changeOnlyCurrentElementText text selectedId)
                    |> setChildrenIn inline
                    |> Inline
                    |> setTreeIn element

            Grid grid ->
                grid
                    |> .children
                    |> List.map (changeOnlyCurrentElementText text selectedId)
                    |> setChildrenIn grid
                    |> Grid
                    |> setTreeIn element

            GridItem gridItem ->
                gridItem
                    |> .children
                    |> List.map (changeOnlyCurrentElementText text selectedId)
                    |> setChildrenIn gridItem
                    |> GridItem
                    |> setTreeIn element

            Text content ->
                element


main : Program Never Model Msg
main =
    B.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


setBackground : a -> { c | background : b } -> { c | background : a }
setBackground elem record =
    { record | background = elem }


setBackgroundIn : { c | background : b } -> a -> { c | background : a }
setBackgroundIn =
    flip setBackground


setColor : a -> { c | color : b } -> { c | color : a }
setColor elem record =
    { record | color = elem }


setColorIn : { c | color : b } -> a -> { c | color : a }
setColorIn =
    flip setColor


type alias Element msg =
    { id : Int
    , tree : Tree msg
    }


setTreeIn : { a | tree : b } -> b -> { a | tree : b }
setTreeIn record elem =
    { record | tree = elem }


setMaybeBoxIn : { a | maybeBox : b } -> b -> { a | maybeBox : b }
setMaybeBoxIn record elem =
    { record | maybeBox = elem }


commonStyle : Display.DisplayBox -> Elegant.CommonStyle
commonStyle style =
    Elegant.commonStyle (Just style) [] Nothing


setDisplayIn : { a | display : b } -> b -> { a | display : b }
setDisplayIn record elem =
    { record | display = elem }


blockStyle : { style : Elegant.CommonStyle }
blockStyle =
    { style =
        { outsideDisplay = Display.Block Nothing
        , insideDisplay = Display.Flow
        , maybeBox = Nothing
        }
            |> Display.ContentsWrapper
            |> commonStyle
    }


inlineStyle : { style : Elegant.CommonStyle }
inlineStyle =
    { style =
        { outsideDisplay = Display.Inline
        , insideDisplay = Display.Flow
        , maybeBox = Nothing
        }
            |> Display.ContentsWrapper
            |> commonStyle
    }


gridContainerXY : a -> { x : Maybe a, y : Maybe a }
gridContainerXY content =
    { x = Just content
    , y = Just content
    }


gridContainerBase : Display.InsideDisplay
gridContainerBase =
    gridContainerXY
        { align = Nothing
        , alignItems = Nothing
        , gutter = Just (px 5)
        , template =
            [ Grid.simple (Grid.fractionOfAvailableSpace 1)
            , Grid.simple (Grid.fractionOfAvailableSpace 1)
            ]
                |> Just
        }
        |> Just
        |> Display.GridContainer


gridStyle : { style : Elegant.CommonStyle }
gridStyle =
    { style =
        { outsideDisplay = Display.Inline
        , maybeBox = Nothing
        , insideDisplay = gridContainerBase
        }
            |> Display.ContentsWrapper
            |> commonStyle
    }


type alias BlockAttributes msg =
    { tag : String
    , constructor :
        Modifiers (A.BlockAttributes msg)
        -> List (Node msg)
        -> Node msg
    , attributes : { style : Elegant.CommonStyle }
    , children : List (Element msg)
    }


type alias NodeAttributes msg =
    { tag : String
    , constructor :
        Modifiers (A.NodeAttributes msg)
        -> List (Node msg)
        -> Node msg
    , attributes : { style : Elegant.CommonStyle }
    , children : List (Element msg)
    }


setChildrenIn : { a | children : b } -> b -> { a | children : b }
setChildrenIn record elem =
    { record | children = elem }


setAttributesIn : { a | attributes : b } -> b -> { a | attributes : b }
setAttributesIn record elem =
    { record | attributes = elem }


setStyleIn : { a | style : b } -> b -> { a | style : b }
setStyleIn record elem =
    { record | style = elem }


defaultBlockAttributes :
    String
    -> (Modifiers (A.BlockAttributes msg) -> List (Node msg) -> Node msg)
    -> BlockAttributes msg
defaultBlockAttributes tag constructor =
    BlockAttributes tag constructor blockStyle []


defaultInlineAttributes :
    String
    -> (Modifiers (A.NodeAttributes msg) -> List (Node msg) -> Node msg)
    -> NodeAttributes msg
defaultInlineAttributes tag constructor =
    NodeAttributes tag constructor inlineStyle []


type alias GridAttributes msg =
    { attributes : { style : Elegant.CommonStyle }
    , children : List (Element msg)
    }


defaultGridAttributes : GridAttributes msg
defaultGridAttributes =
    GridAttributes gridStyle []


type Tree msg
    = Block (BlockAttributes msg)
    | Inline (NodeAttributes msg)
    | Grid (GridAttributes msg)
    | GridItem (GridAttributes msg)
    | Text String


defaultElement : Int -> Tree msg -> Element msg
defaultElement newId tree =
    { id = newId
    , tree = tree
    }


defaultP : Int -> Element Msg
defaultP newId =
    defaultBlockAttributes "p" B.p
        |> Block
        |> defaultElement newId


defaultDiv : Int -> Element Msg
defaultDiv newId =
    defaultBlockAttributes "div" B.div
        |> Block
        |> defaultElement newId


defaultSpan : Int -> Element Msg
defaultSpan newId =
    defaultInlineAttributes "span" B.span
        |> Inline
        |> defaultElement newId


defaultH1 : Int -> Element Msg
defaultH1 newId =
    defaultBlockAttributes "h1" B.h1
        |> Block
        |> defaultElement newId


defaultGrid : Int -> Element Msg
defaultGrid newId =
    defaultGridAttributes
        |> Grid
        |> defaultElement newId


defaultText : String -> Int -> Element msg
defaultText content newId =
    content
        |> Text
        |> defaultElement newId


type alias Model =
    { element : Element Msg
    , selectedId : Int
    , autoIncrement : Int
    }


setElement : a -> { c | element : b } -> { c | element : a }
setElement id model =
    { model | element = id }


setElementIn : { c | element : b } -> a -> { c | element : a }
setElementIn =
    flip setElement


setSelectedId : a -> { c | selectedId : b } -> { c | selectedId : a }
setSelectedId id model =
    { model | selectedId = id }


setAutoIncrement : a -> { c | autoIncrement : b } -> { c | autoIncrement : a }
setAutoIncrement id model =
    { model | autoIncrement = id }


type Msg
    = CreateP
    | CreateH1
    | CreateGrid
    | CreateDiv
    | CreateSpan
    | CreateText
    | SelectEl Int
    | ChangeBoxColor Color
    | ChangeText String
    | AddColumn
    | AddRow


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
                        Block a ->
                            case a.tag of
                                "div" ->
                                    [ ( CreateP, "p" )
                                    , ( CreateH1, "h1" )
                                    , ( CreateGrid, "grid" )
                                    , ( CreateDiv, "div" )
                                    , ( CreateSpan, "span" )
                                    ]

                                "p" ->
                                    [ ( CreateText, "text" )
                                    , ( CreateSpan, "span" )
                                    ]

                                "h1" ->
                                    [ ( CreateText, "text" )
                                    , ( CreateSpan, "span" )
                                    ]

                                _ ->
                                    []

                        Inline a ->
                            [ ( CreateText, "text" )
                            , ( CreateSpan, "span" )
                            ]

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
                                , E.onClick msg
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
        [ E.onClick (SelectEl id) ]


contentViewGridItem : Int -> Element Msg -> List (B.GridItem Msg)
contentViewGridItem selectedId { tree, id } =
    case tree of
        GridItem gridItem ->
            [ B.gridItem
                ([ A.class [ Elegant.commonStyleToCss gridItem.attributes.style ] ] ++ selectOrSelected id selectedId)
                (List.map (contentViewEl selectedId) gridItem.children)
            ]

        _ ->
            []


contentViewEl : Int -> Element Msg -> Node Msg
contentViewEl selectedId { tree, id } =
    case tree of
        Grid grid ->
            B.grid
                ([ A.class [ Elegant.commonStyleToCss grid.attributes.style ] ] ++ selectOrSelected id selectedId)
                (List.concatMap (contentViewGridItem selectedId) grid.children)

        Block block ->
            block.constructor
                ([ A.class [ Elegant.commonStyleToCss block.attributes.style ] ] ++ selectOrSelected id selectedId)
                (List.map (contentViewEl selectedId) block.children)

        Inline node ->
            node.constructor
                ([ A.class [ Elegant.commonStyleToCss node.attributes.style ] ] ++ selectOrSelected id selectedId)
                (List.map (contentViewEl selectedId) node.children)

        Text content ->
            B.text content

        GridItem gridItem ->
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


textEditor : String -> Int -> Node Msg
textEditor text id =
    B.inputText [ A.value text, E.onInput ChangeText ]


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
                            [ Grid.simple (Grid.sizeUnitVal (px 25))
                            , Grid.simple (Grid.fractionOfAvailableSpace 1)
                            , Grid.simple (Grid.sizeUnitVal (px 25))
                            ]
                        , Grid.gap (px 10)
                        ]
                    , Grid.rows
                        [ Grid.template
                            [ Grid.simple (Grid.sizeUnitVal (px 25))
                            , Grid.simple (Grid.fractionOfAvailableSpace 1)
                            , Grid.simple (Grid.sizeUnitVal (px 25))
                            ]
                        , Grid.gap (px 10)
                        ]
                    ]
                , S.block []
                ]
            ]
            [ item ( 1, 0 ) ( Grid.span 1, Grid.span 1 ) [ arrowSelection xTemplate [ S.block [ Block.width (px 120), Block.alignCenter ] ] Grid.columns (B.text "v") ]
            , item ( 0, 1 )
                ( Grid.span 1, Grid.span 1 )
                [ arrowSelection yTemplate
                    [ S.block
                        [ Block.height (px 120) ]
                    ]
                    Grid.rows
                    (B.flex
                        [ A.style
                            [ S.flexContainerProperties
                                [ Flex.align Flex.center
                                , Flex.justifyContent Flex.justifyContentCenter
                                ]
                            , S.block
                                [ Block.height (percent 100)
                                , Block.width (percent 100)
                                ]
                            ]
                        ]
                        [ B.flexItem [] [ B.div [] [ B.text ">" ] ] ]
                    )
                ]
            , item ( 1, 1 ) ( Grid.span 1, Grid.span 1 ) [ gridView grid xTemplate yTemplate ]
            , item ( 2, 1 ) ( Grid.span 1, Grid.span 1 ) [ addButton AddColumn Flex.column ]
            , item ( 1, 2 ) ( Grid.span 1, Grid.span 1 ) [ addButton AddRow Flex.row ]
            ]


gridView :
    { c | attributes : { a | style : Elegant.CommonStyle }, children : b }
    -> List d
    -> List e
    -> Node msg
gridView { attributes, children } xTemplate yTemplate =
    B.grid
        [ attributes.style |> Elegant.commonStyleToStyle |> A.rawStyle, A.style [ S.block [] ] ]
        ((List.foldr
            (\element ( beginning, result ) ->
                ( beginning + 1
                , result
                    ++ [ item ( beginning, 0 )
                            ( Grid.span 1, Grid.untilEndOfCoordinate )
                            [ B.node
                                [ A.style
                                    [ S.block
                                        [ Block.width (px 120)
                                        , Block.height (px 120)
                                        ]
                                    ]
                                ]
                                []
                            ]
                       ]
                )
            )
            ( 0, [] )
            xTemplate
            |> Tuple.second
         )
            ++ (List.foldr
                    (\element ( beginning, result ) ->
                        ( beginning + 1
                        , result
                            ++ [ item ( 0, beginning )
                                    ( Grid.untilEndOfCoordinate, Grid.span 1 )
                                    [ B.node
                                        [ A.style
                                            [ S.block
                                                [ Block.width (px 120)
                                                , Block.height (px 120)
                                                ]
                                            ]
                                        ]
                                        []
                                    ]
                               ]
                        )
                    )
                    ( 0, [] )
                    yTemplate
                    |> Tuple.second
               )
        )


arrowSelection :
    List Grid.Repeatable
    -> List (A.StyleModifier (A.NodeAttributes msg))
    -> (Modifiers Grid.GridContainerCoordinate -> Modifier Grid.GridContainerDetails)
    -> Node msg
    -> Node msg
arrowSelection repeatables styleModifiers selector content =
    B.grid
        [ A.style
            [ S.gridContainerProperties
                [ selector
                    [ Grid.template repeatables ]
                ]
            , S.block
                [ Block.width (percent 100)
                , Block.height (percent 100)
                ]
            ]
        ]
        (B.gridItem []
            [ B.node [ A.style styleModifiers ] [ content ] ]
            |> List.repeat (List.length repeatables)
        )


addButton : Msg -> Flex.FlexDirection -> Node Msg
addButton msg orientation =
    B.flex
        [ A.style [ S.flexContainerProperties [ Flex.direction orientation ] ] ]
        [ B.flexItem [ E.onClick msg ] [ B.text "+" ] ]


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
                            [ B.inputColor [ E.onInput ChangeBoxColor, A.value color ] ]
                        , case tree of
                            Grid grid ->
                                gridEditor grid

                            Text text ->
                                textEditor text id

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
            Text content ->
                [ B.div [ A.style [ S.box [ Box.paddingLeft (px 12) ] ] ]
                    [ B.div (selectOrSelected id selectedId) [ B.text "text" ] ]
                ]

            Block content ->
                treeViewElement id selectedId content.tag content.children

            Inline content ->
                treeViewElement id selectedId content.tag content.children

            Grid content ->
                treeViewElement id selectedId "bb-grid" content.children

            GridItem gridItem ->
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
            Block { children } ->
                List.concatMap (getByIdHelp id) children

            Inline { children } ->
                List.concatMap (getByIdHelp id) children

            Grid { children } ->
                List.concatMap (getByIdHelp id) children

            Text content ->
                []

            GridItem gridItem ->
                List.concatMap (getByIdHelp id) gridItem.children


getColorFromTree : Tree Msg -> Color.Color
getColorFromTree tree =
    Maybe.withDefault Color.black <|
        case tree of
            Block { attributes } ->
                extractColorFromStyle attributes.style

            Inline { attributes } ->
                extractColorFromStyle attributes.style

            Grid { attributes } ->
                extractColorFromStyle attributes.style

            Text content ->
                Nothing

            GridItem { attributes } ->
                extractColorFromStyle attributes.style
