module Main exposing (main)

import BodyBuilder as B exposing (..)
import BodyBuilder.Attributes as A exposing (style)
import BodyBuilder.Events as E
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
        , pageWithHeader
        , push
        )
import BodyBuilder.Style as Style
import Color
import Elegant exposing (SizeUnit, percent, pt, px, vh)
import Elegant.Block as Block
import Elegant.Border as Border
import Elegant.Box as Box
import Elegant.Constants as Constants
import Elegant.Cursor as Cursor
import Elegant.Display as Display
import Elegant.Flex as Flex
import Elegant.Grid as Grid
import Elegant.Grid.Extra as GridExtra
import Elegant.Margin as Margin
import Elegant.Outline as Outline
import Elegant.Padding as Padding
import Elegant.Typography as Typography
import Html
import Html.Attributes
import Html.Events.Extra.Touch as Touch
import Json.Decode as Decode exposing (Decoder)
import Modifiers exposing (..)
import Task
import Time exposing (Posix)


type alias Persisted a =
    { id : Int, createdAt : Posix, updatedAt : Posix, attributes : a }


type alias Objective =
    Persisted ObjectiveAttributes


type alias TimeInterval =
    Float


type alias Participant =
    { name : String
    , hourlyRate : Int
    }


type alias ObjectiveAttributes =
    { title : String
    , achieved : Bool
    }


type alias Data =
    { objectives : List Objective
    , draftObjective : ObjectiveAttributes
    , notes : String
    }


type Route
    = ObjectivesIndex
    | NotesIndex
    | ObjectivesCompletionsIndex


type alias Model =
    { history : History Route Msg
    , data : Data
    }


type HistoryMsg
    = GoToObjectivesIndex
    | GoToNotesIndex
    | GoToObjectivesCompletionsIndex


type UpdateObjectiveMsg
    = UpdateTitle String
    | UpdateCompletion Bool
    | SwitchCompletion


type LinkType route
    = Goto route
    | Share String


type Msg
    = HistoryMsgWrapper HistoryMsg
    | StandardHistoryWrapper StandardHistoryMsg
    | UpdateObjective Int UpdateObjectiveMsg
    | UpdateObjectiveAttributes UpdateObjectiveMsg
    | DestroyObjective Int
    | SaveObjectiveAttributes
    | SaveObjectiveAttributesHelper Posix
    | UpdateData Data
    | UpdateNotes String
    | Restart


type alias MarkdownString =
    String


handleHistory : HistoryMsg -> History Route Msg -> History Route Msg
handleHistory route history =
    case route of
        GoToObjectivesIndex ->
            history |> Router.push (Router.pageWithDefaultTransition ObjectivesIndex)

        GoToNotesIndex ->
            history |> Router.push (Router.pageWithDefaultTransition NotesIndex)

        GoToObjectivesCompletionsIndex ->
            history |> Router.push (Router.pageWithDefaultTransition ObjectivesCompletionsIndex)


gray : Color.Color
gray =
    Color.grayscale 0.02


standardCellStyle : Modifier (A.BoxContainer (A.MaybeBlockContainer a))
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
                ]
            , Box.outline [ Outline.none ]
            , Box.typography
                [ Typography.fontFamilyInherit
                , Typography.size Constants.zeta
                ]
            ]
        ]


checkView objective =
    largePadderHorizontalAndBottom
        [ flex [ style [ Style.block [] ] ]
            [ flexItem []
                [ B.inputCheckbox
                    [ A.checked objective.attributes.achieved
                    , E.onCheck (UpdateObjective objective.id << UpdateCompletion)
                    ]
                ]
            , flexItem
                ([ style [ Style.box [ Box.cursorPointer ] ]
                 ]
                    ++ touchOrClickEvent (UpdateObjective objective.id SwitchCompletion)
                )
                [ grayScaledText
                    (if objective.attributes.achieved then
                        1

                     else
                        0.5
                    )
                    objective.attributes.title
                ]
            ]
        ]


