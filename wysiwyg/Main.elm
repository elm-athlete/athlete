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
import Helpers.Shared


init : ( Model, Cmd Msg )
init =
    { element = defaultGridContainer 1
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
    Update.identity
        (model
            |> case msg of
                CreateElement msg ->
                    createElement msg

                SelectEl id ->
                    setSelectedId id

                ChangeBoxStyle action ->
                    handleBoxChange action

                ChangeText text ->
                    changeTextOfCurrentElement text

                AddColumn ->
                    addColumnInGrid

                AddRow ->
                    addRowInGrid

                ChangeGridItemPlacementX value ->
                    changeGridItemPlacementXOfCurrentElement (value + 1)

                ChangeGridItemPlacementY value ->
                    changeGridItemPlacementYOfCurrentElement (value + 1)

                ChangeGridItemSizeX value ->
                    changeGridItemSizeXOfCurrentElement value

                ChangeGridItemSizeY value ->
                    changeGridItemSizeYOfCurrentElement value

                ToggleGridItemPlacementX value ->
                    toggleGridItemPlacementXOfCurrentElement value

                ToggleGridItemPlacementY value ->
                    toggleGridItemPlacementYOfCurrentElement value

                ChangeColumnSize columnNumber size ->
                    changeGridColumnSizeOfCurrentElement columnNumber size

                ChangeColumnUnit columnNumber unit ->
                    changeGridColumnUnitOfCurrentElement columnNumber unit

                ChangeRowSize rowNumber size ->
                    changeGridRowSizeOfCurrentElement rowNumber size

                ChangeRowUnit rowNumber unit ->
                    changeGridRowUnitOfCurrentElement rowNumber unit
        )


addChildToElement : Element msg -> Element msg -> Element msg
addChildToElement ({ tree } as parent) child =
    tree
        |> addChildToTree child
        |> setTreeIn parent


changeGridItemPlacementXOfCurrentElement : Int -> Model -> Model
changeGridItemPlacementXOfCurrentElement placement =
    changeStyleOfSelectedElement (updateGridItemInStyle (updateGridItemPlacementX placement))


changeGridItemPlacementYOfCurrentElement : Int -> Model -> Model
changeGridItemPlacementYOfCurrentElement placement =
    changeStyleOfSelectedElement (updateGridItemInStyle (updateGridItemPlacementY placement))


toggleGridItemPlacementXOfCurrentElement : Bool -> Model -> Model
toggleGridItemPlacementXOfCurrentElement value =
    changeStyleOfSelectedElement (updateGridItemInStyle (toggleGridItemPlacementX value))


toggleGridItemPlacementYOfCurrentElement : Bool -> Model -> Model
toggleGridItemPlacementYOfCurrentElement value =
    changeStyleOfSelectedElement (updateGridItemInStyle (toggleGridItemPlacementY value))


changeGridItemSizeXOfCurrentElement : Int -> Model -> Model
changeGridItemSizeXOfCurrentElement size =
    changeStyleOfSelectedElement (updateGridItemInStyle (updateGridItemSizeX size))


changeGridItemSizeYOfCurrentElement : Int -> Model -> Model
changeGridItemSizeYOfCurrentElement size =
    changeStyleOfSelectedElement (updateGridItemInStyle (updateGridItemSizeY size))


changeStyleOfSelectedElement : (Elegant.CommonStyle -> Elegant.CommonStyle) -> Model -> Model
changeStyleOfSelectedElement modifier ({ element, selectedId } as model) =
    element
        |> applyToSelectedElement selectedId
            (modifier
                |> updateStyleInAttributes
                |> applyToAttributes
            )
        |> setElementIn model


updateStyleInAttributes :
    (Elegant.CommonStyle -> Elegant.CommonStyle)
    -> { a | style : Elegant.CommonStyle }
    -> { a | style : Elegant.CommonStyle }
updateStyleInAttributes modifier attributes =
    attributes.style
        |> modifier
        |> setStyleIn attributes


addColumnInGrid : Model -> Model
addColumnInGrid =
    changeGridContainerStyleOfSelectedElement (updateGridContainerToAddColumn)


changeGridColumnSizeOfCurrentElement : Int -> Int -> Model -> Model
changeGridColumnSizeOfCurrentElement columnNumber size =
    changeGridContainerStyleOfSelectedElement (updateGridContainerToResizeColumn columnNumber size)


changeGridRowSizeOfCurrentElement : Int -> Int -> Model -> Model
changeGridRowSizeOfCurrentElement rowNumber size =
    changeGridContainerStyleOfSelectedElement (updateGridContainerToResizeRow rowNumber size)


changeGridColumnUnitOfCurrentElement : Int -> String -> Model -> Model
changeGridColumnUnitOfCurrentElement columnNumber unit =
    changeGridContainerStyleOfSelectedElement (updateGridContainerToChangeUnitColumn columnNumber unit)


changeGridRowUnitOfCurrentElement : Int -> String -> Model -> Model
changeGridRowUnitOfCurrentElement rowNumber unit =
    changeGridContainerStyleOfSelectedElement (updateGridContainerToChangeUnitRow rowNumber unit)


addRowInGrid : Model -> Model
addRowInGrid =
    changeGridContainerStyleOfSelectedElement (updateGridContainerToAddRow)


updateGridContainer :
    (Grid.GridContainerDetails -> Maybe Grid.GridContainerCoordinate)
    -> (Grid.GridContainerDetails -> Maybe Grid.GridContainerCoordinate -> Grid.GridContainerDetails)
    -> (Grid.GridContainerCoordinate -> Grid.GridContainerCoordinate)
    -> Grid.GridContainerDetails
    -> Grid.GridContainerDetails
updateGridContainer getter setter modifier gridContainerDetails =
    gridContainerDetails
        |> getter
        |> Maybe.withDefault (Grid.GridContainerCoordinate Nothing Nothing Nothing Nothing)
        |> modifier
        |> Just
        |> setter gridContainerDetails


updateGridItem :
    (Grid.GridItemDetails -> Maybe Grid.GridItemCoordinate)
    -> (Grid.GridItemDetails -> Maybe Grid.GridItemCoordinate -> Grid.GridItemDetails)
    -> (Grid.GridItemCoordinate -> Grid.GridItemCoordinate)
    -> Grid.GridItemDetails
    -> Grid.GridItemDetails
updateGridItem getter setter modifier gridItemDetails =
    gridItemDetails
        |> getter
        |> Maybe.withDefault (Grid.GridItemCoordinate Nothing Nothing Nothing)
        |> modifier
        |> Just
        |> setter gridItemDetails


updateGridContainerX :
    (Grid.GridContainerCoordinate -> Grid.GridContainerCoordinate)
    -> Grid.GridContainerDetails
    -> Grid.GridContainerDetails
updateGridContainerX =
    updateGridContainer .x setXIn


updateGridContainerY :
    (Grid.GridContainerCoordinate -> Grid.GridContainerCoordinate)
    -> Grid.GridContainerDetails
    -> Grid.GridContainerDetails
updateGridContainerY =
    updateGridContainer .y setYIn


updateGridItemX :
    (Grid.GridItemCoordinate -> Grid.GridItemCoordinate)
    -> Grid.GridItemDetails
    -> Grid.GridItemDetails
updateGridItemX =
    updateGridItem .x setXIn


updateGridItemY :
    (Grid.GridItemCoordinate -> Grid.GridItemCoordinate)
    -> Grid.GridItemDetails
    -> Grid.GridItemDetails
updateGridItemY =
    updateGridItem .y setYIn


updateGridContainerToAddRow : Grid.GridContainerDetails -> Grid.GridContainerDetails
updateGridContainerToAddRow =
    updateGridContainerY addSimpleToTemplate


updateGridContainerToAddColumn : Grid.GridContainerDetails -> Grid.GridContainerDetails
updateGridContainerToAddColumn =
    updateGridContainerX addSimpleToTemplate


updateGridContainerToResizeColumn : Int -> Int -> Grid.GridContainerDetails -> Grid.GridContainerDetails
updateGridContainerToResizeColumn columnNumber size =
    updateGridContainerX (updateSimpleSize columnNumber size)


updateGridContainerToResizeRow : Int -> Int -> Grid.GridContainerDetails -> Grid.GridContainerDetails
updateGridContainerToResizeRow rowNumber size =
    updateGridContainerY (updateSimpleSize rowNumber size)


updateGridContainerToChangeUnitColumn : Int -> String -> Grid.GridContainerDetails -> Grid.GridContainerDetails
updateGridContainerToChangeUnitColumn columnNumber unit =
    updateGridContainerX (updateSimpleUnit columnNumber unit)


updateGridContainerToChangeUnitRow : Int -> String -> Grid.GridContainerDetails -> Grid.GridContainerDetails
updateGridContainerToChangeUnitRow rowNumber unit =
    updateGridContainerY (updateSimpleUnit rowNumber unit)


updateGridItemPlacementX : Int -> Grid.GridItemDetails -> Grid.GridItemDetails
updateGridItemPlacementX placement =
    updateGridItemX (updatePlacement placement)


toggleGridItemPlacementX : Bool -> Grid.GridItemDetails -> Grid.GridItemDetails
toggleGridItemPlacementX value =
    updateGridItemX (togglePlacement value)


toggleGridItemPlacementY : Bool -> Grid.GridItemDetails -> Grid.GridItemDetails
toggleGridItemPlacementY value =
    updateGridItemY (togglePlacement value)


updateGridItemPlacementY : Int -> Grid.GridItemDetails -> Grid.GridItemDetails
updateGridItemPlacementY placement =
    updateGridItemY (updatePlacement placement)


updateGridItemSizeX : Int -> Grid.GridItemDetails -> Grid.GridItemDetails
updateGridItemSizeX size =
    updateGridItemX (updateSize size)


updateGridItemSizeY : Int -> Grid.GridItemDetails -> Grid.GridItemDetails
updateGridItemSizeY size =
    updateGridItemY (updateSize size)


updateSize : Int -> Grid.GridItemCoordinate -> Grid.GridItemCoordinate
updateSize size coordinate =
    { coordinate | size = Just (Grid.span size) }


updatePlacement : Int -> Grid.GridItemCoordinate -> Grid.GridItemCoordinate
updatePlacement placement coordinate =
    { coordinate | placement = Just placement }


togglePlacement :
    Bool
    -> { b | placement : Maybe Int }
    -> { b | placement : Maybe Int }
togglePlacement value coordinate =
    if value then
        { coordinate | placement = Just 1 }
    else
        { coordinate | placement = Nothing }


addSimpleToTemplate : Grid.GridContainerCoordinate -> Grid.GridContainerCoordinate
addSimpleToTemplate ({ template } as coordinates) =
    template
        |> Maybe.withDefault []
        |> flip List.append [ Grid.simple (Grid.Fr 1) ]
        |> Just
        |> setTemplateIn coordinates


updateSimpleSize : Int -> Int -> Grid.GridContainerCoordinate -> Grid.GridContainerCoordinate
updateSimpleSize columnNumber size ({ template } as coordinates) =
    template
        |> Maybe.map (updateSizeOfNthColumn columnNumber size)
        |> setTemplateIn coordinates


updateSimpleUnit : Int -> String -> Grid.GridContainerCoordinate -> Grid.GridContainerCoordinate
updateSimpleUnit columnNumber unit ({ template } as coordinates) =
    template
        |> Maybe.map (updateUnitOfNthColumn columnNumber unit)
        |> setTemplateIn coordinates


updateSizeOfNthColumn : Int -> Int -> List Grid.Repeatable -> List Grid.Repeatable
updateSizeOfNthColumn columnNumber size repeatables =
    (List.take columnNumber repeatables)
        ++ (updateSizeOfRepeatable (List.head (List.drop columnNumber repeatables)) size)
        ++ (List.drop (columnNumber + 1) repeatables)


updateUnitOfNthColumn : Int -> String -> List Grid.Repeatable -> List Grid.Repeatable
updateUnitOfNthColumn columnNumber unit repeatables =
    (List.take columnNumber repeatables)
        ++ (updateUnitOfRepeatable (List.head (List.drop columnNumber repeatables)) unit)
        ++ (List.drop (columnNumber + 1) repeatables)


updateUnitOfRepeatable : Maybe Grid.Repeatable -> String -> List Grid.Repeatable
updateUnitOfRepeatable repeatable unit =
    case repeatable of
        Nothing ->
            []

        Just repeatable_ ->
            List.singleton <|
                case repeatable_ of
                    Grid.Simple x ->
                        Grid.Simple <|
                            case unit of
                                "fr" ->
                                    Grid.Fr 1

                                "px" ->
                                    Grid.SizeUnitVal (Elegant.px 120)

                                "%" ->
                                    Grid.SizeUnitVal (Elegant.percent 100)

                                _ ->
                                    x

                    elem ->
                        elem


updateSizeOfRepeatable : Maybe Grid.Repeatable -> Int -> List Grid.Repeatable
updateSizeOfRepeatable repeatable size =
    case repeatable of
        Nothing ->
            []

        Just repeatable_ ->
            List.singleton <|
                case repeatable_ of
                    Grid.Simple x ->
                        Grid.Simple <|
                            case x of
                                Grid.Fr x ->
                                    Grid.Fr size

                                Grid.SizeUnitVal sizeUnit ->
                                    Grid.SizeUnitVal <|
                                        case sizeUnit of
                                            Helpers.Shared.Px x ->
                                                Helpers.Shared.Px size

                                            Helpers.Shared.Percent x ->
                                                Helpers.Shared.Percent (toFloat size)

                                            elem ->
                                                elem

                                elem ->
                                    elem

                    elem ->
                        elem


changeBoxStyleOfSelectedElement : (Box.Box -> Box.Box) -> Model -> Model
changeBoxStyleOfSelectedElement modifier =
    changeStyleOfSelectedElement (updateBoxInStyle modifier)


changeGridContainerStyleOfSelectedElement : (Grid.GridContainerDetails -> Grid.GridContainerDetails) -> Model -> Model
changeGridContainerStyleOfSelectedElement modifier =
    changeStyleOfSelectedElement (updateGridContainerInStyle modifier)


updateElementInStyle :
    ((a -> a) -> Display.DisplayBox -> Display.DisplayBox)
    -> (a -> a)
    -> Elegant.CommonStyle
    -> Elegant.CommonStyle
updateElementInStyle elementModifier modifier ({ display } as style) =
    display
        |> Maybe.map (elementModifier modifier >> Just >> setDisplayIn style)
        |> Maybe.withDefault (commonStyle Display.None)


updateBoxInStyle : (Box.Box -> Box.Box) -> Elegant.CommonStyle -> Elegant.CommonStyle
updateBoxInStyle =
    updateElementInStyle updateBoxInDisplayBox


updateGridItemInStyle : (Grid.GridItemDetails -> Grid.GridItemDetails) -> Elegant.CommonStyle -> Elegant.CommonStyle
updateGridItemInStyle =
    updateElementInStyle (updateOutsideDisplayInDisplayBox << updateGridItemInOutsideDisplay)


updateGridContainerInStyle : (Grid.GridContainerDetails -> Grid.GridContainerDetails) -> Elegant.CommonStyle -> Elegant.CommonStyle
updateGridContainerInStyle =
    updateElementInStyle (updateInsideDisplayInDisplayBox << updateGridContainerInInsideDisplay)


updateBoxInDisplayBox : (Box.Box -> Box.Box) -> Display.DisplayBox -> Display.DisplayBox
updateBoxInDisplayBox modifier display =
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


updateInsideDisplayInDisplayBox : (Display.InsideDisplay -> Display.InsideDisplay) -> Display.DisplayBox -> Display.DisplayBox
updateInsideDisplayInDisplayBox modifier display =
    case display of
        Display.None ->
            Display.None

        Display.ContentsWrapper ({ insideDisplay } as contents) ->
            insideDisplay
                |> modifier
                |> setInsideDisplayIn contents
                |> Display.ContentsWrapper


updateOutsideDisplayInDisplayBox : (Display.OutsideDisplay -> Display.OutsideDisplay) -> Display.DisplayBox -> Display.DisplayBox
updateOutsideDisplayInDisplayBox modifier display =
    case display of
        Display.None ->
            Display.None

        Display.ContentsWrapper ({ outsideDisplay } as contents) ->
            outsideDisplay
                |> modifier
                |> setOutsideDisplayIn contents
                |> Display.ContentsWrapper


updateGridItemInOutsideDisplay : (Grid.GridItemDetails -> Grid.GridItemDetails) -> Display.OutsideDisplay -> Display.OutsideDisplay
updateGridItemInOutsideDisplay modifier outsideDisplay =
    case outsideDisplay of
        Display.GridItem gridItemDetails boxDetails ->
            gridItemDetails
                |> Maybe.map modifier
                |> flip Display.GridItem boxDetails

        _ ->
            outsideDisplay


updateGridContainerInInsideDisplay : (Grid.GridContainerDetails -> Grid.GridContainerDetails) -> Display.InsideDisplay -> Display.InsideDisplay
updateGridContainerInInsideDisplay modifier insideDisplay =
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


updateChildren : (a -> a) -> { b | children : a } -> { b | children : a }
updateChildren applyOnElements treeInside =
    treeInside
        |> .children
        |> applyOnElements
        |> setChildrenIn treeInside


updateAttributes : (a -> a) -> { b | attributes : a } -> { b | attributes : a }
updateAttributes applyOnAttributes treeInside =
    treeInside
        |> .attributes
        |> applyOnAttributes
        |> setAttributesIn treeInside


applyToChildren : (List (Element msg) -> List (Element msg)) -> Tree msg -> Tree msg
applyToChildren applyOnElements tree =
    case tree of
        Block block ->
            block
                |> updateChildren applyOnElements
                |> Block

        Inline inline ->
            inline
                |> updateChildren applyOnElements
                |> Inline

        Grid grid ->
            grid
                |> updateChildren applyOnElements
                |> Grid

        GridItem gridItem ->
            gridItem
                |> updateChildren applyOnElements
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
                |> updateAttributes applyOnAttributes
                |> Block

        Inline inline ->
            inline
                |> updateAttributes applyOnAttributes
                |> Inline

        Grid grid ->
            grid
                |> updateAttributes applyOnAttributes
                |> Grid

        GridItem gridItem ->
            gridItem
                |> updateAttributes applyOnAttributes
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


gridXAndY : a -> a -> { x : Maybe a, y : Maybe a }
gridXAndY x y =
    { x = Just x
    , y = Just y
    }


gridContainerBase : Display.InsideDisplay
gridContainerBase =
    gridXAndY
        { align = Nothing
        , alignItems = Nothing
        , gutter = Just (px 5)
        , template =
            [ Grid.simple (Grid.Fr 1)
            , Grid.simple (Grid.Fr 1)
            ]
                |> Just
        }
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
        { outsideDisplay = Display.Block Nothing
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
    { tag : String
    , attributes : { style : Elegant.CommonStyle }
    , children : List (Element msg)
    }


defaultGridContainerAttributes : GridAttributes msg
defaultGridContainerAttributes =
    GridAttributes "grid" gridContainerStyle []


defaultGridItemAttributes : GridAttributes msg
defaultGridItemAttributes =
    GridAttributes "grid-item" gridItemStyle []


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
    | ToggleGridItemPlacementX Bool
    | ToggleGridItemPlacementY Bool
    | ChangeColumnSize Int Int
    | ChangeColumnUnit Int String
    | ChangeRowSize Int Int
    | ChangeRowUnit Int String


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
            , S.box [ Box.backgroundColor Color.black ]
            ]
        ]
        [ whiteItem ( 0, 0 ) ( Grid.untilEndOfCoordinate, Grid.span 1 ) [ creationView model ]
        , transparentItem ( 0, 1 ) ( Grid.span 1, Grid.untilEndOfCoordinate ) [ contentView model ]
        , whiteItem ( 1, 1 ) ( Grid.untilEndOfCoordinate, Grid.span 1 ) [ inspectorView model ]
        , whiteItem ( 1, 2 ) ( Grid.untilEndOfCoordinate, Grid.untilEndOfCoordinate ) [ treeView model ]
        ]


