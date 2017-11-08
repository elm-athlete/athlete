module Main exposing (..)

import BodyBuilder as B exposing (Node)
import BodyBuilder.Attributes as A
import BodyBuilder.Events as E
import Style as S
import Constants as C
import Color exposing (Color)
import Elegant exposing (px, vh, percent, Modifiers, Modifier)
import Shadow
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


type ChangeBoxStyleMsg
    = ChangeColor Color
    | ChangeOpacity Int


handleBoxChange : ChangeBoxStyleMsg -> Model -> Model
handleBoxChange action model =
    model
        |> changeBoxStyleOfSelectedElement
            (case action of
                ChangeColor color ->
                    changeBoxColor color

                ChangeOpacity opacity ->
                    changeBoxOpacity ((opacity |> toFloat) / 1000)
            )


createElement : CreateElementMsg -> Model -> Model
createElement msg model =
    putElementAsChildIntoModel model <|
        case msg of
            CreateP ->
                defaultP

            CreateH1 ->
                defaultH1

            CreateGrid ->
                defaultGridContainer

            CreateDiv ->
                defaultDiv

            CreateText ->
                defaultText "Change me"

            CreateSpan ->
                defaultSpan

            CreateGridItem ->
                defaultGridItem


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    Update.identity <|
        case msg of
            CreateElement msg ->
                model |> createElement msg

            SelectEl id ->
                model |> setSelectedId id

            ChangeBoxStyle action ->
                model |> handleBoxChange action

            ChangeText text ->
                model |> changeTextOfCurrentElement text

            AddColumn ->
                model |> addColumnInGrid

            AddRow ->
                model |> addRowInGrid

            ChangeGridItemPlacementX value ->
                model |> changeGridItemPlacementXOfCurrentElement value

            ChangeGridItemPlacementY value ->
                model |> changeGridItemPlacementYOfCurrentElement value

            ChangeGridItemSizeX value ->
                model |> changeGridItemSizeXOfCurrentElement value

            ChangeGridItemSizeY value ->
                model |> changeGridItemSizeYOfCurrentElement value


addChildToElement : Element msg -> Element msg -> Element msg
addChildToElement ({ tree } as parent) child =
    tree
        |> addChildToTree child
        |> setTreeIn parent


changeGridItemPlacementXOfCurrentElement : Int -> Model -> Model
changeGridItemPlacementXOfCurrentElement placement =
    changeStyleOfSelectedElement (modifyGridItemInStyle (modifyGridItemPlacementX placement))


changeGridItemPlacementYOfCurrentElement : Int -> Model -> Model
changeGridItemPlacementYOfCurrentElement placement =
    changeStyleOfSelectedElement (modifyGridItemInStyle (modifyGridItemPlacementY placement))


changeGridItemSizeXOfCurrentElement : Int -> Model -> Model
changeGridItemSizeXOfCurrentElement size =
    changeStyleOfSelectedElement (modifyGridItemInStyle (modifyGridItemSizeX size))


changeGridItemSizeYOfCurrentElement : Int -> Model -> Model
changeGridItemSizeYOfCurrentElement size =
    changeStyleOfSelectedElement (modifyGridItemInStyle (modifyGridItemSizeY size))


changeStyleOfSelectedElement : (Elegant.CommonStyle -> Elegant.CommonStyle) -> Model -> Model
changeStyleOfSelectedElement modifier ({ element, selectedId } as model) =
    element
        |> applyToSelectedElement selectedId
            (modifier
                |> modifyStyleInAttributes
                |> applyToAttributes
            )
        |> setElementIn model


modifyStyleInAttributes :
    (Elegant.CommonStyle -> Elegant.CommonStyle)
    -> { a | style : Elegant.CommonStyle }
    -> { a | style : Elegant.CommonStyle }
modifyStyleInAttributes modifier attributes =
    attributes.style
        |> modifier
        |> setStyleIn attributes


