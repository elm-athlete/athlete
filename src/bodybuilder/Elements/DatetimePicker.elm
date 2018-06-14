module BodyBuilder.Elements.DateTimePicker
    exposing
        ( Model
        , Msg(..)
        , init
        , subscriptions
        , update
        , view
        )

{-| Mobile like date time picker

@docs Model
@docs Msg
@docs init
@docs subscriptions
@docs update
@docs view

-}

import AnimationFrame
import BodyBuilder as Builder exposing (NodeWithStyle)
import BodyBuilder.Attributes as Attributes
import BodyBuilder.Elements.WheelPicker as Picker
import BodyBuilder.Style as Style
import Date.RataDie as Date exposing (RataDie)
import DateFormat
import Elegant exposing (px)
import Elegant.Block as Block
import Elegant.Box as Box
import Elegant.Flex as Flex
import Elegant.Margin as Margin
import Elegant.Typography as Typography
import Function
import Time exposing (Month(..), Posix, Zone)
import Touch



---- CONSTANTS ----


toMs : { day : Int, hour : Int, minute : Int }
toMs =
    { day = 86400000
    , hour = 3600000
    , minute = 60000
    }


rataAtPosixZero : Int
rataAtPosixZero =
    719163



---- INIT ----


initDayPicker : ( RataDie, RataDie ) -> Picker.WheelPicker
initDayPicker ( dayLimitStart, dayLimitStop ) =
    let
        format =
            Time.millisToPosix
                >> formatTime
                    [ DateFormat.dayOfMonthNumber
                    , DateFormat.text " "
                    , DateFormat.monthNameFirstThree
                    , DateFormat.text " "
                    , DateFormat.yearNumber
                    ]
    in
    dateRange (rataDieToMillis dayLimitStart) (rataDieToMillis dayLimitStop) toMs.day
        |> List.map format
        |> Picker.defaultWheelPicker 230


initHourPicker : Picker.WheelPicker
initHourPicker =
    let
        format =
            Time.millisToPosix >> formatTime [ DateFormat.hourMilitaryFixed ]
    in
    dateRange 3600000 82800000 toMs.hour
        |> List.map format
        |> Picker.defaultWheelPicker 60


initMinutePicker : Picker.WheelPicker
initMinutePicker =
    let
        format =
            Time.millisToPosix >> formatTime [ DateFormat.minuteFixed ]
    in
    dateRange 0 3540000 toMs.minute
        |> List.map format
        |> Picker.defaultWheelPicker 60


setDate : Posix -> Model -> Model
setDate date model =
    { model | date = date }


{-| The init function of the DateTime Picker
-}
init : ( RataDie, RataDie ) -> Model
init dayLimits =
    let
        initialModel =
            { date = Time.millisToPosix 0
            , dayLimits = dayLimits
            , dayPicker = initDayPicker dayLimits
            , hourPicker = initHourPicker
            , minutePicker = initMinutePicker
            }
    in
    initialModel
        |> setDate (dateFromPickers initialModel)


{-| Model of the DateTime Picker
-}
type alias Model =
    { date : Posix
    , dayLimits : ( RataDie, RataDie )
    , dayPicker : Picker.WheelPicker
    , hourPicker : Picker.WheelPicker
    , minutePicker : Picker.WheelPicker
    }



---- UPDATE ----


type TimeUnit
    = Day
    | Hour
    | Minute


{-| Msg of the DateTime Picker
-}
type Msg
    = PickerMsg TimeUnit Picker.Msg


updateSpecificPicker : Picker.Msg -> Picker.WheelPicker -> ( Picker.WheelPicker, Cmd Picker.Msg )
updateSpecificPicker pickerMsg picker =
    Picker.update pickerMsg picker


{-| The update function of the DateTime Picker
-}
update : Msg -> Model -> (Msg -> msg) -> ( Model, Cmd msg )
update pickerMsg model pickerWrapper =
    let
        ( pickerModel, pickerCmdMsg ) =
            internalUpdate pickerMsg model
    in
    ( pickerModel, Cmd.map pickerWrapper pickerCmdMsg )


{-| The subscriptions function of the DateTime Picker
-}
subscriptions : Model -> (Msg -> msg) -> Sub msg
subscriptions model wrapper =
    Sub.map wrapper (internalSubscriptions model)


getter timeUnit =
    case timeUnit of
        Day ->
            .dayPicker

        Hour ->
            .hourPicker

        Minute ->
            .minutePicker


