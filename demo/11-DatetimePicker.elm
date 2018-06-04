module Main exposing (main)

import BodyBuilder as Builder exposing (NodeWithStyle)
import BodyBuilder.Attributes as Attributes
import BodyBuilder.Events as Events
import BodyBuilder.Elements.DatetimePicker as Picker exposing (DatetimePicker)
import Date.RataDie exposing (RataDie)


--------------------------------------------------------------------------------
-- INIT                                                                       --
--------------------------------------------------------------------------------
---- Model ----


type DateRangeType
    = StartDate
    | StopDate


type alias DateRange =
    { year : Int
    , month : Int
    , day : Int
    , type_ : DateRangeType
    }


initModel =
    { datetimePicker = Picker.initDatetimePicker
    , datesRange = ( DateRange 0 0 0 StartDate, DateRange 0 0 0 StopDate )
    }


type alias Model =
    { datetimePicker : DatetimePicker
    , datesRange : ( DateRangeLimit, DateRangeLimit )
    }



---- Init ----


init : ( Model, Cmd Msg )
init =
    ( initModel, Cmd.none )



--------------------------------------------------------------------------------
-- SUBSCRIPTIONS                                                              --
--------------------------------------------------------------------------------


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



--------------------------------------------------------------------------------
-- UPDATE                                                                     --
--------------------------------------------------------------------------------
---- Msg ----


type Msg
    = NoOp



---- Update ----


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )



--------------------------------------------------------------------------------
-- VIEW                                                                       --
--------------------------------------------------------------------------------


dateRangeFormView : DateRange -> NodeWithStyle Msg
dateRangeFormView dateRangeLimit =
    Builder.div []
        [ Builder.inputText
            [ Events.onClick <| DateRangeMsg InputYear dateRangeLimit.type_
            , Attributes.value dateRangeLimit.year
            ]
        , Builder.inputText
            [ Events.onClick <| DateRangeMsg InputMonth dateRangeLimit.type_
            , Attributes.value dateRangeLimit.month
            ]
        , Builder.inputText
            [ Events.onClick <| DateRangeMsg Inputday dateRangeLimit.type_
            , Attributes.value dateRangeLimit.day
            ]
        ]


datesRangeFormView : ( DateRange, DateRange ) -> NodeWithStyle Msg
datesRangeFormView ( startDate, stopDate ) =
    Builder.div []
        [ dateRangeFormView startDate
        , dateRangeFormView stopDate
        , Builder.button [] [ Builder.text "Done" ]
        ]



---- Main View ----


view : Model -> NodeWithStyle Msg
view model =
    Builder.div []
        [ datesRangeFormView model.datesRange
        , datePickerView model.datetimePicker
        ]



--------------------------------------------------------------------------------
-- MAIN                                                                       --
--------------------------------------------------------------------------------


main : Program () Model Msg
main =
    Builder.embed
        { init = \_ -> init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
