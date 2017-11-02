module Wysiwyg exposing (..)

import BodyBuilder as Builder exposing (Node)
import BodyBuilder.Attributes as Attributes
import BodyBuilder.Events as Events
import Color exposing (Color)
import Elegant exposing (px, vh, percent, Modifiers)
import Style
import Grid
import Box
import Background
import Display
import Block


item :
    ( Int, Int )
    -> ( Grid.GridItemSize, Grid.GridItemSize )
    -> List (Node msg)
    -> Builder.GridItem msg
item ( x, y ) ( width, height ) =
    Builder.gridItem
        [ Attributes.style
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


wysiwyg : Model -> Node Msg
wysiwyg model =
    Builder.grid
        [ Attributes.style
            [ Style.block [ Block.height (percent 100) ]
            , Style.gridContainerProperties
                [ Grid.columns
                    [ Grid.template
                        [ Grid.simple (Grid.fractionOfAvailableSpace 1)
                        , Grid.simple (Grid.fractionOfAvailableSpace 1)
                        , Grid.simple (Grid.fractionOfAvailableSpace 1)
                        ]
                    , Grid.gap (px 30)
                    , Grid.align Grid.stretch
                    , Grid.alignItems (Grid.alignWrapper Grid.center)
                    ]
                , Grid.rows
                    [ Grid.template
                        [ Grid.simple (Grid.fractionOfAvailableSpace 1)
                        , Grid.simple (Grid.fractionOfAvailableSpace 1)
                        , Grid.simple (Grid.fractionOfAvailableSpace 1)
                        ]
                    , Grid.gap (px 30)
                    , Grid.align Grid.stretch
                    , Grid.alignItems (Grid.alignWrapper Grid.center)
                    ]
                ]
            , Style.box [ Box.backgroundColor Color.white ]
            ]
        ]
        [ item ( 0, 0 ) ( Grid.span 2, Grid.untilEndOfCoordinate ) [ contentView model ]
        , item ( 2, 0 ) ( Grid.untilEndOfCoordinate, Grid.span 1 ) [ creationView model ]
        , item ( 2, 1 ) ( Grid.untilEndOfCoordinate, Grid.span 1 ) [ inspectorView model ]
        , item ( 2, 2 ) ( Grid.untilEndOfCoordinate, Grid.untilEndOfCoordinate ) [ treeView model ]
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
        Builder.div [] (insidePossibilities |> List.map (\( msg, str ) -> Builder.button [ Events.onClick msg ] [ Builder.text str ]))


contentView : Model -> Node Msg
contentView { element, selectedId } =
    Builder.div []
        [ contentViewEl selectedId element ]


selectOrSelected : Int -> Int -> Modifiers (Attributes.VisibleAttributesAndEvents Msg a)
selectOrSelected id selectedId =
    if id == selectedId then
        [ Attributes.style [ Style.box [ Box.backgroundColor (Color.rgba 180 180 240 0.4) ] ] ]
    else
        [ Events.onClick (SelectEl id) ]


contentViewEl : Int -> Element Msg -> Node Msg
contentViewEl selectedId { tree, id } =
    case tree of
        Block block ->
            block.constructor
                ([ Attributes.class [ Elegant.commonStyleToCss block.attributes.style ] ] ++ selectOrSelected id selectedId)
                (List.map (contentViewEl selectedId) block.children)

        Text content ->
            Builder.text content


callOn : a -> (a -> b) -> b
callOn var fun =
    fun var


foldElement : (Tree msg -> accumulator -> accumulator) -> accumulator -> Element msg -> accumulator
foldElement fun accu ({ tree } as element) =
    let
        value =
            fun tree accu

        folder =
            foldChildren fun
    in
        case tree of
            Block { children } ->
                List.foldr folder value children

            Text content ->
                value


foldChildren : (Tree msg -> accumulator -> accumulator) -> Element msg -> accumulator -> accumulator
foldChildren fun element acc =
    foldElement fun acc element


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

            Text content ->
                []


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
                Builder.div [] [ Builder.text "Nothing" ]

            Just { id, tree } ->
                let
                    color : Color.Color
                    color =
                        getColorFromTree tree
                in
                    Builder.div []
                        [ Builder.h1 [] [ Builder.text "Inspector" ]
                        , Builder.div []
                            [ Builder.text "Box Attributes" ]
                        , Builder.div []
                            [ Builder.text "Box color" ]
                        , Builder.div []
                            [ Builder.inputColor [ Events.onInput ChangeBoxColor, Attributes.value color ] ]
                        ]


getColorFromTree : Tree Msg -> Color.Color
getColorFromTree tree =
    case tree of
        Block heading ->
            case
                heading.attributes.style
                    |> .display
            of
                Nothing ->
                    Color.black

                Just display ->
                    case display of
                        Display.None ->
                            Color.black

                        Display.ContentsWrapper contents ->
                            contents.maybeBox
                                |> Maybe.withDefault Box.default
                                |> .background
                                |> Maybe.withDefault Background.default
                                |> .color
                                |> Maybe.withDefault Color.black

        Text content ->
            Color.black


extractModifiersWithoutStyleSelector : List ( List a, Attributes.StyleSelector ) -> List a
extractModifiersWithoutStyleSelector =
    List.concatMap extractModifiersWithoutStyleSelectorHelp


extractModifiersWithoutStyleSelectorHelp : ( List a, Attributes.StyleSelector ) -> List a
extractModifiersWithoutStyleSelectorHelp ( modifiers, styleSelector ) =
    if styleSelector == Attributes.StyleSelector Nothing Nothing then
        modifiers
    else
        []


treeView : Model -> Node Msg
treeView { selectedId, element } =
    Builder.div []
        [ Builder.h1 [] [ Builder.text "Tree view" ]
        , displayTreeView selectedId element
        ]


displayTreeView : Int -> Element msg -> Node Msg
displayTreeView selectedId { id, tree } =
    Builder.div [] <|
        case tree of
            Text content ->
                [ Builder.div (selectOrSelected id selectedId) [ Builder.text "text" ] ]

            Block content ->
                [ Builder.div
                    ([ Attributes.style [ Style.box [ Box.paddingLeft (px 12) ] ] ])
                    ((Builder.div (selectOrSelected id selectedId) [ Builder.text content.tag ])
                        :: (List.map (displayTreeView selectedId) content.children)
                    )
                ]


defaultP : Int -> Element Msg
defaultP newId =
    { id = newId
    , tree =
        Block
            { tag = "p"
            , constructor = Builder.p
            , attributes =
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
            , children = [ { id = newId, tree = Text "foo" } ]
            }
    }


defaultDiv : Int -> Element Msg
defaultDiv newId =
    { id = newId
    , tree =
        Block
            { tag = "div"
            , constructor = Builder.div
            , attributes =
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
            , children = []
            }
    }


defaultH1 : Int -> Element Msg
defaultH1 newId =
    { id = newId
    , tree =
        Block
            { tag = "h1"
            , constructor = Builder.h1
            , attributes =
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
            , children = []
            }
    }


init : ( Model, Cmd Msg )
init =
    ( { element = defaultDiv 1, selectedId = 1, autoIncrement = 2 }, Cmd.none )


view : Model -> Node Msg
view =
    wysiwyg


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
            Block heading ->
                { element | tree = Block { heading | children = List.map (changeOnlyCurrentElementColor color selectedId) heading.children } }

            Text content ->
                element


changeColor : Color.Color -> Tree msg -> Tree msg
changeColor color tree =
    case tree of
        Block ({ attributes } as heading) ->
            Block
                { heading
                    | attributes =
                        { style =
                            attributes.style
                                |> changeColorOfStyle color
                        }
                }

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


type alias Element msg =
    { id : Int
    , tree : Tree msg
    }


type Tree msg
    = Block
        { tag : String
        , constructor : Modifiers (Attributes.BlockAttributes msg) -> List (Node msg) -> Node msg
        , attributes : { style : Elegant.CommonStyle }
        , children : List (Element msg)
        }
    | Text String



-- | InputText
--     { tag : Modifiers (Attributes.InputTextAttributes msg) -> Node msg
--     , attributes : Modifiers (Attributes.InputTextAttributes msg)
--     }
-- | Vanilla
--     { tag : Modifiers (Attributes.NodeAttributes msg) -> Node msg
--     , attributes : Modifiers (Attributes.NodeAttributes msg)
--     , children : List (Element msg)
--     }


type alias Model =
    { element : Element Msg
    , selectedId : Int
    , autoIncrement : Int
    }



--
--
-- type GridParams =
--
--
-- type HtmlElement =


type Msg
    = CreateP
    | CreateH1
    | SelectEl Int
    | ChangeBoxColor Color.Color



-- createP :
--     { b
--         | elements :
--             List
--     }
--     ->
--         { b
--             | elements :
--                 List
--                     { attributes : List (Helpers.Shared.Modifier a)
--                     , children : List (Node msg)
--                     , id : Int
--                     , tag :
--                         Helpers.Shared.Modifiers (Attributes.HeadingAttributes msg1)
--                         -> List (Node msg1)
--                         -> Node msg1
--                     }
--         }


addChildToTree : Element msg -> Tree msg -> Tree msg
addChildToTree child parent =
    case parent of
        Block block ->
            Block { block | children = block.children ++ [ child ] }

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

        _ ->
            tree


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
        , view = view
        }