titleView : Objective -> NodeWithStyle Msg
titleView objective =
    node
        [ standardCellStyle
        ]
        [ div
            [ style [ Style.box [ Box.paddingHorizontal Constants.large, Box.paddingBottom Constants.large ] ] ]
            [ div
                [ style
                    [ Style.box
                        [ Box.paddingBottom (Elegant.px 12)
                        , Box.textColor (Color.grayscale 0.5)
                        ]
                    ]
                ]
                [ text
                    ("OBJECTIVE " ++ (objective.id |> String.fromInt))
                ]
            , B.inputText
                [ style
                    [ Style.block
                        [ Display.fullWidth
                        ]
                    , Style.box
                        [ Box.paddingAll Constants.medium
                        ]
                    ]
                , A.value objective.attributes.title
                , E.onInput (UpdateObjective objective.id << UpdateTitle)
                ]
            ]
        ]


{-| returns a background with a color
-}
backgroundColor : Color.Color -> Modifier Box.Box
backgroundColor color =
    Box.background [ Elegant.color color ]


title : String -> NodeWithStyle msg
title content =
    node
        [ style
            [ Style.block []
            , Style.box [ Box.padding [ Padding.all (Elegant.px 12) ] ]
            ]
        ]
        [ text content ]


appTitle =
    title "No Meetings"


littleLine lineWidth color =
    flexItem
        [ style
            [ Style.flexItemProperties
                [ Flex.basis (px lineWidth)
                ]
            , Style.box
                [ Box.backgroundColor color ]
            ]
        ]
        [ div
            [ style
                [ Style.blockProperties
                    [ Block.height (px 5)
                    ]
                ]
            ]
            []
        ]


linePercent numerator denominator =
    flex [ style [ Style.block [ Block.width (px 200) ] ] ]
        [ littleLine (100 * numerator) Color.white
        , littleLine (100 * (denominator - numerator)) (Color.rgb 104 93 220)
        ]


linkStyle =
    style
        [ Style.box
            [ Box.cursorPointer
            , Box.textColor Color.white
            , Box.typography [ Typography.noDecoration ]
            , Box.paddingAll Constants.large
            ]
        , Style.block []
        ]


nextButton numerator denominator nextPage linkText =
    flex
        [ style
            [ Style.flexContainerProperties
                [ Flex.justifyContent Flex.spaceBetween
                , Flex.align Flex.alignCenter
                ]
            , Style.block []
            , Style.box [ Box.backgroundColor (Color.rgb 63 45 209), Box.textColor Color.white ]
            ]
        ]
        [ flexItem [ style [ Style.box [ Box.paddingAll Constants.large ] ] ]
            [ div [ style [ Style.box [ Box.paddingBottom Constants.medium ] ] ] [ text (String.fromInt numerator ++ " of " ++ String.fromInt denominator) ]
            , linePercent numerator denominator
            ]
        , flexItem []
            [ case nextPage of
                Goto to ->
                    span
                        ([ linkStyle
                         ]
                            ++ touchOrClickEvent to
                        )
                        [ text linkText ]

                Share content ->
                    a
                        [ A.href
                            ("mailto:?subject=Meeting defriefing&body="
                                ++ (content |> String.replace "\n" "%0D%0A")
                            )
                        , linkStyle
                        ]
                        [ text linkText ]
            ]
        ]


textToHtml : String -> List (NodeWithStyle msg)
textToHtml =
    (>>)
        (String.split "\n")
        (List.foldr (\e accu -> accu ++ [ text e, br ]) [])


largePadderHorizontalAndBottom =
    div
        [ style
            [ Style.box
                [ Box.paddingHorizontal Constants.large
                , Box.paddingBottom Constants.large
                ]
            ]
        ]


largePadderTop =
    div
        [ style
            [ Style.box
                [ Box.paddingTop Constants.large
                ]
            ]
        ]


largePadder =
    div
        [ style
            [ Style.box
                [ Box.paddingAll Constants.large ]
            ]
        ]


grayScaledText shade content =
    span [ style [ Style.box [ Box.textColor (Color.grayscale shade) ] ] ] [ text content ]