item :
    Elegant.Modifier Box.Box
    -> ( Int, Int )
    -> ( Grid.GridItemSize, Grid.GridItemSize )
    -> List (Node msg)
    -> B.GridItem msg
item color ( x, y ) ( width, height ) =
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
            , S.box [ color ]
            ]
        ]


transparentItem : ( Int, Int ) -> ( Grid.GridItemSize, Grid.GridItemSize ) -> List (Node msg) -> B.GridItem msg
transparentItem =
    item (Box.backgroundColor (Color.rgba 0 0 0 0))


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
    B.grid [ A.style [ S.block [ Block.fullHeight ], S.box [ Box.background [ Background.images [ Background.image "/transparent.png" ] ] ] ] ]
        [ B.gridItem []
            [ B.div []
                [ contentViewEl selectedId element ]
            ]
        ]


selectOrSelected : Int -> Int -> Modifiers (A.VisibleAttributesAndEvents Msg a)
selectOrSelected id selectedId =
    if id == selectedId then
        [ A.style [ S.box [ Box.shadow [ Shadow.blurry (px 5) (px 5) (Color.rgba 30 222 121 0.8) ] ] ] ]
    else
        [ E.onClick (SelectEl id) ]


contentViewGridItem : Int -> Element Msg -> List (B.GridItem Msg)
contentViewGridItem selectedId { tree, id } =
    case tree of
        GridItem gridItem ->
            [ B.gridItem
                (selection gridItem id selectedId)
                (List.map (contentViewEl selectedId) gridItem.children)
            ]

        _ ->
            []


