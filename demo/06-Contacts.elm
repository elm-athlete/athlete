module Blog exposing (..)

{-| This code is something I always dreamt of being able to code with only html
and styles. I thought it would have taken more time to create, but, in the
end I did it. Elm was the way to go after all.
It is heavily inspired by the way iOS works, but the code is original :)
I wouldn't have been able to write that without Elm, BodyBuilder and Elegant.
-}

import BodyBuilder exposing (..)
import BodyBuilder.Attributes as Attributes
import BodyBuilder.Elements as Elements
import BodyBuilder.Events as Events
import Border
import Box
import Color
import Constants
import Cursor
import Dict exposing (Dict)
import Dict.Extra as Dict
import Dimensions
import Display
import Elegant exposing (SizeUnit, percent, pt, px, vh)
import Finders exposing (..)
import Flex
import Function
import Outline
import Overflow
import Padding
import Position
import Router
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
import Style
import Typography


type Route
    = ContactsIndex
    | ContactsShow Int


type alias Data =
    { contacts : List Contact
    }


type alias Model =
    { history : History Route Msg
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


handleHistory : HistoryMsg -> History Route Msg -> History Route Msg
handleHistory route history =
    case route of
        ContactShow id ->
            history |> push (pageWithDefaultTransition (ContactsShow id))


gray : Color.Color
gray =
    Color.grayscale 0.1


titleView : Contact -> Node Msg
titleView contact =
    BodyBuilder.button
        [ Events.onClick <| HistoryMsgWrapper <| ContactShow contact.id
        , Attributes.style
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
                , Box.padding [ Padding.all Constants.large ]
                , Box.background [ Elegant.color Color.white ]
                ]
            , Style.box [ Box.background [ Elegant.color <| Color.grayscale 0.05 ] ]
                |> Style.hover
            ]
        ]
        [ text contact.name ]


commonButtonStyleBox : List (Box.Box -> Box.Box)
commonButtonStyleBox =
    [ Box.padding [ Padding.all Constants.medium ]
    , Box.cursor Cursor.pointer
    , Box.typography [ Typography.size Constants.medium ]
    ]


navItemGroup : Float -> Display.Alignment -> String -> FlexItem Msg
navItemGroup width alignment content =
    BodyBuilder.flexItem
        [ Events.onClick <| StandardHistoryWrapper Back
        , Attributes.style
            [ Style.flexItemProperties
                [ Flex.basis (percent width) ]
            , Style.block
                [ Display.overflow [ Overflow.overflowXY Overflow.hidden ]
                , Display.textOverflowEllipsis
                , Display.alignment alignment
                ]
            , Style.box
                [ commonButtonStyleBox |> Function.compose
                , Box.typography
                    [ Elegant.color Color.black
                    , Typography.whiteSpaceNoWrap
                    ]
                ]
            ]
        ]
        [ text content ]


header : FlexItem Msg
header =
    BodyBuilder.flexItem []
        [ BodyBuilder.flex
            [ Attributes.style
                [ Style.flexContainerProperties
                    [ Flex.direction Flex.row ]
                , Style.block []
                , Style.box
                    [ Box.position <| Position.sticky []
                    , Box.background [ Elegant.color <| Color.rgba 255 255 255 0.9 ]
                    ]
                ]
            ]
            [ navItemGroup 30 Display.left "← BACK"
            , navItemGroup 40 Display.center "POKEMON"
            , navItemGroup 30 Display.right ""
            ]
        ]


showView :
    (a -> Node Msg)
    -> a
    -> Node Msg
showView bodyFun data =
    flex
        [ Attributes.style
            [ Style.flexContainerProperties
                [ Flex.direction Flex.column ]
            , Style.block
                [ Display.dimensions [ Dimensions.height (vh 100) ] ]
            , Style.box
                [ Box.background [ Elegant.color Color.white ] ]
            ]
        ]
        [ header
        , BodyBuilder.flexItem
            [ Attributes.style
                [ Style.flexItemProperties
                    [ Flex.shrink 1000000 ]
                , Style.block
                    []

                -- [ Elegant.overflowYScroll
                -- , Elegant.fullWidth
                -- ,
                -- ]
                ]
            ]
            [ bodyFun data
            ]
        ]


fullFlexCenter : List (Node msg) -> Node msg
fullFlexCenter content =
    flex
        [ -- style [ pageCenter ]
          Attributes.style
            [ Style.block
                [ Display.dimensions
                    [ Dimensions.width (percent 100)
                    , Dimensions.height (vh 100)
                    ]
                ]
            , Style.flexContainerProperties
                [ Flex.align Flex.alignCenter
                , Flex.justifyContent Flex.justifyContentCenter
                ]
            ]
        ]
        [ flexItem [] content ]


contactBodyView : { b | maybeContact : Maybe Contact } -> Node msg
contactBodyView data =
    case data.maybeContact of
        Nothing ->
            text ""

        Just contact ->
            fullFlexCenter
                [ text contact.name
                , p [] []
                , text contact.phoneNumber
                ]


filterByInitial : List Contact -> List ( Char, List Contact )
filterByInitial =
    Dict.filterGroupBy
        (.name
            >> String.uncons
            >> Maybe.map Tuple.first
        )
        >> Dict.toList


initialView : ( Char, List Contact ) -> Node Msg
initialView ( initial, contacts ) =
    Elements.stickyView
        [ Box.background [ Elegant.color gray ]
        , Box.padding [ Padding.left Constants.large ]
        ]
        (String.fromChar initial)
        (contacts |> List.map titleView)


contactsView : List Contact -> List (Node Msg)
contactsView =
    filterByInitial >> List.map initialView


{-| returns a background with a color
-}
backgroundColor : Color.Color -> Box.Box -> Box.Box
backgroundColor color =
    Box.background [ Elegant.color color ]


contactsIndex : List Contact -> Node Msg
contactsIndex contacts =
    node
        [ Attributes.style
            [ Style.block
                [ Display.dimensions
                    [ Dimensions.height (vh 100), Dimensions.width (percent 100) ]
                , Display.overflow [ Overflow.overflowY Overflow.scroll ]
                ]
            , Style.box
                [ backgroundColor gray
                ]
            ]
        ]
        (contacts |> contactsView)


contactsShow : Int -> List Contact -> Node Msg
contactsShow id contacts =
    node [] [ showView contactBodyView { maybeContact = contacts |> find_by .id id } ]


insidePageView : Data -> Page Route Msg -> Maybe (Transition Route Msg) -> Node Msg
insidePageView data page transition =
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
    node
        [ Attributes.style
            [ Style.block []
            , Style.box
                [ Box.typography
                    [ Typography.fontFamilySansSerif
                    , Typography.size Constants.zeta
                    ]
                ]
            ]
        ]
        [ historyView (insidePageView data) history ]


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


init : { data : Data, history : History Route Msg }
init =
    initHistoryAndData ContactsIndex initData StandardHistoryWrapper


main : Program () Model Msg
main =
    embed
        { init = \_ -> ( init, Cmd.none )
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
