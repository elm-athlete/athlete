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


type alias History =
    { before : List Page
    , current : Page
    , after : List Page
    , transition : Maybe Transition
    }


type alias Model =
    { history : History
    , data : List Fable
    }


type Direction
    = Forward
    | Backward


type HistoryMsg
    = Enter Int
    | Back
    | Tick Time


type Msg
    = HistoryMsgWrapper HistoryMsg


type alias MarkdownString =
    String


type alias Fable =
    { id : Int
    , title : String
    , content : MarkdownString
    , image : String
    }


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
        ((easingFun easing) (timer / length))


isRunning : Maybe Transition -> Bool
isRunning transition =
    case transition of
        Nothing ->
            False

        Just transition ->
            transition.timer /= 0


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
maybeTransitionSubscription transition =
    case transition of
        Nothing ->
            Sub.none

        Just transition ->
            AnimationFrame.diffs (HistoryMsgWrapper << Tick)


basicDuration : number
basicDuration =
    250


customTransition : Float -> Direction -> Easing -> Transition
customTransition duration =
    Transition duration duration


push : Page -> History -> History
push el ({ transition, before, current, after } as history) =
    if isRunning transition then
        history
    else
        { history
            | before = current :: before
            , current = el
            , after = []
            , transition = Just (customTransition basicDuration Forward EaseInOut)
        }


pull : History -> History
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
                    , transition = Just (customTransition basicDuration Backward EaseInOut)
                }


handleHistory : HistoryMsg -> History -> History
handleHistory val history =
    case val of
        Enter val ->
            history |> push (Show val)

        Back ->
            history |> pull

        Tick diff ->
            (case history.transition of
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
            )


historySubscriptions : History -> Sub Msg
historySubscriptions history =
    maybeTransitionSubscription history.transition


initHistory : History
initHistory =
    { before = []
    , current = Index
    , after = []
    , transition = Nothing
    }


titleView : Fable -> Node interactiveContent phrasingContent Spanning NotListElement Msg
titleView fable =
    div
        [ onClick (HistoryMsgWrapper (Enter fable.id))
        , style
            [ Elegant.cursorPointer
            , borderBottom gray
            , Elegant.padding Elegant.large
            , Elegant.backgroundColor Color.white
            ]
        ]
        [ text fable.title ]


header : Node interactiveContent phrasingContent Spanning NotListElement Msg
header =
    div
        [ onClick (HistoryMsgWrapper Back)
        , style
            [ Elegant.backgroundColor Color.white
            , Elegant.textColor Color.black
            , Elegant.padding Elegant.medium
            , Elegant.cursorPointer
            ]
        ]
        [ text "< back"
        ]


gray : Color.Color
gray =
    Color.rgba 0 0 0 0.5


body :
    (a -> Node interactiveContent phrasingContent Spanning NotListElement msg)
    -> a
    -> Node interactiveContent phrasingContent Spanning NotListElement msg
body bodyFun data =
    div
        [ style
            [ Elegant.overflowYScroll
            , Elegant.fullWidth
            ]
        ]
        [ bodyFun data
        ]


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
        , body bodyFun data
        ]


fableContentView : String -> List (Node interactiveContent Phrasing spanningContent NotListElement msg)
fableContentView =
    (>>)
        (String.split "\n")
        (List.foldl (\e accu -> accu ++ [ text e, br [] ]) [])


fableBodyView : Fable -> Node interactiveContent Phrasing Spanning NotListElement msg
fableBodyView { image, content } =
    div []
        [ img "" image [ style [ Elegant.fullWidth ] ]
        , div [ style [ Elegant.padding Elegant.medium ] ]
            (fableContentView content)
        ]


insidePageView : Page -> List Fable -> Node interactiveContent Phrasing Spanning NotListElement Msg
insidePageView page fables =
    case page of
        Index ->
            div [ style [ Elegant.backgroundColor gray, Elegant.height (Vh 100) ] ]
                (fables |> List.map titleView)

        Show val ->
            div []
                (fables
                    |> List.filter (\e -> e.id == val)
                    |> List.map (showView fableBodyView)
                )


