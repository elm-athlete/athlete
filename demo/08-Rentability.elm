module Rentability exposing (..)

import BodyBuilder exposing (..)
import BodyBuilder.Attributes as Attributes exposing (style)
import BodyBuilder.Events
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
        , pageWithHeader
        )
import Finders exposing (..)
import Display
import Box
import Cursor
import Border
import Outline
import Typography
import Typography.Character as Character
import Constants
import Padding
import Time exposing (Time)
import Task
import Date
import Date exposing (Month(..))
import Date.Extra as Date
import Style


type alias Persisted a =
    { id : Int, createdAt : Time, updatedAt : Time, attributes : a }


type alias Appartment =
    Persisted AppartmentAttributes


type alias AppartmentAttributes =
    { title : String
    , details : MarkdownString
    , monthlyRent : Int
    , collocs : Int
    , works : Int
    , rate : Float
    }


type alias Data =
    { appartments : List Appartment
    , draftAppartment : AppartmentAttributes
    }


type Route
    = AppartmentsIndex
    | AppartmentsShow Int
    | AppartmentsEdit Int
    | AppartmentsNew
    | AppartmentsIndexEdit


type alias Model =
    { history : History Route
    , data : Data
    }


type HistoryMsg
    = AppartmentShowMsg Int
    | AppartmentEditMsg Int
    | AppartmentNewMsg
    | AppartmentsIndexEditMsg


type UpdateAppartmentMsg
    = UpdateCollocs Int
    | UpdateMonthlyRent Int
    | UpdateWorks Int
    | UpdateTitle String


type Msg
    = HistoryMsgWrapper HistoryMsg
    | StandardHistoryWrapper StandardHistoryMsg
    | UpdateAppartment Int UpdateAppartmentMsg
    | UpdateAppartmentAttributes UpdateAppartmentMsg
    | DestroyAppartment Int
    | SaveAppartmentAttributes
    | SaveAppartmentAttributesHelper Time


type alias MarkdownString =
    String


handleHistory : HistoryMsg -> History Route -> History Route
handleHistory route history =
    case route of
        AppartmentShowMsg id ->
            history |> Router.push (Router.pageWithDefaultTransition (AppartmentsShow id))

        AppartmentEditMsg id ->
            history |> Router.push (Router.pageWithTransition (Router.slideUp) (AppartmentsEdit id))

        AppartmentNewMsg ->
            history |> Router.push (Router.pageWithTransition (Router.slideUp) AppartmentsNew)

        AppartmentsIndexEditMsg ->
            history |> Router.push (Router.pageWithoutTransition AppartmentsIndexEdit)


gray : Color.Color
gray =
    Color.grayscale 0.9


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
            , Box.paddingAll Constants.large
            , Box.background [ Elegant.color Color.white ]
            ]
        ]


titleView : Appartment -> Node Msg
titleView appartment =
    button
        [ BodyBuilder.Events.onClick <|
            HistoryMsgWrapper <|
                AppartmentShowMsg appartment.id
        , standardCellStyle
        ]
        [ text appartment.attributes.title ]


titleViewWithDelete :
    Appartment
    -> Node Msg
titleViewWithDelete appartment =
    button
        [ standardCellStyle ]
        [ flex
            []
            [ flexItem [ BodyBuilder.Events.onClick <| DestroyAppartment appartment.id ] [ text "⛔" ]
            , flexItem [ style [ Style.box [ Box.padding [ Padding.left Constants.medium ] ] ] ]
                [ text appartment.attributes.title ]
            ]
        ]


showView : { b | maybeAppartment : Maybe Appartment } -> Node Msg
showView data =
    case data.maybeAppartment of
        Nothing ->
            node [] [ text "Error" ]

        Just appartment ->
            pageWithHeader
                (Router.headerElement
                    { left = Router.headerButton (StandardHistoryWrapper Router.Back) "← BACK"
                    , center = title appartment.attributes.title
                    , right = Router.headerButton (HistoryMsgWrapper (AppartmentEditMsg appartment.id)) "Edit"
                    }
                )
                (appartmentBodyView appartment)



-- rentrer des apparts, des photos, nom d'appart, plus les données, parking


defaultMonthlyRent : number
defaultMonthlyRent =
    300


defaultCollocs : number
defaultCollocs =
    3


rentaSimple : Float
rentaSimple =
    8.0