noMargin =
    style [ Style.box [ Box.margin [ Margin.all (Margin.width (px 0)) ] ] ]


alignedCellWithPurpleBackground : ( Int, Int ) -> ( Int, Int ) -> ( Flex.Align, Flex.JustifyContent ) -> List (NodeWithStyle msg) -> B.GridItem msg
alignedCellWithPurpleBackground =
    GridExtra.alignedCell [ Style.box [ Box.backgroundColor Color.purple ] ]


objectivesIndexToHtml =
    B.stylise objectivesIndex


notesIndexToHtml =
    B.stylise notesIndex


objectivesCompletionsIndexToHtml =
    B.stylise2 objectivesCompletionsIndex


insidePageView : Data -> Router.Page Route Msg -> Maybe (Router.Transition Route Msg) -> NodeWithStyle Msg
insidePageView data page transition =
    let
        objectives =
            data.objectives
    in
    case page.route of
        ObjectivesIndex ->
            B.lazy objectivesIndexToHtml objectives

        NotesIndex ->
            B.lazy notesIndexToHtml data.notes

        ObjectivesCompletionsIndex ->
            B.lazy2 objectivesCompletionsIndexToHtml objectives data.notes


blank =
    text ""


objectivesIndex : List Objective -> NodeWithStyle Msg
objectivesIndex objectives =
    wizardView
        1
        (Goto (HistoryMsgWrapper GoToNotesIndex))
        [ Router.headerElement
            { left = blank
            , center = appTitle
            , right = contactButton
            }
        , largePadderHorizontalAndBottom
            [ h1 [ noMargin ] [ grayScaledText 0.8 "Before" ]
            , p [ noMargin ] [ grayScaledText 0.4 "Set meeting objectives" ]
            ]
        ]
        (largePadder
            (objectives
                |> List.sortBy .id
                |> List.map titleView
            )
        )
        ">"


notesIndex : String -> NodeWithStyle Msg
notesIndex notes =
    wizardView
        2
        (Goto (HistoryMsgWrapper GoToObjectivesCompletionsIndex))
        [ Router.headerElement
            { left = backButton
            , center = blank
            , right = restartButton
            }
        , largePadderHorizontalAndBottom
            [ h1 [ noMargin ] [ grayScaledText 0.8 "During" ]
            , p [ noMargin ] [ grayScaledText 0.4 "Take notes" ]
            ]
        ]
        (div [ style [ Style.blockProperties [ Block.height (percent 100) ] ] ]
            [ B.textarea
                [ style
                    [ Style.block
                        [ Block.width (percent 100)
                        , Block.height (percent 100)
                        , Block.minHeight (px 300)
                        ]
                    , Style.box
                        [ Box.border [ Border.all [ Border.none ] ]
                        , Box.paddingAll (px 24)
                        ]
                    ]
                , A.placeholder "Start typing..."
                , A.value notes
                , E.onInput UpdateNotes
                ]
            ]
        )
        ">"


objectivesCompletionsIndex : List Objective -> String -> NodeWithStyle Msg
objectivesCompletionsIndex objectives notes =
    wizardView
        3
        (Share
            ("# Achievements:\n\n"
                ++ (objectives
                        |> List.filter (\e -> e.attributes.achieved)
                        |> List.map .attributes
                        |> List.map .title
                        |> List.map (\e -> "- " ++ e)
                        |> String.join "\n"
                   )
                ++ "\n\n\n"
                ++ "# Notes:\n\n"
                ++ notes
            )
        )
        -- (HistoryMsgWrapper GoToObjectivesIndex)
        [ Router.headerElement
            { left = backButton
            , center = blank
            , right = restartButton
            }
        , largePadderHorizontalAndBottom
            [ h1 [ noMargin ] [ grayScaledText 0.8 "After" ]
            , p [ noMargin ] [ grayScaledText 0.4 "Review objectives and share notes" ]
            ]
        ]
        (largePadder
            [ div []
                (objectives
                    |> List.filter (\e -> not (String.isEmpty e.attributes.title))
                    |> List.sortBy .id
                    |> List.map checkView
                )
            , div [] (notes |> textToHtml)
            ]
        )
        "share"