selection :
    { c | attributes : { b | style : Elegant.CommonStyle } }
    -> Int
    -> Int
    -> List (Elegant.Modifier (A.VisibleAttributesAndEvents Msg a))
selection element id selectedId =
    ([ A.class [ Elegant.commonStyleToCss element.attributes.style ] ] ++ selectOrSelected id selectedId)


contentViewEl : Int -> Element Msg -> Node Msg
contentViewEl selectedId { tree, id } =
    case tree of
        Grid grid ->
            B.grid
                (selection grid id selectedId)
                (List.concatMap (contentViewGridItem selectedId) grid.children)

        Block block ->
            block.constructor
                (selection block id selectedId)
                (List.map (contentViewEl selectedId) block.children)

        Inline node ->
            node.constructor
                (selection node id selectedId)
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


whiteItem :
    ( Int, Int )
    -> ( Grid.GridItemSize, Grid.GridItemSize )
    -> List (Node msg)
    -> B.GridItem msg
whiteItem =
    item (Box.backgroundColor (Color.white))


gridEditor :
    GridAttributes Msg
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
            [ whiteItem ( 1, 0 )
                ( Grid.span 1, Grid.span 1 )
                [ arrowSelection xTemplate
                    [ S.block [ Block.width (px (round (240 / (List.length xTemplate |> toFloat)))), Block.alignCenter ] ]
                    Grid.columns
                    (\value type_ columnNumber ->
                        B.flex []
                            [ B.flexItem []
                                [ B.inputNumber
                                    [ A.value value
                                    , E.onInput (ChangeColumnSize columnNumber)
                                    , A.style
                                        [ S.block
                                            [ Block.width (px 40) ]
                                        ]
                                    ]
                                ]
                            , B.flexItem []
                                [ B.select [ E.onInput (ChangeColumnUnit columnNumber) ]
                                    [ B.option "fr" "fr" ("fr" == type_)
                                    , B.option "px" "px" ("px" == type_)
                                    , B.option "%" "%" ("%" == type_)
                                    ]
                                ]
                            ]
                    )
                ]
            , whiteItem
                ( 0, 1 )
                ( Grid.span 1, Grid.span 1 )
                [ arrowSelection yTemplate
                    [ S.block
                        [ Block.height (px (round (240 / (List.length yTemplate |> toFloat)))) ]
                    ]
                    Grid.rows
                    (\value type_ rowNumber ->
                        B.flex
                            [ A.style
                                [ S.flexContainerProperties
                                    [ Flex.align Flex.alignCenter
                                    , Flex.justifyContent Flex.justifyContentCenter
                                    , Flex.direction Flex.column
                                    ]
                                , S.block
                                    [ Block.height (percent 100)
                                    , Block.width (percent 100)
                                    ]
                                ]
                            ]
                            [ B.flexItem []
                                [ B.inputNumber
                                    [ A.value value
                                    , E.onInput (ChangeRowSize rowNumber)
                                    , A.style
                                        [ S.block
                                            [ Block.width (px 40) ]
                                        ]
                                    ]
                                ]
                            , B.flexItem []
                                [ B.select [ E.onInput (ChangeRowUnit rowNumber) ]
                                    [ B.option "fr" "fr" ("fr" == type_)
                                    , B.option "px" "px" ("px" == type_)
                                    , B.option "%" "%" ("%" == type_)
                                    ]
                                ]
                            ]
                    )
                ]
            , transparentItem ( 1, 1 ) ( Grid.span 1, Grid.span 1 ) [ gridView grid xTemplate yTemplate ]
            , whiteItem ( 2, 1 ) ( Grid.span 1, Grid.span 1 ) [ addButton AddColumn Flex.column ]
            , whiteItem ( 1, 2 ) ( Grid.span 1, Grid.span 1 ) [ addButton AddRow Flex.row ]
            ]


