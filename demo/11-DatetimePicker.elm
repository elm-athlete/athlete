module DatetimePicker exposing (..)

import BodyBuilder as Builder exposing (Node)
import BodyBuilder.Attributes as Attributes
import Elegant exposing (px, vh, percent, Style, deg)
import Style
import Box
import Block
import Transform
import Position
import Padding
import Typography
import Constants
import AnimationFrame
import Time exposing (Time)
import Task
import List.Extra
import SingleTouch
import Touch exposing (Coordinates)
import BoundedList exposing (BoundedList)


updateIdentity : a -> ( a, Cmd msg )
updateIdentity model =
    model ! []


addCmds : List (Cmd msg) -> b -> ( b, Cmd msg )
addCmds cmds model =
    model ! cmds


setHoldState : a -> { c | holdState : b } -> { c | holdState : a }
setHoldState b a =
    { a | holdState = b }


setHoldStateIn : { c | holdState : b } -> a -> { c | holdState : a }
setHoldStateIn =
    flip setHoldState


setPosition : a -> { c | position : b } -> { c | position : a }
setPosition b a =
    { a | position = b }


setPositionIn : { c | position : b } -> a -> { c | position : a }
setPositionIn =
    flip setPosition


setLastPositions : a -> { c | lastPositions : b } -> { c | lastPositions : a }
setLastPositions b a =
    { a | lastPositions = b }


setLastPositionsIn : { c | lastPositions : b } -> a -> { c | lastPositions : a }
setLastPositionsIn =
    flip setLastPositions


setTouchesHistory : a -> { c | touchesHistory : b } -> { c | touchesHistory : a }
setTouchesHistory b a =
    { a | touchesHistory = b }


setTouchesHistoryIn : { c | touchesHistory : b } -> a -> { c | touchesHistory : a }
setTouchesHistoryIn =
    flip setTouchesHistory


type Msg
    = RecordingTouches RecordingTouchesMsg
    | RecordsAt Float Time
    | NewTime Time


type RecordingTouchesMsg
    = StartRecordingTouches Coordinates
    | RecordTouch Coordinates
    | StopRecordingTouches Coordinates


type alias Model =
    { holdState : HoldState
    , touchesHistory : TouchesHistory
    , position : Float
    }


type alias Speed =
    Float


type HoldState
    = Held
    | Released ( Time, Speed )


type alias TouchesHistory =
    { lastPositions : BoundedList ( Float, Time )
    , startPosition : Float
    }


initTouchesHistory : Float -> TouchesHistory
initTouchesHistory =
    TouchesHistory (BoundedList.new 5)


reinitTouchesHistory : Float -> Model -> Model
reinitTouchesHistory =
    setTouchesHistory << initTouchesHistory


main : Program Basics.Never Model Msg
main =
    Builder.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


init : ( Model, Cmd Msg )
init =
    { holdState = Released ( 0, 0 )
    , touchesHistory = initTouchesHistory 0
    , position = 0
    }
        ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch <|
        case model.holdState of
            Held ->
                []

            Released ( _, speed ) ->
                if (speed < -0.05 || speed > 0.05) then
                    [ AnimationFrame.times NewTime ]
                else
                    []


updatePosition : Model -> Model
updatePosition model =
    model
        |> interpolatePosition
        |> setPositionIn model


interpolatePosition : Model -> Float
interpolatePosition { holdState, touchesHistory, position } =
    case holdState of
        Held ->
            interpolatePositionHelper touchesHistory position

        Released _ ->
            position


interpolatePositionHelper : TouchesHistory -> Float -> Float
interpolatePositionHelper history position =
    history.lastPositions
        |> BoundedList.head
        |> Maybe.map Tuple.first
        |> Maybe.map (flip (-) history.startPosition)
        |> Maybe.map ((-) position)
        |> Maybe.withDefault position


computeSpeed : Model -> Model
computeSpeed ({ touchesHistory } as model) =
    touchesHistory.lastPositions
        |> BoundedList.content
        |> getTimeAndSpeed
        |> Released
        |> setHoldStateIn model


getTimeAndSpeed : List ( Float, Time ) -> ( Float, Float )
getTimeAndSpeed lastPositions =
    case lastPositions of
        [] ->
            ( 0, 0 )

        [ e ] ->
            ( 0, 0 )

        ( lastPosition, lastTime ) :: l ->
            case List.Extra.last l of
                Just ( firstPosition, firstTime ) ->
                    ( lastTime
                    , 2
                        * (lastPosition - firstPosition)
                        / (lastTime - firstTime)
                    )

                Nothing ->
                    ( 0, 0 )


