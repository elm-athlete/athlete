module Main exposing (..)

import BodyBuilder as Builder exposing (Node)
import BodyBuilder.Attributes as Attributes
import Color exposing (Color)
import Elegant exposing (px, vh, percent, Modifiers)
import Box
import Background
import Display
import Either exposing (Either(..))
import Types exposing (..)
import View


callOn : a -> (a -> b) -> b
callOn var fun =
    fun var


extractModifiersWithoutStyleSelector : List ( List a, Attributes.StyleSelector ) -> List a
extractModifiersWithoutStyleSelector =
    List.concatMap extractModifiersWithoutStyleSelectorHelp


extractModifiersWithoutStyleSelectorHelp : ( List a, Attributes.StyleSelector ) -> List a
extractModifiersWithoutStyleSelectorHelp ( modifiers, styleSelector ) =
    if styleSelector == Attributes.StyleSelector Nothing Nothing then
        modifiers
    else
        []


defaultP : Int -> Element Msg
defaultP newId =
    { id = newId
    , tree =
        Left <|
            Block
                { tag = "p"
                , constructor = Builder.p
                , attributes = blockAttributes
                , children = [ { id = newId, tree = Left <| Text "foo" } ]
                }
    }


blockAttributes : { style : Elegant.CommonStyle }
blockAttributes =
    { style =
        Elegant.commonStyle
            (Just
                (Display.ContentsWrapper
                    { outsideDisplay = Display.Block Nothing
                    , insideDisplay = Display.Flow
                    , maybeBox = Nothing
                    }
                )
            )
            []
            Nothing
    }


defaultDiv : Int -> Element Msg
defaultDiv newId =
    { id = newId
    , tree =
        Left <|
            Block
                { tag = "div"
                , constructor = Builder.div
                , attributes = blockAttributes
                , children = []
                }
    }


defaultH1 : Int -> Element Msg
defaultH1 newId =
    { id = newId
    , tree =
        Left <|
            Block
                { tag = "h1"
                , constructor = Builder.h1
                , attributes = blockAttributes
                , children = []
                }
    }


defaultGrid : Int -> Element Msg
defaultGrid newId =
    { id = newId
    , tree =
        Left <|
            Grid
                { attributes =
                    { style =
                        Elegant.commonStyle
                            (Just
                                (Display.ContentsWrapper
                                    { outsideDisplay = Display.Inline
                                    , insideDisplay = Display.GridContainer Nothing
                                    , maybeBox = Nothing
                                    }
                                )
                            )
                            []
                            Nothing
                    }
                , children = []
                }
    }


defaultText : String -> Int -> Element msg
defaultText content newId =
    { id = newId
    , tree =
        Left <|
            Text content
    }


