module Transition exposing (..)

{-| This code is something I always dreamt of being able to code with only html
    and styles. I thought it would have taken more time to create, but, in the
    end I did it. Elm was the way to go after all.
    It is heavily inspired by the way iOS works, but the code is original :)
    I wouldn't have been able to write that without Elm, BodyBuilder and Elegant.
-}

import BodyBuilder exposing (..)
import Elegant exposing (textCenter, padding, SizeUnit(..), fontSize)
import Elegant.Elements exposing (borderBottom)
import AnimationFrame
import Color
import Time exposing (Time)
import Date
import Date exposing (Month(..))
import Date.Extra as Date
import Json.Decode as Decode


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


maybeTransitionSubscription : Maybe Transition -> Sub Msg
maybeTransitionSubscription =
    Maybe.map (\transition -> AnimationFrame.diffs <| (StandardHistoryWrapper << Tick))
        >> Maybe.withDefault Sub.none


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


type Route
    = BlogpostsIndex
    | BlogpostsShow Int
    | BlogpostsShowImg String


type alias Data =
    { blogposts : List Blogpost
    , scrollEvent : ScrollEvent
    }


type alias Model =
    { history : History Route
    , data : Data
    }


type HistoryMsg
    = BlogpostShow Int
    | ShowImage String


type Msg
    = HistoryMsgWrapper HistoryMsg
    | StandardHistoryWrapper StandardHistoryMsg
    | Scroll ScrollEvent


type alias MarkdownString =
    String


type alias Blogpost =
    { id : Int
    , title : String
    , content : MarkdownString
    , publishedAt : Maybe Date.Date
    , image : String
    }


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


overflowHiddenContainer :
    List (FlowAttributes msg -> FlowAttributes msg)
    -> List (Node interactiveContent phrasingContent Spanning NotListElement msg)
    -> Node interactiveContent phrasingContent Spanning NotListElement msg
overflowHiddenContainer attributes content =
    div [ style [ Elegant.overflowHidden ] ]
        [ div attributes content ]


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


historySubscriptions : History route -> Sub Msg
historySubscriptions history =
    maybeTransitionSubscription history.transition


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



--- Custom


handleHistory : HistoryMsg -> History Route -> History Route
handleHistory val history =
    case val of
        BlogpostShow val ->
            history |> push (pageWithDefaultTransition (BlogpostsShow val))

        ShowImage image ->
            history |> push (pageWithDefaultTransition (BlogpostsShowImg image))


gray : Color.Color
gray =
    Color.grayscale 0.9


titleView : Blogpost -> Node Interactive phrasingContent Spanning NotListElement Msg
titleView blogpost =
    button
        [ onClick <| HistoryMsgWrapper <| BlogpostShow blogpost.id
        , style
            [ Elegant.cursorPointer
            , Elegant.borderNone
            , borderBottom gray
            , Elegant.outlineNone
            , Elegant.textLeft
            , Elegant.fontFamilyInherit
            , Elegant.fontSize Elegant.zeta
            , Elegant.padding Elegant.large
            , Elegant.backgroundColor Color.white
            , Elegant.fullWidth
            ]
        , focusStyle [ Elegant.backgroundColor <| Color.grayscale 0.05 ]
        ]
        [ text blogpost.title ]


header : Node interactiveContent phrasingContent Spanning NotListElement Msg
header =
    div [ style [ Elegant.displayFlex, Elegant.flexDirectionRow, Elegant.fullWidth ] ]
        [ div
            [ onClick <| StandardHistoryWrapper Back
            , style
                [ Elegant.backgroundColor Color.white
                , Elegant.textColor Color.black
                , Elegant.padding Elegant.medium
                , Elegant.cursorPointer
                , Elegant.fontSize (Px 12)
                , Elegant.whiteSpaceNoWrap
                , Elegant.overflowHidden
                , Elegant.width (Percent 30)
                , Elegant.textOverflowEllipsis
                , Elegant.positionFixed
                , Elegant.fullWidth
                ]
            ]
            [ text "← BACK"
            ]
        , div
            [ onClick <| StandardHistoryWrapper Back
            , style
                [ Elegant.backgroundColor Color.white
                , Elegant.textColor Color.black
                , Elegant.padding Elegant.medium
                , Elegant.cursorPointer
                , Elegant.fontSize (Px 12)
                , Elegant.textCenter
                , Elegant.width (Percent 40)
                ]
            ]
            [ text "TRAAAVEL"
            ]
        , div
            [ onClick <| StandardHistoryWrapper Back
            , style
                [ Elegant.backgroundColor Color.white
                , Elegant.textColor Color.black
                , Elegant.padding Elegant.medium
                , Elegant.cursorPointer
                , Elegant.fontSize (Px 12)
                , Elegant.textCenter
                , Elegant.width (Percent 30)
                ]
            ]
            [ text ""
            ]
        ]


