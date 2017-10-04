module Stripe exposing (..)

import BodyBuilder exposing (..)
import BodyBuilder.Elements
import Elegant exposing (textCenter, padding, SizeUnit(..), fontSize)
import Elegant.Elements exposing (..)
import Color
import Router
    exposing
        ( History
        , StandardHistoryMsg
        , Page
        , Transition
        , historyView
        , handleStandardHistory
        , maybeTransitionSubscription
        , initHistoryAndData
        )
import Function exposing (compose)


type Route
    = PlansIndex


type alias Data =
    { stripePlan : StripePlan
    }


type alias Model =
    { history : History Route
    , data : Data
    }


type HistoryMsg
    = PlanShow Int


type Msg
    = HistoryMsgWrapper HistoryMsg
    | StandardHistoryWrapper StandardHistoryMsg
    | Select StripePlan


type alias MarkdownString =
    String


type alias Plan =
    { id : Int
    , name : String
    , phoneNumber : String
    }


handleHistory : HistoryMsg -> History Route -> History Route
handleHistory route history =
    case route of
        _ ->
            history


gray : Color.Color
gray =
    Color.grayscale 0.1


pageCenter : Elegant.Style -> Elegant.Style
pageCenter =
    [ Elegant.displayFlex
    , Elegant.alignItemsCenter
    , Elegant.justifyContentCenter
    , Elegant.height (Vh 100)
    ]
        |> compose


planBodyView : { b | maybePlan : Maybe Plan } -> Node msg
planBodyView data =
    case data.maybePlan of
        Nothing ->
            text ""

        Just plan ->
            div [ style [ pageCenter ] ] [ text plan.name, br [], text plan.phoneNumber ]


type StripePlan
    = Mensual
    | Semestrial
    | Annual


getStripeData : StripePlan -> List ( String, String )
getStripeData stripePlan =
    case stripePlan of
        Mensual ->
            [ ( "image", "https://stripe.com/img/documentation/checkout/marketplace.png" )
            , ( "key", "pk_test_1" )
            , ( "name", "Sponsoring mensuel" )
            , ( "description", "450€ HT / mois" )
            , ( "panel-label", "Sponsoriser" )
            , ( "label", "Sponsoriser au mois" )
            , ( "amount", "54000" )
            , ( "currency", "EUR" )
            , ( "allow-remember-me", "false" )
            ]

        Semestrial ->
            [ ( "image", "https://stripe.com/img/documentation/checkout/marketplace.png" )
            , ( "key", "pk_test_2" )
            , ( "name", "Sponsoring 6 mois" )
            , ( "description", "425€ HT / mois" )
            , ( "panel-label", "Sponsoriser" )
            , ( "label", "Sponsoriser aux 6 mois" )
            , ( "amount", "306000" )
            , ( "currency", "EUR" )
            , ( "allow-remember-me", "false" )
            ]

        Annual ->
            [ ( "image", "https://stripe.com/img/documentation/checkout/marketplace.png" )
            , ( "key", "pk_test_3" )
            , ( "name", "Sponsoring annuel" )
            , ( "description", "405€ HT / mois" )
            , ( "panel-label", "Sponsoriser" )
            , ( "label", "Sponsoriser à l'année" )
            , ( "amount", "583200" )
            , ( "currency", "EUR" )
            , ( "allow-remember-me", "false" )
            ]


selectionButton :
    StripePlan
    -> String
    -> Bool
    -> Node Msg
selectionButton msg label selected =
    div
        [ style
            [ Elegant.h3S
            , Elegant.textCenter
            , Elegant.padding Elegant.medium
            ]
        , BodyBuilder.Elements.invertableButton
            (Color.grayscale
                (if selected then
                    0.7
                 else
                    0.3
                )
            )
            (Color.grayscale
                (if selected then
                    0.2
                 else
                    0.8
                )
            )
        , onClick (Select msg)
        ]
        [ text label ]


toId : StripePlan -> String
toId stripePlan =
    case stripePlan of
        Mensual ->
            "mensuel"

        Semestrial ->
            "semestrial"

        Annual ->
            "annual"


plansIndex : StripePlan -> Node Msg
plansIndex stripePlan =
    let
        stripeData =
            getStripeData stripePlan
    in
        div
            [ style
                [ Elegant.backgroundColor Color.white
                , Elegant.height (Vh 100)
                , Elegant.overflowYScroll
                , Elegant.fullWidth
                ]
            ]
            [ div
                [ style
                    [ Elegant.h1S
                    , Elegant.textCenter
                    , Elegant.padding Elegant.medium
                    ]
                ]
                [ text "Sponsoring ParisRB" ]
            , div [ style [ centerHorizontal ] ]
                [ div [ style [ Elegant.displayFlex ] ]
                    [ selectionButton Mensual "Mensuel" (Mensual == stripePlan)
                    , selectionButton Semestrial "Semestriel" (Semestrial == stripePlan)
                    , selectionButton Annual "Annuel" (Annual == stripePlan)
                    ]
                ]
            , div []
                [ div [ id (toString stripePlan), style [ textCenter ] ]
                    [ stripeButton Mensual stripePlan
                    , stripeButton Semestrial stripePlan
                    , stripeButton Annual stripePlan
                    ]
                ]
            ]


stripeButton :
    StripePlan
    -> StripePlan
    -> Node msg
stripeButton stripePlan currentStripePlan =
    div
        [ style
            (if stripePlan == currentStripePlan then
                []
             else
                [ Elegant.displayNone ]
            )
        ]
        [ script
            [ src ("https://checkout.stripe.com/checkout.js")
            , class [ "stripe-button" ]
            , data (getStripeData stripePlan)
            ]
        ]


insidePageView : Page Route -> Data -> Maybe Transition -> Node Msg
insidePageView page data transition =
    let
        stripePlan =
            data.stripePlan
    in
        case page.route of
            PlansIndex ->
                plansIndex stripePlan


mainContainer : List (Node msg) -> Node msg
mainContainer =
    div [ style [ Elegant.fontFamilySansSerif, Elegant.fontSize Elegant.zeta ] ]


view : Model -> Node Msg
view { history, data } =
    mainContainer
        [ historyView insidePageView history data ]


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        HistoryMsgWrapper historyMsg ->
            ( { model | history = handleHistory historyMsg model.history }, Cmd.none )

        StandardHistoryWrapper historyMsg ->
            model |> handleStandardHistory historyMsg

        Select val ->
            let
                data =
                    model.data

                newData =
                    { data | stripePlan = val }
            in
                ( { model | data = newData }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    maybeTransitionSubscription StandardHistoryWrapper model.history.transition


initPlans : List Plan
initPlans =
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
    { stripePlan = Mensual }


init : { data : Data, history : History Route }
init =
    initHistoryAndData PlansIndex initData


main : Program Basics.Never Model Msg
main =
    program
        { init = ( init, Cmd.none )
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
