module Blog exposing (..)

{-| This code is something I always dreamt of being able to code with only html
and styles. I thought it would have taken more time to create, but, in the
end I did it. Elm was the way to go after all.
It is heavily inspired by the way iOS works, but the code is original :)
I wouldn't have been able to write that without Elm, BodyBuilder and Elegant.
-}

import BodyBuilder exposing (..)
import BodyBuilder.Attributes
import BodyBuilder.Elements exposing (..)
import Elegant exposing (SizeUnit, px, pt, percent, vh)
import Color
import Router
    exposing
        ( History
        , StandardHistoryMsg(Back)
        , handleStandardHistory
        , push
        , pageWithDefaultTransition
        , Page
        , Transition
        , historyView
        , maybeTransitionSubscription
        , initHistoryAndData
        )
import Finders exposing (..)
import Dict exposing (Dict)
import Dict.Extra as Dict
import Display
import Layout
import Cursor
import Border
import Outline
import Typography
import Typography.Character as Character
import Constants
import Padding
import Display.Overflow as Overflow
import Position
import Function


type Route
    = ContactsIndex
    | ContactsShow Int


type alias Data =
    { contacts : List Contact
    }


type alias Model =
    { history : History Route
    , data : Data
    }


type HistoryMsg
    = ContactShow Int


type Msg
    = HistoryMsgWrapper HistoryMsg
    | StandardHistoryWrapper StandardHistoryMsg


type alias MarkdownString =
    String


type alias Contact =
    { id : Int
    , name : String
    , phoneNumber : String
    }


handleHistory : HistoryMsg -> History Route -> History Route
handleHistory route history =
    case route of
        ContactShow id ->
            history |> push (pageWithDefaultTransition (ContactsShow id))


gray : Color.Color
gray =
    Color.grayscale 0.1


fullWidth : Display.BlockDetails -> Display.BlockDetails
fullWidth =
    Display.dimensions [ Display.width (percent 100) ]


titleView : Contact -> Node Msg
titleView contact =
    BodyBuilder.button
        [ BodyBuilder.Attributes.onClick <| HistoryMsgWrapper <| ContactShow contact.id
        , BodyBuilder.Attributes.style <|
            Elegant.style <|
                Display.block
                    [ Display.alignment Display.right
                    , fullWidth
                    ]
                    [ Layout.cursor Cursor.pointer
                    , Layout.border
                        [ Border.all [ Border.none ]
                        , Border.bottom [ Border.solid, Elegant.color gray ]
                        ]
                    , Layout.outline [ Outline.none ]
                    , Layout.typography
                        [ Typography.character
                            [ Character.fontFamilyInherit
                            , Character.size Constants.zeta
                            ]
                        ]
                    , Layout.padding [ Padding.all Constants.large ]
                    , Layout.background [ Elegant.color Color.white ]
                    ]
        , BodyBuilder.Attributes.focusStyle <|
            Elegant.style <|
                Display.block []
                    [ Layout.background [ Elegant.color <| Color.grayscale 0.05 ] ]
        ]
        [ text contact.name ]


commonButtonStyleLayout : List (Layout.Layout -> Layout.Layout)
commonButtonStyleLayout =
    [ Layout.padding [ Padding.all Constants.medium ]
    , Layout.cursor Cursor.pointer
    , Layout.typography [ Typography.character [ Character.size Constants.medium ] ]
    ]


navItemGroup : Float -> Display.Align -> String -> Node Msg
navItemGroup width alignment content =
    div
        [ BodyBuilder.Attributes.onClick <| StandardHistoryWrapper Back
        , BodyBuilder.Attributes.style <|
            Elegant.style <|
                Display.flexChild
                    [ Display.basis (percent width), Display.alignSelf alignment ]
                    [ Display.overflow [ Overflow.overflowXY Overflow.hidden ]
                    , Display.textOverflowEllipsis
                    ]
                    [ commonButtonStyleLayout |> Function.compose
                    , Layout.typography
                        [ Elegant.color Color.black
                        , Typography.whiteSpaceNoWrap
                        ]
                    ]
        ]
        [ text content ]