init : ( Model, Cmd Msg )
init =
    ( { element = defaultDiv 1, selectedId = 1, autoIncrement = 2 }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


selectEl : a -> { c | selectedId : b } -> { c | selectedId : a }
selectEl id model =
    { model | selectedId = id }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CreateP ->
            ( putElementAsChildIntoModel model defaultP, Cmd.none )

        CreateH1 ->
            ( putElementAsChildIntoModel model defaultH1, Cmd.none )

        CreateGrid ->
            ( putElementAsChildIntoModel model defaultGrid, Cmd.none )

        SelectEl id ->
            ( model |> selectEl id, Cmd.none )

        ChangeBoxColor color ->
            ( model |> changeBoxColorOfCurrentElement color, Cmd.none )


changeOnlyCurrentElementColor : Color.Color -> Int -> Element msg -> Element msg
changeOnlyCurrentElementColor color selectedId ({ id, tree } as element) =
    if id == selectedId then
        { element | tree = changeColor color tree }
    else
        case tree of
            Left treeType ->
                case treeType of
                    Block heading ->
                        { element | tree = Left <| Block { heading | children = List.map (changeOnlyCurrentElementColor color selectedId) heading.children } }

                    Grid grid ->
                        { element | tree = Left <| Grid { grid | children = List.map (changeOnlyCurrentElementColor color selectedId) grid.children } }

                    Text content ->
                        element

            Right (GridItem gridItem) ->
                { element | tree = Right <| GridItem { gridItem | children = List.map (changeOnlyCurrentElementColor color selectedId) gridItem.children } }


changeColorInAttributes :
    { b | attributes : { a | style : Elegant.CommonStyle } }
    -> Color
    -> { b | attributes : { style : Elegant.CommonStyle } }
changeColorInAttributes element color =
    { element
        | attributes =
            { style =
                element.attributes.style
                    |> changeColorOfStyle color
            }
    }


changeColor : Color.Color -> Either (Tree msg) (GridItem msg) -> Either (Tree msg) (GridItem msg)
changeColor color tree =
    case tree of
        Left treeType ->
            case treeType of
                Block heading ->
                    Left <| Block <| changeColorInAttributes heading color

                Grid grid ->
                    Left <| Grid <| changeColorInAttributes grid color

                Text content ->
                    tree

        Right (GridItem gridItem) ->
            Right <| GridItem <| changeColorInAttributes gridItem color


changeColorOfStyle : Color.Color -> Elegant.CommonStyle -> Elegant.CommonStyle
changeColorOfStyle color ({ display } as style) =
    case display of
        Nothing ->
            Elegant.commonStyle (Just Display.None) [] Nothing

        Just displayyy ->
            case displayyy of
                Display.None ->
                    Elegant.commonStyle (Just Display.None) [] Nothing

                Display.ContentsWrapper ({ maybeBox } as contents) ->
                    let
                        newBox =
                            case maybeBox of
                                Nothing ->
                                    let
                                        defaultBox =
                                            Box.default

                                        defaultBackground =
                                            Background.default
                                    in
                                        { defaultBox | background = Just { defaultBackground | color = Just color } }

                                Just box ->
                                    let
                                        background =
                                            Maybe.withDefault Background.default box.background
                                    in
                                        { box | background = Just { background | color = Just color } }
                    in
                        { style | display = Just (Display.ContentsWrapper { contents | maybeBox = Just newBox }) }


changeBoxColorOfCurrentElement : Color.Color -> Model -> Model
changeBoxColorOfCurrentElement color ({ element, selectedId } as model) =
    { model | element = element |> changeOnlyCurrentElementColor color selectedId }


addChildToTree : Element msg -> Either (Tree msg) (GridItem msg) -> Either (Tree msg) (GridItem msg)
addChildToTree child parent =
    case parent of
        Left treeType ->
            case treeType of
                Block block ->
                    Left <| Block { block | children = block.children ++ [ child ] }

                Grid grid ->
                    Left <| Grid { grid | children = grid.children ++ [ child ] }

                _ ->
                    parent

        Right (GridItem gridItem) ->
            Right <| GridItem { gridItem | children = gridItem.children ++ [ child ] }


addChildToElement : Element msg -> Element msg -> Element msg
addChildToElement parent child =
    { parent | tree = parent.tree |> addChildToTree child }


putElementAsChildIntoSelectedElement : Int -> Element msg -> Element msg -> Element msg
putElementAsChildIntoSelectedElement selectedId child parent =
    if parent.id == selectedId then
        { parent | tree = addChildToTree child parent.tree }
    else
        { parent | tree = addChildToChildren parent.tree (putElementAsChildIntoSelectedElement selectedId child) }


addChildToChildren : Either (Tree msg) (GridItem msg) -> (Element msg -> Element msg) -> Either (Tree msg) (GridItem msg)
addChildToChildren tree elementModifier =
    case tree of
        Left treeType ->
            case treeType of
                Block block ->
                    Left <| Block { block | children = List.map elementModifier block.children }

                Grid grid ->
                    Left <| Grid { grid | children = List.map elementModifier grid.children }

                _ ->
                    tree

        Right (GridItem gridItem) ->
            Right <| GridItem { gridItem | children = List.map elementModifier gridItem.children }


putElementAsChildIntoModel : Model -> (Int -> Element Msg) -> Model
putElementAsChildIntoModel ({ selectedId, element, autoIncrement } as model) childCreator =
    { model
        | element = putElementAsChildIntoSelectedElement selectedId (childCreator autoIncrement) element
        , autoIncrement = autoIncrement + 1
    }


main : Program Never Model Msg
main =
    Builder.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = View.view
        }