pageView sizeUntilNow beforeSize transition page current fables =
    let
        boxShadowIfRunning =
            if isRunning transition then
                [ Elegant.boxShadowCenteredBlurry (Px 5) Color.black ]
            else
                []
    in
        [ div
            [ style ([ Elegant.fullWidth ] ++ boxShadowIfRunning) ]
            [ insidePageView page fables ]
        ]


tableView :
    History
    -> List Fable
    -> Node interactiveContent Phrasing Spanning NotListElement Msg
tableView history fables =
    let
        total =
            history.before ++ [ history.current ] ++ history.after

        totalSize =
            total |> List.length |> toFloat

        beforeSize =
            history.before |> List.length |> toFloat
    in
        div [ style [ Elegant.overflowHidden ] ]
            [ div
                [ style
                    [ Elegant.displayFlex
                    , Elegant.width
                        (Percent
                            (100
                                * (if history.transition |> isRunning then
                                    totalSize
                                   else
                                    1
                                  )
                            )
                        )
                    , Elegant.right
                        (Percent
                            (100
                                * ((if history.transition |> isRunning then
                                        beforeSize
                                    else
                                        0
                                   )
                                    + getMaybeTransitionValue history.transition
                                  )
                            )
                        )
                    , Elegant.positionRelative
                    ]
                ]
                (if history.transition |> isRunning then
                    (Tuple.second
                        (List.foldl
                            (\page ( sizeUntilNow, views ) ->
                                ( sizeUntilNow + 1
                                , views ++ (pageView sizeUntilNow beforeSize history.transition page history.current fables)
                                )
                            )
                            ( 0, [] )
                            total
                        )
                    )
                 else
                    pageView 0 0 history.transition history.current history.current fables
                )
            ]


view : Model -> Node interactiveContent Phrasing Spanning NotListElement Msg
view { history, data } =
    tableView history data


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        HistoryMsgWrapper historyMsg ->
            ( { model | history = handleHistory historyMsg model.history }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    historySubscriptions model.history


init : Model
init =
    { history = initHistory
    , data =
        [ { id = 1
          , title = "La cigale et la fourmi"
          , content = "La Cigale, ayant chanté\nTout l'Été,\nSe trouva fort dépourvue\nQuand la bise fut venue.\nPas un seul petit morceau\nDe mouche ou de vermisseau.\nElle alla crier famine\nChez la Fourmi sa voisine,\nLa priant de lui prêter\nQuelque grain pour subsister\nJusqu'à la saison nouvelle.\nJe vous paierai, lui dit-elle,\nAvant l'Oût, foi d'animal,\nIntérêt et principal.\nLa Fourmi n'est pas prêteuse ;\nC'est là son moindre défaut.\n« Que faisiez-vous au temps chaud ?\nDit-elle à cette emprunteuse.\n— Nuit et jour à tout venant\nJe chantais, ne vous déplaise.\n— Vous chantiez ? j'en suis fort aise.\nEh bien !dansez maintenant. »\n"
          , image = "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Snodgrass_Magicicada_septendecim.jpg/1024px-Snodgrass_Magicicada_septendecim.jpg"
          }
        , { id = 2
          , title = "Le corbeau et le renard"
          , content = "Maître Corbeau, sur un arbre perché,\nTenait en son bec un fromage.\nMaître Renard, par l'odeur alléché,\nLui tint à peu près ce langage :\nEt bonjour, Monsieur du Corbeau.\nQue vous êtes joli ! que vous me semblez beau !\nSans mentir, si votre ramage\nSe rapporte à votre plumage,\nVous êtes le Phénix des hôtes de ces bois.\nÀ ces mots, le Corbeau ne se sent pas de joie ;\nEt pour montrer sa belle voix,\nIl ouvre un large bec, laisse tomber sa proie.\nLe Renard s'en saisit, et dit : Mon bon Monsieur,\nApprenez que tout flatteur\nVit aux dépens de celui qui l'écoute.\nCette leçon vaut bien un fromage, sans doute.\nLe Corbeau honteux et confus\nJura, mais un peu tard, qu'on ne l'y prendrait plus."
          , image = "https://upload.wikimedia.org/wikipedia/commons/4/47/Karga_9107.svg"
          }
        ]
    }


main : Program Basics.Never Model Msg
main =
    program
        { init = ( init, Cmd.none )
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
