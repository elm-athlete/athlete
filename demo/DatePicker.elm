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

updateIdentity : a -> (a, Cmd msg)
updateIdentity = flip (!) []

addCmds : List (Cmd msg) -> b -> (b, Cmd msg)
addCmds = flip (!)

type HoldState
  = Held
  | Released

type Inertia
  = Immobile
  | Computing
  | Mobile (Time, Speed)

type alias Model =
  { holdState : HoldState
  , touchesHistory : TouchesHistory
  , position : (WheelRound, Position)
  , selections : List String
  , inertia : Inertia
  , activeItem : String
  }

setHoldState : HoldState -> Model -> Model
setHoldState state model = { model | holdState = state }

setHeld : Model -> Model
setHeld = setHoldState Held

setHoldStateIn : Model -> HoldState -> Model
setHoldStateIn = flip setHoldState

setPosition : (WheelRound, Position) -> Model -> Model
setPosition position model = { model | position = position }

setPositionIn : Model -> (WheelRound, Position) -> Model
setPositionIn = flip setPosition

setTouchesHistory : TouchesHistory -> Model -> Model
setTouchesHistory history model = { model | touchesHistory = history }

setTouchesHistoryIn : Model -> TouchesHistory -> Model
setTouchesHistoryIn = flip setTouchesHistory

initTouchesHistory : Position -> TouchesHistory
initTouchesHistory = TouchesHistory (BoundedList.new 20)

reinitTouchesHistory : Position -> Model -> Model
reinitTouchesHistory = setTouchesHistory << initTouchesHistory

setInertia : Inertia -> Model -> Model
setInertia inertia model = { model | inertia = inertia }

setInertiaIn : Model -> Inertia -> Model
setInertiaIn = flip setInertia

setActiveItem : String -> Model -> Model
setActiveItem activeItem model = { model | activeItem = activeItem }

setActiveItemIn : Model -> String -> Model
setActiveItemIn = flip setActiveItem

type alias TouchesHistory =
  { lastPositions : BoundedList (Time, Position)
  , startPosition : Position
  }

setLastPositions : BoundedList (Time, Position) -> TouchesHistory -> TouchesHistory
setLastPositions list history = { history | lastPositions = list }

setLastPositionsIn : TouchesHistory -> BoundedList (Time, Position) -> TouchesHistory
setLastPositionsIn = flip setLastPositions

addInHistory : Position -> Time -> TouchesHistory -> TouchesHistory
addInHistory position currentTime ({ lastPositions } as history) =
  lastPositions
    |> BoundedList.insert (currentTime, position)
    |> setLastPositionsIn history

type alias Speed = Float
type alias Position = Float
type alias WheelRound = Int

type Msg
  = RecordingTouches RecordingTouchesMsg
  | RecordsAt Position Time
  | UpdateViewAt Time

type RecordingTouchesMsg
  = StartRecordingTouches Coordinates
  | RecordTouch Coordinates
  | StopRecordingTouches Coordinates

main : Program Basics.Never Model Msg
main =
  Builder.program
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }

init : (Model, Cmd Msg)
init =
  { holdState = Released
  , touchesHistory = initTouchesHistory 0
  , position = (0, 0)
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
  , inertia = Immobile
  , activeItem = "19 janvier 2017"
  }
    ! []

subscriptions : Model -> Sub Msg
subscriptions { inertia } =
  case inertia of
    Immobile -> Sub.none
    Computing -> Sub.none
    Mobile speed -> AnimationFrame.times UpdateViewAt

update : Msg -> Model -> (Model, Cmd Msg)
update msg ({ touchesHistory, holdState, inertia } as model) =
  case msg of
    RecordingTouches action -> updateRecordingAction action model
    RecordsAt position currentTime ->
      touchesHistory
        |> addInHistory position currentTime
        |> setTouchesHistoryIn model
        |> (case inertia of
          Computing -> updatePosition >> updateTimeAndSpeed
          _ -> identity)
        |> getActiveItem
        |> updateIdentity
    UpdateViewAt currentTime ->
      updateIdentity
        <| getActiveItem
        <| case inertia of
            Mobile (lastTime, speed) ->
              if insignificantSpeed speed then
                focusOnNearestItem model
              else
                applyAndChangeSpeed lastTime currentTime speed model
            _ -> model

getActiveItem : Model -> Model
getActiveItem ({ position, selections } as model) =
  selections
    |> associateIndexes
    |> List.map (\(index, content) -> (abs (reelAngle (toFloat index) 15.0), content))
    |> selectActiveItem position
    |> Maybe.map (setActiveItemIn model)
    |> Maybe.withDefault model

selectActiveItem : (WheelRound, Position) -> List (Float, String) -> Maybe String
selectActiveItem (wheelRound, position) list =
  case list of
    [] -> Nothing
    (pos, content) :: tl ->
      if pos <= position && position <= pos then
        Just content
      else
        selectActiveItem (wheelRound, position) tl