addColumnInGrid : Model -> Model
addColumnInGrid =
    changeGridContainerStyleOfSelectedElement (modifyGridContainerToAddColumn)


addRowInGrid : Model -> Model
addRowInGrid =
    changeGridContainerStyleOfSelectedElement (modifyGridContainerToAddRow)


modifyGridContainer :
    (Grid.GridContainerDetails -> Maybe Grid.GridContainerCoordinate)
    -> (Grid.GridContainerDetails -> Maybe Grid.GridContainerCoordinate -> Grid.GridContainerDetails)
    -> (Grid.GridContainerCoordinate -> Grid.GridContainerCoordinate)
    -> Grid.GridContainerDetails
    -> Grid.GridContainerDetails
modifyGridContainer getter setter modifier gridContainerDetails =
    gridContainerDetails
        |> getter
        |> Maybe.withDefault (Grid.GridContainerCoordinate Nothing Nothing Nothing Nothing)
        |> modifier
        |> Just
        |> setter gridContainerDetails


modifyGridItem :
    (Grid.GridItemDetails -> Maybe Grid.GridItemCoordinate)
    -> (Grid.GridItemDetails -> Maybe Grid.GridItemCoordinate -> Grid.GridItemDetails)
    -> (Grid.GridItemCoordinate -> Grid.GridItemCoordinate)
    -> Grid.GridItemDetails
    -> Grid.GridItemDetails
modifyGridItem getter setter modifier gridItemDetails =
    gridItemDetails
        |> getter
        |> Maybe.withDefault (Grid.GridItemCoordinate Nothing Nothing Nothing)
        |> modifier
        |> Just
        |> setter gridItemDetails


modifyGridContainerX :
    (Grid.GridContainerCoordinate -> Grid.GridContainerCoordinate)
    -> Grid.GridContainerDetails
    -> Grid.GridContainerDetails
modifyGridContainerX =
    modifyGridContainer .x setXIn


modifyGridContainerY :
    (Grid.GridContainerCoordinate -> Grid.GridContainerCoordinate)
    -> Grid.GridContainerDetails
    -> Grid.GridContainerDetails
modifyGridContainerY =
    modifyGridContainer .y setYIn


modifyGridItemX :
    (Grid.GridItemCoordinate -> Grid.GridItemCoordinate)
    -> Grid.GridItemDetails
    -> Grid.GridItemDetails
modifyGridItemX =
    modifyGridItem .x setXIn


modifyGridItemY :
    (Grid.GridItemCoordinate -> Grid.GridItemCoordinate)
    -> Grid.GridItemDetails
    -> Grid.GridItemDetails
modifyGridItemY =
    modifyGridItem .y setYIn


modifyGridContainerToAddRow : Grid.GridContainerDetails -> Grid.GridContainerDetails
modifyGridContainerToAddRow =
    modifyGridContainerY addSimpleToTemplate


modifyGridContainerToAddColumn : Grid.GridContainerDetails -> Grid.GridContainerDetails
modifyGridContainerToAddColumn =
    modifyGridContainerX addSimpleToTemplate


modifyGridItemPlacementX : Int -> Grid.GridItemDetails -> Grid.GridItemDetails
modifyGridItemPlacementX placement =
    modifyGridItemX (modifyPlacement placement)


modifyGridItemPlacementY : Int -> Grid.GridItemDetails -> Grid.GridItemDetails
modifyGridItemPlacementY placement =
    modifyGridItemY (modifyPlacement placement)


modifyGridItemSizeX : Int -> Grid.GridItemDetails -> Grid.GridItemDetails
modifyGridItemSizeX size =
    modifyGridItemX (modifySize size)


modifyGridItemSizeY : Int -> Grid.GridItemDetails -> Grid.GridItemDetails
modifyGridItemSizeY size =
    modifyGridItemY (modifySize size)


modifySize : Int -> Grid.GridItemCoordinate -> Grid.GridItemCoordinate
modifySize size coordinate =
    { coordinate | size = Just (Grid.span size) }


