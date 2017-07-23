module Transition exposing (..)

import BodyBuilder exposing (..)
import Elegant exposing (textCenter, padding, SizeUnit(..), fontSize)
import AnimationFrame
import Function exposing (..)
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
    , fables : List Fable
    }


type Direction
    = Forward
    | Backward


type Msg
    = Enter Int
    | Back
    | Tick Time


type alias MarkdownString =
    String


type alias Fable =
    { id : Int
    , title : String
    , content : MarkdownString
    , image : String
    }


titleView : Fable -> Node interactiveContent phrasingContent Spanning NotListElement Msg
titleView fable =
    div
        [ onClick (Enter fable.id)
        , style
            [ Elegant.cursorPointer
            , borderBottom
            , Elegant.padding Elegant.large
            , Elegant.backgroundColor Color.white
            ]
        ]
        [ text fable.title ]


showView fable =
    div [ style [ Elegant.backgroundColor Color.white, Elegant.height (Vh 100) ] ]
        [ div [ style [ Elegant.padding Elegant.medium ] ] [ div [ onClick Back, style [ Elegant.cursorPointer ] ] [ text "< back" ] ]
        , img "" fable.image [ style [ Elegant.fullWidth ] ]
        , div [ style [ Elegant.padding Elegant.medium ] ] ((fable.content |> String.split "\n" |> List.map (\e -> div [] [ text e ])))
        ]


insidePageView : Page -> List Fable -> Node interactiveContent phrasingContent Spanning NotListElement Msg
insidePageView page fables =
    case page of
        Index ->
            div [ style [ Elegant.backgroundColor Color.gray, Elegant.height (Vh 100) ] ]
                (fables |> List.map titleView)

        Show val ->
            div []
                (fables
                    |> List.filter (\e -> e.id == val)
                    |> List.map showView
                )


borderBottom =
    [ Elegant.borderBottomColor Color.black, Elegant.borderBottomWidth 1, Elegant.borderBottomSolid ] |> compose


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
        div [ style [ Elegant.overflowXHidden, Elegant.overflowYScroll ] ]
            [ div
                [ style
                    [ Elegant.displayFlex
                    , Elegant.width
                        (Percent
                            (100
                                * (if model.transition |> isRunning then
                                    totalSize
                                   else
                                    1
                                  )
                            )
                        )
                    , Elegant.right
                        (Percent
                            (100
                                * ((if model.transition |> isRunning then
                                        beforeSize
                                    else
                                        0
                                   )
                                    + getMaybeTransitionValue model.transition
                                  )
                            )
                        )
                    , Elegant.positionRelative
                    ]
                ]
                (if model.transition |> isRunning then
                    (Tuple.second
                        (List.foldl
                            (\page ( sizeUntilNow, views ) ->
                                ( sizeUntilNow + 1
                                , views ++ (pageView sizeUntilNow beforeSize model.transition page model.current model.fables)
                                )
                            )
                            ( 0, [] )
                            total
                        )
                    )
                 else
                    pageView 0 0 model.transition model.current model.current model.fables
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
    if isRunning model.transition then
        model
    else
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
                    let
                        newTransition =
                            (transition |> timeDiff diff)
                    in
                        if newTransition.timer > 0 then
                            { model | transition = Just newTransition }
                        else
                            { model | transition = Nothing }
              )
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    case model.transition of
        Nothing ->
            Sub.none

        Just transition ->
            AnimationFrame.diffs Tick


init : Model
init =
    { before = []
    , current = Index
    , after = []
    , transition = Nothing
    , fables =
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
