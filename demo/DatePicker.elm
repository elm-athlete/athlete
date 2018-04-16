module DatePicker exposing (..)

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
import Color
import Date exposing (Date)
import Time exposing (Time)
import List.Extra as List


updateIdentity : a -> ( a, Cmd msg )
updateIdentity =
    flip (!) []


addCmds : List (Cmd msg) -> b -> ( b, Cmd msg )
addCmds =
    flip (!)


firstDate : Date
firstDate =
    Date.fromTime 0


type HoldState
    = Held
    | Released


type Inertia
    = Immobile
    | Mobilizing
    | Mobile ( Time, Speed )


type alias TouchesHistory =
    { lastPositions : BoundedList ( Time, Rotation )
    , startPosition : Rotation
    }


type alias Speed =
    Float


type alias Rotation =
    Float


type alias WheelTurns =
    Int


type alias Model =
    DatePicker


type alias MouseX =
    Float

type Msg
    = RecordingTouches RecordingTouchesMsg
    | RecordsAt MouseX Time
    | UpdateViewAt Time


type RecordingTouchesMsg
    = StartRecordingTouches Coordinates
    | RecordTouch Coordinates
    | StopRecordingTouches Coordinates


type DatePicker
    = DatePicker
        { holdState : HoldState
        , touchesHistory : TouchesHistory
        , rotation : ( WheelTurns, Rotation )
        , selections : List ( Int, Date, Bool )
        , inertia : Inertia
        , activeItem : Date
        }


newDatePicker : { start : Time, end : Time, unselectableDates : List Date } -> DatePicker
newDatePicker { start, end, unselectableDates } =
    let
        dateRange =
            List.map (unselectWrongDates unselectableDates) (createDateRange start end)
    in
        DatePicker
            { holdState = Released
            , touchesHistory = initTouchesHistory 0
            , rotation = ( 0, 0 )
            , selections = associateIndexes dateRange
            , inertia = Immobile
            , activeItem = Date.fromTime start
            }


createDateRange : Time -> Time -> List Time
createDateRange start end =
    createDateRangeHelper start end []



-- 86_400_000 ms in a day.
numberOfMsInADay : number
numberOfMsInADay =
  86400000

createDateRangeHelper : Time -> Time -> List Time -> List Time
createDateRangeHelper start end acc =
    if start < end then
        createDateRangeHelper (start + numberOfMsInADay) end (start :: acc)
    else
        List.reverse (List.unique acc)


unselectWrongDates : List Date -> Time -> ( Date, Bool )
unselectWrongDates unselectableDates time =
    let
        date =
            Date.fromTime time
    in
        if List.member date unselectableDates then
            ( date, False )
        else
            ( date, True )


associateIndexes : List ( a, b ) -> List ( Int, a, b )
associateIndexes =
    List.indexedMap (\index ( a, b ) -> ( index % (round (360 / angleBetweenTwoItems)) , a, b ))


setHoldState : HoldState -> DatePicker -> DatePicker
setHoldState state (DatePicker datePicker) =
    DatePicker { datePicker | holdState = state }


setHeld : DatePicker -> DatePicker
setHeld =
    setHoldState Held


setHoldStateIn : DatePicker -> HoldState -> DatePicker
setHoldStateIn =
    flip setHoldState


setRotation : ( WheelTurns, Rotation ) -> DatePicker -> DatePicker
setRotation rotation (DatePicker datePicker) =
    DatePicker { datePicker | rotation = rotation }


setRotationIn : DatePicker -> ( WheelTurns, Rotation ) -> DatePicker
setRotationIn =
    flip setRotation


setTouchesHistory : TouchesHistory -> DatePicker -> DatePicker
setTouchesHistory history (DatePicker datePicker) =
    DatePicker { datePicker | touchesHistory = history }


setTouchesHistoryIn : DatePicker -> TouchesHistory -> DatePicker
setTouchesHistoryIn =
    flip setTouchesHistory


initTouchesHistory : Rotation -> TouchesHistory
initTouchesHistory =
    TouchesHistory (BoundedList.new 20)


reinitTouchesHistory : Rotation -> DatePicker -> DatePicker
reinitTouchesHistory =
    setTouchesHistory << initTouchesHistory


setInertia : Inertia -> DatePicker -> DatePicker
setInertia inertia (DatePicker datePicker) =
    DatePicker { datePicker | inertia = inertia }


setInertiaIn : DatePicker -> Inertia -> DatePicker
setInertiaIn =
    flip setInertia


setActiveItem : Date -> DatePicker -> DatePicker
setActiveItem activeItem (DatePicker datePicker) =
    DatePicker { datePicker | activeItem = activeItem }