modifyPlacement : Int -> Grid.GridItemCoordinate -> Grid.GridItemCoordinate
modifyPlacement placement coordinate =
    { coordinate | placement = Just placement }


addSimpleToTemplate : Grid.GridContainerCoordinate -> Grid.GridContainerCoordinate
addSimpleToTemplate ({ template } as coordinates) =
    template
        |> Maybe.withDefault []
        |> flip List.append [ Grid.simple (Grid.sizeUnitVal (px 120)) ]
        |> Just
        |> setTemplateIn coordinates


changeBoxStyleOfSelectedElement : (Box.Box -> Box.Box) -> Model -> Model
changeBoxStyleOfSelectedElement modifier =
    changeStyleOfSelectedElement (modifyBoxInStyle modifier)


changeGridContainerStyleOfSelectedElement : (Grid.GridContainerDetails -> Grid.GridContainerDetails) -> Model -> Model
changeGridContainerStyleOfSelectedElement modifier =
    changeStyleOfSelectedElement (modifyGridContainerInStyle modifier)


modifyElementInStyle :
    ((a -> a) -> Display.DisplayBox -> Display.DisplayBox)
    -> (a -> a)
    -> Elegant.CommonStyle
    -> Elegant.CommonStyle
modifyElementInStyle elementModifier modifier ({ display } as style) =
    display
        |> Maybe.map (elementModifier modifier >> Just >> setDisplayIn style)
        |> Maybe.withDefault (commonStyle Display.None)


modifyBoxInStyle : (Box.Box -> Box.Box) -> Elegant.CommonStyle -> Elegant.CommonStyle
modifyBoxInStyle =
    modifyElementInStyle modifyBoxInDisplayBox


modifyGridItemInStyle : (Grid.GridItemDetails -> Grid.GridItemDetails) -> Elegant.CommonStyle -> Elegant.CommonStyle
modifyGridItemInStyle =
    modifyElementInStyle (modifyOutsideDisplayInDisplayBox << modifyGridItemInOutsideDisplay)


modifyGridContainerInStyle : (Grid.GridContainerDetails -> Grid.GridContainerDetails) -> Elegant.CommonStyle -> Elegant.CommonStyle
modifyGridContainerInStyle =
    modifyElementInStyle (modifyInsideDisplayInDisplayBox << modifyGridContainerInInsideDisplay)


modifyBoxInDisplayBox : (Box.Box -> Box.Box) -> Display.DisplayBox -> Display.DisplayBox
modifyBoxInDisplayBox modifier display =
    case display of
        Display.None ->
            Display.None

        Display.ContentsWrapper ({ maybeBox } as contents) ->
            maybeBox
                |> Maybe.map modifier
                |> Maybe.withDefault (modifier Box.default)
                |> Just
                |> setMaybeBoxIn contents
                |> Display.ContentsWrapper


modifyInsideDisplayInDisplayBox : (Display.InsideDisplay -> Display.InsideDisplay) -> Display.DisplayBox -> Display.DisplayBox
modifyInsideDisplayInDisplayBox modifier display =
    case display of
        Display.None ->
            Display.None

        Display.ContentsWrapper ({ insideDisplay } as contents) ->
            insideDisplay
                |> modifier
                |> setInsideDisplayIn contents
                |> Display.ContentsWrapper


modifyOutsideDisplayInDisplayBox : (Display.OutsideDisplay -> Display.OutsideDisplay) -> Display.DisplayBox -> Display.DisplayBox
modifyOutsideDisplayInDisplayBox modifier display =
    case display of
        Display.None ->
            Display.None

        Display.ContentsWrapper ({ outsideDisplay } as contents) ->
            outsideDisplay
                |> modifier
                |> setOutsideDisplayIn contents
                |> Display.ContentsWrapper


