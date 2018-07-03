module Main exposing (..)

import BodyBuilder as Builder exposing (NodeWithStyle)
import BodyBuilder.Attributes as Attributes
import Browser.Events
import Time exposing (Posix)
import Touch


---- INIT ----


type alias Model =
    { times : Maybe ( Int, Int )
    , state : ( Int, Int )
    }



---- SUBSCRIPTIONS ----


subscriptions _ =
    Browser.Events.onAnimationFrame NewFrame



---- UPDATE ----


type Msg
    = NewFrame Posix
    | StartTouch Touch.Event
    | HoldTouch Touch.Event
    | StopTouch Touch.Event


update msg model =
    case msg of
        NewFrame posix ->
            case model of
                Nothing ->
                    ( Just ( Time.posixToMillis posix, Time.posixToMillis posix ), Cmd.none )

                Just ( initial, _ ) ->
                    ( Just ( initial, Time.posixToMillis posix )
                    , Cmd.none
                    )



---- VIEW ----


view model =
    Builder.div
        [ Attributes.rawAttribute (Touch.onStart StartTouch)
        , Attributes.rawAttribute (Touch.onMove HoldTouch)
        , Attributes.rawAttribute (Touch.onEnd StopTouch)
        ]
        [ case model of
            Nothing ->
                Builder.text "No Time"

            Just ( initial, time ) ->
                Builder.text (String.fromInt (time - initial))
        ]



---- MAIN ----


main : Program () Model Msg
main =
    Builder.element
        { init = always ( Model Nothing ( 0, 0 ), Cmd.none )
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