replaceTemplateByOneFraction : Grid.GridContainerDetails -> Grid.GridContainerDetails
replaceTemplateByOneFraction gridContainerDetails =
    gridContainerDetails
        |> updateGridContainerToReplaceTemplateInX
        |> updateGridContainerToReplaceTemplateInY


updateGridContainerToReplaceTemplateInY : Grid.GridContainerDetails -> Grid.GridContainerDetails
updateGridContainerToReplaceTemplateInY ({ y } as gridContainerDetails) =
    y
        |> Maybe.withDefault (Grid.GridContainerCoordinate Nothing Nothing Nothing Nothing)
        |> replaceTemplate
        |> Just
        |> setYIn gridContainerDetails


updateGridContainerToReplaceTemplateInX : Grid.GridContainerDetails -> Grid.GridContainerDetails
updateGridContainerToReplaceTemplateInX ({ x } as gridContainerDetails) =
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
            |> updateGridContainerInStyle (replaceTemplateByOneFraction)
            |> Elegant.commonStyleToStyle
            |> A.rawStyle
        , A.style [ S.block [ Block.fullHeight ] ]
        ]
        (B.gridItem [ A.style [ S.box [ Box.backgroundColor (Color.rgb 50 50 50) ] ] ] [] |> List.repeat (List.length xTemplate * List.length yTemplate))


