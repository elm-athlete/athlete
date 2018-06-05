module BodyBuilder.Elements.DatetimePicker exposing (Model, Msg(..), initModel, subscriptions, update, view)

import AnimationFrame
import BodyBuilder as Builder exposing (NodeWithStyle)
import BodyBuilder.Attributes as Attributes
import BodyBuilder.Elements.WheelPicker as Picker
import BodyBuilder.Style as Style
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
import Date.RataDie as Date exposing (RataDie)


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
            |> Picker.defaultWheelPicker 175


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


initModel : ( RataDie, RataDie ) -> Model
initModel dayLimits =
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


type alias Model =
    { date : Posix
    , dayLimits : ( RataDie, RataDie )
    , dayPicker : Picker.WheelPicker
    , hourPicker : Picker.WheelPicker
    , minutePicker : Picker.WheelPicker
    }



---- UPDATE ----


type Msg
    = DayPickerMsg Picker.Msg
    | HourPickerMsg Picker.Msg
    | MinutePickerMsg Picker.Msg


updateSpecificPicker : Picker.Msg -> Picker.WheelPicker -> ( Picker.WheelPicker, Cmd Picker.Msg )
updateSpecificPicker pickerMsg picker =
    Picker.update pickerMsg picker


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        DayPickerMsg pickerMsg ->
            let
                ( pickerModel, pickerCmdMsg ) =
                    updateSpecificPicker pickerMsg model.dayPicker
            in
                ( { model | dayPicker = pickerModel }
                    |> setDate (dateFromPickers model)
                , Cmd.map DayPickerMsg pickerCmdMsg
                )

        HourPickerMsg pickerMsg ->
            let
                ( pickerModel, pickerCmdMsg ) =
                    updateSpecificPicker pickerMsg model.hourPicker
            in
                ( { model | hourPicker = pickerModel }
                    |> setDate (dateFromPickers model)
                , Cmd.map HourPickerMsg pickerCmdMsg
                )

        MinutePickerMsg pickerMsg ->
            let
                ( pickerModel, pickerCmdMsg ) =
                    updateSpecificPicker pickerMsg model.minutePicker
            in
                ( { model | minutePicker = pickerModel }
                    |> setDate (dateFromPickers model)
                , Cmd.map MinutePickerMsg pickerCmdMsg
                )



---- SUBSCRIPTIONS ----


pickerSubscriptions : (Picker.Msg -> Msg) -> Picker.WheelPicker -> Sub Msg
pickerSubscriptions msg picker =
    if Picker.isAnimationFrameNeeded picker then
        AnimationFrame.times (msg << Picker.NewFrame)
    else
        Sub.none


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ pickerSubscriptions DayPickerMsg model.dayPicker
        , pickerSubscriptions HourPickerMsg model.hourPicker
        , pickerSubscriptions MinutePickerMsg model.minutePicker
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


view : (Msg -> msg) -> Model -> NodeWithStyle msg
view msgWrapper model =
    Builder.flex
        [ Attributes.style
            [ Style.flexContainerProperties [ Flex.direction Flex.row, Flex.align Flex.alignCenter ] ]
        ]
        [ pickerView (msgWrapper << DayPickerMsg) model.dayPicker
        , pickerLabelView " at "
        , pickerView (msgWrapper << HourPickerMsg) model.hourPicker
        , pickerLabelView ":"
        , pickerView (msgWrapper << MinutePickerMsg) model.minutePicker
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
