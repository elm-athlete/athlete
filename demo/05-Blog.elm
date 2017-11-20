module Blog exposing (..)

{-| This code is something I always dreamt of being able to code with only html
and styles. I thought it would have taken more time to create, but, in the
end I did it. Elm was the way to go after all.
It is heavily inspired by the way iOS works, but the code is original :)
I wouldn't have been able to write that without Elm, BodyBuilder and Elegant.
-}

import BodyBuilder exposing (..)
import BodyBuilder.Attributes as Attributes exposing (..)
import BodyBuilder.Events as Events
import Finders exposing (..)
import Elegant exposing (SizeUnit, px, pt, percent, vh)
import Padding
import Constants
import Elegant
import Color
import Display
import Dimensions
import Box
import Cursor
import Border
import Outline
import Typography
import Character
import Style
import Date exposing (Month(..))
import Date.Extra as Date
import Flex
import Position
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


type alias MyHistory =
    History Route Data Msg


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
    , publishedAt : Maybe Date.Date
    , image : String
    }


customTransitionVie :
    { after : List (Page route data msg)
    , before : List (Page route data msg)
    , current : Page route data msg
    , transition : Maybe (Transition route data msg)
    }
    ->
        (Page route data msg
         -> a
         -> Maybe (Transition route data msg)
         -> Node msg
        )
    -> a
    -> Node msg
customTransitionVie history insidePageView_ data =
    Router.overflowHiddenContainer []
        [ flexItem
            [ style
                [ Style.block []
                , Style.flexItemProperties [ Flex.basis (percent 100) ]
                ]
            ]
            (List.map (Router.pageView insidePageView_ history.transition data) (history |> Router.beforeTransition))
        , flexItem
            [ style
                [ Style.block [ Display.dimensions [ Dimensions.width (percent 100) ] ]
                , Style.flexItemProperties [ Flex.basis (percent 100) ]
                , Style.box
                    [ Box.position <|
                        Position.absolute <|
                            [ Position.bottom <|
                                Router.percentage ((Router.getMaybeTransitionValue <| history.transition) - 1)
                            ]
                    ]
                ]
            ]
            (List.map (Router.pageView insidePageView_ history.transition data) (history |> Router.afterTransition))
        ]


handleHistory : HistoryMsg -> MyHistory -> MyHistory
handleHistory route history =
    case route of
        BlogpostShow id ->
            history
                |> push
                    (Router.pageWithTransition
                        (Router.customTransition
                            250
                            (Router.customKind customTransitionVie)
                            Router.forward
                            Router.easeInOutt
                        )
                        (BlogpostsShow id)
                    )


gray : Color.Color
gray =
    Color.grayscale 0.9


titleView : Blogpost -> Node Msg
titleView blogpost =
    button
        [ Events.onClick <| HistoryMsgWrapper <| BlogpostShow blogpost.id
        , standardCellStyle
        ]
        [ text blogpost.title ]


showView : { b | maybeBlogpost : Maybe Blogpost } -> Node Msg
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


blogpostView : Blogpost -> Node msg
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


textToHtml : String -> List (Node msg)
textToHtml =
    (>>)
        (String.split "\n")
        (List.foldr (\e accu -> [ text e, br ] ++ accu) [])


standardCellStyle : Elegant.Modifier (Attributes.BoxContainer (Attributes.MaybeBlockContainer a))
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
                [ Typography.character
                    [ Character.fontFamilyInherit
                    , Character.size Constants.zeta
                    ]
                ]
            , Box.padding [ Padding.all Constants.large ]
            , Box.background [ Elegant.color Color.white ]
            ]
        ]


blogpostsIndex : List Blogpost -> Node Msg
blogpostsIndex blogposts =
    node
        [ style
            [ Style.block [ Display.dimensions [ Dimensions.height (vh 100) ] ]
            , Style.box [ Box.background [ Elegant.color gray ] ]
            ]
        ]
        (blogposts |> List.map titleView)


blogpostsShow : Int -> List Blogpost -> Node Msg
blogpostsShow id blogposts =
    node [] [ showView { maybeBlogpost = (blogposts |> find_by .id id) } ]


insidePageView : Page Route Data Msg -> Data -> Maybe (Transition Route Data Msg) -> Node Msg
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
    node
        [ style
            [ Style.block []
            , Style.box
                [ Box.typography
                    [ Typography.character
                        [ Character.fontFamilySansSerif
                        , Character.size Constants.zeta
                        ]
                    ]
                ]
            ]
        ]
        [ historyView insidePageView history data ]


update : Msg -> Model -> ( Model, Cmd Msg )
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


init : { data : Data, history : MyHistory }
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
