module Router
    exposing
        ( History
        , StandardHistoryMsg(Back)
        , Page
        , Transition
        , push
        , slideUp
        , pageWithDefaultTransition
        , pageWithTransition
        , pageWithoutTransition
        , headerElement
        , headerButton
        , historyView
        , handleStandardHistory
        , maybeTransitionSubscription
        , initHistoryAndData
        )

{-| Router based on BodyBuilder and Elegant implementing transitions between
pages and history (backward and forward)

@docs History
@docs StandardHistoryMsg
@docs Page
@docs Transition

@docs handleStandardHistory
@docs maybeTransitionSubscription
@docs initHistoryAndData
@docs push
@docs slideUp
@docs pageWithDefaultTransition
@docs pageWithTransition
@docs pageWithoutTransition

@docs headerElement
@docs headerButton
@docs historyView

-}

import BodyBuilder exposing (..)
import BodyBuilder.Attributes exposing (..)
import BodyBuilder.Events exposing (..)
import Elegant exposing (SizeUnit, percent)
import AnimationFrame
import Time exposing (Time)
import Display
import Display.Overflow
import Box
import Position
import Typography
import Padding
import Cursor
import Typography.Character


type Easing
    = EaseInOut
    | Linear


type Kind
    = SlideRight
    | SlideUp


{-| Transition between 2 pages
-}
type alias Transition =
    { timer : Float
    , length : Float
    , kind : Kind
    , direction : Direction
    , easing : Easing
    }


{-| Page type handling transition
-}
type alias Page customRoute =
    { maybeTransition : Maybe Transition
    , route : customRoute
    }


{-| Generic History type handling current page, before pages, after pages
and current transition
-}
type alias History route =
    { before : List (Page route)
    , current : Page route
    , after : List (Page route)
    , transition : Maybe Transition
    }


type Direction
    = Forward
    | Backward


{-| Standard History Messages type :
Tick to handle transitions with RequestAnimationFrame
Back to handle back buttons
-}
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


{-| push a page into history
-}
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
    case direction of
        Backward ->
            Forward

        Forward ->
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


{-| creates a page with the defaultTransition
-}
pageWithDefaultTransition : route -> Page route
pageWithDefaultTransition =
    Page defaultTransition


{-| creates a page without any transition
-}
pageWithoutTransition : route -> Page route
pageWithoutTransition =
    Page Nothing


{-| creates a page with a custom transition
-}
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


{-| slideUp transition
-}
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
    percent <| 100 * a


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
    -> List (Node msg)
    -> Node msg
overflowHiddenContainer attributes content =
    div
        [ style
            [ Elegant.style <|
                Display.block
                    [ Display.overflow
                        [ Display.Overflow.overflowXY Display.Overflow.hidden ]
                    ]
                    []
            ]
        ]
        [ div attributes content ]


pageView :
    (a -> b -> Maybe Transition -> Node msg)
    -> Maybe Transition
    -> b
    -> a
    -> Node msg
pageView insidePageView_ transition data page =
    div
        [ style
            [ Elegant.style <|
                Display.block
                    [ Display.dimensions [ Display.width (percent 100) ] ]
                    [ Box.boxShadow
                        [-- BoxShadow.
                        ]
                    ]
            ]

        -- , Elegant.boxShadowCenteredBlurry (Px 5) (Color.grayscale <| abs <| getMaybeTransitionValue <| transition)
        ]
        [ insidePageView_ page data transition ]


{-| display the current possible transition from one page to the other using
the history and its own routing system
-}
historyView :
    (Page route -> data -> Maybe Transition -> Node msg)
    -> History route
    -> data
    -> Node msg
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
                                    [ Elegant.style <|
                                        Display.block
                                            [ Display.dimensions [ Display.width (percent 100) ] ]
                                            []
                                    ]
                                ]
                                (List.map (pageView insidePageView_ history.transition data) (history |> beforeTransition))
                            , div
                                [ style
                                    [ Elegant.style <|
                                        Display.block
                                            [ Display.dimensions [ Display.width (percent 100) ] ]
                                            [ Box.position <|
                                                Position.absolute <|
                                                    [ Position.bottom <|
                                                        percentage ((getMaybeTransitionValue <| history.transition) - 1)
                                                    ]
                                            ]
                                    ]
                                ]
                                (List.map (pageView insidePageView_ history.transition data) (history |> afterTransition))
                            ]

                    SlideRight ->
                        overflowHiddenContainer
                            [ style
                                [ Elegant.style <|
                                    Display.blockFlexContainer []
                                        [ Display.dimensions [ Display.width <| percentage <| toFloat <| List.length <| visiblePages_ ] ]
                                        [ Box.position <|
                                            Position.relative <|
                                                [ Position.right <|
                                                    percentage <|
                                                        getMaybeTransitionValue <|
                                                            history.transition
                                                ]
                                        ]
                                ]
                            ]
                            (List.map (pageView insidePageView_ history.transition data) visiblePages_)


{-| maybe transition subscription
-}
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


{-| handle model's history update using historyMsg
-}
handleStandardHistory : StandardHistoryMsg -> { a | history : History route } -> ( { a | history : History route }, Cmd msg )
handleStandardHistory historyMsg model =
    ( { model | history = standardHandleHistory historyMsg model.history }, Cmd.none )


{-| initialize history and data based on the routing system
-}
initHistoryAndData : route -> data -> { history : History route, data : data }
initHistoryAndData route data =
    { history = initHistory route
    , data = data
    }


headerButtonStyle width align =
    Display.flexChild
        [ Display.basis width
        ]
        [ Display.overflow
            [ Display.Overflow.overflowXY Display.Overflow.hidden ]
        , Display.textOverflowEllipsis
        , align
        ]
        [ Box.cursor Cursor.pointer
        , Box.typography
            [ Typography.character
                [ Typography.Character.size (Elegant.px 12) ]
            ]
        ]


headerButtonStyleLeft : Display.DisplayBox
headerButtonStyleLeft =
    headerButtonStyle (percent 30) (Display.alignment Display.left)


headerButtonStyleCenter : Display.DisplayBox
headerButtonStyleCenter =
    headerButtonStyle (percent 40) Display.alignCenter


headerButtonStyleRight : Display.DisplayBox
headerButtonStyleRight =
    headerButtonStyle (percent 30) (Display.alignment Display.right)


{-| display header
-}
headerElement :
    { a | center : Node msg, left : Node msg, right : Node msg }
    -> Node msg
headerElement { left, center, right } =
    div
        [ style
            [ Elegant.style <|
                Display.block
                    [ Display.dimensions [ Display.width <| percent 100 ] ]
                    [ Box.position <| Position.sticky [] ]
            ]
        ]
        [ div
            [ style
                [ Elegant.style <|
                    Display.blockFlexContainer
                        [ Display.direction Display.row ]
                        [ Display.dimensions [ Display.width (percent 100) ] ]
                        []
                ]
            ]
            [ div [ style [ Elegant.style <| headerButtonStyleLeft ] ] [ left ]
            , div [ style [ Elegant.style <| headerButtonStyleCenter ] ] [ center ]
            , div [ style [ Elegant.style <| headerButtonStyleRight ] ] [ right ]
            ]
        ]


{-| display button
-}
headerButton : msg -> String -> Node msg
headerButton msg content =
    div
        [ onClick <| msg
        , style [ Elegant.style <| Display.block [] [ Box.padding [ Padding.all (Elegant.px 12) ] ] ]
        ]
        [ text content
        ]