setActiveItemIn : DatePicker -> Date -> DatePicker
setActiveItemIn =
    flip setActiveItem




setLastPositions : BoundedList ( Time, Rotation ) -> TouchesHistory -> TouchesHistory
setLastPositions list history =
    { history | lastPositions = list }


setLastPositionsIn : TouchesHistory -> BoundedList ( Time, Rotation ) -> TouchesHistory
setLastPositionsIn =
    flip setLastPositions


addInHistory : Rotation -> Time -> TouchesHistory -> TouchesHistory
addInHistory position currentTime ({ lastPositions } as history) =
    lastPositions
        |> BoundedList.insert ( currentTime, position )
        |> setLastPositionsIn history



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
    (newDatePicker
        { start = 1523451140067
        , end = 1526537540067
        , unselectableDates = []
        }
    )
        ! []


subscriptions : Model -> Sub Msg
subscriptions (DatePicker { inertia }) =
    case inertia of
        Immobile ->
            Sub.none

        Mobilizing ->
            Sub.none

        Mobile speed ->
            AnimationFrame.times UpdateViewAt


update : Msg -> Model -> ( Model, Cmd Msg )
update msg ((DatePicker { touchesHistory, holdState, inertia }) as model) =
    case msg of
        RecordingTouches action ->
            updateRecordingAction action model

        RecordsAt position currentTime ->
            touchesHistory
                |> addInHistory position currentTime
                |> setTouchesHistoryIn model
                |> (case inertia of
                        Mobilizing ->
                            updatePosition >> updateTimeAndSpeed

                        _ ->
                            identity
                   )
                |> getActiveItem
                |> updateIdentity

        UpdateViewAt currentTime ->
            updateIdentity <|
                getActiveItem <|
                    case inertia of
                        Mobile ( lastTime, speed ) ->
                            if insignificantSpeed speed then
                                focusOnNearestItem model
                            else
                                applyAndChangeSpeed lastTime currentTime speed model

                        _ ->
                            model




getActiveItem : DatePicker -> DatePicker
getActiveItem ((DatePicker { rotation, selections }) as model) =
    selections
        |> selectVisibleItems (toCompleteRotation rotation)
        |> List.map (\( index, content, _ ) -> ( abs (reelAngle (toFloat index) ), content ))
        |> selectActiveItem rotation
        |> Maybe.map (setActiveItemIn model)
        |> Maybe.withDefault model


selectActiveItem : ( WheelTurns, Rotation ) -> List ( Float, Date ) -> Maybe Date
selectActiveItem ( wheelTurns, position ) list =
    case list of
        [] ->
            Nothing

        ( pos, content ) :: tl ->
            if pos <= position && position <= pos then
                Just content
            else
                selectActiveItem ( wheelTurns, position ) tl


updateRecordingAction : RecordingTouchesMsg -> DatePicker -> ( DatePicker, Cmd Msg )
updateRecordingAction msg =
    case msg of
        StartRecordingTouches { clientY } ->
            reinitTouchesHistory clientY >> setInertia Immobile >> setHeld >> recordsAt clientY

        RecordTouch { clientY } ->
            recordsAt clientY

        StopRecordingTouches { clientY } ->
            stopRecordTouches >> recordsAt clientY


recordsAt : Float -> DatePicker -> ( DatePicker, Cmd Msg )
recordsAt position =
    addCmds [ Task.perform (RecordsAt position) Time.now ]


stopRecordTouches : DatePicker -> DatePicker
stopRecordTouches model =
    model
        |> setHoldState Released
        |> setInertia Mobilizing


updatePosition : DatePicker -> DatePicker
updatePosition model =
    model
        |> interpolatePosition
        |> setRotationIn model

angleBetweenTwoItems : number
angleBetweenTwoItems =
  24
maxRotation : List a -> Float
maxRotation selections =
   (toFloat (List.length selections - 1)) * angleBetweenTwoItems


interpolatePosition : DatePicker -> ( WheelTurns, Rotation )
interpolatePosition (DatePicker { holdState, inertia, touchesHistory, rotation, selections }) =
    let
        completeRotation =
            toCompleteRotation rotation

        value =
            case holdState of
                Held ->
                    interpolatePositionHelper touchesHistory completeRotation

                Released ->
                    case inertia of
                        Mobilizing ->
                            interpolatePositionHelper touchesHistory completeRotation

                        _ ->
                            completeRotation

    in
        toPartialRotation (clamp 0 (maxRotation selections) value)

