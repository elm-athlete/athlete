module Transition exposing (..)

import BodyBuilder exposing (..)
import Elegant exposing (textCenter, padding, SizeUnit(..), fontSize)
import AnimationFrame
import Color
import Time exposing (Time)


type Page
    = Index
    | Show Int


type alias Model =
    { before : List Page
    , current : Page
    , after : List Page
    , transition :
        { timer : Float
        , direction : Direction
        }
    }


type Direction
    = Forward
    | Backward
    | Initial


type Msg
    = Enter Int
    | Back
    | Tick Time


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


pageView sizeUntilNow beforeSize transition page =
    let
        percentage =
            (sizeUntilNow / (beforeSize + 1))
    in
        [ div
            [ style
                [ Elegant.width (Percent 100)
                ]
            ]
            [ insidePageView page ]
        ]


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
                            ((100 * beforeSize)
                                + ((if model.transition.direction == Forward then
                                        negate
                                    else
                                        identity
                                   )
                                    (model.transition.timer / 10)
                                  )
                            )
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


push el model =
    { model
        | before = model.current :: model.before
        , current = el
        , after = []
        , transition = { direction = Forward, timer = 1000 }
    }


pull model =
    case model.before of
        [] ->
            model

        head :: tail ->
            { model
                | before = tail
                , current = head
                , after = model.current :: model.after
                , transition = { direction = Backward, timer = 1000 }
            }


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


init =
    { before = [], current = Index, after = [], transition = { direction = Initial, timer = 0 } }


main : Program Basics.Never Model Msg
main =
    program
        { init = ( init, Cmd.none )
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
