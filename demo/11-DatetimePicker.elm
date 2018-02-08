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


setHeld : { c | holdState : b } -> { c | holdState : HoldState }
setHeld =
    setHoldState Held


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


type alias Speed =
    Float


type alias Position =
    Float


type Msg
    = RecordingTouches RecordingTouchesMsg
    | RecordsAt Position Time
    | UpdateViewAt Time


type RecordingTouchesMsg
    = StartRecordingTouches Coordinates
    | RecordTouch Coordinates
    | StopRecordingTouches Coordinates


type HoldState
    = Held
    | Released (Maybe ( Time, Speed ))


type alias TouchesHistory =
    { lastPositions : BoundedList ( Time, Position )
    , startPosition : Position
    }


type alias Model =
    { holdState : HoldState
    , touchesHistory : TouchesHistory
    , position : ( Int, Position )
    , selections : List String
    }


initTouchesHistory : Float -> TouchesHistory
initTouchesHistory =
    TouchesHistory (BoundedList.new 20)


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
    { holdState = Released Nothing
    , touchesHistory = initTouchesHistory 0
    , position = ( 0, 0 )
    , selections =
        [ "19 janvier 2017"
        , "20 janvier 2017"
        , "21 janvier 2017"
        , "22 janvier 2017"
        , "23 janvier 2017"
        , "24 janvier 2017"
        , "25 janvier 2017"
        , "26 janvier 2017"
        , "27 janvier 2017"
        , "28 janvier 2017"
        , "29 janvier 2017"
        , "30 janvier 2017"
        , "31 janvier 2017"
        , "20 février 2017"
        , "21 février 2017"
        , "22 février 2017"
        , "23 février 2017"
        , "24 février 2017"
        , "25 février 2017"
        , "26 février 2017"
        , "27 février 2017"
        , "28 février 2017"
        , "29 février 2017"
        , "30 février 2017"
        , "31 février 2017"
        ]
    }
        ! []


insignificantSpeed : Speed -> Bool
insignificantSpeed speed =
    abs speed < 0.000005


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch <|
        case model.holdState of
            Held ->
                []

            Released (Just ( _, speed )) ->
                if insignificantSpeed speed then
                    []
                else
                    [ AnimationFrame.times UpdateViewAt ]

            Released Nothing ->
                []


updatePosition : Model -> Model
updatePosition model =
    model
        |> interpolatePosition
        |> setPositionIn model


toCompleteRotation : ( Int, Position ) -> Position
toCompleteRotation ( wheelRound, position ) =
    (wheelRound * 360 |> toFloat) + position


toPartialRotation : Position -> ( Int, Position )
toPartialRotation position =
    let
        wheelRound =
            round position // 360
    in
        ( wheelRound, position - (wheelRound * 360 |> toFloat) )


interpolatePosition : Model -> ( Int, Position )
interpolatePosition { holdState, touchesHistory, position, selections } =
    let
        rotation =
            toCompleteRotation position

        value =
            case holdState of
                Held ->
                    interpolatePositionHelper touchesHistory rotation

                Released Nothing ->
                    interpolatePositionHelper touchesHistory rotation

                Released _ ->
                    rotation

        maxValue =
            (toFloat <| List.length selections) * 37.2
    in
        if value <= 0 then
            toPartialRotation 0
        else if value >= maxValue then
            toPartialRotation maxValue
        else
            toPartialRotation value


interpolatePositionHelper : TouchesHistory -> Float -> Float
interpolatePositionHelper history position =
    history.lastPositions
        |> BoundedList.head
        |> Maybe.map Tuple.second
        |> Maybe.map (flip (-) history.startPosition)
        |> Maybe.map ((-) position)
        |> Maybe.withDefault position


updateTimeAndSpeed : Model -> Model
updateTimeAndSpeed ({ touchesHistory } as model) =
    touchesHistory.lastPositions
        |> BoundedList.content
        |> computeTimeAndSpeed
        |> Just
        |> Released
        |> setHoldStateIn model


relevantTimeFrame : Float
relevantTimeFrame =
    0.2


relevantPositions : Time -> List ( Time, Position ) -> List ( Time, Position )
relevantPositions lastTime =
    List.filter (\( time, _ ) -> (lastTime - time |> Time.inSeconds) < relevantTimeFrame)


computeTimeAndSpeed : List ( Time, Position ) -> ( Time, Speed )
computeTimeAndSpeed lastPositions =
    case lastPositions of
        ( lastTime, lastPosition ) :: queue ->
            case List.Extra.last (lastPositions |> relevantPositions lastTime) of
                Nothing ->
                    ( 0, 0 )

                Just ( firstTime, firstPosition ) ->
                    if lastTime == firstTime then
                        ( 0, 0 )
                    else
                        ( lastTime
                        , 2 * (lastPosition - firstPosition) / (lastTime - firstTime)
                        )

        _ ->
            ( 0, 0 )


