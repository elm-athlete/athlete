module Rentability exposing (..)

import BodyBuilder exposing (..)
import Elegant exposing (textCenter, padding, SizeUnit(..), fontSize)
import Elegant.Elements exposing (borderBottom)
import Color
import Date
import Date exposing (Month(..))
import Time exposing (Time)
import Date.Extra as Date
import Router exposing (..)
import Finders exposing (..)
import Function exposing (compose)
import Task


type Route
    = AppartmentsIndex
    | AppartmentsShow Int
    | AppartmentsEdit Int
    | AppartmentsNew
    | AppartmentsIndexEdit


type alias Data =
    { appartments : List Appartment
    , draftAppartment : DraftAppartment
    }


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
    | UpdateDraftAppartment UpdateAppartmentMsg
    | DestroyAppartment Int
    | SaveDraftAppartment
    | SaveDraftAppartmentHelper Time


type alias MarkdownString =
    String


type alias Persisted a =
    { a | id : Int, createdAt : Time, updatedAt : Time }


type alias Appartment =
    Persisted DraftAppartment


type alias DraftAppartment =
    { title : String
    , details : MarkdownString
    , monthlyRent : Int
    , collocs : Int
    , works : Int
    , rate : Float
    }


handleHistory : HistoryMsg -> History Route -> History Route
handleHistory route history =
    case route of
        AppartmentShowMsg id ->
            history |> push (pageWithDefaultTransition (AppartmentsShow id))

        AppartmentEditMsg id ->
            history |> push (pageWithTransition (slideUp) (AppartmentsEdit id))

        AppartmentNewMsg ->
            history |> push (pageWithTransition (slideUp) AppartmentsNew)

        AppartmentsIndexEditMsg ->
            history |> push (pageWithoutTransition AppartmentsIndexEdit)


gray : Color.Color
gray =
    Color.grayscale 0.9


standardCellStyle :
    { a | style : StyleAttribute }
    -> { a | style : StyleAttribute }