updateRecordingAction : RecordingTouchesMsg -> Model -> (Model, Cmd Msg)
updateRecordingAction msg =
  case msg of
    StartRecordingTouches { clientY } -> reinitTouchesHistory clientY >> setInertia Immobile >> setHeld >> recordsAt clientY
    RecordTouch { clientY } -> recordsAt clientY
    StopRecordingTouches { clientY } -> stopRecordTouches >> recordsAt clientY

recordsAt : Float -> Model -> (Model, Cmd Msg)
recordsAt position = addCmds [ Task.perform (RecordsAt position) Time.now ]

stopRecordTouches : Model -> Model
stopRecordTouches model =
  model
    |> setHoldState Released
    |> setInertia Computing

updatePosition : Model -> Model
updatePosition model =
  model
    |> interpolatePosition
    |> setPositionIn model

interpolatePosition : Model -> (WheelRound, Position)
interpolatePosition { holdState, inertia, touchesHistory, position, selections } =
  let rotation = toCompleteRotation position
      value = case holdState of
        Held -> interpolatePositionHelper touchesHistory rotation
        Released -> case inertia of
          Computing -> interpolatePositionHelper touchesHistory rotation
          _ -> rotation
      maxValue = (toFloat (List.length selections)) * 37.2 in
  if value <= 0 then
    toPartialRotation 0
  else if value >= maxValue then
    toPartialRotation maxValue
  else
    toPartialRotation value

toCompleteRotation : (WheelRound, Position) -> Position
toCompleteRotation (wheelRound, position) = (toFloat (wheelRound * 360)) + position

toPartialRotation : Position -> (Int, Position)
toPartialRotation position =
  let wheelRound = round position // 360 in
  (wheelRound, position - (toFloat (wheelRound * 360)))

interpolatePositionHelper : TouchesHistory -> Position -> Position
interpolatePositionHelper ({ lastPositions, startPosition } as history) position =
  lastPositions
    |> BoundedList.head
    |> Maybe.map Tuple.second
    |> Maybe.map (flip (-) startPosition)
    |> Maybe.map ((-) position)
    |> Maybe.withDefault position

updateTimeAndSpeed : Model -> Model
updateTimeAndSpeed ({ touchesHistory } as model) =
  touchesHistory.lastPositions
    |> BoundedList.content
    |> computeTimeAndSpeed
    |> Mobile
    |> setInertiaIn model

computeTimeAndSpeed : List (Time, Position) -> (Time, Speed)
computeTimeAndSpeed lastPositions =
  case lastPositions of
    (lastTime, lastPosition) :: queue ->
      case List.Extra.last (relevantPositions lastTime lastPositions) of
        Nothing -> (0, 0)
        Just (firstTime, firstPosition) ->
          if lastTime == firstTime then
            (0, 0)
          else
            ( lastTime
            , 2 * (lastPosition - firstPosition) / (lastTime - firstTime)
            )
    _ -> (0, 0)

relevantPositions : Time -> List (Time, Position) -> List (Time, Position)
relevantPositions lastTime =
    List.filter <| \(time, _) -> (Time.inSeconds (lastTime - time)) < relevantTimeFrame

relevantTimeFrame : Float
relevantTimeFrame = 0.3

applyAndChangeSpeed : Time -> Time -> Speed -> Model -> Model
applyAndChangeSpeed lastTime currentTime speed ({ position, selections } as model) =
  position
    |> toCompleteRotation
    |> flip (-) (speed * (currentTime - lastTime))
    |> clamp 0 ((toFloat <| List.length selections) * 37.2)
    |> toPartialRotation
    |> setPositionIn model
    |> setInertia (Mobile (currentTime, computeNewSpeed speed currentTime lastTime))

computeNewSpeed : Speed -> Time -> Time -> Speed
computeNewSpeed speed currentTime lastTime =
  speed * (0.99 ^ toFloat ((round (currentTime - lastTime)) % 17))

insignificantSpeed : Speed -> Bool
insignificantSpeed speed = abs speed < 0.00005

{-
  Focus.
-}

focusOnNearestItem : Model -> Model
focusOnNearestItem ({ position, selections, touchesHistory } as model) =
  position
    |> adjustPosition touchesHistory
    |> toNearestPosition selections
    |> modifyModelAccordingToNearestPosition model

adjustPosition : TouchesHistory -> (WheelRound, Position) -> (WheelRound, Position)
adjustPosition { lastPositions } =
  let operator = selectIncreaseOrDecrease (BoundedList.content lastPositions) in
  toCompleteRotation >> flip operator 1.0 >> toPartialRotation

selectIncreaseOrDecrease : List (Time, Position) -> (Position -> Position -> Position)
selectIncreaseOrDecrease positions =
  Maybe.withDefault (+) <|
    case List.head positions of
      Nothing -> Nothing
      Just (_, lastPosition) ->
        case secondElement positions of
          Nothing -> Nothing
          Just (_, previousPosition) ->
            if lastPosition > previousPosition then
              Just (-)
            else if lastPosition == previousPosition then
              case thirdElement positions of
                Nothing -> Nothing
                Just (_, thirdPosition) ->
                  if lastPosition > thirdPosition then Just (-) else Nothing
            else
              Nothing