rentaColloc : Float
rentaColloc =
    10.0


renta : Int -> Float
renta collocs =
    if collocs > 1 then
        rentaColloc
    else
        rentaSimple


maxPrice : AppartmentAttributes -> Float
maxPrice appartment =
    (yearlyRent appartment |> toFloat) / ((renta appartment.collocs) / 100)


yearsOfDebt : number
yearsOfDebt =
    25


monthlyBankDebt : AppartmentAttributes -> Int
monthlyBankDebt model =
    let
        k =
            model |> maxPrice

        t =
            model.rate

        n =
            yearsOfDebt * 12
    in
        (k * (t / 12)) / (1 - ((1 + t / 12) ^ (-n))) |> round


minSalary : AppartmentAttributes -> Int
minSalary model =
    (model |> monthlyBankDebt) * 3


pad =
    style
        [ Style.block []
        , Style.box [ Box.padding [ Padding.all Constants.medium ] ]
        ]


result : String -> a -> Node msg
result label value =
    node [ pad ]
        [ text <| label
        , br
        , text (value |> toString)
        ]


yearlyRent : AppartmentAttributes -> Int
yearlyRent model =
    (totalMonthlyRent model) * 12


totalMonthlyRent : AppartmentAttributes -> Int
totalMonthlyRent { collocs, monthlyRent } =
    monthlyRent * collocs


appartmentEditBodyView : Appartment -> Node Msg
appartmentEditBodyView ({ attributes } as appartment) =
    node []
        [ result "Renta standard en % : " (renta attributes.collocs)
        , node [ pad ]
            [ node [ style [ Style.block [] ] ]
                [ text
                    ("Loyer mensuel "
                        ++ (if attributes.collocs > 1 then
                                " (par locataire)"
                            else
                                ""
                           )
                    )
                ]
            , inputNumber
                [ Attributes.value (attributes.monthlyRent)
                , BodyBuilder.Events.onInput (UpdateAppartment appartment.id << UpdateMonthlyRent)
                ]
            ]
        , node [ pad ]
            [ node [ style [ Style.block [] ] ] [ text "Nombre de locataires" ]
            , inputNumber
                [ Attributes.value (attributes.collocs)
                , BodyBuilder.Events.onInput (UpdateAppartment appartment.id << UpdateCollocs)
                ]
            ]
        , node [ pad ]
            [ node [ style [ Style.block [] ] ] [ text "Travaux" ]
            , inputNumber
                [ Attributes.value (attributes.works)
                , BodyBuilder.Events.onInput (UpdateAppartment appartment.id << UpdateWorks)
                ]
            ]
        , result "Loyer mensuel total : " (totalMonthlyRent attributes)
        , result "Loyer annuel : " (yearlyRent attributes)
        , result "Prix d'acquisition global (travaux compris) max conseillé : " (maxPrice attributes)
        , result "Prix d'acquisition global (sans travaux) max conseillé : " (maxPrice attributes - (attributes.works |> toFloat))
        , result "Prix d'acquisition global (avant frais notaires) max conseillé : " ((maxPrice attributes - (attributes.works |> toFloat)) / 1.08)
        , result "Mensualités moyennes à payer à la banque (20 ans) : " (monthlyBankDebt attributes)
        , result "Revenus minimum pour endettement : " (minSalary attributes)
        ]


toPositiveInt : Int -> Int
toPositiveInt i =
    if i < 1 then
        1
    else
        i



-- assurance : Generali


{-| returns a background with a color
-}
backgroundColor : Color.Color -> Elegant.Modifier Box.Box
backgroundColor color =
    Box.background [ Elegant.color color ]


editView : { a | maybeAppartment : Maybe Appartment } -> Node Msg
editView data =
    case data.maybeAppartment of
        Nothing ->
            node [] [ text "Error" ]

        Just appartment ->
            pageWithHeader
                (Router.headerElement
                    { left = Router.headerButton (StandardHistoryWrapper Router.Back) "x"
                    , center = title appartment.attributes.title
                    , right = node [] []
                    }
                )
                (appartmentEditBodyView appartment)


textToHtml : String -> List (Node msg)
textToHtml =
    (>>)
        (String.split "\n")
        (List.foldr (\e accu -> accu ++ [ text e, br ]) [])


