module DatetimePicker exposing (..)

import BodyBuilder as Builder exposing (Node)
import BodyBuilder.Attributes as Attributes
import BodyBuilder.Events as Events
import Elegant exposing (px, vh, percent, Style, deg)
import Border
import Style
import Box
import Block
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
    , speed : Float
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
                            model.rotation - (xy.y - drag.current.y |> toFloat)

                        Nothing ->
                            model.rotation
            in
                ( { model
                    | rotation = newRotation
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
                            model.rotation - (xy.y - drag.current.y |> toFloat)

                        Nothing ->
                            model.rotation

                newSpeed =
                    case model.maybeDrag of
                        Just drag ->
                            xy.y - drag.current.y |> toFloat

                        Nothing ->
                            model.speed
            in
                ( { model
                    | rotation = newRotation
                    , maybeDrag = Nothing
                    , speed = newSpeed
                  }
                , Cmd.none
                )

        Tick _ ->
            let
                newRotation =
                    model.rotation + model.speed

                newSpeed =
                    if (model.speed < 0) then
                        (model.speed + 1)
                    else if (model.speed > 0) then
                        (model.speed - 1)
                    else
                        0
            in
                ( { model
                    | rotation = newRotation
                    , speed = newSpeed
                  }
                , Cmd.none
                )


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


carousel : List String -> Int -> Float -> Node msg
carousel list height rotation =
    let
        length =
            List.length list
    in
        Builder.div []
            (List.indexedMap
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
            )


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
            [ carousel
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
            ]
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
                if (model.speed /= 0) then
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
