module Transition exposing (..)

import BodyBuilder exposing (..)
import Elegant exposing (textCenter, padding, SizeUnit(..), fontSize)
import AnimationFrame
import Color
import Time exposing (Time)


type Page
    = Index
    | Show Int


type alias Transition =
    { timer : Float
    , length : Float
    , direction : Direction
    }


type alias Model =
    { before : List Page
    , current : Page
    , after : List Page
    , transition : Transition
    }


type Direction
    = Forward
    | Backward
    | Initial


type Msg
    = Enter Int
    | Back
    | Tick Time


insidePageView : Page -> Node interactiveContent phrasingContent Spanning NotListElement Msg
insidePageView page =
    case page of
        Index ->
            div [ style [ Elegant.backgroundColor Color.yellow ] ]
                [ div [ onClick (Enter 1) ] [ text "Toto 1Toto 1Toto 1Toto 1Toto 1Toto 1Toto 1" ]
                , div [ onClick (Enter 2) ] [ text "Toto 2Toto 2Toto 2Toto 2Toto 2Toto 2Toto 2" ]
                ]

        Show val ->
            div [ style [ Elegant.backgroundColor Color.blue ] ]
                [ div [ onClick Back ] [ text "back" ]
                , div [] [ text (val |> toString) ]
                ]


pageView :
    a
    -> b
    -> c
    -> Page
    -> List (Node interactiveContent phrasingContent Spanning NotListElement Msg)
pageView sizeUntilNow beforeSize transition page =
    [ div
        [ style [ Elegant.fullWidth ] ]
        [ insidePageView page ]
    ]


getTransitionValue : Transition -> Float
getTransitionValue transition =
    (if transition.direction == Forward then
        negate
     else
        identity
    )
        (transition.timer / 1000)


view : Model -> Node Interactive NotPhrasing Spanning NotListElement Msg
view model =
    let
        total =
            model.before ++ [ model.current ] ++ model.after

        totalSize =
            total |> List.length |> toFloat

        beforeSize =
            model.before |> List.length |> toFloat
    in
        div [ style [ Elegant.overflowHidden ] ]
            [ div
                [ style
                    [ Elegant.displayFlex
                    , Elegant.width (Percent (100 * totalSize))
                    , Elegant.right
                        (Percent
                            (100 * (beforeSize + getTransitionValue model.transition))
                        )
                    , Elegant.positionRelative
                    ]
                ]
                (Tuple.second
                    (List.foldl
                        (\page ( sizeUntilNow, views ) ->
                            ( sizeUntilNow + 1
                            , views ++ (pageView sizeUntilNow beforeSize model.transition page)
                            )
                        )
                        ( 0, [] )
                        total
                    )
                )
            ]


push : Page -> Model -> Model
push el model =
    { model
        | before = model.current :: model.before
        , current = el
        , after = []
        , transition = { direction = Forward, length = 500, timer = 1000 }
    }


pull : Model -> Model
pull model =
    case model.before of
        [] ->
            model

        head :: tail ->
            { model
                | before = tail
                , current = head
                , after = model.current :: model.after
                , transition = { direction = Backward, length = 500, timer = 1000 }
            }


timeDiff : Float -> Transition -> Transition
timeDiff diff ({ timer } as transition) =
    let
        newTimer =
            if timer - diff <= 0 then
                0
            else
                timer - diff
    in
        { transition | timer = newTimer }


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        Enter val ->
            ( model |> push (Show val), Cmd.none )

        Back ->
            ( model |> pull, Cmd.none )

        Tick diff ->
            ( { model | transition = model.transition |> timeDiff diff }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    if model.transition.timer > 0 then
        AnimationFrame.diffs Tick
    else
        Sub.none


init : Model
init =
    { before = [], current = Index, after = [], transition = { direction = Initial, timer = 0, length = 0 } }


main : Program Basics.Never Model Msg
main =
    program
        { init = ( init, Cmd.none )
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