appartmentBodyView : Appartment -> Node msg
appartmentBodyView appartment =
    node
        [ style [ Style.block [], Style.box [ Box.padding [ Padding.horizontal Constants.medium ] ] ] ]
        ([ node [] (textToHtml appartment.attributes.details)
         ]
        )


title : String -> Node msg
title content =
    node
        [ style
            [ Style.block []
            , Style.box [ Box.padding [ Padding.all (Elegant.px 12) ] ]
            ]
        ]
        [ text content ]


appartmentsIndex : List Appartment -> Node Msg
appartmentsIndex appartments =
    pageWithHeader
        (Router.headerElement
            { left = Router.headerButton (HistoryMsgWrapper AppartmentsIndexEditMsg) "edit"
            , center = title "Rentabilize"
            , right = Router.headerButton (HistoryMsgWrapper AppartmentNewMsg) "new"
            }
        )
        (node [ style [ Style.block [], Style.box [ backgroundColor gray ] ] ]
            (appartments |> List.map titleView)
        )


appartmentsIndexEdit : List Appartment -> Node Msg
appartmentsIndexEdit appartments =
    pageWithHeader
        (Router.headerElement
            { left = Router.headerButton (StandardHistoryWrapper Router.Back) "done"
            , center = title "Rentabilize"
            , right = text ""
            }
        )
        (node [ style [ Style.block [], Style.box [ backgroundColor gray ] ] ]
            (appartments |> List.map titleViewWithDelete)
        )


appartmentsShow : Int -> List Appartment -> Node Msg
appartmentsShow id appartments =
    node [] [ showView { maybeAppartment = (appartments |> find_by .id id) } ]


appartmentsEdit :
    Int
    -> List Appartment
    -> Node Msg
appartmentsEdit id appartments =
    node [] [ editView { maybeAppartment = (appartments |> find_by .id id) } ]


appartmentsNew : AppartmentAttributes -> Node Msg
appartmentsNew draftAppartment =
    pageWithHeader
        (Router.headerElement
            { left = Router.headerButton (StandardHistoryWrapper Router.Back) "cancel"
            , center = title draftAppartment.title
            , right = Router.headerButton SaveAppartmentAttributes "save"
            }
        )
        (node
            []
            [ inputText [ Attributes.value draftAppartment.title, BodyBuilder.Events.onInput (UpdateAppartmentAttributes << UpdateTitle) ]
            ]
        )


insidePageView : Router.Page Route -> Data -> Maybe Router.Transition -> Node Msg
insidePageView page data transition =
    let
        appartments =
            data.appartments
    in
        case page.route of
            AppartmentsIndex ->
                appartmentsIndex appartments

            AppartmentsIndexEdit ->
                appartmentsIndexEdit appartments

            AppartmentsShow id ->
                appartmentsShow id appartments

            AppartmentsEdit id ->
                appartmentsEdit id appartments

            AppartmentsNew ->
                appartmentsNew data.draftAppartment


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
        [ Router.historyView insidePageView history data ]


updateAppartmentAttributesBasedOnMsg : UpdateAppartmentMsg -> AppartmentAttributes -> AppartmentAttributes
updateAppartmentAttributesBasedOnMsg msg attributes =
    case msg of
        UpdateMonthlyRent monthlyRent ->
            { attributes | monthlyRent = monthlyRent }

        UpdateCollocs collocs ->
            { attributes | collocs = collocs |> toPositiveInt }

        UpdateWorks works ->
            { attributes | works = works }

        UpdateTitle title ->
            { attributes | title = title }


updateAppartmentBasedOnMsg : UpdateAppartmentMsg -> Appartment -> Appartment
updateAppartmentBasedOnMsg msg appartment =
    let
        attributes =
            appartment.attributes
    in
        { appartment
            | attributes =
                updateAppartmentAttributesBasedOnMsg msg attributes
        }


updateAppartmentHelper : Appartment -> UpdateAppartmentMsg -> Model -> Model
updateAppartmentHelper appartment msg model =
    let
        newAppartment =
            updateAppartmentBasedOnMsg msg appartment

        data =
            model.data

        newAppartments =
            data.appartments
                |> List.filter (\e -> e.id /= appartment.id)
                |> (::) newAppartment

        newData =
            { data | appartments = newAppartments }
    in
        { model | data = newData }


