module Blog exposing (..)

{-| This code is something I always dreamt of being able to code with only html
    and styles. I thought it would have taken more time to create, but, in the
    end I did it. Elm was the way to go after all.
    It is heavily inspired by the way iOS works, but the code is original :)
    I wouldn't have been able to write that without Elm, BodyBuilder and Elegant.
-}

import BodyBuilder exposing (..)
import BodyBuilder.Elements exposing (..)
import Elegant exposing (textCenter, padding, SizeUnit(..), fontSize)
import Elegant.Elements exposing (borderBottom)
import Color
import Router exposing (..)
import Finders exposing (..)
import Dict exposing (Dict)
import Dict.Extra as Dict
import Function exposing (compose)


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


titleView : Contact -> Node Interactive phrasingContent Spanning NotListElement Msg
titleView contact =
    button
        [ onClick <| HistoryMsgWrapper <| ContactShow contact.id
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
        [ text contact.name ]


header : Node interactiveContent phrasingContent Spanning NotListElement Msg
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
                [ text "POKEMON"
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
            ]
            [ bodyFun data
            ]
        ]


pageCenter : Elegant.Style -> Elegant.Style
pageCenter =
    [ Elegant.displayFlex
    , Elegant.alignItemsCenter
    , Elegant.justifyContentCenter
    , Elegant.height (Vh 100)
    ]
        |> compose


contactBodyView : { b | maybeContact : Maybe Contact } -> Node interactiveContent Phrasing Spanning NotListElement msg
contactBodyView data =
    case data.maybeContact of
        Nothing ->
            text ""

        Just contact ->
            div [ style [ pageCenter ] ] [ text contact.name, br [], text contact.phoneNumber ]


filterByInitial : List Contact -> Dict Char (List Contact)
filterByInitial =
    Dict.filterGroupBy
        (.name
            >> String.uncons
            >> Maybe.map Tuple.first
        )


initialView : ( Char, List Contact ) -> Node Interactive phrasingContent Spanning NotListElement Msg
initialView ( initial, contacts ) =
    stickyView [ Elegant.backgroundColor gray, Elegant.paddingLeft (Px 24) ] (String.fromChar initial) (contacts |> List.map titleView)


initialsView : Dict Char (List Contact) -> List (Node Interactive phrasingContent Spanning NotListElement Msg)
initialsView initialAndContactsList =
    initialAndContactsList
        |> Dict.toList
        |> List.map initialView


contactsView : List Contact -> List (Node Interactive phrasingContent Spanning NotListElement Msg)
contactsView contacts =
    contacts
        |> filterByInitial
        |> initialsView


contactsIndex : List Contact -> Node Interactive phrasingContent Spanning NotListElement Msg
contactsIndex contacts =
    div
        [ style
            [ Elegant.backgroundColor gray
            , Elegant.height (Vh 100)
            , Elegant.overflowYScroll
            , Elegant.fullWidth
            ]
        ]
        (contacts |> contactsView)


contactsShow : Int -> List Contact -> Node interactiveContent Phrasing Spanning NotListElement Msg
contactsShow id contacts =
    div [] [ showView contactBodyView { maybeContact = (contacts |> find_by .id id) } ]


insidePageView : Page Route -> Data -> Maybe Transition -> Node Interactive Phrasing Spanning NotListElement Msg
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



-- [ div []
--     [ div []
--         [ div [ style [ Elegant.positionSticky, Elegant.top (Px 0), Elegant.backgroundColor Color.red, Elegant.fullWidth ] ] [ text "a" ]
--         , div [] [ text "titi" ]
--         , div [] [ text "titi" ]
--         , div [] [ text "titi" ]
--         , div [] [ text "titi" ]
--         , div [] [ text "titi" ]
--         , div [] [ text "titi" ]
--         , div [] [ text "titi" ]
--         , div [] [ text "titi" ]
--         , div [] [ text "titi" ]
--         ]
--     , div []
--         [ div [ style [ Elegant.positionSticky, Elegant.top (Px 0), Elegant.backgroundColor Color.red, Elegant.fullWidth ] ] [ text "b" ]
--         , div [] [ text "titi" ]
--         , div [] [ text "titi" ]
--         , div [] [ text "titi" ]
--         , div [] [ text "titi" ]
--         , div [] [ text "titi" ]
--         , div [] [ text "titi" ]
--         , div [] [ text "titi" ]
--         , div [] [ text "titi" ]
--         , div [] [ text "titi" ]
--         , div [] [ text "titi" ]
--         , div [] [ text "titi" ]
--         , div [] [ text "titi" ]
--         , div [] [ text "titi" ]
--         ]
--     , div [] [ text "titi" ]
--     , div [] [ text "titi" ]
--     , div [] [ text "titi" ]
--     , div [] [ text "titi" ]
--     , div [] [ text "titi" ]
--     , div [] [ text "titi" ]
--     , div [] [ text "titi" ]
--     , div [] [ text "titi" ]
--     , div [] [ text "titi" ]
--     , div [] [ text "titi" ]
--     , div [] [ text "titi" ]
--     , div [] [ text "titi" ]
--     , div [] [ text "titi" ]
--     , div [] [ text "titi" ]
--     , div [] [ text "titi" ]
--     , div [] [ text "titi" ]
--     , div [] [ text "titi" ]
--     , div [] [ text "titi" ]
--     , div [] [ text "titi" ]
--     , div [] [ text "titi" ]
--     , div [] [ text "titi" ]
--     , div [] [ text "titi" ]
--     , div [] [ text "titi" ]
--     , div [] [ text "titi" ]
--     , div [] [ text "titi" ]
--     , div [] [ text "titi" ]
--     , div [] [ text "titi" ]
--     , div [] [ text "titi" ]
--     , div [] [ text "titi" ]
--     , div [] [ text "titi" ]
--     , div [] [ text "titi" ]
--     ]
