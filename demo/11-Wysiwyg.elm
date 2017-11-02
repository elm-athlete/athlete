module Wysiwyg exposing (..)

import BodyBuilder as Builder exposing (Node)
import BodyBuilder.Attributes as Attributes
import BodyBuilder.Events as Events
import Color exposing (Color)
import Elegant exposing (px, vh, percent, Modifiers)
import Style
import Grid
import Box
import Function
import Background


-- import Shadow

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
        , item ( 2, 0 ) ( Grid.untilEndOfCoordinate, Grid.span 1 ) [ creationView ]
        , item ( 2, 1 ) ( Grid.untilEndOfCoordinate, Grid.span 1 ) [ inspectorView model ]
        , item ( 2, 2 ) ( Grid.untilEndOfCoordinate, Grid.untilEndOfCoordinate ) [ treeView model ]
        ]


creationView : Node Msg
creationView =
    Builder.div []
        [ Builder.button [ Events.onClick CreateP ] [ Builder.text "p" ]
        , Builder.button [ Events.onClick CreateH1 ] [ Builder.text "h1" ]
        ]


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
        Heading heading ->
            heading.constructor
                (heading.attributes ++ selectOrSelected id selectedId)
                (List.map (contentViewEl selectedId) heading.children)

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
            Heading { children } ->
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
            Heading { children } ->
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
        Heading heading ->
            Attributes.defaultHeadingAttributes
                |> (Function.compose heading.attributes)
                |> .box
                |> extractModifiersWithoutStyleSelector
                |> Function.compose
                |> callOn Box.default
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
            Heading heading ->
                Builder.div (selectOrSelected id selectedId) [ Builder.text heading.tag ]
                    :: (List.map (displayTreeView selectedId) heading.children)

            Text content ->
                [ Builder.div (selectOrSelected id selectedId) [ Builder.text "text" ] ]


defaultP : Int -> Element Msg -> Element Msg
defaultP newId content =
    { id = newId
    , tree =
        Heading
            { tag = "p"
            , constructor = Builder.p
            , attributes = []
            , children = [ content ]
            }
    }


defaultH1 : Int -> Element Msg -> Element Msg
defaultH1 newId content =
    { id = newId
    , tree =
        Heading
            { tag = "p"
            , constructor = Builder.h1
            , attributes = []
            , children = [ content ]
            }
    }


init : ( Model, Cmd Msg )
init =
    ( { element = defaultP 1 { id = 2, tree = Text "Foo" }, selectedId = 1 }, Cmd.none )


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
            ( model |> createP, Cmd.none )

        CreateH1 ->
            ( model |> createH1, Cmd.none )

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
            Heading heading ->
                { element | tree = Heading { heading | children = List.map (changeOnlyCurrentElementColor color selectedId) heading.children } }

            Text content ->
                element


changeColor : Color.Color -> Tree msg -> Tree msg
changeColor color tree =
    case tree of
        Heading heading ->
            Heading { heading | attributes = (Attributes.style [ Style.box [ Box.backgroundColor color ] ]) :: heading.attributes }

        Text content ->
            tree


changeBoxColorOfCurrentElement : Color.Color -> Model -> Model
changeBoxColorOfCurrentElement color ({ element, selectedId } as model) =
    { model | element = element |> changeOnlyCurrentElementColor color selectedId }


type alias Element msg =
    { id : Int
    , tree : Tree msg
    }


type Tree msg
    = Heading
        { tag : String
        , constructor : Modifiers (Attributes.HeadingAttributes msg) -> List (Node msg) -> Node msg
        , attributes : Modifiers (Attributes.HeadingAttributes msg)
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


createH1 : Model -> Model
createH1 model =
    { model | element = defaultH1 12 model.element }


createP : Model -> Model
createP model =
    { model | element = defaultP 34 model.element }


main : Program Never Model Msg
main =
    Builder.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
