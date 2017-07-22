module Transition exposing (..)

import BodyBuilder exposing (..)
import Elegant exposing (textCenter, padding, SizeUnit(..), fontSize)
import AnimationFrame
import Time exposing (Time)


type Page
    = Index
    | IndexTo Int
    | IndexFrom Int


type alias Model =
    { page : Page
    , timer : Float
    }


type Msg
    = Enter Int
    | Leave Int
    | Tick Time


view : Model -> Node Interactive NotPhrasing Spanning NotListElement Msg
view model =
    let
        percentage =
            case model.page of
                IndexTo _ ->
                    model.timer / 20 - 50

                IndexFrom _ ->
                    0 - model.timer / 20

                Index ->
                    0
    in
        div [ style [ Elegant.overflowHidden ] ]
            [ div [ style [ Elegant.displayFlex, Elegant.width (Percent 200) ] ]
                [ div [ style [ Elegant.positionRelative, Elegant.left (Percent percentage), Elegant.width (Percent 100), Elegant.opacity 1 ] ]
                    [ p [ onClick (Enter 1) ] [ text "Toto 1Toto 1Toto 1Toto 1Toto 1Toto 1Toto 1" ]
                    , p [ onClick (Enter 2) ] [ text "Toto 2Toto 2Toto 2Toto 2Toto 2Toto 2Toto 2" ]
                    ]
                , div
                    [ style [ Elegant.positionRelative, Elegant.left (Percent percentage), Elegant.width (Percent 100), Elegant.opacity 1 ] ]
                    [ p [ onClick (Leave 1) ] [ text "1" ] ]
                ]
            , div [] [ p [] [ text (model.timer |> toString) ] ]
            ]


update :
    Msg
    -> Model
    -> ( Model, Cmd msg )
update msg model =
    case msg of
        Enter val ->
            ( { model | page = (IndexTo val), timer = 1000 }, Cmd.none )

        Leave val ->
            ( { model | page = (IndexFrom val), timer = 1000 }, Cmd.none )

        Tick diff ->
            let
                newTimer =
                    if model.timer - diff < 0 then
                        0
                    else
                        model.timer - diff
            in
                ( { model | timer = newTimer }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    if model.timer > 0 then
        AnimationFrame.diffs Tick
    else
        Sub.none


main : Program Basics.Never Model Msg
main =
    program
        { init = ( { page = Index, timer = 0 }, Cmd.none )
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