applyAndChangeSpeed : Time.Time -> Time.Time -> Speed -> Model -> Model
applyAndChangeSpeed lastTime newTime ySpeed model =
    { model
        | position =
            model.position - (ySpeed * (newTime - lastTime))
    }
        |> setHoldState
            (Released
                ( newTime
                , ySpeed
                    * (0.99
                        ^ ((round (newTime - lastTime))
                            % 17
                            |> toFloat
                          )
                      )
                )
            )


addInHistory : Float -> Time -> TouchesHistory -> TouchesHistory
addInHistory position currentTime history =
    history.lastPositions
        |> BoundedList.insert ( position, currentTime )
        |> setLastPositionsIn history


update : Msg -> Model -> ( Model, Cmd Msg )
update msg ({ touchesHistory, holdState } as model) =
    case msg of
        RecordingTouches action ->
            updateRecordingAction action model

        RecordsAt position currentTime ->
            touchesHistory
                |> addInHistory position currentTime
                |> setTouchesHistoryIn model
                |> (case model.holdState of
                        Held ->
                            identity

                        Released ( lastTime, ySpeed ) ->
                            computeSpeed
                                >> updatePosition
                                >> applyAndChangeSpeed lastTime currentTime ySpeed
                   )
                |> updateIdentity

        NewTime time ->
            updateIdentity <|
                case model.holdState of
                    Held ->
                        model

                    Released ( lastTime, ySpeed ) ->
                        applyAndChangeSpeed lastTime time ySpeed model


updateRecordingAction : RecordingTouchesMsg -> Model -> ( Model, Cmd Msg )
updateRecordingAction msg =
    case msg of
        StartRecordingTouches { clientY } ->
            reinitTouchesHistory clientY >> recordsAt clientY

        RecordTouch { clientY } ->
            recordsAt clientY

        StopRecordingTouches { clientY } ->
            stopRecordTouches >> recordsAt clientY


recordsAt : Float -> Model -> ( Model, Cmd Msg )
recordsAt position =
    addCmds [ Task.perform (RecordsAt position) Time.now ]


stopRecordTouches : Model -> Model
stopRecordTouches ({ touchesHistory, holdState } as model) =
    case holdState of
        Held ->
            Released ( 0, 0 )
                |> setHoldStateIn model

        Released _ ->
            model



-- View


rotatedDiv : Float -> String -> Int -> Elegant.SizeUnit -> Node msg
rotatedDiv angle text height translationZ =
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
                    , Typography.userSelect (False)
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
        Builder.div
            [ Attributes.style
                [ Style.blockProperties
                    [ Block.width (px 300)
                    , Block.height (px height)
                    ]
                , Style.box
                    [ Box.transform
                        [ Transform.preserve3d
                        , Transform.perspective (px 1000)
                        ]
                    ]
                ]
            ]
            [ Builder.div
                [ Attributes.style
                    [ Style.box
                        [ Box.transform
                            [ Transform.rotateX (deg (rotation / 2))
                            , Transform.preserve3d
                            , Transform.origin
                                ( Constants.zero
                                , px
                                    ((toFloat height)
                                        / 2
                                        |> round
                                    )
                                , Constants.zero
                                )
                            ]
                        ]
                    ]
                ]
                (List.indexedMap
                    (\i e ->
                        (rotatedDiv
                            (-(((i |> toFloat)) + ((length |> toFloat) / 2))
                                * (360 / (length |> toFloat))
                            )
                        )
                            e
                            height
                            (px
                                (Basics.round
                                    (((height |> toFloat)
                                        / 2
                                     )
                                        / Basics.tan
                                            (Basics.pi
                                                / (length |> toFloat)
                                            )
                                    )
                                )
                            )
                    )
                    list
                )
            ]


view : Model -> Node Msg
view model =
    Builder.div
        ([ Attributes.style
            [ Style.box
                [ Box.padding
                    [ Padding.left (px 200)
                    , Padding.top (px 200)
                    ]
                ]
            ]
         , Attributes.rawAttribute <| SingleTouch.onStart (RecordingTouches << StartRecordingTouches)
         ]
            ++ (case model.holdState of
                    Held ->
                        [ Attributes.rawAttribute <| SingleTouch.onMove (RecordingTouches << RecordTouch)
                        , Attributes.rawAttribute <| SingleTouch.onEnd (RecordingTouches << StopRecordingTouches)
                        ]

                    Released ( timeTime, ySpeed ) ->
                        []
               )
        )
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
            (interpolatePosition model)
        ]