onScroll : (ScrollEvent -> value) -> OnEvent value a -> OnEvent value a
onScroll tagger =
    on "scroll" (Decode.map tagger onScrollJsonParser)


onScrollJsonParser : Decode.Decoder ScrollEvent
onScrollJsonParser =
    Decode.map3 ScrollEvent
        (Decode.at [ "target", "scrollHeight" ] Decode.int)
        (Decode.at [ "target", "scrollTop" ] Decode.int)
        (Decode.at [ "target", "clientHeight" ] Decode.int)


showView :
    (a -> Node interactiveContent phrasingContent Spanning NotListElement Msg)
    -> a
    -> Node interactiveContent phrasingContent Spanning NotListElement Msg
showView bodyFun data =
    div
        [ style
            [ Elegant.backgroundColor Color.white
            , Elegant.height (Vh 100)
            , Elegant.displayFlex
            , Elegant.flexDirectionColumn
            ]
        ]
        [ header
        , div
            [ style
                [ Elegant.overflowYScroll
                , Elegant.fullWidth
                , Elegant.flexShrink 1000000
                ]
            , onScroll Scroll
            ]
            [ bodyFun data
            ]
        ]


textToHtml : String -> List (Node interactiveContent Phrasing spanningContent NotListElement msg)
textToHtml =
    (>>)
        (String.split "\n")
        (List.foldl (\e accu -> accu ++ [ text e, br [] ]) [])


verticalParallax speed scrollEvent el =
    let
        toto =
            Basics.max ((scrollEvent.scrollPos |> toFloat) * speed |> round) 0
    in
        div [ style [ Elegant.positionAbsolute ] ]
            [ div [ style [ Elegant.marginTop (Px -toto) ] ] []
            , el
            , div
                [ style [ Elegant.marginTop (Px toto) ] ]
                []
            ]


blogpostBodyView : { b | maybeBlogpost : Maybe Blogpost, scrollEvent : ScrollEvent } -> Node interactiveContent Phrasing Spanning NotListElement msg
blogpostBodyView data =
    case data.maybeBlogpost of
        Nothing ->
            text ""

        Just blogpost ->
            div []
                ([ img ""
                    blogpost.image
                    [ style [ Elegant.fullWidth ] ]

                 --  , text (data.scrollEvent |> toString)
                 , (verticalParallax 1.5
                        data.scrollEvent
                        (div [ style [ Elegant.padding Elegant.medium ] ]
                            (textToHtml blogpost.content)
                        )
                   )
                 , (verticalParallax 1.2
                        data.scrollEvent
                        (div [ style [ Elegant.padding Elegant.medium ] ]
                            (textToHtml blogpost.content)
                        )
                   )

                 --  , div [ style [ Elegant.marginBottom (Px ((data.scrollEvent.scrollPos |> toFloat) * 1.5 |> round)) ] ] []
                 --  , div [ style [ Elegant.height (Px (Basics.max (100 - data.scrollEvent.scrollPos) 0)) ] ] []
                 ]
                )


blogpostsIndex :
    List Blogpost
    -> Node Interactive phrasingContent Spanning NotListElement Msg
blogpostsIndex blogposts =
    div [ style [ Elegant.backgroundColor gray, Elegant.height (Vh 100) ] ]
        (blogposts |> List.map titleView)


find_by : (a -> b) -> b -> List a -> Maybe a
find_by insideDataFun data =
    List.filter (\e -> insideDataFun e == data)
        >> List.head


type alias ScrollEvent =
    { scrollHeight : Int
    , scrollPos : Int
    , visibleHeight : Int
    }


visiblePortion : ScrollEvent -> Float
visiblePortion { scrollPos, scrollHeight, visibleHeight } =
    (scrollPos |> toFloat) / ((scrollHeight - visibleHeight) |> toFloat)


