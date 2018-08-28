module BodyBuilder.Router exposing
    ( History
    , StandardHistoryMsg(..)
    , Page
    , Transition
    , PageView
    , handleStandardHistory
    , maybeTransitionSubscription
    , initHistory
    , initHistoryAndData
    , push
    , slideUp
    , forward
    , pageWithDefaultTransition
    , pageWithTransition
    , pageWithoutTransition
    , customTransition
    , easeInOut
    , customKind
    , overflowHiddenContainer
    , pageView
    , beforeTransition
    , percentage
    , getMaybeTransitionValue
    , afterTransition
    , visiblePages
    , focusedElement
    , headerElement
    , pageWithHeader
    , headerButton
    , historyView
    , mobileMeta
    )

{-| Router based on BodyBuilder and Elegant implementing transitions between
pages and history (backward and forward)

@docs History
@docs StandardHistoryMsg
@docs Page
@docs Transition
@docs PageView

@docs handleStandardHistory
@docs maybeTransitionSubscription
@docs initHistory
@docs initHistoryAndData
@docs push
@docs slideUp
@docs forward
@docs pageWithDefaultTransition
@docs pageWithTransition
@docs pageWithoutTransition
@docs customTransition
@docs easeInOut
@docs customKind
@docs overflowHiddenContainer
@docs pageView
@docs beforeTransition
@docs percentage
@docs getMaybeTransitionValue
@docs afterTransition
@docs visiblePages
@docs focusedElement

@docs headerElement
@docs pageWithHeader
@docs headerButton
@docs historyView

-}

-- import Native.BodyBuilder
-- import Dom

import BodyBuilder exposing (..)
import BodyBuilder.Attributes as Attributes exposing (..)
import BodyBuilder.Events exposing (..)
import BodyBuilder.Style as Style
import Browser
import Browser.Dom
import Browser.Events
import Color
import Elegant exposing (SizeUnit, percent, px)
import Elegant.Block as Block
import Elegant.Box as Box
import Elegant.Cursor as Cursor
import Elegant.Dimensions as Dimensions
import Elegant.Display as Display
import Elegant.Flex as Flex
import Elegant.Overflow as Overflow
import Elegant.Padding as Padding
import Elegant.Position as Position
import Elegant.Transform as Transform
import Elegant.Typography as Typography
import Html
import Html.Attributes
import Modifiers exposing (..)
import Task


type Easing
    = EaseInOut
    | Linear


type Kind route msg
    = CustomKind
        (History route msg
         -> (Page route msg -> Maybe (Transition route msg) -> NodeWithStyle msg)
         -> NodeWithStyle msg
        )


{-| -}
customKind : (History route msg -> (Page route msg -> Maybe (Transition route msg) -> NodeWithStyle msg) -> NodeWithStyle msg) -> Kind route msg
customKind =
    CustomKind


{-| Transition between 2 pages
-}
type alias Transition route msg =
    { timer : Float
    , length : Float
    , kind : Kind route msg
    , direction : Direction
    , easing : Easing
    }


{-| Page type handling transition
-}
type alias Page route msg =
    { maybeFocusedId : Maybe String
    , maybeTransition : Maybe (Transition route msg)
    , route : route
    }


{-| Generic History type handling current page, before pages, after pages
and current transition
-}
type alias History route msg =
    { before : List (Page route msg)
    , current : Page route msg
    , after : List (Page route msg)
    , transition : Maybe (Transition route msg)
    , currentPageHasFocusElement : Bool
    , standardHistoryWrapper : StandardHistoryMsg -> msg
    }


type TransitionWrapper route msg
    = InProgress (Transition route msg)
    | Finished
    | NoTransition


{-| -}
type alias PageView route msg =
    Page route msg
    -> Maybe (Transition route msg)
    -> NodeWithStyle msg


type Direction
    = Forward
    | Backward


{-| -}
forward : Direction
forward =
    Forward


{-| -}
easeInOut : Easing
easeInOut =
    EaseInOut


