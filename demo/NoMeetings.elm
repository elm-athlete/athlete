module Main exposing
    ( Data
    , Goal
    , GoalAttributes
    , HistoryMsg(..)
    , MarkdownString
    , Model
    , Msg(..)
    , Participant
    , Persisted
    , Route(..)
    , TimeInterval
    , UpdateGoalMsg(..)
    , addCmd
    , appTitle
    , backgroundColor
    , collocNumberId
    , destroyGoal
    , draftGoalToGoal
    , goalsIndex
    , gray
    , handleHistory
    , init
    , initData
    , initGoalAttributes
    , initGoals
    , insidePageView
    , lastId
    , main
    , pad
    , performSuccessfulTask
    , result
    , saveGoalAttributes
    , standardCellStyle
    , subscriptions
    , textToHtml
    , title
    , titleView
    , titleViewWithDelete
    , toPositiveInt
    , update
    , updateGoal
    , updateGoalAttributes
    , updateGoalAttributesBasedOnMsg
    , updateGoalBasedOnMsg
    , updateGoalHelper
    , view
    )

import BodyBuilder as B exposing (..)
import BodyBuilder.Attributes as A exposing (style)
import BodyBuilder.Events as E
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
import Json.Decode as Decode exposing (Decoder)
import Modifiers exposing (..)
import Task
import Time exposing (Posix)


type alias Persisted a =
    { id : Int, createdAt : Posix, updatedAt : Posix, attributes : a }


type alias Goal =
    Persisted GoalAttributes


type alias TimeInterval =
    Float


type alias Participant =
    { name : String
    , hourlyRate : Int
    }


type alias GoalAttributes =
    { title : String
    , achieved : Bool
    }


type alias Data =
    { goals : List Goal
    , draftGoal : GoalAttributes
    , notes : String
    }


type Route
    = GoalsIndex
    | NotesIndex
    | GoalsCompletionsIndex


type alias Model =
    { history : History Route Msg
    , data : Data
    }


type HistoryMsg
    = GoToGoalsIndex
    | GoToNotesIndex
    | GoToGoalsCompletionsIndex


type UpdateGoalMsg
    = UpdateTitle String


type Msg
    = HistoryMsgWrapper HistoryMsg
    | StandardHistoryWrapper StandardHistoryMsg
    | UpdateGoal Int UpdateGoalMsg
    | UpdateGoalAttributes UpdateGoalMsg
    | DestroyGoal Int
    | SaveGoalAttributes
    | SaveGoalAttributesHelper Posix
    | UpdateData Data
    | Restart


type alias MarkdownString =
    String


handleHistory : HistoryMsg -> History Route Msg -> History Route Msg
handleHistory route history =
    case route of
        GoToGoalsIndex ->
            history |> Router.push (Router.pageWithDefaultTransition GoalsIndex)

        GoToNotesIndex ->
            history |> Router.push (Router.pageWithDefaultTransition NotesIndex)

        GoToGoalsCompletionsIndex ->
            history |> Router.push (Router.pageWithDefaultTransition GoalsCompletionsIndex)


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


titleView : Goal -> NodeWithStyle Msg
titleView goal =
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
                    ("GOAL " ++ (goal.id |> String.fromInt))
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
                , A.value goal.attributes.title
                , E.onInput (UpdateGoal goal.id << UpdateTitle)
                ]
            ]
        ]


titleViewWithDelete :
    Goal
    -> NodeWithStyle Msg
titleViewWithDelete goal =
    button
        [ standardCellStyle ]
        [ flex
            []
            [ flexItem [ E.onClick <| DestroyGoal goal.id ] [ text "⛔" ]
            , flexItem [ style [ Style.box [ Box.padding [ Padding.left Constants.medium ] ] ] ]
                [ text goal.attributes.title ]
            ]
        ]



-- rentrer des apparts, des photos, nom d'appart, plus les données, parking


pad : Modifier (A.BoxContainer (A.MaybeBlockContainer a))
pad =
    style
        [ Style.block []
        , Style.box [ Box.padding [ Padding.all Constants.medium ] ]
        ]


result : String -> Float -> NodeWithStyle msg
result label value =
    node [ pad ]
        [ text <| label
        , br
        , text (value |> String.fromFloat)
        ]


collocNumberId =
    "collocNumber"