updateAppartment : Int -> UpdateAppartmentMsg -> Model -> Model
updateAppartment id customMsg model =
    let
        maybeAppartment =
            model.data.appartments |> find_by .id id
    in
        case maybeAppartment of
            Nothing ->
                model

            Just appartment ->
                updateAppartmentHelper appartment customMsg model


updateAppartmentAttributes : UpdateAppartmentMsg -> Model -> Model
updateAppartmentAttributes customMsg model =
    let
        newAppartmentAttributes =
            updateAppartmentAttributesBasedOnMsg customMsg model.data.draftAppartment

        data =
            model.data

        newData =
            { data | draftAppartment = newAppartmentAttributes }
    in
        { model | data = newData }


draftAppartmentToAppartment : { a | newId : Int, createdAt : Time } -> AppartmentAttributes -> Appartment
draftAppartmentToAppartment { newId, createdAt } draftAppartment =
    { id = newId
    , createdAt = createdAt
    , updatedAt = createdAt
    , attributes = draftAppartment
    }


lastId : List { a | id : Int } -> Int
lastId =
    List.map .id >> List.maximum >> Maybe.withDefault 1


saveAppartmentAttributes : Time.Time -> Model -> Model
saveAppartmentAttributes currentTime ({ data } as model) =
    let
        newData =
            { data
                | appartments =
                    (draftAppartmentToAppartment
                        { newId = ((lastId data.appartments) + 1)
                        , createdAt = currentTime
                        }
                        data.draftAppartment
                    )
                        :: data.appartments
                , draftAppartment = initAppartmentAttributes
            }
    in
        { model | data = newData }


performSuccessfulTask : a -> Cmd a
performSuccessfulTask msg =
    Task.perform identity (Task.succeed msg)


destroyAppartment : Int -> Model -> Model
destroyAppartment id model =
    let
        data =
            model.data

        newData =
            { data | appartments = data.appartments |> List.filter (\e -> e.id /= id) }
    in
        { model | data = newData }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        HistoryMsgWrapper historyMsg ->
            ( { model | history = handleHistory historyMsg model.history }, Cmd.none )

        StandardHistoryWrapper historyMsg ->
            model |> Router.handleStandardHistory historyMsg

        UpdateAppartment id customMsg ->
            ( model |> updateAppartment id customMsg, Cmd.none )

        UpdateAppartmentAttributes customMsg ->
            ( model |> updateAppartmentAttributes customMsg, Cmd.none )

        SaveAppartmentAttributes ->
            ( model, Task.perform SaveAppartmentAttributesHelper Time.now )

        SaveAppartmentAttributesHelper time ->
            ( model |> saveAppartmentAttributes time, performSuccessfulTask (StandardHistoryWrapper Router.Back) )

        DestroyAppartment id ->
            ( model |> destroyAppartment id, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Router.maybeTransitionSubscription StandardHistoryWrapper model.history.transition


initAppartments : List Appartment
initAppartments =
    [ { id = 1
      , createdAt = Date.fromCalendarDate 2017 Aug 10 |> Date.toTime
      , updatedAt = Date.fromCalendarDate 2017 Aug 10 |> Date.toTime
      , attributes =
            { title = "Immeuble rapport (Belfort)"
            , details = "details"
            , monthlyRent = defaultMonthlyRent
            , collocs = defaultCollocs
            , works = 0
            , rate = 0.0175
            }
      }
    , { id = 2
      , createdAt = Date.fromCalendarDate 2017 Aug 10 |> Date.toTime
      , updatedAt = Date.fromCalendarDate 2017 Aug 10 |> Date.toTime
      , attributes =
            { title = "Immeuble rapport 2 (Belfort)"
            , details = "details"
            , monthlyRent = defaultMonthlyRent
            , collocs = defaultCollocs
            , works = 0
            , rate = 0.0175
            }
      }
    ]


initAppartmentAttributes : AppartmentAttributes
initAppartmentAttributes =
    { title = "New"
    , details = ""
    , works = 0
    , rate = 0.0175
    , monthlyRent = defaultMonthlyRent
    , collocs = defaultCollocs
    }


initData : Data
initData =
    { appartments = initAppartments
    , draftAppartment = initAppartmentAttributes
    }


init : Model
init =
    Router.initHistoryAndData AppartmentsIndex initData


main : Program Basics.Never Model Msg
main =
    program
        { init = ( init, Cmd.none )
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