secondElement : List a -> Maybe a
secondElement list = Maybe.andThen List.head (List.tail list)

thirdElement : List a -> Maybe a
thirdElement list = Maybe.andThen List.head (Maybe.andThen List.tail (List.tail list))

toNearestPosition : List String -> (WheelRound, Position) -> (Bool, (WheelRound, Position))
toNearestPosition selections position =
  selections
    |> associateIndexes
    |> List.map (\(index, _) -> reelAngle (toFloat index) 15.0)
    |> List.foldr modifyToNearestPosition (False, position)

modifyToNearestPosition : Position -> (Bool, (WheelRound, Position)) -> (Bool, (WheelRound, Position))
modifyToNearestPosition angle (reset, (wheelRound, position)) =
  if 0 < angle + position && angle + position <= 3 then
    (True, (wheelRound, abs angle))
  else
    (reset, (wheelRound, position))

modifyModelAccordingToNearestPosition : Model -> (Bool, (WheelRound, Position)) -> Model
modifyModelAccordingToNearestPosition model (reset, position) =
  model
    |> setPosition position
    |> (if reset then setInertia Immobile else identity)

{-
  View. Carousel and reel.
-}

view : Model -> Node Msg
view model =
  Builder.div
    [ Attributes.style [ Style.box [ Box.padding [ Padding.left (px 200), Padding.top (px 200) ] ] ]
    , Attributes.rawAttribute (SingleTouch.onStart (RecordingTouches << StartRecordingTouches))
    , Attributes.rawAttribute (SingleTouch.onMove (RecordingTouches << RecordTouch))
    , Attributes.rawAttribute (SingleTouch.onEnd (RecordingTouches << StopRecordingTouches))
    ]
    [ carousel model.selections 50 (interpolatePosition model) ]

carousel : List String -> Int -> (Int, Position) -> Node msg
carousel list height (( _, rotation ) as position) =
  let list2 = (selectVisibleItems (toCompleteRotation position) (associateIndexes list)) in
  Builder.div
    [ Attributes.style
      [ Style.blockProperties [ Block.width (px 300) , Block.height (px height) ]
      , Style.box [ Box.transform [ Transform.preserve3d, Transform.perspective (px 1000) ] ]
      ]
    ]
    [ Builder.div
      [ Attributes.style
        [ Style.box
          [ Box.transform
            [ Transform.rotateX (deg rotation)
            , Transform.preserve3d
            , Transform.origin (Constants.zero, px ((toFloat height) / 2 |> round), Constants.zero)
            ]
          ]
        ]
      ]
      (List.map (reelFrame rotation (List.length list2) height) list2)
    ]

associateIndexes : List a -> List (Int, a)
associateIndexes list =
  List.indexedMap (\index content -> (index % 15, content)) list

selectVisibleItems : Position -> List (Int, String) -> List (Int, String)
selectVisibleItems completeRotation =
  List.drop (round completeRotation // 80)
    >> List.take (chooseNumberOfVisibleItems completeRotation)
    >> fillAbsentAndRemoveUselessEntries

chooseNumberOfVisibleItems : Position -> Int
chooseNumberOfVisibleItems completeRotation =
  if completeRotation < 240 then 12 else 15

fillAbsentAndRemoveUselessEntries : List (Int, String) -> List (Int, String)
fillAbsentAndRemoveUselessEntries list =
  List.range 0 14
    |> List.map (fillAbsentEntries list)
    |> List.foldl removeUselessEntries (True, [])
    |> Tuple.second

removeUselessEntries : (Int, String) -> (Bool, List (Int, String)) -> (Bool, List (Int, String))
removeUselessEntries (index, content ) ( keeping, accumulator ) =
  if (content /= "" && keeping) || index < 3 then
      (True, (index, content) :: accumulator)
  else
      (False, (index, "") :: accumulator)

fillAbsentEntries : List (Int, String) -> Int -> (Int, String)
fillAbsentEntries list element =
  list
    |> List.Extra.find (Tuple.first >> (==) element)
    |> Maybe.withDefault (element, "")

reelFrame : Position -> Int -> Int -> (Int, String) -> Node msg
reelFrame rotation length height ( index, content ) =
  let l = toFloat length
      h = toFloat height
      i = toFloat index in
  rotatedDiv (reelAngle i l) content rotation height (px (Basics.round (h / (2 * Basics.tan (Basics.pi / l)))))

rotatedDiv : Float -> String -> Position -> Int -> Elegant.SizeUnit -> Node msg
rotatedDiv angle text rotation height translationZ =
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
          , Typography.color (if moreOrLess 10.0 (abs angle) (abs rotation) then Color.black else Color.grayscale 0.3)
          ]
      , Box.position (Position.absolute [])
        ]
      ]
    ]
    [ Builder.text text ]

reelAngle : Float -> Float -> Float
reelAngle i l = -i * 360 / 15

moreOrLess : Float -> Float -> Float -> Bool
moreOrLess value base comparison = comparison - value < base && base < comparison + value