standardCellStyle =
    [ style
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
        |> compose


titleView : Appartment -> Node Interactive phrasingContent Spanning NotListElement Msg
titleView appartment =
    button
        [ onClick <|
            HistoryMsgWrapper <|
                AppartmentShowMsg appartment.id
        , standardCellStyle
        ]
        [ text appartment.title ]


titleViewWithDelete appartment =
    button
        [ standardCellStyle
        ]
        [ div [ style [ Elegant.displayFlex ] ]
            [ div [ onClick <| DestroyAppartment appartment.id ] [ text "⛔" ]
            , div [ style [ Elegant.paddingLeft Elegant.medium ] ] [ text appartment.title ]
            ]
        ]


showView : { b | maybeAppartment : Maybe Appartment } -> Node interactiveContent Phrasing Spanning NotListElement Msg
showView data =
    case data.maybeAppartment of
        Nothing ->
            div [] [ text "Error" ]

        Just appartment ->
            pageWithHeader
                (headerElement
                    { left = headerButton (StandardHistoryWrapper Back) "← BACK"
                    , center =
                        div
                            []
                            [ text appartment.title
                            ]
                    , right = headerButton (HistoryMsgWrapper (AppartmentEditMsg appartment.id)) "Edit"
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


maxPrice : Appartment -> Float
maxPrice ({ collocs } as model) =
    (yearlyRent model |> toFloat) / ((renta collocs) / 100)


yearsOfDebt : number
yearsOfDebt =
    25


monthlyBankDebt : Appartment -> Int
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


minSalary : Appartment -> Int
minSalary model =
    (model |> monthlyBankDebt) * 3


pad =
    style [ padding Elegant.medium ]


result label value =
    div [ pad ]
        [ text <| label
        , br []
        , text (value |> toString)
        ]


yearlyRent : Appartment -> Int
yearlyRent model =
    (totalMonthlyRent model) * 12


totalMonthlyRent : Appartment -> Int
totalMonthlyRent { collocs, monthlyRent } =
    monthlyRent * collocs


appartmentEditBodyView model =
    div []
        [ result "Renta standard en % : " (renta model.collocs)
        , div [ pad ]
            [ div []
                [ text
                    ("Loyer mensuel "
                        ++ (if model.collocs > 1 then
                                " (par locataire)"
                            else
                                ""
                           )
                    )
                ]
            , inputNumber
                [ value (model.monthlyRent)
                , onInput (UpdateAppartment model.id << UpdateMonthlyRent)
                ]
            ]
        , div [ pad ]
            [ div [] [ text "Nombre de locataires" ]
            , inputNumber
                [ value (model.collocs)
                , onInput (UpdateAppartment model.id << UpdateCollocs)
                ]
            ]
        , div [ pad ]
            [ div [] [ text "Travaux" ]
            , inputNumber
                [ value (model.works)
                , onInput (UpdateAppartment model.id << UpdateWorks)
                ]
            ]
        , result "Loyer mensuel total : " (totalMonthlyRent model)
        , result "Loyer annuel : " (yearlyRent model)
        , result "Prix d'acquisition global (travaux compris) max conseillé : " (maxPrice model)
        , result "Prix d'acquisition global (sans travaux) max conseillé : " (maxPrice model - (model.works |> toFloat))
        , result "Prix d'acquisition global (avant frais notaires) max conseillé : " ((maxPrice model - (model.works |> toFloat)) / 1.08)
        , result "Mensualités moyennes à payer à la banque (20 ans) : " (monthlyBankDebt model)
        , result "Revenus minimum pour endettement : " (minSalary model)
        ]


toPositiveInt : Int -> Int
toPositiveInt i =
    if i < 1 then
        1
    else
        i



-- assurance : Generali


mainElement html =
    div
        [ style
            [ Elegant.overflowYScroll
            , Elegant.fullWidth
            ]
        ]
        [ html
        ]


pageWithHeader header page =
    div
        [ style
            [ Elegant.backgroundColor Color.white
            , Elegant.height (Vh 100)
            , Elegant.displayFlex
            , Elegant.flexDirectionColumn
            ]
        ]
        [ header
        , mainElement page
        ]


editView data =
    case data.maybeAppartment of
        Nothing ->
            div [] [ text "Error" ]

        Just appartment ->
            pageWithHeader
                (headerElement
                    { left = headerButton (StandardHistoryWrapper Back) "x"
                    , center = div [] [ text appartment.title ]
                    , right = div [] []
                    }
                )
                (appartmentEditBodyView appartment)


textToHtml : String -> List (Node interactiveContent Phrasing spanningContent NotListElement msg)
textToHtml =
    (>>)
        (String.split "\n")
        (List.foldl (\e accu -> accu ++ [ text e, br [] ]) [])


appartmentBodyView : Appartment -> Node interactiveContent Phrasing Spanning NotListElement msg
appartmentBodyView appartment =
    div [ style [ Elegant.paddingHorizontal Elegant.medium ] ]
        ([ div [] (textToHtml appartment.details)
         ]
        )


appartmentsIndex : List Appartment -> Node Interactive phrasingContent Spanning NotListElement Msg
appartmentsIndex appartments =
    pageWithHeader
        (headerElement
            { left = headerButton (HistoryMsgWrapper AppartmentsIndexEditMsg) "Edit"
            , center = div [] [ text "Rentabilize" ]
            , right = headerButton (HistoryMsgWrapper AppartmentNewMsg) "New"
            }
        )
        (div [ style [ Elegant.backgroundColor gray ] ]
            (appartments |> List.map titleView)
        )


appartmentsIndexEdit appartments =
    pageWithHeader
        (headerElement
            { left = headerButton (StandardHistoryWrapper Back) "Done"
            , center = div [] [ text "Rentabilize" ]
            , right = text ""
            }
        )
        (div [ style [ Elegant.backgroundColor gray ] ]
            (appartments |> List.map titleViewWithDelete)
        )


appartmentsShow : Int -> List Appartment -> Node interactiveContent Phrasing Spanning NotListElement Msg
appartmentsShow id appartments =
    div [] [ showView { maybeAppartment = (appartments |> find_by .id id) } ]


appartmentsEdit :
    Int
    -> List Appartment
    -> Node Interactive Phrasing Spanning NotListElement Msg
appartmentsEdit id appartments =
    div [] [ editView { maybeAppartment = (appartments |> find_by .id id) } ]


appartmentsNew draftAppartment =
    pageWithHeader
        (headerElement
            { left = headerButton (StandardHistoryWrapper Back) "cancel"
            , center = div [] [ text draftAppartment.title ]
            , right = headerButton SaveDraftAppartment "save"
            }
        )
        (div
            []
            [ inputText [ value draftAppartment.title, onInput (UpdateDraftAppartment << UpdateTitle) ]
            ]
        )


insidePageView : Page Route -> Data -> Maybe Transition -> Node Interactive Phrasing Spanning NotListElement Msg
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


view : Model -> Node Interactive Phrasing Spanning NotListElement Msg
view { history, data } =
    div [ style [ Elegant.fontFamilySansSerif, Elegant.fontSize Elegant.zeta ] ]
        [ historyView insidePageView history data ]


updateAppartmentBasedOnMsg msg appartment =
    case msg of
        UpdateMonthlyRent monthlyRent ->
            { appartment | monthlyRent = monthlyRent }

        UpdateCollocs collocs ->
            { appartment | collocs = collocs |> toPositiveInt }

        UpdateWorks works ->
            { appartment | works = works }

        UpdateTitle title ->
            { appartment | title = title }


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


updateDraftAppartment customMsg model =
    let
        newDraftAppartment =
            updateAppartmentBasedOnMsg customMsg model.data.draftAppartment

        data =
            model.data

        newData =
            { data | draftAppartment = newDraftAppartment }
    in
        { model | data = newData }


draftAppartmentToAppartment : { a | newId : Int, createdAt : Time } -> DraftAppartment -> Appartment
draftAppartmentToAppartment { newId, createdAt } draftAppartment =
    { id = newId
    , createdAt = createdAt
    , updatedAt = createdAt
    , title = draftAppartment.title
    , details = draftAppartment.details
    , monthlyRent = draftAppartment.monthlyRent
    , collocs = draftAppartment.collocs
    , works = draftAppartment.works
    , rate = draftAppartment.rate
    }


lastId : List { a | id : Int } -> Int
lastId =
    List.map .id >> List.maximum >> Maybe.withDefault 1


saveDraftAppartment : Time.Time -> Model -> Model
saveDraftAppartment currentTime ({ data } as model) =
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
                , draftAppartment = initDraftAppartment
            }
    in
        { model | data = newData }


performSuccessfulTask : a -> Cmd a
performSuccessfulTask msg =
    Task.perform identity (Task.succeed msg)


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
            model |> handleStandardHistory historyMsg

        UpdateAppartment id customMsg ->
            ( model |> updateAppartment id customMsg, Cmd.none )

        UpdateDraftAppartment customMsg ->
            ( model |> updateDraftAppartment customMsg, Cmd.none )

        SaveDraftAppartment ->
            ( model, Task.perform SaveDraftAppartmentHelper Time.now )

        SaveDraftAppartmentHelper time ->
            ( model |> saveDraftAppartment time, performSuccessfulTask (StandardHistoryWrapper Back) )

        DestroyAppartment id ->
            ( model |> destroyAppartment id, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    maybeTransitionSubscription StandardHistoryWrapper model.history.transition


initAppartments : List Appartment
initAppartments =
    [ { id = 1
      , title = "Immeuble rapport (Belfort)"
      , createdAt = Date.fromCalendarDate 2017 Aug 10 |> Date.toTime
      , updatedAt = Date.fromCalendarDate 2017 Aug 10 |> Date.toTime
      , details = "details"
      , monthlyRent = defaultMonthlyRent
      , collocs = defaultCollocs
      , works = 0
      , rate = 0.0175
      }
    , { id = 2
      , title = "Immeuble rapport 2 (Belfort)"
      , createdAt = Date.fromCalendarDate 2017 Aug 10 |> Date.toTime
      , updatedAt = Date.fromCalendarDate 2017 Aug 10 |> Date.toTime
      , details = "details"
      , monthlyRent = defaultMonthlyRent
      , collocs = defaultCollocs
      , works = 0
      , rate = 0.0175
      }
    ]


initDraftAppartment =
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
    , draftAppartment = initDraftAppartment
    }


init : { data : Data, history : History Route }
init =
    initHistoryAndData AppartmentsIndex initData


main : Program Basics.Never Model Msg
main =
    program
        { init = ( init, Cmd.none )
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