arrowSelection :
    List Grid.Repeatable
    -> List (A.StyleModifier (A.NodeAttributes msg))
    -> (Modifiers Grid.GridContainerCoordinate -> Modifier Grid.GridContainerDetails)
    -> (Int -> String -> Int -> Node msg)
    -> Node msg
arrowSelection repeatables styleModifiers selector content =
    B.grid
        [ A.style
            [ S.gridContainerProperties
                [ selector
                    [ repeatables
                        |> List.map (always (Grid.simple (Grid.fractionOfAvailableSpace 1)))
                        |> Grid.template
                    ]
                ]
            , S.block
                [ Block.width (percent 100)
                , Block.height (percent 100)
                ]
            ]
        ]
        (repeatables
            |> List.foldr (generateSizeModifier styleModifiers content) ( (List.length repeatables) - 1, [] )
            |> Tuple.second
        )


generateSizeModifier :
    List (A.StyleModifier (A.NodeAttributes msg))
    -> (Int -> String -> Int -> Node msg)
    -> Grid.Repeatable
    -> ( Int, List (B.GridItem msg) )
    -> ( Int, List (B.GridItem msg) )
generateSizeModifier styleModifiers content repeatable ( placement, acc ) =
    let
        ( size, unit ) =
            case repeatable of
                Grid.Simple x ->
                    case x of
                        Grid.SizeUnitVal y ->
                            case y of
                                Helpers.Shared.Px z ->
                                    ( z, "px" )

                                Helpers.Shared.Percent z ->
                                    ( round z, "%" )

                                _ ->
                                    ( 1, "fr" )

                        Grid.Fr y ->
                            ( y, "fr" )

                        _ ->
                            ( 1, "fr" )

                _ ->
                    ( 1, "fr" )
    in
        ( placement - 1
        , (B.gridItem []
            [ B.node
                [ A.style styleModifiers ]
                [ content size unit placement ]
            ]
          )
            :: acc
        )


