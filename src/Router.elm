module Router exposing (..)

import BodyBuilder exposing (..)
import Elegant exposing (textCenter, padding, SizeUnit(..), fontSize)
import AnimationFrame
import Color
import Time exposing (Time)


type alias Page customRoute =
    { maybeTransition : Maybe Transition
    , route : customRoute
    }


type Easing
    = EaseInOut
    | Linear


type Kind
    = SlideRight
    | SlideUp


type alias Transition =
    { timer : Float
    , length : Float
    , kind : Kind
    , direction : Direction
    , easing : Easing
    }


type alias History route =
    { before : List (Page route)
    , current : Page route
    , after : List (Page route)
    , transition : Maybe Transition
    }


type Direction
    = Forward
    | Backward


type StandardHistoryMsg
    = Tick Time
    | Back


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
        (easingFun easing <| timer / length)
        + (case direction of
            Forward ->
                1

            Backward ->
                0
          )


isRunning : Maybe Transition -> Bool
isRunning transition =
    case transition of
        Nothing ->
            False

        Just transition ->
            transition.timer > 0


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


basicDuration : number
basicDuration =
    250


customTransition : Float -> Kind -> Direction -> Easing -> Transition
customTransition duration =
    Transition duration duration


push : Page route -> History route -> History route
push el ({ transition, before, current, after } as history) =
    if isRunning transition then
        history
    else
        { history
            | before = current :: before
            , current = el
            , after = []
            , transition = el.maybeTransition
        }


oppositeDirection : Direction -> Direction
oppositeDirection direction =
    if direction == Backward then
        Forward
    else
        Backward


opposite : Maybe Transition -> Maybe Transition
opposite maybeTransition =
    case maybeTransition of
        Nothing ->
            Nothing

        Just transition ->
            Just
                { transition
                    | direction =
                        oppositeDirection transition.direction
                }


defaultTransition : Maybe Transition
defaultTransition =
    Just <| customTransition basicDuration SlideRight Forward EaseInOut


pageWithDefaultTransition : route -> Page route
pageWithDefaultTransition =
    Page defaultTransition


pageWithoutTransition : route -> Page route
pageWithoutTransition =
    Page Nothing


pageWithTransition : Transition -> route -> Page route
pageWithTransition transition =
    Page (Just transition)


pull : History route -> History route
pull ({ transition, before, current, after } as history) =
    if isRunning transition then
        history
    else
        case before of
            [] ->
                history

            head :: tail ->
                { history
                    | before = tail
                    , current = head
                    , after = current :: after
                    , transition = opposite current.maybeTransition
                }


slideUp : Transition
slideUp =
    customTransition basicDuration SlideUp Forward EaseInOut


putHeadInListIfExists : List a -> List a
putHeadInListIfExists list =
    case list of
        [] ->
            []

        head :: _ ->
            [ head ]


visiblePages : History route -> List (Page route)
visiblePages { transition, before, current, after } =
    case transition of
        Nothing ->
            [ current ]

        Just transition ->
            case transition.direction of
                Forward ->
                    (putHeadInListIfExists before) ++ [ current ]

                Backward ->
                    current :: putHeadInListIfExists after


percentage : Float -> SizeUnit
percentage a =
    Percent <| 100 * a


beforeTransition : History route -> List (Page route)
beforeTransition history =
    case history.transition of
        Nothing ->
            []

        Just transition ->
            if transition.direction == Backward then
                [ history.current ]
            else
                putHeadInListIfExists history.before


afterTransition : History route -> List (Page route)
afterTransition history =
    case history.transition of
        Nothing ->
            []

        Just transition ->
            if transition.direction == Backward then
                putHeadInListIfExists history.after
            else
                [ history.current ]


overflowHiddenContainer :
    List (FlowAttributes msg -> FlowAttributes msg)
    -> List (Node interactiveContent phrasingContent Spanning NotListElement msg)
    -> Node interactiveContent phrasingContent Spanning NotListElement msg
overflowHiddenContainer attributes content =
    div [ style [ Elegant.overflowHidden ] ]
        [ div attributes content ]


pageView :
    (a -> b -> Node interactiveContent phrasingContent Spanning NotListElement msg)
    -> Maybe Transition
    -> b
    -> a
    -> Node interactiveContent phrasingContent Spanning NotListElement msg
pageView insidePageView_ transition data page =
    div
        [ style
            ([ Elegant.fullWidth
             , Elegant.boxShadowCenteredBlurry (Px 5) (Color.grayscale <| abs <| getMaybeTransitionValue <| transition)
             ]
            )
        ]
        [ insidePageView_ page data ]


historyView :
    (Page route -> a -> Node interactiveContent phrasingContent Spanning NotListElement msg)
    -> History route
    -> a
    -> Node interactiveContent phrasingContent Spanning NotListElement msg
historyView insidePageView_ history data =
    let
        visiblePages_ =
            visiblePages history
    in
        case history.transition of
            Nothing ->
                overflowHiddenContainer [] [ pageView insidePageView_ Nothing data history.current ]

            Just transition ->
                case transition.kind of
                    SlideUp ->
                        overflowHiddenContainer
                            []
                            [ div
                                [ style
                                    [ Elegant.width (Percent 100)
                                    ]
                                ]
                                (List.map (pageView insidePageView_ history.transition data) (history |> beforeTransition))
                            , div
                                [ style
                                    [ Elegant.bottom <| percentage ((getMaybeTransitionValue <| history.transition) - 1)
                                    , Elegant.positionAbsolute
                                    , Elegant.width (Percent 100)
                                    ]
                                ]
                                (List.map (pageView insidePageView_ history.transition data) (history |> afterTransition))
                            ]

                    SlideRight ->
                        overflowHiddenContainer
                            [ style
                                [ Elegant.displayFlex
                                , Elegant.width <| percentage <| toFloat <| List.length <| visiblePages_
                                , Elegant.positionRelative
                                , Elegant.right <| percentage <| getMaybeTransitionValue <| history.transition
                                ]
                            ]
                            (List.map (pageView insidePageView_ history.transition data) visiblePages_)


maybeTransitionSubscription : (StandardHistoryMsg -> msg) -> Maybe a -> Sub msg
maybeTransitionSubscription standardHistoryWrapper =
    Maybe.map (\transition -> AnimationFrame.diffs <| (standardHistoryWrapper << Tick))
        >> Maybe.withDefault Sub.none


initHistory : route -> History route
initHistory currentPage =
    { before = []
    , current = pageWithoutTransition currentPage
    , after = []
    , transition = Nothing
    }


standardHandleHistory : StandardHistoryMsg -> History route -> History route
standardHandleHistory historyMsg history =
    case historyMsg of
        Back ->
            history |> pull

        Tick diff ->
            case history.transition of
                Nothing ->
                    history

                Just transition ->
                    let
                        newTransition =
                            (transition |> timeDiff diff)
                    in
                        if newTransition.timer > 0 then
                            { history | transition = Just newTransition }
                        else
                            { history | transition = Nothing }


handleStandardHistory : StandardHistoryMsg -> { a | history : History route } -> ( { a | history : History route }, Cmd msg )
handleStandardHistory historyMsg model =
    ( { model | history = standardHandleHistory historyMsg model.history }, Cmd.none )


initHistoryAndData : route -> data -> { history : History route, data : data }
initHistoryAndData route data =
    { history = initHistory route
    , data = data
    }