modifyGridItemInOutsideDisplay : (Grid.GridItemDetails -> Grid.GridItemDetails) -> Display.OutsideDisplay -> Display.OutsideDisplay
modifyGridItemInOutsideDisplay modifier outsideDisplay =
    case outsideDisplay of
        Display.GridItem gridItemDetails boxDetails ->
            gridItemDetails
                |> Maybe.map modifier
                |> flip Display.GridItem boxDetails

        _ ->
            outsideDisplay


modifyGridContainerInInsideDisplay : (Grid.GridContainerDetails -> Grid.GridContainerDetails) -> Display.InsideDisplay -> Display.InsideDisplay
modifyGridContainerInInsideDisplay modifier insideDisplay =
    case insideDisplay of
        Display.Flow ->
            Display.Flow

        Display.FlexContainer flexContainer ->
            Display.FlexContainer flexContainer

        Display.GridContainer gridContainerDetails ->
            gridContainerDetails
                |> Maybe.map modifier
                |> Display.GridContainer


changeBoxColor : Color.Color -> Box.Box -> Box.Box
changeBoxColor color box =
    color
        |> Just
        |> setColorIn (Maybe.withDefault Background.default box.background)
        |> Just
        |> setBackgroundIn box


changeBoxOpacity : Float -> Box.Box -> Box.Box
changeBoxOpacity opacity box =
    opacity
        |> Just
        |> setOpacityIn box


putElementAsChildIntoModel : Model -> (Int -> Element Msg) -> Model
putElementAsChildIntoModel ({ selectedId, element, autoIncrement } as model) childCreator =
    element
        |> putElementAsChildIntoSelectedElement selectedId (childCreator autoIncrement)
        |> setElementIn model
        |> setSelectedId autoIncrement
        |> setAutoIncrement (autoIncrement + 1)


putElementAsChildIntoSelectedElement : Int -> Element msg -> Element msg -> Element msg
putElementAsChildIntoSelectedElement selectedId child ({ id, tree } as parent) =
    tree
        |> (if id == selectedId then
                addChildToTree child
            else
                mapChildren (putElementAsChildIntoSelectedElement selectedId child)
           )
        |> setTreeIn parent


mapChildren : (Element msg -> Element msg) -> Tree msg -> Tree msg
mapChildren elementModifier =
    applyToChildren (List.map elementModifier)


addChildToTree : Element msg -> Tree msg -> Tree msg
addChildToTree child =
    applyToChildren (flip List.append [ child ])


modifyChildren : (a -> a) -> { b | children : a } -> { b | children : a }
modifyChildren applyOnElements treeInside =
    treeInside
        |> .children
        |> applyOnElements
        |> setChildrenIn treeInside


modifyAttributes : (a -> a) -> { b | attributes : a } -> { b | attributes : a }
modifyAttributes applyOnAttributes treeInside =
    treeInside
        |> .attributes
        |> applyOnAttributes
        |> setAttributesIn treeInside


applyToChildren : (List (Element msg) -> List (Element msg)) -> Tree msg -> Tree msg
applyToChildren applyOnElements tree =
    case tree of
        Block block ->
            block
                |> modifyChildren applyOnElements
                |> Block

        Inline inline ->
            inline
                |> modifyChildren applyOnElements
                |> Inline

        Grid grid ->
            grid
                |> modifyChildren applyOnElements
                |> Grid

        GridItem gridItem ->
            gridItem
                |> modifyChildren applyOnElements
                |> GridItem

        Text content ->
            Text content


applyToAttributes :
    ({ style : Elegant.CommonStyle } -> { style : Elegant.CommonStyle })
    -> Tree msg
    -> Tree msg
applyToAttributes applyOnAttributes tree =
    case tree of
        Block block ->
            block
                |> modifyAttributes applyOnAttributes
                |> Block

        Inline inline ->
            inline
                |> modifyAttributes applyOnAttributes
                |> Inline

        Grid grid ->
            grid
                |> modifyAttributes applyOnAttributes
                |> Grid

        GridItem gridItem ->
            gridItem
                |> modifyAttributes applyOnAttributes
                |> GridItem

        Text content ->
            Text content


