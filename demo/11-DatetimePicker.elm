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


setLastPositions : a -> { c | lastPositions : b } -> { c | lastPositions : a }
setLastPositions b a =
    { a | lastPositions = b }


setLastPositionsIn : { c | lastPositions : b } -> a -> { c | lastPositions : a }
setLastPositionsIn =
    flip setLastPositions


type Msg
    = UpdateTouch TouchAction
    | HappensAt Float Time
    | NewTime Time


type TouchAction
    = TouchStart Coordinates
    | TouchAt Coordinates
    | TouchEnd TouchHistory Coordinates


type alias Model =
    { holdState : HoldState
    , position : Float
    }


type alias Speed =
    Float


type HoldState
    = Held TouchHistory
    | Released ( Time, Speed )


type alias TouchHistory =
    { startPosition : Float
    , lastPositions : BoundedList ( Float, Time )
    }


getLastPosition : TouchHistory -> Maybe ( Float, Time )
getLastPosition history =
    history.lastPositions
        |> BoundedList.head


initTouchHistory : Float -> TouchHistory
initTouchHistory position =
    TouchHistory position (BoundedList.new 5)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch <|
        case model.holdState of
            Held touch ->
                []

            Released ( _, speed ) ->
                if (speed < -0.05 || speed > 0.05) then
                    [ AnimationFrame.times NewTime ]
                else
                    []


interpolateYPosition : Model -> Float
interpolateYPosition { holdState, position } =
    case holdState of
        Held history ->
            history
                |> getLastPosition
                |> Maybe.map Tuple.first
                |> Maybe.map (flip (-) history.startPosition)
                |> Maybe.map ((-) position)
                |> Maybe.withDefault position

        Released _ ->
            position


getTimeAndSpeed : List ( Float, Float ) -> ( Float, Float )
getTimeAndSpeed lastPositions =
    case lastPositions of
        [] ->
            ( 0, 0 )

        [ e ] ->
            ( 0, 0 )

        ( lastYPosition, lastTime ) :: l ->
            case List.Extra.last l of
                Just ( oldYPosition, oldTime ) ->
                    ( lastTime
                    , 2
                        * (lastYPosition - oldYPosition)
                        / (lastTime - oldTime)
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


addInHistory : Float -> Time -> TouchHistory -> TouchHistory
addInHistory position currentTime history =
    history
        |> .lastPositions
        |> BoundedList.insert ( position, currentTime )
        |> setLastPositionsIn history


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateTouch action ->
            updateTouchAction action model

        HappensAt position currentTime ->
            ( case model.holdState of
                Held history ->
                    history
                        |> addInHistory position currentTime
                        |> Held
                        |> setHoldStateIn model

                Released ( lastTime, ySpeed ) ->
                    applyAndChangeSpeed lastTime currentTime ySpeed model
            , Cmd.none
            )

        NewTime time ->
            ( case model.holdState of
                Held touch ->
                    model

                Released ( lastTime, ySpeed ) ->
                    applyAndChangeSpeed lastTime time ySpeed model
            , Cmd.none
            )


updateTouchAction : TouchAction -> Model -> ( Model, Cmd Msg )
updateTouchAction msg =
    case msg of
        TouchStart { clientY } ->
            setHoldState
                (Held (initTouchHistory clientY))
                >> happensAt clientY

        TouchAt { clientY } ->
            happensAt clientY

        TouchEnd touch { clientY } ->
            touchEnd touch clientY
                >> happensAt clientY


happensAt : Float -> Model -> ( Model, Cmd Msg )
happensAt position =
    addCmds [ Task.perform (HappensAt position) Time.now ]


touchEnd : TouchHistory -> Float -> Model -> Model
touchEnd lastTouch y model =
    lastTouch.lastPositions
        |> BoundedList.content
        |> getTimeAndSpeed
        |> Released
        |> setHoldStateIn model
        |> setPosition (interpolateYPosition model)


main : Program Basics.Never Model Msg
main =
    Builder.program
        { init = Model (Released ( 0, 0 )) 0 ! []
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



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
         , Attributes.rawAttribute <| SingleTouch.onStart (UpdateTouch << TouchStart)
         ]
            ++ (case model.holdState of
                    Held touch ->
                        [ Attributes.rawAttribute <| SingleTouch.onMove (UpdateTouch << TouchAt)
                        , Attributes.rawAttribute <| SingleTouch.onEnd (UpdateTouch << TouchEnd touch)
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
            (interpolateYPosition model)
        ]