touchOrClickEvent msg =
    [ A.rawAttribute (Touch.onStart (\_ -> msg)), E.onClick msg ]


backButton =
    menuLinkTo (StandardHistoryWrapper Router.Back) "< back"


contactButton =
    menuLinkToHref "https://notonlymeetings.com" "contact us"


restartButton =
    menuLinkTo Restart "restart"


menuLinkToHref href label =
    a
        [ style
            [ Style.box
                [ Box.cursorPointer
                ]
            ]
        , A.href href
        ]
        [ title label ]


menuLinkTo msg label =
    div
        ([ style
            [ Style.box
                [ Box.cursorPointer
                ]
            ]
         ]
            ++ touchOrClickEvent msg
        )
        [ title label ]


wizardView step nextPage pageTitle pageContent linkText =
    flex
        [ style
            [ Style.flexContainerProperties
                [ Flex.direction Flex.column
                , Flex.justifyContent Flex.spaceBetween
                ]
            , Style.block [ Block.minHeight (percent 100) ]
            , Style.box [ backgroundColor gray ]
            ]
        ]
        [ flexItem
            [ style
                [ Style.flexItemProperties
                    [ Flex.grow 1
                    ]
                ]
            ]
            [ flex
                [ style
                    [ Style.flexContainerProperties
                        [ Flex.direction Flex.column
                        , Flex.justifyContent Flex.spaceBetween
                        ]
                    , Style.block [ Block.height (percent 100) ]
                    ]
                ]
                [ flexItem
                    [ style
                        [ Style.box
                            [ backgroundColor Color.white
                            , Box.border
                                [ Border.bottom
                                    [ Border.color (Color.grayscale 0.2)
                                    , Border.solid
                                    , Border.thickness (px 1)
                                    ]
                                ]
                            ]
                        ]
                    ]
                    pageTitle
                , flexItem
                    [ style
                        [ Style.flexItemProperties
                            [ Flex.grow 1
                            ]
                        ]
                    ]
                    [ pageContent ]
                ]
            ]
        , flexItem
            [ style
                [ Style.flexItemProperties
                    [ Flex.shrink 0
                    ]
                ]
            ]
            [ nextButton step 3 nextPage linkText ]
        ]


view : Model -> NodeWithStyle Msg
view { history, data } =
    div
        [ style
            [ Style.blockProperties [ Block.height (percent 100) ]
            , Style.box
                [ Box.typography
                    [ Typography.fontFamilySansSerif
                    , Typography.size Constants.zeta
                    ]
                ]
            ]
        ]
        [ Router.historyView (insidePageView data) history
        ]


updateObjectiveAttributesBasedOnMsg : UpdateObjectiveMsg -> ObjectiveAttributes -> ObjectiveAttributes
updateObjectiveAttributesBasedOnMsg msg attributes =
    case msg of
        UpdateTitle title_ ->
            { attributes | title = title_ }

        UpdateCompletion achieved_ ->
            { attributes | achieved = achieved_ }

        SwitchCompletion ->
            { attributes | achieved = not attributes.achieved }


updateObjectiveBasedOnMsg : UpdateObjectiveMsg -> Objective -> Objective
updateObjectiveBasedOnMsg msg objective =
    let
        attributes =
            objective.attributes
    in
    { objective
        | attributes =
            updateObjectiveAttributesBasedOnMsg msg attributes
    }


eounah =
    2


updateObjectiveHelper : Objective -> UpdateObjectiveMsg -> Model -> Model
updateObjectiveHelper objective msg model =
    let
        newObjective =
            updateObjectiveBasedOnMsg msg objective

        data =
            model.data

        newObjectives =
            data.objectives
                |> List.filter (\e -> e.id /= objective.id)
                |> (::) newObjective

        newData =
            { data | objectives = newObjectives }
    in
    { model | data = newData }


find_by : (a -> b) -> b -> List a -> Maybe a
find_by insideDataFun data =
    List.filter (\e -> insideDataFun e == data)
        >> List.head


