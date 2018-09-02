module Main exposing (main)

{-| This code is something I always dreamt of being able to code with only html
and styles. I thought it would have taken more time to create, but, in the
end I did it. Elm was the way to go after all.
It is heavily inspired by the way iOS works, but the code is original :)
I wouldn't have been able to write that without Elm, BodyBuilder and Elegant.
-}

-- import Date exposing (Month(..))
-- import Date.Extra as Date

import BodyBuilder exposing (..)
import BodyBuilder.Attributes as Attributes exposing (..)
import BodyBuilder.Events as Events
import BodyBuilder.Finders exposing (..)
import BodyBuilder.Router as Router
    exposing
        ( History
        , Page
        , StandardHistoryMsg(..)
        , Transition
        , handleStandardHistory
        , historyView
        , initHistoryAndData
        , maybeTransitionSubscription
        , pageWithDefaultTransition
        , push
        )
import BodyBuilder.Style as Style
import Color
import Elegant exposing (SizeUnit, percent, pt, px, vh)
import Elegant.Border as Border
import Elegant.Box as Box
import Elegant.Constants as Constants
import Elegant.Corner as Corner
import Elegant.Cursor as Cursor
import Elegant.Dimensions as Dimensions
import Elegant.Display as Display
import Elegant.Outline as Outline
import Elegant.Padding as Padding
import Elegant.Typography as Typography
import Modifiers exposing (..)
import Time


type Route
    = BlogpostsIndex
    | BlogpostsShow Int


type alias Data =
    { blogposts : List Blogpost
    }


type alias MyHistory =
    History Route Msg


type alias Model =
    { history : MyHistory
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
    , publishedAt : Maybe Time.Posix
    , image : String
    }


handleHistory : HistoryMsg -> MyHistory -> MyHistory
handleHistory route history =
    case route of
        BlogpostShow id ->
            history |> push (Router.pageWithDefaultTransition (BlogpostsShow id))


gray : Color.Color
gray =
    Color.grayscale 0.9


titleView : Blogpost -> NodeWithStyle Msg
titleView blogpost =
    button
        [ Events.onClick <| HistoryMsgWrapper <| BlogpostShow blogpost.id
        , standardCellStyle
        ]
        [ text blogpost.title ]


showView : { b | maybeBlogpost : Maybe Blogpost } -> NodeWithStyle Msg
showView data =
    case data.maybeBlogpost of
        Nothing ->
            node [] [ text "Error" ]

        Just blogPost ->
            Router.pageWithHeader
                (Router.headerElement
                    { left = Router.headerButton (StandardHistoryWrapper Router.Back) "← BACK"
                    , center = Router.headerButton (StandardHistoryWrapper Router.Back) "Blog"
                    , right = node [] []
                    }
                )
                (blogpostView blogPost)


blogpostView : Blogpost -> NodeWithStyle msg
blogpostView blogpost =
    node []
        [ img "" blogpost.image [ style [ Style.block [ Display.fullWidth ] ] ]
        , node
            [ style
                [ Style.block []
                , Style.box [ Box.padding [ Padding.horizontal Constants.medium ] ]
                ]
            ]
            (textToHtml blogpost.content)
        ]


textToHtml : String -> List (NodeWithStyle msg)
textToHtml =
    (>>)
        (String.split "\n")
        (List.foldr (\e accu -> [ text e, br ] ++ accu) [])


standardCellStyle : Modifiers.Modifier (Attributes.BoxContainer (Attributes.MaybeBlockContainer a))
standardCellStyle =
    style
        [ Style.block
            [ Display.alignment Display.left
            , Display.fullWidth
            ]
        , Style.box
            [ Box.cursor Cursor.pointer
            , Box.border
                [ Border.all [ Border.none ]
                , Border.bottom [ Border.solid, Elegant.color gray ]
                ]
            , Box.outline [ Outline.none ]
            , Box.typography
                [ Typography.fontFamilyInherit
                , Typography.size Constants.zeta
                ]
            , Box.corner [ Corner.circular Corner.all (px 0) ]
            , Box.padding [ Padding.all Constants.large ]
            , Box.background [ Elegant.color Color.white ]
            ]
        ]