header : Node Msg
header =
    div
        [ BodyBuilder.Attributes.style <|
            Elegant.style <|
                Display.flexChildContainer
                    [ Display.direction Display.row ]
                    [ Display.basis (px 200) ]
                    []
                    [ Layout.position <| Position.fixed []
                    , Layout.background [ Elegant.color <| Color.rgba 255 255 255 0.9 ]
                    ]
        ]
        [ navItemGroup 30 Display.center "← BACK"
        , navItemGroup 40 Display.center "POKEMON"
        , navItemGroup 30 Display.center ""
        ]


showView :
    (a -> Node Msg)
    -> a
    -> Node Msg
showView bodyFun data =
    div
        [ BodyBuilder.Attributes.style <|
            Elegant.style <|
                Display.blockFlexContainer
                    [ Display.direction Display.column ]
                    [ Display.dimensions [ Display.height (vh 100) ] ]
                    [ Layout.background [ Elegant.color Color.white ] ]
        ]
        [ header
        , div
            [ BodyBuilder.Attributes.style <|
                Elegant.style <|
                    Display.flexChild
                        [ Display.shrink 1000000 ]
                        []
                        []

            -- [ Elegant.overflowYScroll
            -- , Elegant.fullWidth
            -- ,
            -- ]
            ]
            [ bodyFun data
            ]
        ]


contactBodyView : { b | maybeContact : Maybe Contact } -> Node msg
contactBodyView data =
    case data.maybeContact of
        Nothing ->
            text ""

        Just contact ->
            div
                [-- style [ pageCenter ]
                ]
                [ text contact.name
                , br []
                , text contact.phoneNumber
                ]


filterByInitial : List Contact -> List ( Char, List Contact )
filterByInitial =
    (Dict.filterGroupBy
        (.name
            >> String.uncons
            >> Maybe.map Tuple.first
        )
    )
        >> Dict.toList


initialView : ( Char, List Contact ) -> Node Msg
initialView ( initial, contacts ) =
    stickyView
        [ Layout.background [ Elegant.color gray ]
        , Layout.padding [ Padding.left Constants.large ]
        ]
        (String.fromChar initial)
        (contacts |> List.map titleView)


contactsView : List Contact -> List (Node Msg)
contactsView =
    filterByInitial >> List.map initialView


contactsIndex : List Contact -> Node Msg
contactsIndex contacts =
    div
        [ BodyBuilder.Attributes.style <|
            Elegant.style <|
                Display.block
                    [ Display.dimensions
                        [ Display.height (vh 100), Display.width (percent 100) ]
                    , Display.overflow [ Overflow.overflowY Overflow.scroll ]
                    ]
                    [ Layout.background [ Elegant.color gray ]
                    ]
        ]
        (contacts |> contactsView)


contactsShow : Int -> List Contact -> Node Msg
contactsShow id contacts =
    div [] [ showView contactBodyView { maybeContact = (contacts |> find_by .id id) } ]


insidePageView : Page Route -> Data -> Maybe Transition -> Node Msg
insidePageView page data transition =
    let
        contacts =
            data.contacts
    in
        case page.route of
            ContactsIndex ->
                contactsIndex contacts

            ContactsShow id ->
                contactsShow id contacts


view : Model -> Node Msg
view { history, data } =
    div
        [ BodyBuilder.Attributes.style <|
            Elegant.style <|
                Display.block []
                    [ Layout.typography
                        [ Typography.character
                            [ Character.fontFamilySansSerif
                            , Character.size Constants.zeta
                            ]
                        ]
                    ]
        ]
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


