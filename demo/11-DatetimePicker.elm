module DateTimePicker exposing (main)

import BodyBuilder as Builder exposing (NodeWithStyle)
import BodyBuilder.Attributes as Attributes
import BodyBuilder.Elements.DateTimePicker as Picker
import BodyBuilder.Events as Events
import BodyBuilder.Style as Style
import Date.RataDie as RataDie exposing (RataDie)
import DateFormat
import Elegant exposing (px)
import Elegant.Block as Block
import Elegant.Box as Box
import Elegant.Margin as Margin
import Elegant.Typography as Typography
import Time exposing (Posix)


---- INIT ----


type alias Model =
    Picker.Model


type Msg
    = PickerMsg Picker.Msg


initModel =
    Picker.init
        ( RataDie.fromCalendarDate 2017 RataDie.Dec 15
        , RataDie.fromCalendarDate 2018 RataDie.Jan 14
        )


init : ( Model, Cmd Msg )
init =
    ( initModel, Cmd.none )



---- SUBSCRIPTIONS ----


subscriptions : Model -> Sub Msg
subscriptions model =
    Picker.subscriptions model PickerMsg



---- UPDATE ----


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        PickerMsg pickerMsg ->
            Picker.update pickerMsg model PickerMsg



---- VIEW ----


dateView : Posix -> String
dateView =
    DateFormat.format
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
        Time.utc


view : Model -> NodeWithStyle Msg
view model =
    Builder.div
        [ Attributes.style
            [ Style.blockProperties [ Block.alignCenter ]
            , Style.box
                [ Box.margin [ Margin.top <| Margin.width (px 200) ]
                , Box.fontFamilySansSerif
                ]
            ]
        ]
        [ Picker.view PickerMsg model
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