toCompleteRotation : ( WheelTurns, Rotation ) -> Rotation
toCompleteRotation ( wheelTurns, position ) =
    (toFloat (wheelTurns * 360)) + position


toPartialRotation : Rotation -> ( Int, Rotation )
toPartialRotation position =
    let
        wheelTurns =
            round position // 360
    in
        ( wheelTurns, position - (toFloat (wheelTurns * 360)) )


interpolatePositionHelper : TouchesHistory -> Rotation -> Rotation
interpolatePositionHelper ({ lastPositions, startPosition } as history) position =
    lastPositions
        |> BoundedList.head
        |> Maybe.map Tuple.second
        |> Maybe.map (flip (-) startPosition)
        |> Maybe.map ((-) position)
        |> Maybe.withDefault position


updateTimeAndSpeed : Model -> Model
updateTimeAndSpeed ((DatePicker { touchesHistory }) as model) =
    touchesHistory.lastPositions
        |> BoundedList.content
        |> computeTimeAndSpeed
        |> Mobile
        |> setInertiaIn model


computeTimeAndSpeed : List ( Time, Rotation ) -> ( Time, Speed )
computeTimeAndSpeed lastPositions =
    case lastPositions of
        ( lastTime, lastPosition ) :: queue ->
            case List.Extra.last (relevantPositions lastTime lastPositions) of
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


relevantPositions : Time -> List ( Time, Rotation ) -> List ( Time, Rotation )
relevantPositions lastTime =
    List.filter <| \( time, _ ) -> (Time.inSeconds (lastTime - time)) < relevantTimeFrame


relevantTimeFrame : Float
relevantTimeFrame =
    0.3


applyAndChangeSpeed : Time -> Time -> Speed -> Model -> Model
applyAndChangeSpeed lastTime currentTime speed ((DatePicker { rotation, selections }) as model) =
    ((toCompleteRotation rotation) - speed * (currentTime - lastTime))
        |> clamp 0 (maxRotation selections)
        |> toPartialRotation
        |> setRotationIn model
        |> setInertia (Mobile ( currentTime, computeNewSpeed speed currentTime lastTime ))


computeNewSpeed : Speed -> Time -> Time -> Speed
computeNewSpeed speed currentTime lastTime =
    speed * (0.99 ^ toFloat ((round (currentTime - lastTime)) % 17))


insignificantSpeed : Speed -> Bool
insignificantSpeed speed =
    abs speed < 0.04



{-
   Focus.
-}


focusOnNearestItem : Model -> Model
focusOnNearestItem ((DatePicker { rotation, selections, touchesHistory }) as model) =
    rotation
        |> adjustPosition touchesHistory
        |> toNearestPosition selections
        |> modifyModelAccordingToNearestPosition model


adjustPosition : TouchesHistory -> ( WheelTurns, Rotation ) -> ( WheelTurns, Rotation )
adjustPosition { lastPositions } =
    let
        operator =
            selectIncreaseOrDecrease (BoundedList.content lastPositions)
    in
        toCompleteRotation >> flip operator 1.0 >> toPartialRotation


selectIncreaseOrDecrease : List ( Time, Rotation ) -> (Rotation -> Rotation -> Rotation)
selectIncreaseOrDecrease positions =
    Maybe.withDefault (+) <|
        case List.head positions of
            Nothing ->
                Nothing

            Just ( _, lastPosition ) ->
                case secondElement positions of
                    Nothing ->
                        Nothing

                    Just ( _, previousPosition ) ->
                        if lastPosition > previousPosition then
                            Just (-)
                        else if lastPosition == previousPosition then
                            case thirdElement positions of
                                Nothing ->
                                    Nothing

                                Just ( _, thirdPosition ) ->
                                    if lastPosition > thirdPosition then
                                        Just (-)
                                    else
                                        Nothing
                        else
                            Nothing


secondElement : List a -> Maybe a
secondElement list =
    Maybe.andThen List.head (List.tail list)


thirdElement : List a -> Maybe a
thirdElement list =
    Maybe.andThen List.head (Maybe.andThen List.tail (List.tail list))


toNearestPosition : List ( Int, Date, Bool ) -> ( WheelTurns, Rotation ) -> ( Bool, ( WheelTurns, Rotation ) )
toNearestPosition selections position =
    selections
        |> List.map (\( index, _, displayed ) -> ( reelAngle (toFloat index), displayed ))
        |> List.foldr modifyToNearestPosition ( False, position )


