module BodyBuilder.Elements.DatetimePicker exposing (Model, initialModel, main)

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


---- CONSTANTS ----


dayPickerLimits : { start : Int, end : Int }
dayPickerLimits =
    { start = 1513299600000
    , end = 1515891600000
    }


hourPickerLimits : { start : Int, end : Int }
hourPickerLimits =
    { start = 3600000
    , end = 82800000
    }


minutePickerLimits : { start : Int, end : Int }
minutePickerLimits =
    { start = 0
    , end = 3540000
    }


toMs : { day : Int, hour : Int, minute : Int }
toMs =
    { day = 86400000
    , hour = 3600000
    , minute = 60000
    }


ourTimezone : Zone
ourTimezone =
    Time.utc



---- INIT ----


initDayPicker : Picker.WheelPicker
initDayPicker =
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
    dateRange dayPickerLimits.start dayPickerLimits.end toMs.day
        |> List.map format
        |> Picker.defaultWheelPicker 175


initHourPicker : Picker.WheelPicker
initHourPicker =
    let
        format =
            Time.millisToPosix >> formatTime [ DateFormat.hourMilitaryFixed ]
    in
    dateRange hourPickerLimits.start hourPickerLimits.end toMs.hour
        |> List.map format
        |> Picker.defaultWheelPicker 60


initMinutePicker : Picker.WheelPicker
initMinutePicker =
    let
        format =
            Time.millisToPosix >> formatTime [ DateFormat.minuteFixed ]
    in
    dateRange minutePickerLimits.start minutePickerLimits.end toMs.minute
        |> List.map format
        |> Picker.defaultWheelPicker 60


setDate : Posix -> Model -> Model
setDate date model =
    { model | date = date }


initialModel : Model
initialModel =
    { date = Time.millisToPosix 0
    , dayPicker = initDayPicker
    , hourPicker = initHourPicker
    , minutePicker = initMinutePicker
    }


type alias Model =
    { date : Posix
    , dayPicker : Picker.WheelPicker
    , hourPicker : Picker.WheelPicker
    , minutePicker : Picker.WheelPicker
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel
        |> setDate (dateFromPickers initialModel)
    , Cmd.none
    )



---- UPDATE ----


type PickerId
    = DayPicker
    | HourPicker
    | MinutePicker


updatePicker : PickerId -> Picker.Msg -> Model -> ( Model, Cmd Msg )
updatePicker pickerId pickerMsg model =
    let
        updateSpecificPicker picker =
            Picker.update pickerMsg picker
    in
    case pickerId of
        DayPicker ->
            ( { model | dayPicker = Tuple.first (updateSpecificPicker model.dayPicker) }
                |> setDate (dateFromPickers model)
            , Cmd.map (PickerMsg DayPicker) (Tuple.second (updateSpecificPicker model.dayPicker))
            )

        HourPicker ->
            ( { model | hourPicker = Tuple.first (updateSpecificPicker model.hourPicker) }
                |> setDate (dateFromPickers model)
            , Cmd.map (PickerMsg HourPicker) (Tuple.second (updateSpecificPicker model.hourPicker))
            )

        MinutePicker ->
            ( { model | minutePicker = Tuple.first (updateSpecificPicker model.minutePicker) }
                |> setDate (dateFromPickers model)
            , Cmd.map (PickerMsg MinutePicker) (Tuple.second (updateSpecificPicker model.minutePicker))
            )


type Msg
    = PickerMsg PickerId Picker.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        PickerMsg pickerId pickerMsg ->
            updatePicker pickerId pickerMsg model



---- SUBSCRIPTIONS ----


pickerSubscriptions : PickerId -> Picker.WheelPicker -> Sub Msg
pickerSubscriptions pickerId picker =
    if Picker.isAnimationFrameNeeded picker then
        AnimationFrame.times (PickerMsg pickerId << Picker.NewFrame)
    else
        Sub.none


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ pickerSubscriptions DayPicker model.dayPicker
        , pickerSubscriptions HourPicker model.hourPicker
        , pickerSubscriptions MinutePicker model.minutePicker
        ]



---- VIEW ----


pickerView : PickerId -> Picker.WheelPicker -> Builder.FlexItem Msg
pickerView pickerId picker =
    let
        touchMsgWrapper =
            PickerMsg pickerId << Picker.GetTouch
    in
    Builder.flexItem
        [ Attributes.rawAttribute (Touch.onStart (touchMsgWrapper << Picker.StartTouch))
        , Attributes.rawAttribute (Touch.onMove (touchMsgWrapper << Picker.HoldTouch))
        , Attributes.rawAttribute (Touch.onEnd (touchMsgWrapper << Picker.StopTouch))
        ]
        [ Picker.view picker ]


pickerLabelView : String -> Builder.FlexItem Msg
pickerLabelView text =
    Builder.flexItem []
        [ Builder.div
            [ Attributes.style
                [ Style.box [ Box.typography [ Typography.size (px 31) ] ] ]
            ]
            [ Builder.text text ]
        ]


dateView : Posix -> String
dateView =
    let
        formatter =
            [ DateFormat.monthNameFull
            , DateFormat.text " "
            , DateFormat.dayOfMonthSuffix
            , DateFormat.text ", "
            , DateFormat.yearNumber
            , DateFormat.text " at "
            , DateFormat.hourMilitaryFixed
            , DateFormat.text ":"
            , DateFormat.minuteFixed
            ]
    in
    formatTime formatter


view : Model -> NodeWithStyle Msg
view model =
    Builder.div
        [ Attributes.style
            [ Style.blockProperties [ Block.alignCenter ]
            , Style.box [ Box.margin [ Margin.top <| Margin.width (px 200) ] ]
            ]
        ]
        [ Builder.flex
            [ Attributes.style
                [ Style.flexContainerProperties [ Flex.direction Flex.row, Flex.align Flex.alignCenter ] ]
            ]
            [ pickerView DayPicker model.dayPicker
            , pickerLabelView " at "
            , pickerView HourPicker model.hourPicker
            , pickerLabelView ":"
            , pickerView MinutePicker model.minutePicker
            ]
        , Builder.div
            [ Attributes.style
                [ Style.box
                    [ Box.margin [ Margin.top <| Margin.width (px 20) ]
                    , Box.typography [ Typography.size (px 30) ]
                    ]
                ]
            ]
            [ Builder.text ("Selected: " ++ dateView model.date) ]
        ]



---- MAIN ----


main : Program () Model Msg
main =
    Builder.embed
        { init = \_ -> init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



---- HELPERS ----


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
            Picker.getSelect model.hourPicker

        minute =
            Picker.getSelect model.minutePicker
    in
    (dayPickerLimits.start + toMs.day * day + toMs.hour * hour + toMs.minute * minute)
        |> Time.millisToPosix


formatTime : List DateFormat.Token -> Posix -> String
formatTime formatter value =
    DateFormat.format formatter ourTimezone value
