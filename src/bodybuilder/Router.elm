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
        , pageWithHeader
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
@docs pageWithHeader
@docs headerButton
@docs historyView

-}

import BodyBuilder exposing (..)
import BodyBuilder.Attributes as Attributes exposing (..)
import BodyBuilder.Events exposing (..)
import Elegant exposing (SizeUnit, px, percent)
import AnimationFrame
import Time exposing (Time)
import Display
import Display.Overflow as Overflow
import Box
import BoxShadow
import Position
import Typography
import Padding
import Cursor
import Typography.Character
import Color
import Flex
import Dimensions
import Block
import Style


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
    percent <| toFloat <| round <| 100 * a



-- Heavily reduces the number of generated classes...


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


overflowHiddenContainer attributes content =
    flex
        ([ style
            [ Style.block
                [ Display.overflow
                    [ Overflow.overflowXY Overflow.hidden ]
                ]
            ]
         ]
            ++ attributes
        )
        content


pageView :
    (a -> b -> Maybe Transition -> Node msg)
    -> Maybe Transition
    -> b
    -> a
    -> Node msg
pageView insidePageView_ transition data page =
    node
        [ Attributes.style
            [ Style.block
                [ Display.dimensions [ Dimensions.width (percent 100) ] ]
            , Style.box
                [ Box.boxShadow
                    [ BoxShadow.standard (px 1) (Color.rgba 1 1 1 0.5) ( px 2, px 2 )
                    ]
                ]
            ]

        -- , Elegant.boxShadowCenteredBlurry (Px 5) (Color.grayscale <| abs <| getMaybeTransitionValue <| transition)
        ]
        [ insidePageView_ page data transition ]


{-|
-}
pageWithHeader : Node msg -> Node msg -> Node msg
pageWithHeader header page =
    flex
        [ style
            [ Style.flexContainerProperties [ Flex.direction Flex.column ]
            , Style.block [ Display.dimensions [ Dimensions.height (Elegant.vh 100) ] ]
            , Style.box [ Box.background [ Elegant.color Color.white ] ]
            ]
        ]
        [ flexItem [] [ header ]
        , flexItem [] [ mainElement page ]
        ]


{-|
-}
mainElement : Node msg -> Node msg
mainElement html =
    node
        [ style
            [ Style.block
                [ Display.overflow [ Overflow.overflowY Overflow.scroll ]
                , Display.fullWidth
                ]
            ]
        ]
        [ html
        ]


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
                overflowHiddenContainer []
                    [ flexItem
                        [ Attributes.style [ Style.flexItemProperties [ Flex.basis (percent 100) ] ] ]
                        [ pageView insidePageView_ Nothing data history.current ]
                    ]

            Just transition ->
                case transition.kind of
                    SlideUp ->
                        overflowHiddenContainer []
                            [ flexItem
                                [ style
                                    [ Style.block []
                                    , Style.flexItemProperties [ Flex.basis (percent 100) ]
                                    ]
                                ]
                                (List.map (pageView insidePageView_ history.transition data) (history |> beforeTransition))
                            , flexItem
                                [ style
                                    [ Style.block [ Display.dimensions [ Dimensions.width (percent 100) ] ]
                                    , Style.flexItemProperties [ Flex.basis (percent 100) ]
                                    , Style.box
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
                                [ Style.block
                                    [ Display.dimensions [ Dimensions.width <| percentage <| toFloat <| List.length <| visiblePages_ ] ]
                                , Style.box
                                    [ Box.position
                                        (Position.relative
                                            ([ Position.right (percentage (getMaybeTransitionValue history.transition)) ])
                                        )
                                    ]
                                ]
                            ]
                            (List.map
                                (BodyBuilder.flexItem
                                    [ Attributes.style
                                        [ Style.flexItemProperties
                                            [ Flex.basis (percent 100)
                                            ]
                                        ]
                                    ]
                                    << List.singleton
                                )
                                (List.map (pageView insidePageView_ history.transition data) visiblePages_)
                            )


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
    Attributes.style
        [ Style.flexItemProperties [ Flex.basis width ]
        , Style.block
            [ Display.overflow
                [ Overflow.overflowXY Overflow.hidden ]
            , Display.textOverflowEllipsis
            , align
            ]
        , Style.box
            [ Box.cursor Cursor.pointer
            , Box.typography
                [ Typography.character
                    [ Typography.Character.size (Elegant.px 12) ]
                ]
            ]
        ]


headerButtonStyleLeft =
    headerButtonStyle (percent 30) (Display.alignment Display.left)


headerButtonStyleCenter =
    headerButtonStyle (percent 40) Block.alignCenter


headerButtonStyleRight =
    headerButtonStyle (percent 30) (Display.alignment Display.right)


{-| display header
-}
headerElement :
    { a | center : Node msg, left : Node msg, right : Node msg }
    -> Node msg
headerElement { left, center, right } =
    node
        [ style
            [ Style.block
                [ Display.dimensions [ Dimensions.width <| percent 100 ] ]
            , Style.box
                [ Box.position <| Position.sticky []
                , Box.background [ Elegant.color Color.white ]
                ]
            ]
        ]
        [ flex
            [ style
                [ Style.block [ Display.dimensions [ Dimensions.width (percent 100) ] ]
                , Style.flexContainerProperties [ Flex.direction Flex.row ]
                ]
            ]
            [ flexItem [ headerButtonStyleLeft ] [ left ]
            , flexItem [ headerButtonStyleCenter ] [ center ]
            , flexItem [ headerButtonStyleRight ] [ right ]
            ]
        ]


{-| display button
-}
headerButton : msg -> String -> Node msg
headerButton msg content =
    node
        [ onClick <| msg
        , style [ Style.block [], Style.box [ Box.padding [ Padding.all (Elegant.px 12) ] ] ]
        ]
        [ text content
        ]