toPositiveInt : Int -> Int
toPositiveInt i =
    if i < 1 then
        1

    else
        i



-- assurance : Generali


{-| returns a background with a color
-}
backgroundColor : Color.Color -> Modifier Box.Box
backgroundColor color =
    Box.background [ Elegant.color color ]


textToHtml : String -> List (NodeWithStyle msg)
textToHtml =
    (>>)
        (String.split "\n")
        (List.foldr (\e accu -> accu ++ [ text e, br ]) [])


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


nextButton numerator denominator nextPage =
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
        , flexItem [ style [ Style.box [ Box.paddingAll Constants.large ] ] ]
            [ a [ E.onClick (HistoryMsgWrapper nextPage) ] [ text ">" ]
            ]
        ]


largePadder =
    div [ style [ Style.box [ Box.paddingHorizontal Constants.large, Box.paddingBottom Constants.large ] ] ]


grayScaledText shade content =
    span [ style [ Style.box [ Box.textColor (Color.grayscale shade) ] ] ] [ text content ]


noMargin =
    style [ Style.box [ Box.margin [ Margin.all (Margin.width (px 0)) ] ] ]


alignedCellWithPurpleBackground : ( Int, Int ) -> ( Int, Int ) -> ( Flex.Align, Flex.JustifyContent ) -> List (NodeWithStyle msg) -> B.GridItem msg
alignedCellWithPurpleBackground =
    GridExtra.alignedCell [ Style.box [ Box.backgroundColor Color.purple ] ]


insidePageView : Data -> Router.Page Route Msg -> Maybe (Router.Transition Route Msg) -> NodeWithStyle Msg
insidePageView data page transition =
    let
        goals =
            data.goals
    in
    case page.route of
        GoalsIndex ->
            goalsIndex goals

        NotesIndex ->
            notesIndex data.notes

        GoalsCompletionsIndex ->
            goalsCompletionsIndex goals data.notes


blank =
    text ""


goalsIndex : List Goal -> NodeWithStyle Msg
goalsIndex goals =
    wizardView
        1
        GoToNotesIndex
        [ Router.headerElement
            { left = blank
            , center = appTitle
            , right = blank
            }
        , largePadder
            [ h1 [ noMargin ] [ grayScaledText 0.8 "Before" ]
            , p [ noMargin ] [ grayScaledText 0.4 "Set meeting objectives" ]
            ]
        ]
        (div
            [ style
                [ Style.box
                    [ Box.paddingTop Constants.large
                    ]
                ]
            ]
            (goals
                |> List.sortBy .id
                |> List.map titleView
            )
        )


notesIndex : String -> NodeWithStyle Msg
notesIndex notes =
    wizardView
        2
        GoToGoalsCompletionsIndex
        [ Router.headerElement
            { left = backButton
            , center = blank
            , right = restartButton
            }
        , largePadder
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
                        ]
                    , Style.box
                        [ Box.border [ Border.all [ Border.none ] ]
                        ]
                    ]
                , A.placeholder "Blah"
                ]
            ]
        )


goalsCompletionsIndex goals notes =
    wizardView
        3
        GoToGoalsIndex
        [ Router.headerElement
            { left = backButton
            , center = blank
            , right = restartButton
            }
        ]
        (text
            "TODO"
        )


backButton =
    menuLinkTo (StandardHistoryWrapper Router.Back) "< back"


restartButton =
    menuLinkTo Restart "restart"


menuLinkTo msg label =
    a [ E.onClick msg ] [ title label ]


wizardView step nextPage pageTitle pageContent =
    flex
        [ style
            [ Style.flexContainerProperties
                [ Flex.direction Flex.column
                , Flex.justifyContent Flex.spaceBetween
                ]
            , Style.block [ Block.minHeight (vh 100) ]
            , Style.box [ backgroundColor gray ]
            ]
        ]
        [ flexItem []
            [ div
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
            , pageContent
            ]
        , flexItem [] [ nextButton step 3 nextPage ]
        ]


