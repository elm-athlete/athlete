module Blog exposing (..)

{-| This code is something I always dreamt of being able to code with only html
and styles. I thought it would have taken more time to create, but, in the
end I did it. Elm was the way to go after all.
It is heavily inspired by the way iOS works, but the code is original :)
I wouldn't have been able to write that without Elm, BodyBuilder and Elegant.
-}

import BodyBuilder exposing (..)
import Elegant exposing (textCenter, padding, SizeUnit(..), fontSize)
import Elegant.Elements exposing (borderBottom)
import Color
import Date
import Date exposing (Month(..))
import Date.Extra as Date
import Router
    exposing
        ( History
        , StandardHistoryMsg(Back)
        , push
        , pageWithDefaultTransition
        , Page
        , Transition
        , historyView
        , handleStandardHistory
        , maybeTransitionSubscription
        , initHistoryAndData
        )
import Finders exposing (..)


type Route
    = BlogpostsIndex
    | BlogpostsShow Int


type alias Data =
    { blogposts : List Blogpost
    }


type alias Model =
    { history : History Route
    , data : Data
    }


type HistoryMsg
    = BlogpostShow Int


type Msg
    = HistoryMsgWrapper HistoryMsg
    | StandardHistoryWrapper StandardHistoryMsg


type alias MarkdownString =
    String


type alias Blogpost =
    { id : Int
    , title : String
    , content : MarkdownString
    , publishedAt : Maybe Date.Date
    , image : String
    }


handleHistory : HistoryMsg -> History Route -> History Route
handleHistory route history =
    case route of
        BlogpostShow id ->
            history |> push (pageWithDefaultTransition (BlogpostsShow id))


gray : Color.Color
gray =
    Color.grayscale 0.9


titleView : Blogpost -> Node Msg
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


header : Node Msg
header =
    div [ style [ Elegant.positionFixed, Elegant.fullWidth, Elegant.backgroundColor (Color.rgba 255 255 255 0.9) ] ]
        [ div [ style [ Elegant.displayFlex, Elegant.flexDirectionRow, Elegant.fullWidth ] ]
            [ div
                [ onClick <| StandardHistoryWrapper Back
                , style
                    [ Elegant.textColor Color.black
                    , Elegant.padding Elegant.medium
                    , Elegant.cursorPointer
                    , Elegant.fontSize (Px 12)
                    , Elegant.whiteSpaceNoWrap
                    , Elegant.overflowHidden
                    , Elegant.width (Percent 30)
                    , Elegant.textOverflowEllipsis
                    ]
                ]
                [ text "← BACK"
                ]
            , div
                [ onClick <| StandardHistoryWrapper Back
                , style
                    [ Elegant.textColor Color.black
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
                    [ Elegant.textColor Color.black
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
        ]


showView :
    (a -> Node Msg)
    -> a
    -> Node Msg
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
            ]
            [ bodyFun data
            ]
        ]


textToHtml : String -> List (Node msg)
textToHtml =
    (>>)
        (String.split "\n")
        (List.foldr (\e accu -> accu ++ [ text e, br [] ]) [])


blogpostBodyView : { b | maybeBlogpost : Maybe Blogpost } -> Node msg
blogpostBodyView data =
    case data.maybeBlogpost of
        Nothing ->
            text ""

        Just blogpost ->
            div []
                ([ img ""
                    blogpost.image
                    [ style [ Elegant.fullWidth ] ]
                 , div [] (textToHtml blogpost.content)
                 ]
                )


blogpostsIndex : List Blogpost -> Node Msg
blogpostsIndex blogposts =
    div [ style [ Elegant.backgroundColor gray, Elegant.height (Vh 100) ] ]
        (blogposts |> List.map titleView)


blogpostsShow : Int -> List Blogpost -> Node Msg
blogpostsShow id blogposts =
    div [] [ showView blogpostBodyView { maybeBlogpost = (blogposts |> find_by .id id) } ]


insidePageView : Page Route -> Data -> Maybe Transition -> Node Msg
insidePageView page data transition =
    let
        blogposts =
            data.blogposts
    in
        case page.route of
            BlogpostsIndex ->
                blogpostsIndex blogposts

            BlogpostsShow id ->
                blogpostsShow id blogposts


view : Model -> Node Msg
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


subscriptions : Model -> Sub Msg
subscriptions model =
    maybeTransitionSubscription StandardHistoryWrapper model.history.transition


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
    { blogposts = initBlogposts }


init : { data : Data, history : History Route }
init =
    initHistoryAndData BlogpostsIndex initData


main : Program Basics.Never Model Msg
main =
    program
        { init = ( init, Cmd.none )
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
