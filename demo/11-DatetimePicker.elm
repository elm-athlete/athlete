module DatePicker exposing (main)

-- import SingleTouch

import AnimationFrame
import Block
import BodyBuilder as Builder exposing (NodeWithStyle)
import BodyBuilder.Attributes as Attributes
import BodyBuilder.Elements.WheelPicker as Picker
import Box
import Date
import Elegant exposing (px)
import Flex
import Function
import Margin
import Style
import Time
import Touch
import Typography


---- CONSTANTS ----


dayPickerLimits : { start : Int, end : Int }
dayPickerLimits =
    { start = 1544828400000
    , end = 1547506800000
    }


toMs : { day : Int, hour : Int, minute : Int }
toMs =
    { day = 86400000
    , hour = 3600000
    , minute = 60000
    }



---- INIT ----


ourFormatter : Zone -> Posix -> String
ourFormatter =
    DateFormat.format
        [ DateFormat.monthNameFull
        , DateFormat.text " "
        , DateFormat.dayOfMonthSuffix
        , DateFormat.text ", "
        , DateFormat.yearNumber
        ]


ourTimezone : Zone
ourTimezone =
    utc


ourPrettyDate : Posix -> String
ourPrettyDate =
    ourFormatter ourTimezone


timeToString value =
    value |> format


initDayPicker : Picker.WheelPicker
initDayPicker =
    dateRange dayPickerLimits.start dayPickerLimits.end
        |> List.map timeToString
        |> Picker.defaultWheelPicker 175


initHourPicker : Picker.WheelPicker
initHourPicker =
    List.range 0 59
        |> List.map (\value -> intToString 2 value)
        |> Picker.defaultWheelPicker 60


initMinutePicker : Picker.WheelPicker
initMinutePicker =
    List.range 0 59
        |> List.map (\value -> intToString 2 value)
        |> Picker.defaultWheelPicker 60


setDate : Date.Date -> Model -> Model
setDate date model =
    { model | date = date }


initialModel : Model
initialModel =
    { date = Date.fromRataDie 0
    , dayPicker = initDayPicker
    , hourPicker = initHourPicker
    , minutePicker = initMinutePicker
    }


type alias Model =
    { date : Date.Date
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


dateView : Date.Date -> String
dateView date =
    (Date.day date |> String.fromInt)
        |> Function.flip (++) " "
        |> Function.flip (++) (Date.month date |> String.fromInt)
        |> Function.flip (++) " "
        |> Function.flip (++) (Date.year date |> String.fromInt)
        |> Function.flip (++) " at "
        |> Function.flip (++) (intToString 2 (Time.toHour Time.utc date))
        |> Function.flip (++) ":"
        |> Function.flip (++) (intToString 2 (Time.toMinute Time.utc date))


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


main : Program Never Model Msg
main =
    Builder.embed
        { init = \_ -> init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



---- HELPERS ----


intToString : Int -> Int -> String
intToString digitsNb value =
    let
        baseString =
            String.fromInt value

        additionalZeros =
            baseString
                |> String.length
                |> (-) digitsNb
                |> Function.flip String.repeat "0"
    in
    String.append additionalZeros baseString


dateRange_ : Int -> Int -> List Int -> List Int
dateRange_ start end acc =
    if start < end then
        dateRange_ (start + toMs.day) end (start :: acc)
    else
        acc


dateRange : Int -> Int -> List Int
dateRange start end =
    dateRange_ start end []
        |> List.reverse


dateFromPickers : Model -> Date.Date
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
        |> Date.fromRataDie