computeNewSpeed : Speed -> Time -> Time -> Speed
computeNewSpeed speed currentTime lastTime =
    speed * (0.99 ^ ((round (currentTime - lastTime)) % 17 |> toFloat))


applyAndChangeSpeed : Time -> Time -> Speed -> Model -> Model
applyAndChangeSpeed lastTime currentTime speed ({ position, selections } as model) =
    position
        |> toCompleteRotation
        |> flip (-) (speed * (currentTime - lastTime))
        |> clamp 0 ((toFloat <| List.length selections) * 37.2)
        |> toPartialRotation
        |> setPositionIn model
        |> setHoldState
            (Released <| Just ( currentTime, computeNewSpeed speed currentTime lastTime ))


addInHistory : Float -> Time -> TouchesHistory -> TouchesHistory
addInHistory position currentTime history =
    history.lastPositions
        |> BoundedList.insert ( currentTime, position )
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
                |> (case holdState of
                        Held ->
                            identity

                        Released _ ->
                            updatePosition
                                >> updateTimeAndSpeed
                   )
                |> updateIdentity

        UpdateViewAt currentTime ->
            updateIdentity <|
                case holdState of
                    Held ->
                        model

                    Released (Just ( lastTime, speed )) ->
                        applyAndChangeSpeed lastTime currentTime speed model

                    Released _ ->
                        model


updateRecordingAction : RecordingTouchesMsg -> Model -> ( Model, Cmd Msg )
updateRecordingAction msg =
    case msg of
        StartRecordingTouches { clientY } ->
            reinitTouchesHistory clientY >> setHeld >> recordsAt clientY

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
            Released Nothing
                |> setHoldStateIn model

        Released _ ->
            model


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


reelAngle : Float -> Float -> Float
reelAngle i l =
    -i * 360 / 15


reelFrame : Int -> Int -> ( Int, String ) -> Node msg
reelFrame length height ( index, content ) =
    let
        l =
            length |> toFloat

        h =
            height |> toFloat

        i =
            index |> toFloat
    in
        rotatedDiv
            (reelAngle i l)
            content
            height
            (px
                (Basics.round
                    (h / (2 * Basics.tan (Basics.pi / l)))
                )
            )


selectVisibleItems : Position -> List ( Int, String ) -> List ( Int, String )
selectVisibleItems completeRotation =
    List.drop (round completeRotation // 80)
        >> List.take (chooseNumberOfVisibleItems completeRotation)
        >> fillAbsentAndRemoveUselessEntries


chooseNumberOfVisibleItems : Position -> Int
chooseNumberOfVisibleItems completeRotation =
    if completeRotation < 240 then
        12
    else
        15


fillAbsentAndRemoveUselessEntries : List ( Int, String ) -> List ( Int, String )
fillAbsentAndRemoveUselessEntries list =
    List.range 0 14
        |> List.map (fillAbsentEntries list)
        |> List.foldl removeUselessEntries ( True, [] )
        |> Tuple.second


removeUselessEntries : ( Int, String ) -> ( Bool, List ( Int, String ) ) -> ( Bool, List ( Int, String ) )
removeUselessEntries ( index, content ) ( keeping, accumulator ) =
    if (content /= "" && keeping) || index < 3 then
        ( True, ( index, content ) :: accumulator )
    else
        ( False, ( index, "" ) :: accumulator )


fillAbsentEntries : List ( Int, String ) -> Int -> ( Int, String )
fillAbsentEntries list element =
    list
        |> List.Extra.find (Tuple.first >> (==) element)
        |> Maybe.withDefault ( element, "" )


carousel : List String -> Int -> ( Int, Position ) -> Node msg
carousel list height (( wheelRound, rotation ) as position) =
    let
        list2 =
            list
                |> associateIndexes
                |> selectVisibleItems (toCompleteRotation position)
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
                            [ Transform.rotateX (deg rotation)
                            , Transform.preserve3d
                            , Transform.origin
                                ( Constants.zero
                                , px ((toFloat height) / 2 |> round)
                                , Constants.zero
                                )
                            ]
                        ]
                    ]
                ]
                (List.map (reelFrame (List.length list2) height) list2)
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
         , Attributes.rawAttribute <| SingleTouch.onMove (RecordingTouches << RecordTouch)
         , Attributes.rawAttribute <| SingleTouch.onEnd (RecordingTouches << StopRecordingTouches)
         ]
        )
        [ carousel
            model.selections
            50
            (interpolatePosition model)
        ]


associateIndexes : List a -> List ( Int, a )
associateIndexes list =
    list
        |> List.indexedMap (\index content -> ( index % 15, content ))