applyToSelectedElement : Int -> (Tree msg -> Tree msg) -> Element msg -> Element msg
applyToSelectedElement selectedId modifierTree ({ id, tree } as element) =
    tree
        |> (if id == selectedId then
                modifierTree
            else
                applyToChildren (List.map (applyToSelectedElement selectedId modifierTree))
           )
        |> setTreeIn element


changeOnlyCurrentElementText : Int -> String -> Element msg -> Element msg
changeOnlyCurrentElementText id text =
    applyToSelectedElement id (always (Text text))


changeTextOfCurrentElement : String -> Model -> Model
changeTextOfCurrentElement text ({ element, selectedId } as model) =
    element
        |> changeOnlyCurrentElementText selectedId text
        |> setElementIn model


setBackground : a -> { c | background : b } -> { c | background : a }
setBackground elem record =
    { record | background = elem }


setBackgroundIn : { c | background : b } -> a -> { c | background : a }
setBackgroundIn =
    flip setBackground


setInsideDisplay : a -> { c | insideDisplay : b } -> { c | insideDisplay : a }
setInsideDisplay elem record =
    { record | insideDisplay = elem }


setInsideDisplayIn : { c | insideDisplay : b } -> a -> { c | insideDisplay : a }
setInsideDisplayIn =
    flip setInsideDisplay


setOutsideDisplay : a -> { c | outsideDisplay : b } -> { c | outsideDisplay : a }
setOutsideDisplay elem record =
    { record | outsideDisplay = elem }


setOutsideDisplayIn : { c | outsideDisplay : b } -> a -> { c | outsideDisplay : a }
setOutsideDisplayIn =
    flip setOutsideDisplay


setColor : a -> { c | color : b } -> { c | color : a }
setColor elem record =
    { record | color = elem }


setColorIn : { c | color : b } -> a -> { c | color : a }
setColorIn =
    flip setColor


setOpacity : a -> { c | opacity : b } -> { c | opacity : a }
setOpacity elem record =
    { record | opacity = elem }


setOpacityIn : { c | opacity : b } -> a -> { c | opacity : a }
setOpacityIn =
    flip setOpacity


setX : a -> { c | x : b } -> { c | x : a }
setX elem record =
    { record | x = elem }


setXIn : { c | x : b } -> a -> { c | x : a }
setXIn =
    flip setX


setY : a -> { c | y : b } -> { c | y : a }
setY elem record =
    { record | y = elem }


setYIn : { c | y : b } -> a -> { c | y : a }
setYIn =
    flip setY


setTemplate : a -> { c | template : b } -> { c | template : a }
setTemplate elem record =
    { record | template = elem }


setTemplateIn : { c | template : b } -> a -> { c | template : a }
setTemplateIn =
    flip setTemplate


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


outsideDependentStyle : Display.OutsideDisplay -> { style : Elegant.CommonStyle }
outsideDependentStyle outsideDisplay =
    { style =
        { outsideDisplay = outsideDisplay
        , insideDisplay = Display.Flow
        , maybeBox = Nothing
        }
            |> Display.ContentsWrapper
            |> commonStyle
    }


blockStyle : { style : Elegant.CommonStyle }
blockStyle =
    outsideDependentStyle (Display.Block Nothing)


inlineStyle : { style : Elegant.CommonStyle }
inlineStyle =
    outsideDependentStyle Display.Inline


gridXY : a -> { x : Maybe a, y : Maybe a }
gridXY content =
    { x = Just content
    , y = Just content
    }


gridContainerBase : Display.InsideDisplay
gridContainerBase =
    gridXY
        { align = Nothing
        , alignItems = Nothing
        , gutter = Just (px 5)
        , template =
            [ Grid.simple (Grid.sizeUnitVal (px 120))
            , Grid.simple (Grid.sizeUnitVal (px 120))
            ]
                |> Just
        }
        |> Just
        |> Display.GridContainer