modifyToNearestPosition : ( Rotation, Bool ) -> ( Bool, ( WheelTurns, Rotation ) ) -> ( Bool, ( WheelTurns, Rotation ) )
modifyToNearestPosition ( angle, displayed ) ( reset, ( wheelTurns, position ) ) =
    if displayed then
        if 0 <= angle + position && angle + position <= 1 then
            ( True, ( wheelTurns, abs angle ) )
        else
            ( reset, ( wheelTurns, position ) )
    else
        ( reset, ( wheelTurns, position ) )


modifyModelAccordingToNearestPosition : Model -> ( Bool, ( WheelTurns, Rotation ) ) -> Model
modifyModelAccordingToNearestPosition model ( reset, position ) =
    model
        |> setRotation position
        |> (if reset then
                setInertia Immobile
            else
                identity
           )



{-
   View. Carousel and reel.
-}


view : Model -> Node Msg
view ((DatePicker { selections }) as model) =
    Builder.div
        [ Attributes.style [ Style.box [ Box.padding [ Padding.left (px 200), Padding.top (px 200) ] ] ]
        , Attributes.rawAttribute (SingleTouch.onStart (RecordingTouches << StartRecordingTouches))
        , Attributes.rawAttribute (SingleTouch.onMove (RecordingTouches << RecordTouch))
        , Attributes.rawAttribute (SingleTouch.onEnd (RecordingTouches << StopRecordingTouches))
        ]
        [ carousel selections 50 (interpolatePosition model) ]


carousel : List ( Int, Date, Bool ) -> Int -> ( WheelTurns, Rotation ) -> Node msg
carousel list radius (( _, rotation ) as position) =
    let
        visibleItems =
            selectVisibleItems (toCompleteRotation position) list
    in
        Builder.div
            [ Attributes.style
                [ Style.blockProperties [ Block.width (px 300), Block.height (px radius) ]
                , Style.box [ Box.transform [ Transform.preserve3d, Transform.perspective (px 1000) ] ]
                ]
            ]
            [ Builder.div
                [ Attributes.style
                    [ Style.box
                        [ Box.transform
                            [ Transform.rotateX (deg rotation)
                            , Transform.preserve3d
                            , Transform.origin ( Constants.zero, px ((toFloat radius) / 2 |> round), Constants.zero )
                            ]
                        ]
                    ]
                ]
                (List.map (reelFrame rotation (List.length visibleItems) radius) visibleItems)
            ]


selectVisibleItems : Rotation -> List ( Int, Date, Bool ) -> List ( Int, Date, Bool )
selectVisibleItems completeRotation items =
    items
        |> List.drop (round completeRotation // 35)
        -- Have to find the right formula.
        |> List.take (chooseNumberOfVisibleItems completeRotation)
        |> fillAbsent


chooseNumberOfVisibleItems : Rotation -> Int
chooseNumberOfVisibleItems completeRotation =
    if completeRotation < 240 then
        12
    else
        round (360 / angleBetweenTwoItems)


fillAbsent : List ( Int, Date, Bool ) -> List ( Int, Date, Bool )
fillAbsent list =
    List.map (fillAbsentEntries list) (List.range 0 14)


fillAbsentEntries : List ( Int, Date, Bool ) -> Int -> ( Int, Date, Bool )
fillAbsentEntries list element =
    list
        |> List.Extra.find (\( elem, _, _ ) -> element == elem)
        |> Maybe.withDefault ( element, firstDate, True )


reelFrame : Rotation -> Int -> Int -> ( Int, Date, Bool ) -> Node msg
reelFrame rotation length height ( index, content, displayed ) =
    let
        l =
            toFloat length

        h =
            toFloat height

        i =
            toFloat index
    in
        rotatedDiv (reelAngle i) content displayed rotation height (px (Basics.round (h / (2 * Basics.tan (Basics.pi / l)))))


rotatedDiv : Float -> Date -> Bool -> Rotation -> Int -> Elegant.SizeUnit -> Node msg
rotatedDiv angle date displayed rotation height translationZ =
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
                    , Typography.color <|
                        if displayed then
                            if moreOrLess 10.0 (abs angle) (abs rotation) then
                                Color.black
                            else
                                Color.grayscale 0.3
                        else
                            Color.grayscale 0.1
                    ]
                , Box.position (Position.absolute [])
                ]
            ]
        ]
        [ Builder.text <|
            String.join " " <|
                if date == firstDate then
                    []
                else
                    [ toString (Date.day date)
                    , toString (Date.month date)
                    , toString (Date.year date)
                    ]
        ]


reelAngle : Float -> Float
reelAngle i =
    -i * angleBetweenTwoItems


moreOrLess : Float -> Float -> Float -> Bool
moreOrLess value base comparison =
    comparison - value < base && base < comparison + value