{-| Standard History Messages type :
Tick to handle transitions with RequestAnimationFrame
Back to handle back buttons
-}
type StandardHistoryMsg
    = Tick Float
    | Back
    | FocusMsg (Result Browser.Dom.Error ())


easingFun : Easing -> Float -> Float
easingFun easing =
    case easing of
        EaseInOut ->
            easeInOutFun

        Linear ->
            identity


easeInOutFun : Float -> Float
easeInOutFun t =
    if t < 0.5 then
        2 * t * t

    else
        -1 + (4 - 2 * t) * t


{-| -}
getMaybeTransitionValue : Maybe (Transition route msg) -> Float
getMaybeTransitionValue maybeTransition =
    case maybeTransition of
        Nothing ->
            0

        Just transition ->
            transition |> getTransitionValue


getTransitionValue : Transition route msg -> Float
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


isRunning : Maybe (Transition route msg) -> Bool
isRunning transition_ =
    case transition_ of
        Nothing ->
            False

        Just transition__ ->
            transition__.timer > 0


timeDiff : Float -> Transition route msg -> Transition route msg
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


{-| -}
customTransition : Float -> Kind route msg -> Direction -> Easing -> Transition route msg
customTransition duration =
    Transition duration duration


{-| push a page into history
-}
push : Page route msg -> History route msg -> History route msg
push el ({ transition, before, current, after } as history) =
    if isRunning transition then
        history

    else
        { history
            | before = current :: before
            , current = el
            , after = []
            , transition = el.maybeTransition
            , currentPageHasFocusElement = Maybe.withDefault False (Maybe.map (always True) el.maybeFocusedId)
        }


oppositeDirection : Direction -> Direction
oppositeDirection direction =
    case direction of
        Backward ->
            Forward

        Forward ->
            Backward


opposite : Maybe (Transition route msg) -> Maybe (Transition route msg)
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


defaultTransition : Maybe (Transition route msg)
defaultTransition =
    Just <| customTransition basicDuration (customKind slideLeftView) Forward EaseInOut


pageWithoutIdToFocusOn : Maybe (Transition route msg) -> route -> Page route msg
pageWithoutIdToFocusOn =
    Page Nothing


{-| creates a page with the defaultTransition
-}
pageWithDefaultTransition : route -> Page route msg
pageWithDefaultTransition =
    pageWithoutIdToFocusOn defaultTransition


{-| creates a page without any transition
-}
pageWithoutTransition : route -> Page route msg
pageWithoutTransition =
    pageWithoutIdToFocusOn Nothing


{-| creates a page with a custom transition
-}
pageWithTransition : Transition route msg -> route -> Page route msg
pageWithTransition transition =
    pageWithoutIdToFocusOn (Just transition)


{-| -}
focusedElement : String -> Page route msg -> Page route msg
focusedElement idElement page =
    { page | maybeFocusedId = Just idElement }


pull : History route msg -> History route msg
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
slideUp : Transition route msg
slideUp =
    customTransition basicDuration (customKind slideUpView) Forward EaseInOut


putHeadInListIfExists : List a -> List a
putHeadInListIfExists list =
    case list of
        [] ->
            []

        head :: _ ->
            [ head ]


{-| -}
visiblePages : History route msg -> List (Page route msg)
visiblePages history =
    case history.transition of
        Nothing ->
            [ history.current ]

        Just transition_ ->
            case transition_.direction of
                Forward ->
                    putHeadInListIfExists history.before ++ [ history.current ]

                Backward ->
                    history.current :: putHeadInListIfExists history.after


{-| -}
percentage : Float -> Float
percentage a =
    toFloat <| round <| 100 * a



-- Heavily reduces the number of generated classes...


{-| -}
beforeTransition : History route msg -> List (Page route msg)
beforeTransition history =
    case history.transition of
        Nothing ->
            []

        Just transition ->
            if transition.direction == Backward then
                [ history.current ]

            else
                putHeadInListIfExists history.before


{-| -}
afterTransition : History route msg -> List (Page route msg)
afterTransition history =
    case history.transition of
        Nothing ->
            []

        Just transition ->
            if transition.direction == Backward then
                putHeadInListIfExists history.after

            else
                [ history.current ]