addButton : Msg -> Flex.FlexDirection -> Node Msg
addButton msg orientation =
    B.flex
        [ A.style [ S.flexContainerProperties [ Flex.direction orientation ] ] ]
        [ B.flexItem [] [ B.button [ E.onClick msg ] [ B.text "+" ] ] ]


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
                                        [ B.inputColor [ E.onInput (ChangeBoxStyle << ChangeColor), A.value (getColorFromElement tree) ] ]
                                    , B.div []
                                        [ B.text "Box opacity" ]
                                    , B.div []
                                        [ B.inputRange [ A.min 0, A.max 1000, E.onInput (ChangeBoxStyle << ChangeOpacity), A.value (1000 * getOpacityFromElement tree |> round) ] ]
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
                |> Maybe.withDefault ( Nothing, Nothing )

        sizeXY =
            gridItemAttributes
                |> Maybe.andThen extractSizeFromAttributes
                |> Maybe.withDefault ( Nothing, Nothing )
    in
        B.div []
            [ B.div []
                [ B.inputCheckbox
                    [ A.checked (Tuple.first placementXY |> isJust)
                    , E.onCheck ToggleGridItemPlacementX
                    ]
                , B.node [] [ B.text "placement X" ]
                , B.node []
                    [ B.inputNumber
                        ([ A.value (Tuple.first placementXY |> Maybe.withDefault 1 |> flip (-) 1)
                         , E.onInput ChangeGridItemPlacementX
                         ]
                            ++ if Tuple.first placementXY |> isJust then
                                []
                               else
                                [ A.disabled ]
                        )
                    ]
                , B.inputCheckbox
                    [ A.checked (Tuple.second placementXY |> isJust)
                    , E.onCheck ToggleGridItemPlacementY
                    ]
                , B.node [] [ B.text " placement Y " ]
                , B.node []
                    [ B.inputNumber
                        ([ A.value (Tuple.second placementXY |> Maybe.withDefault 1 |> flip (-) 1)
                         , E.onInput ChangeGridItemPlacementY
                         ]
                            ++ if Tuple.second placementXY |> isJust then
                                Debug.log "not disable" []
                               else
                                Debug.log "disable" [ A.disabled ]
                        )
                    ]
                ]
            , B.div []
                [ B.node [] [ B.text "size X" ]
                , B.node []
                    [ B.inputNumber
                        [ A.value (Tuple.first sizeXY |> Maybe.withDefault 1)
                        , E.onInput ChangeGridItemSizeX
                        ]
                    ]
                , B.node [] [ B.text " size Y " ]
                , B.node []
                    [ B.inputNumber
                        [ A.value (Tuple.second sizeXY |> Maybe.withDefault 1)
                        , E.onInput ChangeGridItemSizeY
                        ]
                    ]
                ]
            ]