updateObjective : Int -> UpdateObjectiveMsg -> Model -> Model
updateObjective id customMsg model =
    let
        maybeObjective =
            model.data.objectives |> find_by .id id
    in
    case maybeObjective of
        Nothing ->
            model

        Just objective ->
            updateObjectiveHelper objective customMsg model


updateObjectiveAttributes : UpdateObjectiveMsg -> Model -> Model
updateObjectiveAttributes customMsg model =
    let
        newObjectiveAttributes =
            updateObjectiveAttributesBasedOnMsg customMsg model.data.draftObjective

        data =
            model.data

        newData =
            { data | draftObjective = newObjectiveAttributes }
    in
    { model | data = newData }


draftObjectiveToObjective : { a | newId : Int, createdAt : Posix } -> ObjectiveAttributes -> Objective
draftObjectiveToObjective { newId, createdAt } draftObjective =
    { id = newId
    , createdAt = createdAt
    , updatedAt = createdAt
    , attributes = draftObjective
    }


lastId : List { a | id : Int } -> Int
lastId =
    List.map .id >> List.maximum >> Maybe.withDefault 0


saveObjectiveAttributes : Posix -> Model -> Model
saveObjectiveAttributes currentTime ({ data } as model) =
    let
        newData =
            { data
                | objectives =
                    draftObjectiveToObjective
                        { newId = lastId data.objectives + 1
                        , createdAt = currentTime
                        }
                        data.draftObjective
                        :: data.objectives
                , draftObjective = initObjectiveAttributes
            }
    in
    { model | data = newData }


destroyObjective : Int -> Model -> Model
destroyObjective id model =
    let
        data =
            model.data

        newData =
            { data | objectives = data.objectives |> List.filter (\e -> e.id /= id) }
    in
    { model | data = newData }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        HistoryMsgWrapper historyMsg ->
            ( { model | history = handleHistory historyMsg model.history }, Cmd.none )

        StandardHistoryWrapper historyMsg ->
            model |> Router.handleStandardHistory historyMsg

        UpdateObjective id customMsg ->
            ( model |> updateObjective id customMsg, Cmd.none )

        UpdateObjectiveAttributes customMsg ->
            ( model |> updateObjectiveAttributes customMsg, Cmd.none )

        UpdateData data ->
            ( { model | data = data }, Cmd.none )

        UpdateNotes notes ->
            let
                data =
                    model.data
            in
            update (UpdateData { data | notes = notes }) model

        SaveObjectiveAttributes ->
            model
                |> update (StandardHistoryWrapper Back)
                |> addCmd (Task.perform SaveObjectiveAttributesHelper Time.now)

        SaveObjectiveAttributesHelper time ->
            ( model |> saveObjectiveAttributes time, Cmd.none )

        DestroyObjective id ->
            ( model |> destroyObjective id, Cmd.none )

        Restart ->
            init


addCmd : Cmd msg -> ( model, Cmd msg ) -> ( model, Cmd msg )
addCmd cmd ( model, cmds ) =
    ( model, Cmd.batch [ cmd, cmds ] )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Router.maybeTransitionSubscription model.history
        ]


initObjectives : List Objective
initObjectives =
    []


initObjectiveAttributes : ObjectiveAttributes
initObjectiveAttributes =
    { title = ""
    , achieved = False
    }


initData : Data
initData =
    { objectives = initObjectives
    , draftObjective = initObjectiveAttributes
    , notes = ""
    }


homePage =
    ObjectivesIndex



-- NotesIndex
-- ObjectivesCompletionsIndex


initModel : Model
initModel =
    Router.initHistoryAndData homePage initData StandardHistoryWrapper


withAObjective =
    addCmd (Task.perform SaveObjectiveAttributesHelper Time.now)


withThreeObjectives =
    withAObjective << withAObjective << withAObjective


init =
    ( initModel, Cmd.none )
        |> withThreeObjectives


main : Program () Model Msg
main =
    element
        { init = \_ -> init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
