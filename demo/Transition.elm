module Transition exposing (..)

import BodyBuilder exposing (..)
import Elegant exposing (textCenter, padding, SizeUnit(..), fontSize)
import AnimationFrame
import Color
import Time exposing (Time)


type Page
    = Index
    | Show Int


type Easing
    = EaseInOut
    | Linear


type alias Transition =
    { timer : Float
    , length : Float
    , direction : Direction
    , easing : Easing
    }


type alias Model =
    { before : List Page
    , current : Page
    , after : List Page
    , transition : Maybe Transition
    }


type Direction
    = Forward
    | Backward


type Msg
    = Enter Int
    | Back
    | Tick Time


insidePageView : Page -> Node interactiveContent phrasingContent Spanning NotListElement Msg
insidePageView page =
    case page of
        Index ->
            div [ style [ Elegant.backgroundColor Color.yellow ] ]
                [ div [ onClick (Enter 1), style [ Elegant.cursorPointer ] ] [ text "Toto 1Toto 1Toto 1Toto 1Toto 1Toto 1Toto 1" ]
                , div [ onClick (Enter 2), style [ Elegant.cursorPointer ] ] [ text "Toto 2Toto 2Toto 2Toto 2Toto 2Toto 2Toto 2" ]
                ]

        Show val ->
            div [ style [ Elegant.backgroundColor Color.blue, Elegant.height (Vh 100) ] ]
                [ div [ onClick Back, style [ Elegant.cursorPointer ] ] [ text "back" ]
                , div [] [ text (val |> toString) ]
                ]


pageView sizeUntilNow beforeSize transition page =
    [ div
        [ style [ Elegant.fullWidth ] ]
        [ insidePageView page ]
    ]


getMaybeTransitionValue : Maybe Transition -> Float
getMaybeTransitionValue maybeTransition =
    case maybeTransition of
        Nothing ->
            0

        Just transition ->
            transition |> getTransitionValue


getTransitionValue : Transition -> Float
getTransitionValue { direction, timer, length, easing } =
    (case direction of
        Forward ->
            negate

        Backward ->
            identity
    )
        ((easingFun easing) (timer / length))


easingFun : Easing -> Float -> Float
easingFun easing =
    case easing of
        EaseInOut ->
            easeInOut

        Linear ->
            identity


easeInOut : Float -> Float
easeInOut t =
    if t < 0.5 then
        2 * t * t
    else
        -1 + (4 - 2 * t) * t


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
                            (100 * (beforeSize + getMaybeTransitionValue model.transition))
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


isRunning : Maybe Transition -> Bool
isRunning transition =
    case transition of
        Nothing ->
            False

        Just transition ->
            transition.timer /= 0


push : Page -> Model -> Model
push el model =
    if isRunning model.transition then
        model
    else
        { model
            | before = model.current :: model.before
            , current = el
            , after = []
            , transition = Just (transition Forward 250 EaseInOut)
        }


transition : Direction -> Float -> Easing -> Transition
transition direction length easing =
    { direction = direction, length = length, timer = length, easing = easing }


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
                , transition = Just (transition Backward 250 EaseInOut)
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
            ( (case model.transition of
                Nothing ->
                    model

                Just transition ->
                    { model | transition = Just (transition |> timeDiff diff) }
              )
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    case model.transition of
        Nothing ->
            Sub.none

        Just transition ->
            if transition.timer > 0 then
                AnimationFrame.diffs Tick
            else
                Sub.none


init : Model
init =
    { before = []
    , current = Index
    , after = []
    , transition = Nothing
    }


main : Program Basics.Never Model Msg
main =
    program
        { init = ( init, Cmd.none )
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
