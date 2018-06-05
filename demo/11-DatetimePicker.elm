module Main exposing (main)

import BodyBuilder as Builder exposing (NodeWithStyle)
import BodyBuilder.Attributes as Attributes
import BodyBuilder.Events as Events
import BodyBuilder.Elements.DatetimePicker as Picker
import Date.RataDie as RataDie exposing (RataDie)
import DateFormat
import Elegant.Block as Block
import BodyBuilder.Style as Style
import Elegant.Box as Box
import Elegant.Margin as Margin
import Elegant exposing (px)
import Elegant.Typography as Typography
import Time exposing (Posix)


---- INIT ----


initModel =
    Picker.initModel
        ( RataDie.fromCalendarDate 2017 RataDie.Dec 15
        , RataDie.fromCalendarDate 2018 RataDie.Jan 14
        )


type alias Model =
    Picker.Model


init : ( Model, Cmd Msg )
init =
    ( initModel, Cmd.none )



---- SUBSCRIPTIONS ----


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.map PickerMsg (Picker.subscriptions model)



---- UPDATE ----


type Msg
    = PickerMsg Picker.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        PickerMsg pickerMsg ->
            let
                ( pickerModel, pickerCmdMsg ) =
                    Picker.update pickerMsg model
            in
                ( pickerModel, Cmd.map PickerMsg pickerCmdMsg )



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
            , Style.box [ Box.margin [ Margin.top <| Margin.width (px 200) ] ]
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