blogpostsShow : Int -> List Blogpost -> ScrollEvent -> Node interactiveContent Phrasing Spanning NotListElement Msg
blogpostsShow id blogposts scrollEvent =
    div [] [ showView blogpostBodyView { maybeBlogpost = (blogposts |> find_by .id id), scrollEvent = scrollEvent } ]


blogpostsShowImg : String -> Node interactiveContent phrasingContent Spanning NotListElement Msg
blogpostsShowImg src =
    div
        []
        [ header
        , img "" src [ style [ Elegant.fullWidth ] ]
        ]


insidePageView : Page Route -> Data -> Node Interactive Phrasing Spanning NotListElement Msg
insidePageView page data =
    let
        blogposts =
            data.blogposts
    in
        case page.route of
            BlogpostsIndex ->
                blogpostsIndex blogposts

            BlogpostsShow id ->
                blogpostsShow id blogposts data.scrollEvent

            BlogpostsShowImg src ->
                blogpostsShowImg src


view : Model -> Node Interactive Phrasing Spanning NotListElement Msg
view { history, data } =
    div [ style [ Elegant.fontFamilySansSerif, Elegant.fontSize Elegant.zeta ] ]
        [ historyView insidePageView history data ]


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        HistoryMsgWrapper historyMsg ->
            ( { model | history = handleHistory historyMsg model.history }, Cmd.none )

        StandardHistoryWrapper historyMsg ->
            model |> handleStandardHistory historyMsg

        Scroll scrollEvent ->
            let
                data =
                    model.data

                newData =
                    { data | scrollEvent = scrollEvent }
            in
                ( { model | data = newData }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    historySubscriptions model.history


initBlogposts : List Blogpost
initBlogposts =
    [ { id = 1
      , title = "La cigale et la fourmi"
      , publishedAt = Just <| Date.fromCalendarDate 2017 Aug 10
      , content = "La Cigale, ayant chanté\nTout l'Été,\nSe trouva fort dépourvue\nQuand la bise fut venue.\nPas un seul petit morceau\nDe mouche ou de vermisseau.\nElle alla crier famine\nChez la Fourmi sa voisine,\nLa priant de lui prêter\nQuelque grain pour subsister\nJusqu'à la saison nouvelle.\nJe vous paierai, lui dit-elle,\nAvant l'Oût, foi d'animal,\nIntérêt et principal.\nLa Fourmi n'est pas prêteuse ;\nC'est là son moindre défaut.\n« Que faisiez-vous au temps chaud ?\nDit-elle à cette emprunteuse.\n— Nuit et jour à tout venant\nJe chantais, ne vous déplaise.\n— Vous chantiez ? j'en suis fort aise.\nEh bien !dansez maintenant. »\n"
      , image = "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Snodgrass_Magicicada_septendecim.jpg/1024px-Snodgrass_Magicicada_septendecim.jpg"
      }
    , { id = 2
      , title = "Le corbeau et le renard"
      , content = "Maître Corbeau, sur un arbre perché,\nTenait en son bec un fromage.\nMaître Renard, par l'odeur alléché,\nLui tint à peu près ce langage :\nEt bonjour, Monsieur du Corbeau.\nQue vous êtes joli ! que vous me semblez beau !\nSans mentir, si votre ramage\nSe rapporte à votre plumage,\nVous êtes le Phénix des hôtes de ces bois.\nÀ ces mots, le Corbeau ne se sent pas de joie ;\nEt pour montrer sa belle voix,\nIl ouvre un large bec, laisse tomber sa proie.\nLe Renard s'en saisit, et dit : Mon bon Monsieur,\nApprenez que tout flatteur\nVit aux dépens de celui qui l'écoute.\nCette leçon vaut bien un fromage, sans doute.\nLe Corbeau honteux et confus\nJura, mais un peu tard, qu'on ne l'y prendrait plus."
      , publishedAt = Just <| Date.fromCalendarDate 2017 Aug 10
      , image = "https://upload.wikimedia.org/wikipedia/commons/4/47/Karga_9107.svg"
      }
    ]


initData : Data
initData =
    { blogposts = initBlogposts, scrollEvent = (ScrollEvent 0 0 0) }


init : { data : Data, history : History Route }
init =
    initHistoryAndData (BlogpostsShow 1) initData


main : Program Basics.Never Model Msg
main =
    program
        { init = ( init, Cmd.none )
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