blogpostsIndex : List Blogpost -> NodeWithStyle Msg
blogpostsIndex blogposts =
    node
        [ style
            [ Style.block [ Display.dimensions [ Dimensions.height (vh 100) ] ]
            , Style.box [ Box.background [ Elegant.color gray ] ]
            ]
        ]
        (blogposts |> List.map titleView)


blogpostsShow : Int -> List Blogpost -> NodeWithStyle Msg
blogpostsShow id blogposts =
    node [] [ showView { maybeBlogpost = blogposts |> find_by .id id } ]


pageView : Data -> Page Route Msg -> Maybe (Transition Route Msg) -> NodeWithStyle Msg
pageView { blogposts } { route } transition =
    case route of
        BlogpostsIndex ->
            blogpostsIndex blogposts

        BlogpostsShow id ->
            blogpostsShow id blogposts


view : Model -> NodeWithStyle Msg
view ({ history, data } as model) =
    div
        [ style
            [ Style.box
                [ Box.typography
                    [ Typography.fontFamilySansSerif
                    , Typography.size Constants.zeta
                    ]
                ]
            ]
        ]
        [ historyView (pageView data) history ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        HistoryMsgWrapper historyMsg ->
            ( { model | history = handleHistory historyMsg model.history }, Cmd.none )

        StandardHistoryWrapper historyMsg ->
            model |> handleStandardHistory historyMsg


subscriptions : Model -> Sub Msg
subscriptions model =
    maybeTransitionSubscription model.history


initBlogposts : List Blogpost
initBlogposts =
    [ { id = 1
      , title = "La cigale et la fourmi"
      , publishedAt = Just <| Time.millisToPosix 1502323200
      , content = "La Cigale, ayant chanté\nTout l'Été,\nSe trouva fort dépourvue\nQuand la bise fut venue.\nPas un seul petit morceau\nDe mouche ou de vermisseau.\nElle alla crier famine\nChez la Fourmi sa voisine,\nLa priant de lui prêter\nQuelque grain pour subsister\nJusqu'à la saison nouvelle.\nJe vous paierai, lui dit-elle,\nAvant l'Oût, foi d'animal,\nIntérêt et principal.\nLa Fourmi n'est pas prêteuse ;\nC'est là son moindre défaut.\n« Que faisiez-vous au temps chaud ?\nDit-elle à cette emprunteuse.\n— Nuit et jour à tout venant\nJe chantais, ne vous déplaise.\n— Vous chantiez ? j'en suis fort aise.\nEh bien !dansez maintenant. »\n"
      , image = "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Snodgrass_Magicicada_septendecim.jpg/1024px-Snodgrass_Magicicada_septendecim.jpg"
      }
    , { id = 2
      , title = "Le corbeau et le renard"
      , content = "Maître Corbeau, sur un arbre perché,\nTenait en son bec un fromage.\nMaître Renard, par l'odeur alléché,\nLui tint à peu près ce langage :\nEt bonjour, Monsieur du Corbeau.\nQue vous êtes joli ! que vous me semblez beau !\nSans mentir, si votre ramage\nSe rapporte à votre plumage,\nVous êtes le Phénix des hôtes de ces bois.\nÀ ces mots, le Corbeau ne se sent pas de joie ;\nEt pour montrer sa belle voix,\nIl ouvre un large bec, laisse tomber sa proie.\nLe Renard s'en saisit, et dit : Mon bon Monsieur,\nApprenez que tout flatteur\nVit aux dépens de celui qui l'écoute.\nCette leçon vaut bien un fromage, sans doute.\nLe Corbeau honteux et confus\nJura, mais un peu tard, qu'on ne l'y prendrait plus."
      , publishedAt = Just <| Time.millisToPosix 1502323200
      , image = "https://upload.wikimedia.org/wikipedia/commons/4/47/Karga_9107.svg"
      }
    ]


initData : Data
initData =
    { blogposts = initBlogposts }


init : { data : Data, history : MyHistory }
init =
    initHistoryAndData BlogpostsIndex initData StandardHistoryWrapper


main : Program () Model Msg
main =
    element
        { init = \_ -> ( init, Cmd.none )
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
