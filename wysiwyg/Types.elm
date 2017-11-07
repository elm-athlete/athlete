module Types exposing (..)

import Elegant exposing (Modifiers, px, percent)
import BodyBuilder as B exposing (Node)
import BodyBuilder.Attributes as A
import Color exposing (Color)
import Display
import Grid


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
            |> Just
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
