module Main exposing (..)

import BodyBuilder as B exposing (Node)
import Color exposing (Color)
import Elegant exposing (px, vh, percent, Modifiers)
import Box
import Background
import Display
import Types exposing (..)
import View
import Update


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


addColumnInGrid : Model -> Model
addColumnInGrid model =
    model


changeOnlyCurrentElementColor : Color.Color -> Int -> Element msg -> Element msg
changeOnlyCurrentElementColor color selectedId ({ id, tree } as element) =
    if id == selectedId then
        { element | tree = changeColor color tree }
    else
        case tree of
            Block heading ->
                heading
                    |> .children
                    |> List.map (changeOnlyCurrentElementColor color selectedId)
                    |> setChildrenIn heading
                    |> Block
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
    { b | attributes : { style : Elegant.CommonStyle } }
    -> Color
    -> { b | attributes : { style : Elegant.CommonStyle } }
changeColorInAttributes element color =
    element.attributes.style
        |> changeColorOfStyle color
        |> setStyleIn element.attributes
        |> setAttributesIn element


changeColor : Color.Color -> Tree msg -> Tree msg
changeColor color tree =
    case tree of
        Block heading ->
            Block <| changeColorInAttributes heading color

        Grid grid ->
            Grid <| changeColorInAttributes grid color

        GridItem gridItem ->
            GridItem <| changeColorInAttributes gridItem color

        Text content ->
            tree


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


changeTextOfCurrentElement : String -> Model -> Model
changeTextOfCurrentElement text ({ element, selectedId } as model) =
    { model | element = element |> changeOnlyCurrentElementText text selectedId }


changeOnlyCurrentElementText text selectedId ({ id, tree } as element) =
    if id == selectedId then
        { element | tree = Text text }
    else
        case tree of
            Block heading ->
                heading
                    |> .children
                    |> List.map (changeOnlyCurrentElementText text selectedId)
                    |> setChildrenIn heading
                    |> Block
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


addChildToTree : Element msg -> Tree msg -> Tree msg
addChildToTree child parent =
    case parent of
        Block block ->
            Block { block | children = block.children ++ [ child ] }

        Grid grid ->
            Grid { grid | children = grid.children ++ [ child ] }

        GridItem gridItem ->
            GridItem { gridItem | children = gridItem.children ++ [ child ] }

        _ ->
            parent


addChildToElement : Element msg -> Element msg -> Element msg
addChildToElement parent child =
    { parent | tree = parent.tree |> addChildToTree child }


putElementAsChildIntoSelectedElement : Int -> Element msg -> Element msg -> Element msg
putElementAsChildIntoSelectedElement selectedId child parent =
    if parent.id == selectedId then
        { parent | tree = addChildToTree child parent.tree }
    else
        { parent | tree = addChildToChildren parent.tree (putElementAsChildIntoSelectedElement selectedId child) }


addChildToChildren : Tree msg -> (Element msg -> Element msg) -> Tree msg
addChildToChildren tree elementModifier =
    case tree of
        Block block ->
            Block { block | children = List.map elementModifier block.children }

        Grid grid ->
            Grid { grid | children = List.map elementModifier grid.children }

        GridItem gridItem ->
            GridItem { gridItem | children = List.map elementModifier gridItem.children }

        _ ->
            tree


putElementAsChildIntoModel : Model -> (Int -> Element Msg) -> Model
putElementAsChildIntoModel ({ selectedId, element, autoIncrement } as model) childCreator =
    { model
        | element = putElementAsChildIntoSelectedElement selectedId (childCreator autoIncrement) element
        , selectedId = autoIncrement
        , autoIncrement = autoIncrement + 1
    }


main : Program Never Model Msg
main =
    B.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = View.view
        }