{-| -}
overflowHiddenContainer :
    Modifiers (Attributes.FlexContainerAttributes msg)
    -> List (FlexItem msg)
    -> NodeWithStyle msg
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


{-| -}
pageView :
    (a -> Maybe (Transition route msg) -> NodeWithStyle msg)
    -> Maybe (Transition route msg)
    -> a
    -> NodeWithStyle msg
pageView insidePageView_ transition page =
    node
        [ Attributes.style
            [ Style.block
                [ Display.dimensions [ Dimensions.width (percent 100) ] ]
            ]
        ]
        [ insidePageView_ page transition ]


{-| -}
pageWithHeader : NodeWithStyle msg -> NodeWithStyle msg -> NodeWithStyle msg
pageWithHeader header page =
    flex
        [ style
            [ Style.flexContainerProperties [ Flex.direction Flex.column ]
            , Style.block [ Display.dimensions [ Dimensions.width (Elegant.percent 100) ] ]
            , Style.box [ Box.background [ Elegant.color Color.white ] ]
            ]
        ]
        [ flexItem [] [ header ]
        , flexItem [] [ mainElement page ]
        ]


{-| -}
mainElement : NodeWithStyle msg -> NodeWithStyle msg
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


slideUpView : History route msg -> PageView route msg -> NodeWithStyle msg
slideUpView history insidePageView_ =
    let
        visiblePages_ =
            visiblePages history
    in
    overflowHiddenContainer
        [ style
            [ Style.block
                [ Display.dimensions [ Dimensions.height <| Elegant.vh <| percentage <| toFloat <| List.length <| visiblePages_ ] ]
            , Style.box
                [ Box.transform
                    [ Transform.translateY (Elegant.vh <| percentage (0 - getMaybeTransitionValue history.transition))
                    ]
                ]
            , Style.flexContainerProperties [ Flex.direction Flex.column ]
            ]
        ]
        [ flexItem
            [ style
                [ Style.block [ Display.dimensions [ Dimensions.height (Elegant.vh 100), Dimensions.width (Elegant.vw 100) ] ]
                , Style.flexItemProperties [ Flex.basis (percent 100) ]
                ]
            ]
            (List.map (pageView insidePageView_ history.transition) (history |> beforeTransition))
        , flexItem
            [ style
                [ Style.block [ Display.dimensions [ Dimensions.height (Elegant.vh 100), Dimensions.width (Elegant.vw 100) ] ]
                , Style.flexItemProperties [ Flex.basis (percent 100) ]
                ]
            ]
            (List.map (pageView insidePageView_ history.transition) (history |> afterTransition))
        ]


slideLeftView :
    History route msg
    -> PageView route msg
    -> NodeWithStyle msg