isJust : Maybe a -> Bool
isJust a =
    case a of
        Nothing ->
            False

        Just _ ->
            True


isNothing : Maybe a -> Bool
isNothing =
    not << isJust


extractSizeFromAttributes : Grid.GridItemDetails -> Maybe ( Maybe Int, Maybe Int )
extractSizeFromAttributes { x, y } =
    Just
        ( x
            |> Maybe.andThen .size
            |> Maybe.andThen extractSpan
        , y
            |> Maybe.andThen .size
            |> Maybe.andThen extractSpan
        )


extractSpan : Grid.GridItemSize -> Maybe Int
extractSpan size =
    case size of
        Grid.Span x ->
            Just x

        Grid.UntilEndOfCoordinate ->
            Nothing


extractPlacementFromAttributes : Grid.GridItemDetails -> Maybe ( Maybe Int, Maybe Int )
extractPlacementFromAttributes { x, y } =
    Just ( x |> Maybe.andThen .placement, y |> Maybe.andThen .placement )


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
        foldOnTagAndChildren
            ([ B.div [ A.style [ S.box [ Box.paddingLeft (px 12) ] ] ]
                [ B.div (selectOrSelected id selectedId) [ B.text "text" ] ]
             ]
            )
            (treeViewElement id selectedId)
            tree