gridContainerStyle : { style : Elegant.CommonStyle }
gridContainerStyle =
    { style =
        { outsideDisplay = Display.Inline
        , maybeBox = Nothing
        , insideDisplay = gridContainerBase
        }
            |> Display.ContentsWrapper
            |> commonStyle
    }


gridItemBase : Display.OutsideDisplay
gridItemBase =
    gridXY
        { align = Nothing
        , placement = Nothing
        , size = Nothing
        }
        |> Just
        |> flip Display.GridItem (Just Display.defaultBlockDetails)


gridItemStyle : { style : Elegant.CommonStyle }
gridItemStyle =
    { style =
        { outsideDisplay = gridItemBase
        , maybeBox = Nothing
        , insideDisplay = Display.Flow
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


defaultGridContainerAttributes : GridAttributes msg
defaultGridContainerAttributes =
    GridAttributes gridContainerStyle []


defaultGridItemAttributes : GridAttributes msg
defaultGridItemAttributes =
    GridAttributes gridItemStyle []


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


defaultGridContainer : Int -> Element Msg
defaultGridContainer newId =
    defaultGridContainerAttributes
        |> Grid
        |> defaultElement newId


defaultGridItem : Int -> Element Msg
defaultGridItem newId =
    defaultGridItemAttributes
        |> GridItem
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


type CreateElementMsg
    = CreateP
    | CreateH1
    | CreateGrid
    | CreateDiv
    | CreateSpan
    | CreateText
    | CreateGridItem


type Msg
    = CreateElement CreateElementMsg
    | SelectEl Int
    | ChangeBoxStyle ChangeBoxStyleMsg
    | ChangeText String
    | AddColumn
    | AddRow
    | ChangeGridItemPlacementX Int
    | ChangeGridItemPlacementY Int
    | ChangeGridItemSizeX Int
    | ChangeGridItemSizeY Int


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
                    [ Grid.placement x
                    , Grid.size width
                    , Grid.align Grid.stretch
                    ]
                , Grid.vertical
                    [ Grid.placement y
                    , Grid.size height
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

                        Grid a ->
                            [ ( CreateGridItem, "grid-item" ) ]

                        GridItem b ->
                            [ ( CreateGrid, "grid" )
                            , ( CreateDiv, "div" )
                            , ( CreateSpan, "span" )
                            , ( CreateP, "p" )
                            , ( CreateH1, "h1" )
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
                                [ A.style
                                    [ S.block [ Block.height (percent 100), Block.width (px 50) ]
                                    , S.box [ Box.borderNone, Box.backgroundColor (Color.rgba 0 0 0 0) ]
                                    ]
                                , E.onClick (CreateElement msg)
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
        [ A.style [ S.box [ Box.shadow [ Shadow.blurry (px 5) (px 5) (Color.rgba 0 0 0 0.1) ] ] ] ]
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
            B.span (selectOrSelected id selectedId)
                [ B.text content
                ]

        GridItem gridItem ->
            B.text ""


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


extractOpacityFromStyle : Elegant.CommonStyle -> Maybe Float
extractOpacityFromStyle style =
    case style.display of
        Nothing ->
            Nothing

        Just display ->
            case display of
                Display.None ->
                    Nothing

                Display.ContentsWrapper contents ->
                    contents.maybeBox
                        |> Maybe.andThen .opacity


extractGridItemAttributes :
    { a | display : Maybe Display.DisplayBox }
    -> Maybe Grid.GridItemDetails
extractGridItemAttributes style =
    case style.display of
        Nothing ->
            Nothing

        Just display ->
            case display of
                Display.None ->
                    Nothing

                Display.ContentsWrapper contents ->
                    case contents.outsideDisplay of
                        Display.GridItem details _ ->
                            details

                        _ ->
                            Nothing


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
            [ item ( 1, 0 ) ( Grid.span 1, Grid.span 1 ) [ arrowSelection xTemplate [ S.block [ Block.width (px (round (240 / (List.length xTemplate |> toFloat)))), Block.alignCenter ] ] Grid.columns (B.text "v") ]
            , item ( 0, 1 )
                ( Grid.span 1, Grid.span 1 )
                [ arrowSelection yTemplate
                    [ S.block
                        [ Block.height (px (round (240 / (List.length yTemplate |> toFloat)))) ]
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


replaceTemplateByOneFraction : Grid.GridContainerDetails -> Grid.GridContainerDetails
replaceTemplateByOneFraction gridContainerDetails =
    gridContainerDetails
        |> modifyGridContainerToReplaceTemplateInX
        |> modifyGridContainerToReplaceTemplateInY


modifyGridContainerToReplaceTemplateInY : Grid.GridContainerDetails -> Grid.GridContainerDetails
modifyGridContainerToReplaceTemplateInY ({ y } as gridContainerDetails) =
    y
        |> Maybe.withDefault (Grid.GridContainerCoordinate Nothing Nothing Nothing Nothing)
        |> replaceTemplate
        |> Just
        |> setYIn gridContainerDetails


modifyGridContainerToReplaceTemplateInX : Grid.GridContainerDetails -> Grid.GridContainerDetails
modifyGridContainerToReplaceTemplateInX ({ x } as gridContainerDetails) =
    x
        |> Maybe.withDefault (Grid.GridContainerCoordinate Nothing Nothing Nothing Nothing)
        |> replaceTemplate
        |> Just
        |> setXIn gridContainerDetails


replaceTemplate : Grid.GridContainerCoordinate -> Grid.GridContainerCoordinate
replaceTemplate ({ template } as coordinate) =
    template
        |> Maybe.withDefault []
        |> List.map (always (Grid.simple (Grid.fractionOfAvailableSpace 1)))
        |> Just
        |> setTemplateIn coordinate


gridView :
    { c | attributes : { a | style : Elegant.CommonStyle }, children : b }
    -> List d
    -> List e
    -> Node msg
gridView { attributes, children } xTemplate yTemplate =
    B.grid
        [ attributes.style
            |> modifyGridContainerInStyle (replaceTemplateByOneFraction)
            |> Elegant.commonStyleToStyle
            |> A.rawStyle
        , A.style [ S.block [] ]
        ]
        ((List.foldr
            (\element ( beginning, result ) ->
                ( beginning + 1
                , result
                    ++ [ item ( beginning, 0 )
                            ( Grid.span 1, Grid.untilEndOfCoordinate )
                            [ B.node
                                [ A.style
                                    [ S.block
                                        [ Block.width (px (round (240 / (List.length xTemplate |> toFloat))))
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
                                                , Block.height (px (round (240 / (List.length yTemplate |> toFloat))))
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
                    [ repeatables |> List.map (always (Grid.simple (Grid.fractionOfAvailableSpace 1))) |> Grid.template ]
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
                B.div [ A.style [ S.box [ Box.paddingAll (C.medium) ] ] ]
                    [ B.h1 [] [ B.text "Inspector" ]
                    , case tree of
                        Text t ->
                            B.none

                        _ ->
                            B.div []
                                [ B.div []
                                    [ B.text "Box Attributes" ]
                                , B.div []
                                    [ B.div []
                                        [ B.text "Box color" ]
                                    , B.div []
                                        [ B.inputColor [ E.onInput (ChangeBoxStyle << ChangeColor), A.value (getColorFromTree tree) ] ]
                                    , B.div []
                                        [ B.text "Box opacity" ]
                                    , B.div []
                                        [ B.inputRange [ A.min 0, A.max 1000, E.onInput (ChangeBoxStyle << ChangeOpacity), A.value (1000 * getOpacityFromTree tree |> round) ] ]
                                    ]
                                ]
                    , case tree of
                        Grid grid ->
                            gridEditor grid

                        Text text ->
                            textEditor text id

                        GridItem gridItem ->
                            gridItemEditor gridItem

                        _ ->
                            B.text ""
                    ]


gridItemEditor : GridAttributes Msg -> Node Msg
gridItemEditor { attributes, children } =
    let
        gridItemAttributes =
            attributes
                |> .style
                |> extractGridItemAttributes

        placementXY =
            gridItemAttributes
                |> Maybe.andThen extractPlacementFromAttributes
                |> Maybe.withDefault ( 0, 0 )

        sizeXY =
            gridItemAttributes
                |> Maybe.andThen extractSizeFromAttributes
                |> Maybe.withDefault ( 0, 0 )
    in
        B.div []
            [ B.div []
                [ B.node [] [ B.text "placement X" ]
                , B.node [] [ B.inputNumber [ A.value (Tuple.first placementXY), E.onInput ChangeGridItemPlacementX ] ]
                , B.node [] [ B.text " Y " ]
                , B.node [] [ B.inputNumber [ A.value (Tuple.second placementXY), E.onInput ChangeGridItemPlacementY ] ]
                ]
            , B.div []
                [ B.node [] [ B.text "size X" ]
                , B.node [] [ B.inputNumber [ A.value (Tuple.first sizeXY), E.onInput ChangeGridItemSizeX ] ]
                , B.node [] [ B.text " Y " ]
                , B.node [] [ B.inputNumber [ A.value (Tuple.second sizeXY), E.onInput ChangeGridItemSizeY ] ]
                ]
            ]


extractSizeFromAttributes : Grid.GridItemDetails -> Maybe ( Int, Int )
extractSizeFromAttributes { x, y } =
    Just
        ( x
            |> Maybe.andThen .size
            |> Maybe.andThen extractSpan
            |> Maybe.withDefault 0
        , y
            |> Maybe.andThen .size
            |> Maybe.andThen extractSpan
            |> Maybe.withDefault 0
        )


extractSpan : Grid.GridItemSize -> Maybe Int
extractSpan size =
    case size of
        Grid.Span x ->
            Just x

        Grid.UntilEndOfCoordinate ->
            Nothing


extractPlacementFromAttributes : Grid.GridItemDetails -> Maybe ( Int, Int )
extractPlacementFromAttributes { x, y } =
    Just
        ( x
            |> Maybe.andThen .placement
            |> Maybe.withDefault 0
        , y
            |> Maybe.andThen .placement
            |> Maybe.withDefault 0
        )


treeView : Model -> Node Msg
treeView { selectedId, element } =
    B.div [ A.style [ S.box [ Box.paddingAll (C.medium) ] ] ]
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
            Block content ->
                treeViewElement id selectedId content.tag content.children

            Inline content ->
                treeViewElement id selectedId content.tag content.children

            Grid content ->
                treeViewElement id selectedId "bb-grid" content.children

            GridItem gridItem ->
                treeViewElement id selectedId "bb-grid-item" gridItem.children

            Text content ->
                [ B.div [ A.style [ S.box [ Box.paddingLeft (px 12) ] ] ]
                    [ B.div (selectOrSelected id selectedId) [ B.text "text" ] ]
                ]


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

            GridItem gridItem ->
                List.concatMap (getByIdHelp id) gridItem.children

            Text content ->
                []


getOpacityFromTree : Tree msg -> Float
getOpacityFromTree tree =
    Maybe.withDefault 1.0 <|
        case tree of
            Block { attributes } ->
                extractOpacityFromStyle attributes.style

            Inline { attributes } ->
                extractOpacityFromStyle attributes.style

            Grid { attributes } ->
                extractOpacityFromStyle attributes.style

            GridItem { attributes } ->
                extractOpacityFromStyle attributes.style

            Text content ->
                Nothing


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

            GridItem { attributes } ->
                extractColorFromStyle attributes.style

            Text content ->
                Nothing


main : Program Never Model Msg
main =
    B.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