initContacts : List Contact
initContacts =
    [ { name = "Bulbasaurdagger", id = 1, phoneNumber = "+33389399383" }
    , { name = "Ivysaur", id = 2, phoneNumber = "+33389399383" }
    , { name = "Venusaur", id = 3, phoneNumber = "+33389399383" }
    , { name = "Charmanderdagger", id = 4, phoneNumber = "+33389399383" }
    , { name = "Charmeleon", id = 5, phoneNumber = "+33389399383" }
    , { name = "Charizard", id = 6, phoneNumber = "+33389399383" }
    , { name = "Squirtledagger", id = 7, phoneNumber = "+33389399383" }
    , { name = "Wartortle", id = 8, phoneNumber = "+33389399383" }
    , { name = "Blastoise", id = 9, phoneNumber = "+33389399383" }
    , { name = "Caterpie", id = 10, phoneNumber = "+33389399383" }
    , { name = "Metapod", id = 11, phoneNumber = "+33389399383" }
    , { name = "Butterfree", id = 12, phoneNumber = "+33389399383" }
    , { name = "Weedle", id = 13, phoneNumber = "+33389399383" }
    , { name = "Kakuna", id = 14, phoneNumber = "+33389399383" }
    , { name = "Beedrill", id = 15, phoneNumber = "+33389399383" }
    , { name = "Pidgey", id = 16, phoneNumber = "+33389399383" }
    , { name = "Pidgeotto", id = 17, phoneNumber = "+33389399383" }
    , { name = "Pidgeot", id = 18, phoneNumber = "+33389399383" }
    , { name = "Rattata", id = 19, phoneNumber = "+33389399383" }
    , { name = "Raticate", id = 20, phoneNumber = "+33389399383" }
    , { name = "Spearow", id = 21, phoneNumber = "+33389399383" }
    , { name = "Fearow", id = 22, phoneNumber = "+33389399383" }
    , { name = "Ekans", id = 23, phoneNumber = "+33389399383" }
    , { name = "Arbok", id = 24, phoneNumber = "+33389399383" }
    , { name = "Pikachudagger", id = 25, phoneNumber = "+33389399383" }
    , { name = "Raichu", id = 26, phoneNumber = "+33389399383" }
    , { name = "Sandshrew", id = 27, phoneNumber = "+33389399383" }
    , { name = "Sandslash", id = 28, phoneNumber = "+33389399383" }
    , { name = "Nidoran♀", id = 29, phoneNumber = "+33389399383" }
    , { name = "Nidorina", id = 30, phoneNumber = "+33389399383" }
    , { name = "Nidoqueen", id = 31, phoneNumber = "+33389399383" }
    , { name = "Nidoran♂", id = 32, phoneNumber = "+33389399383" }
    , { name = "Nidorino", id = 33, phoneNumber = "+33389399383" }
    , { name = "Nidoking", id = 34, phoneNumber = "+33389399383" }
    , { name = "Clefairy", id = 35, phoneNumber = "+33389399383" }
    , { name = "Clefable", id = 36, phoneNumber = "+33389399383" }
    , { name = "Vulpix", id = 37, phoneNumber = "+33389399383" }
    , { name = "Ninetales", id = 38, phoneNumber = "+33389399383" }
    , { name = "Jigglypuff", id = 39, phoneNumber = "+33389399383" }
    , { name = "Wigglytuff", id = 40, phoneNumber = "+33389399383" }
    , { name = "Zubat", id = 41, phoneNumber = "+33389399383" }
    , { name = "Golbat", id = 42, phoneNumber = "+33389399383" }
    , { name = "Oddish", id = 43, phoneNumber = "+33389399383" }
    , { name = "Gloom", id = 44, phoneNumber = "+33389399383" }
    , { name = "Ivysaur", id = 2, phoneNumber = "+33389399383" }
    , { name = "Venusaur", id = 3, phoneNumber = "+33389399383" }
    ]


initData : Data
initData =
    { contacts = initContacts }


init : { data : Data, history : History Route }
init =
    initHistoryAndData ContactsIndex initData


main : Program Basics.Never Model Msg
main =
    program
        { init = ( init, Cmd.none )
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