slideLeftView history insidePageView_ =
    let
        visiblePages_ =
            visiblePages history
    in
    overflowHiddenContainer
        [ style
            [ Style.block
                [ Display.dimensions [ Dimensions.width <| Elegant.vw <| percentage <| toFloat <| List.length <| visiblePages_ ] ]
            , Style.box
                [ Box.transform
                    [ Transform.translateX (Elegant.vw <| percentage (0 - getMaybeTransitionValue history.transition))
                    ]
                , Box.willChange [ "transform" ]

                -- , Box.position
                -- (Position.relative
                --     ([ Position.right (percentage (getMaybeTransitionValue history.transition)) ])
                -- )
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
            (List.map (pageView insidePageView_ history.transition) visiblePages_)
        )


{-| display the current possible transition from one page to the other using
the history and its own routing system
-}
historyView :
    (Page route msg -> Maybe (Transition route msg) -> NodeWithStyle msg)
    -> History route msg
    -> NodeWithStyle msg
historyView insidePageView_ history =
    div []
        [ ( Html.node "style" [] [ Html.text "body {margin: 0px}\n*{box-sizing: border-box;}" ], [] )
        , mobileMeta
        , case history.transition of
            Nothing ->
                overflowHiddenContainer []
                    [ flexItem
                        [ Attributes.style [ Style.flexItemProperties [ Flex.basis (percent 100) ] ] ]
                        [ pageView insidePageView_ Nothing history.current ]
                    ]

            Just transition ->
                case transition.kind of
                    CustomKind view_ ->
                        view_ history insidePageView_
        ]


{-| maybe transition subscription
-}
maybeTransitionSubscription : History route msg -> Sub msg
maybeTransitionSubscription history =
    history.transition
        |> Maybe.map (\transition_ -> Browser.Events.onAnimationFrameDelta (history.standardHistoryWrapper << Tick))
        |> Maybe.withDefault Sub.none


{-| Init your history.
-}
initHistory : route -> (StandardHistoryMsg -> msg) -> History route msg
initHistory currentPage standardHistoryMsg =
    { before = []
    , current = pageWithoutTransition currentPage
    , after = []
    , transition = Nothing
    , currentPageHasFocusElement = False
    , standardHistoryWrapper = standardHistoryMsg
    }


updateIdentity : model -> ( model, Cmd msg )
updateIdentity model =
    ( model, Cmd.none )


standardHandleHistory : StandardHistoryMsg -> History route msg -> ( History route msg, Cmd msg )
standardHandleHistory historyMsg history =
    case historyMsg of
        Back ->
            history
                |> pull
                |> updateIdentity

        FocusMsg result ->
            updateIdentity <|
                history

        Tick diff ->
            case history.transition of
                Nothing ->
                    ( history, Cmd.none )

                Just transition ->
                    let
                        newTransition =
                            transition |> timeDiff diff
                    in
                    if newTransition.timer > 0 then
                        ( { history | transition = Just newTransition }, Cmd.none )

                    else
                        ( { history | transition = Nothing }
                        , case history.currentPageHasFocusElement of
                            False ->
                                Cmd.none

                            True ->
                                case history.current.maybeFocusedId of
                                    Nothing ->
                                        Cmd.none

                                    Just maybeFocusedId_ ->
                                        Task.attempt
                                            (FocusMsg >> history.standardHistoryWrapper)
                                            (Browser.Dom.focus maybeFocusedId_)
                        )


{-| handle model's history update using historyMsg
-}
handleStandardHistory : StandardHistoryMsg -> { a | history : History route msg } -> ( { a | history : History route msg }, Cmd msg )
handleStandardHistory historyMsg model =
    model.history
        |> standardHandleHistory historyMsg
        |> (\( history_, cmds ) -> ( { model | history = history_ }, cmds ))


{-| initialize history and data based on the routing system
-}
initHistoryAndData : route -> data -> (StandardHistoryMsg -> msg) -> { history : History route msg, data : data }
initHistoryAndData route data standardHistoryWrapper =
    { history = initHistory route standardHistoryWrapper
    , data = data
    }


headerButtonStyle :
    SizeUnit
    -> Modifier Display.BlockDetails
    -> Modifier (Attributes.FlexItemAttributes msg)
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
                [ Typography.size (Elegant.px 12) ]
            ]
        ]


headerButtonStyleLeft : Modifier (Attributes.FlexItemAttributes msg)
headerButtonStyleLeft =
    headerButtonStyle (percent 30) (Display.alignment Display.left)


headerButtonStyleCenter : Modifier (FlexItemAttributes msg)
headerButtonStyleCenter =
    headerButtonStyle (percent 40) Block.alignCenter


headerButtonStyleRight : Modifier (FlexItemAttributes msg)
headerButtonStyleRight =
    headerButtonStyle (percent 30) (Display.alignment Display.right)


{-| display header
-}
headerElement :
    { a | center : NodeWithStyle msg, left : NodeWithStyle msg, right : NodeWithStyle msg }
    -> NodeWithStyle msg
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
headerButton : msg -> String -> NodeWithStyle msg
headerButton msg content =
    node
        [ onClick <| msg
        , style [ Style.block [], Style.box [ Box.padding [ Padding.all (Elegant.px 12) ] ] ]
        ]
        [ text content
        ]


mobileMeta =
    ( Html.node "meta"
        [ Html.Attributes.name "viewport"
        , Html.Attributes.attribute "content"
            "width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
        ]
        []
    , []
    )