getById : Int -> Element msg -> Maybe (Element msg)
getById id element =
    getByIdHelp id element
        |> List.head


getByIdHelp : Int -> Element msg -> List (Element msg)
getByIdHelp id element =
    if id == element.id then
        [ element ]
    else
        foldOnChildren [] (List.concatMap (getByIdHelp id)) element.tree


getOpacityFromElement : Tree msg -> Float
getOpacityFromElement tree =
    getPropertyFromStyle 1.0 extractOpacityFromStyle tree


getColorFromElement : Tree Msg -> Color.Color
getColorFromElement tree =
    getPropertyFromStyle Color.black extractColorFromStyle tree


getPropertyFromStyle : a -> (Elegant.CommonStyle -> Maybe a) -> Tree msg -> a
getPropertyFromStyle default fun element =
    Maybe.withDefault default <|
        foldOnAttributes Nothing (fun << .style) element


foldOnAttributes : a -> ({ style : Elegant.CommonStyle } -> a) -> Tree msg -> a
foldOnAttributes default fun element =
    case element of
        Block { attributes } ->
            fun attributes

        Inline { attributes } ->
            fun attributes

        Grid { attributes } ->
            fun attributes

        GridItem { attributes } ->
            fun attributes

        _ ->
            default


foldOnChildren : a -> (List (Element msg) -> a) -> Tree msg -> a
foldOnChildren default fun element =
    case element of
        Block { children } ->
            fun children

        Inline { children } ->
            fun children

        Grid { children } ->
            fun children

        GridItem { children } ->
            fun children

        _ ->
            default


foldOnTagAndChildren : a -> (String -> List (Element msg) -> a) -> Tree msg -> a
foldOnTagAndChildren default fun element =
    case element of
        Block { tag, children } ->
            fun tag children

        Inline { tag, children } ->
            fun tag children

        Grid { tag, children } ->
            fun tag children

        GridItem { tag, children } ->
            fun tag children

        _ ->
            default


main : Program Never Model Msg
main =
    B.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