view : Model -> NodeWithStyle Msg
view { history, data } =
    node
        [ style
            [ Style.block []
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


updateGoalAttributesBasedOnMsg : UpdateGoalMsg -> GoalAttributes -> GoalAttributes
updateGoalAttributesBasedOnMsg msg attributes =
    case msg of
        UpdateTitle title_ ->
            { attributes | title = title_ }


updateGoalBasedOnMsg : UpdateGoalMsg -> Goal -> Goal
updateGoalBasedOnMsg msg goal =
    let
        attributes =
            goal.attributes
    in
    { goal
        | attributes =
            updateGoalAttributesBasedOnMsg msg attributes
    }


updateGoalHelper : Goal -> UpdateGoalMsg -> Model -> Model
updateGoalHelper goal msg model =
    let
        newGoal =
            updateGoalBasedOnMsg msg goal

        data =
            model.data

        newGoals =
            data.goals
                |> List.filter (\e -> e.id /= goal.id)
                |> (::) newGoal

        newData =
            { data | goals = newGoals }
    in
    { model | data = newData }


updateGoal : Int -> UpdateGoalMsg -> Model -> Model
updateGoal id customMsg model =
    let
        maybeGoal =
            model.data.goals |> find_by .id id
    in
    case maybeGoal of
        Nothing ->
            model

        Just goal ->
            updateGoalHelper goal customMsg model


updateGoalAttributes : UpdateGoalMsg -> Model -> Model
updateGoalAttributes customMsg model =
    let
        newGoalAttributes =
            updateGoalAttributesBasedOnMsg customMsg model.data.draftGoal

        data =
            model.data

        newData =
            { data | draftGoal = newGoalAttributes }
    in
    { model | data = newData }


draftGoalToGoal : { a | newId : Int, createdAt : Posix } -> GoalAttributes -> Goal
draftGoalToGoal { newId, createdAt } draftGoal =
    { id = newId
    , createdAt = createdAt
    , updatedAt = createdAt
    , attributes = draftGoal
    }


lastId : List { a | id : Int } -> Int
lastId =
    List.map .id >> List.maximum >> Maybe.withDefault 0


saveGoalAttributes : Posix -> Model -> Model
saveGoalAttributes currentTime ({ data } as model) =
    let
        newData =
            { data
                | goals =
                    draftGoalToGoal
                        { newId = lastId data.goals + 1
                        , createdAt = currentTime
                        }
                        data.draftGoal
                        :: data.goals
                , draftGoal = initGoalAttributes
            }
    in
    { model | data = newData }


performSuccessfulTask : a -> Cmd a
performSuccessfulTask msg =
    Task.perform identity (Task.succeed msg)


destroyGoal : Int -> Model -> Model
destroyGoal id model =
    let
        data =
            model.data

        newData =
            { data | goals = data.goals |> List.filter (\e -> e.id /= id) }
    in
    { model | data = newData }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        HistoryMsgWrapper historyMsg ->
            ( { model | history = handleHistory historyMsg model.history }, Cmd.none )

        StandardHistoryWrapper historyMsg ->
            model |> Router.handleStandardHistory historyMsg

        UpdateGoal id customMsg ->
            ( model |> updateGoal id customMsg, Cmd.none )

        UpdateGoalAttributes customMsg ->
            ( model |> updateGoalAttributes customMsg, Cmd.none )

        UpdateData data ->
            ( { model | data = data }, Cmd.none )

        SaveGoalAttributes ->
            model
                |> update (StandardHistoryWrapper Back)
                |> addCmd (Task.perform SaveGoalAttributesHelper Time.now)

        SaveGoalAttributesHelper time ->
            ( model |> saveGoalAttributes time, Cmd.none )

        DestroyGoal id ->
            ( model |> destroyGoal id, Cmd.none )

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


initGoals : List Goal
initGoals =
    []


initGoalAttributes : GoalAttributes
initGoalAttributes =
    { title = ""
    , achieved = False
    }


initData : Data
initData =
    { goals = initGoals
    , draftGoal = initGoalAttributes
    , notes = ""
    }


homePage =
    -- GoalsIndex
    NotesIndex


initModel : Model
initModel =
    Router.initHistoryAndData homePage initData StandardHistoryWrapper


withAGoal =
    addCmd (Task.perform SaveGoalAttributesHelper Time.now)


withThreeGoals =
    withAGoal << withAGoal << withAGoal


init =
    ( initModel, Cmd.none )
        |> withThreeGoals


main : Program () Model Msg
main =
    element
        { init = \_ -> init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
