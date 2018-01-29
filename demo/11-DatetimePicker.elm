module DatetimePicker exposing (..)

import BodyBuilder as Builder exposing (Node)
import BodyBuilder.Attributes as Attributes
import BodyBuilder.Events as Events
import Color exposing (Color)
import Elegant exposing (px, vh, percent, Style, deg)
import Border
import Style
import Grid
import Grid.Extra
import Box
import Block
import Flex
import Transform
import Position
import Padding
import Typography
import Json.Decode as Decode
import Mouse
import Time


type Msg
    = DragStart Mouse.Position
    | DragAt Mouse.Position
    | DragEnd Mouse.Position
    | Tick Time.Time


type alias Model =
    { maybeDrag : Maybe Drag
    , rotation : Float
    , movement : Float
    }


type alias Drag =
    { start : Mouse.Position
    , current : Mouse.Position
    , travelledDistance : Int
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        DragStart xy ->
            ( { model | maybeDrag = Just (Drag xy xy 0) }, Cmd.none )

        DragAt xy ->
            let
                newRotation =
                    case model.maybeDrag of
                        Just drag ->
                            xy.y - drag.current.y |> toFloat

                        Nothing ->
                            model.rotation
            in
                ( { model
                    | rotation = model.rotation - newRotation
                    , maybeDrag =
                        (Maybe.map
                            (\drag ->
                                Drag drag.start
                                    xy
                                    (drag.travelledDistance + 1)
                            )
                            model.maybeDrag
                        )
                  }
                , Cmd.none
                )

        DragEnd xy ->
            let
                newRotation =
                    case model.maybeDrag of
                        Just drag ->
                            xy.y - drag.current.y |> toFloat

                        Nothing ->
                            model.rotation

                newMovement =
                    case model.maybeDrag of
                        Just drag ->
                            xy.y - drag.current.y |> toFloat

                        Nothing ->
                            model.movement
            in
                ( { model
                    | rotation = model.rotation - newRotation
                    , maybeDrag = Nothing
                  }
                , Cmd.none
                )

        Tick _ ->
            let
                newRotation =
                    model.rotation + model.movement

                newMovement =
                    if (model.movement < 0) then
                        (model.movement + 1)
                    else if (model.movement > 0) then
                        (model.movement - 1)
                    else
                        0
            in
                ( { model
                    | rotation = newRotation
                    , movement = newMovement
                  }
                , Cmd.none
                )


alignedCellWithPurpleBackground : ( Int, Int ) -> ( Int, Int ) -> ( Flex.Align, Flex.JustifyContent ) -> List (Node msg) -> Builder.GridItem msg
alignedCellWithPurpleBackground =
    Grid.Extra.alignedCell [ Style.box [ Box.backgroundColor Color.purple ] ]


example : Node msg
example =
    Builder.grid
        [ Attributes.style
            [ Style.block [ Block.height (vh 100) ]
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
            , Style.box [ Box.backgroundColor Color.lightPurple ]
            ]
        ]
        [ alignedCellWithPurpleBackground ( 0, 0 ) ( 1, 1 ) ( Flex.flexEnd, Flex.justifyContentFlexStart ) [ content "bottom left" ]
        , alignedCellWithPurpleBackground ( 2, 0 ) ( 1, 2 ) ( Flex.alignCenter, Flex.justifyContentCenter ) [ content "center" ]
        , alignedCellWithPurpleBackground ( 1, 2 ) ( 2, 1 ) ( Flex.flexStart, Flex.justifyContentFlexEnd ) [ content "top right" ]
        , alignedCellWithPurpleBackground ( 0, 1 ) ( 1, 2 ) ( Flex.alignCenter, Flex.justifyContentFlexEnd ) [ content "center right" ]
        ]


content : String -> Node msg
content str =
    Builder.div [ Attributes.style [ Style.box [ Box.backgroundColor Color.yellow, Box.paddingAll (px 24) ] ] ] [ Builder.text str ]


rotatedDiv : Float -> String -> Int -> Elegant.SizeUnit -> Node msg
rotatedDiv angle text height translationZ =
    --   height: 116px;
    --   line-height: 116px;
    Builder.div
        [ Attributes.style
            [ Style.blockProperties
                [ Block.height (px height)
                , Block.width (px 300)
                , Block.alignCenter
                ]
            , Style.box
                [ Box.transform
                    [ Transform.rotateX (deg angle)
                    , Transform.translateZ translationZ
                    , Transform.backfaceVisibilityHidden
                    ]
                , Box.typography
                    [ Typography.size (px 20)
                    , Typography.lineHeight (px height)
                    ]
                , Box.border
                    [ Border.all
                        [ Border.thickness (px 1)
                        , Border.solid
                        ]
                    ]
                , Box.position <|
                    Position.absolute
                        []
                ]
            ]
        ]
        [ Builder.text text ]


carousel : List String -> Int -> Float -> List (Node msg)
carousel list height rotation =
    let
        length =
            List.length list - 1
    in
        List.indexedMap
            (\i e ->
                (rotatedDiv
                    (-((i |> toFloat) + ((length |> toFloat) / 2))
                        * (360 / (length |> toFloat))
                        + (rotation / 2)
                    )
                )
                    e
                    height
                    (px (Basics.round (((height |> toFloat) / 2) / Basics.tan (Basics.pi / (length |> toFloat)))))
            )
            list


view : Model -> Node Msg
view model =
    Builder.div
        [ Attributes.style
            [ Style.box
                [ Box.padding
                    [ Padding.left (px 200)
                    , Padding.top (px 200)
                    ]
                ]
            ]
        , Events.on "mousedown" (Decode.map DragStart Mouse.position)
        ]
        [ Builder.div
            [ Attributes.style
                [ Style.blockProperties
                    [ Block.width (px 300)
                    , Block.height (px 116)
                    ]
                , Style.box
                    [ Box.transform
                        [ Transform.preserve3d
                        , Transform.perspective (px 1000)
                        ]
                    ]
                ]
            ]
            (carousel
                [ "19 janvier 2017"
                , "20 janvier 2017"
                , "21 janvier 2017"
                , "22 janvier 2017"
                , "23 janvier 2017"
                , "24 janvier 2017"
                , "25 janvier 2017"
                , "26 janvier 2017"
                , "27 janvier 2017"
                ]
                116
                model.rotation
            )
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        (case model.maybeDrag of
            Just drag ->
                [ Mouse.moves DragAt
                , Mouse.ups (DragEnd)
                ]

            Nothing ->
                if (model.movement /= 0) then
                    [ Time.every (Time.millisecond * 17) Tick ]
                else
                    []
        )


main : Program Basics.Never Model Msg
main =
    Builder.program
        { init = ( Model Nothing 0 0, Cmd.none )
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
