module View exposing (..)

import Types exposing (..)
import BodyBuilder as Builder exposing (Node)
import BodyBuilder.Attributes as Attributes
import BodyBuilder.Events as Events
import Elegant exposing (Modifiers, px, percent)
import Either exposing (Either(..))
import Color exposing (Color)
import Style
import Display
import Box
import Block
import Grid
import Background


view : Model -> Node Msg
view model =
    Builder.grid
        [ Attributes.style
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
        Builder.flex
            [ Attributes.style
                [ Style.block [ Block.height (percent 100) ]
                ]
            ]
            (insidePossibilities
                |> List.map
                    (\( msg, str ) ->
                        Builder.flexItem []
                            [ Builder.button
                                [ Attributes.style [ Style.block [ Block.height (percent 100) ] ]
                                , Events.onClick msg
                                ]
                                [ Builder.text str ]
                            ]
                    )
            )


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


contentViewGridItem : Int -> Element Msg -> List (Builder.GridItem Msg)
contentViewGridItem selectedId { tree, id } =
    case tree of
        Left treeType ->
            []

        Right (GridItem gridItem) ->
            [ Builder.gridItem
                ([ Attributes.class [ Elegant.commonStyleToCss gridItem.attributes.style ] ] ++ selectOrSelected id selectedId)
                (List.map (contentViewEl selectedId) gridItem.children)
            ]


contentViewEl : Int -> Element Msg -> Node Msg
contentViewEl selectedId { tree, id } =
    case tree of
        Left treeType ->
            case treeType of
                Grid grid ->
                    Builder.grid
                        ([ Attributes.class [ Elegant.commonStyleToCss grid.attributes.style ] ] ++ selectOrSelected id selectedId)
                        (List.concatMap (contentViewGridItem selectedId) grid.children)

                Block block ->
                    block.constructor
                        ([ Attributes.class [ Elegant.commonStyleToCss block.attributes.style ] ] ++ selectOrSelected id selectedId)
                        (List.map (contentViewEl selectedId) block.children)

                Text content ->
                    Builder.text content

        Right gridItem ->
            Builder.text ""


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


treeView : Model -> Node Msg
treeView { selectedId, element } =
    Builder.div []
        [ Builder.h1 [] [ Builder.text "Tree view" ]
        , displayTreeView selectedId element
        ]


treeViewElement : Int -> Int -> String -> List (Element msg) -> List (Node Msg)
treeViewElement id selectedId tag =
    List.map (displayTreeView selectedId)
        >> (::) (Builder.div (selectOrSelected id selectedId) [ Builder.text tag ])
        >> Builder.div [ Attributes.style [ Style.box [ Box.paddingLeft (px 12) ] ] ]
        >> List.singleton


displayTreeView : Int -> Element msg -> Node Msg
displayTreeView selectedId { id, tree } =
    Builder.div [] <|
        case tree of
            Left treeType ->
                case treeType of
                    Text content ->
                        [ Builder.div [ Attributes.style [ Style.box [ Box.paddingLeft (px 12) ] ] ]
                            [ Builder.div (selectOrSelected id selectedId) [ Builder.text "text" ] ]
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
    case tree of
        Left treeType ->
            case treeType of
                Block { attributes } ->
                    extractColorFromStyle attributes.style

                Grid { attributes } ->
                    extractColorFromStyle attributes.style

                Text content ->
                    Color.black

        Right (GridItem { attributes }) ->
            extractColorFromStyle attributes.style


extractColorFromStyle : Elegant.CommonStyle -> Color
extractColorFromStyle style =
    case style.display of
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