setDayPicker val model =
    { model | dayPicker = val }


setHourPicker val model =
    { model | hourPicker = val }


setMinutePicker val model =
    { model | minutePicker = val }


setter timeUnit =
    case timeUnit of
        Day ->
            setDayPicker

        Hour ->
            setHourPicker

        Minute ->
            setMinutePicker


updateTimeUnitPicker timeUnit pickerMsg model =
    let
        ( pickerModel, pickerCmdMsg ) =
            updateSpecificPicker pickerMsg (model |> getter timeUnit)
    in
    ( setter timeUnit pickerModel model
        |> setDate (dateFromPickers model)
    , Cmd.map (PickerMsg timeUnit) pickerCmdMsg
    )


internalUpdate : Msg -> Model -> ( Model, Cmd Msg )
internalUpdate msg model =
    case msg of
        PickerMsg timeUnit pickerMsg ->
            updateTimeUnitPicker timeUnit pickerMsg model



---- SUBSCRIPTIONS ----


pickerSubscriptions : (Picker.Msg -> Msg) -> Picker.WheelPicker -> Sub Msg
pickerSubscriptions msg picker =
    if Picker.isAnimationFrameNeeded picker then
        AnimationFrame.times (msg << Picker.NewFrame)

    else
        Sub.none


internalSubscriptions : Model -> Sub Msg
internalSubscriptions model =
    Sub.batch
        [ pickerSubscriptions (PickerMsg Day) model.dayPicker
        , pickerSubscriptions (PickerMsg Hour) model.hourPicker
        , pickerSubscriptions (PickerMsg Minute) model.minutePicker
        ]



---- VIEW ----


pickerView : (Picker.Msg -> msg) -> Picker.WheelPicker -> Builder.FlexItem msg
pickerView msg picker =
    -- let
    --     touchMsgWrapper =
    --         msgWrapper pickerId << Picker.GetTouch
    -- in
    Builder.flexItem
        [ Attributes.rawAttribute (Touch.onStart (msg << Picker.GetTouch << Picker.StartTouch))
        , Attributes.rawAttribute (Touch.onMove (msg << Picker.GetTouch << Picker.HoldTouch))
        , Attributes.rawAttribute (Touch.onEnd (msg << Picker.GetTouch << Picker.StopTouch))
        ]
        [ Picker.view picker ]


pickerLabelView : String -> Builder.FlexItem msg
pickerLabelView text =
    Builder.flexItem []
        [ Builder.div
            [ Attributes.style
                [ Style.box [ Box.typography [ Typography.size (px 31) ] ] ]
            ]
            [ Builder.text text ]
        ]


{-| The view function of the DateTime Picker
-}
view : (Msg -> msg) -> Model -> NodeWithStyle msg
view msgWrapper model =
    Builder.flex
        [ Attributes.style
            [ Style.flexContainerProperties
                [ Flex.direction Flex.row
                , Flex.align Flex.alignCenter
                ]
            , Style.box
                [ Box.typography
                    [ Typography.userSelect False
                    ]
                ]
            ]
        ]
        [ pickerView (msgWrapper << PickerMsg Day) model.dayPicker
        , pickerLabelView " at "
        , pickerView (msgWrapper << PickerMsg Hour) model.hourPicker
        , pickerLabelView ":"
        , pickerView (msgWrapper << PickerMsg Minute) model.minutePicker
        ]



---- HELPERS ----


rataDieToMillis : RataDie -> Int
rataDieToMillis rata =
    (rata - rataAtPosixZero) * toMs.day


dateRange : Int -> Int -> Int -> List Int
dateRange start end increment =
    let
        dateRange_ start_ end_ increment_ acc_ =
            if start_ <= end_ then
                dateRange_ (start_ + increment_) end_ increment_ (start_ :: acc_)

            else
                acc_
    in
    dateRange_ start end increment []
        |> List.reverse


dateFromPickers : Model -> Posix
dateFromPickers model =
    let
        day =
            Picker.getSelect model.dayPicker

        hour =
            1 + Picker.getSelect model.hourPicker

        minute =
            Picker.getSelect model.minutePicker
    in
    ((Tuple.first model.dayLimits |> rataDieToMillis) + toMs.day * day + toMs.hour * hour + toMs.minute * minute)
        |> Time.millisToPosix


formatTime : List DateFormat.Token -> Posix -> String
formatTime formatter value =
    DateFormat.format formatter Time.utc value
