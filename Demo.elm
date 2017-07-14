module Demo exposing (..)

import Elegant exposing (..)
import Elegant.Elements exposing (..)
import Color exposing (..)
import Color.Manipulate as Color
import BodyBuilder exposing (..)
import Function exposing (..)
import Elegant.Grid exposing (..)
import Elegant.Elements as Elements exposing (..)


type Msg
    = ChangeColor Color
    | ChangeWidth Int
    | ChangeGutter Int
    | ChangeColumnsNumber Int
    | ChangeBootstrapState Bool
    | ChangeBodyBuilderState Bool
    | ChangeBoth Bool
    | Blah String


type alias Model =
    { color : Color
    , columnWidth : Int
    , gutterWidth : Int
    , columnsNumber : Int
    , bootstrapState : Bool
    , bodybuilderState : Bool
    }


buttonStyle color =
    [ style [ outlineNone, backgroundColor color, Elegant.round, borderNone, h1S, padding medium, overflowHidden ]
    , focusStyle [ backgroundColor (Color.saturate 0.5 color), boxShadowCenteredBlurry (Px 1) Color.black ]
    ]
        |> compose


exampleGridContent content =
    [ div [ style [ paddingBottom medium ] ]
        [ div [ style [ Elements.border Color.black, padding large, textCenter ] ]
            [ text content
            ]
        ]
    ]


view :
    Model
    -> BodyBuilder.Node BodyBuilder.Interactive BodyBuilder.NotPhrasing BodyBuilder.Spanning BodyBuilder.NotListElement Msg
view { color, columnWidth, gutterWidth, columnsNumber, bodybuilderState, bootstrapState } =
    div
        [ style
            [ maxWidth (Percent 100)
            , Elegant.width (Px 1024)
            , marginAuto
            , padding medium
            , Elegant.fontFamilySansSerif
            ]
        ]
        [ h1
            [ style
                [ paddingBottom tiny
                , textCenter
                , fontSize alpha
                ]
            ]
            [ text "Elegant" ]
        , h2
            [ style
                [ paddingBottom tiny
                ]
            ]
            [ text "Alignment" ]
        , div
            [ style
                [ Elegant.width (Px 400)
                , marginAuto
                , border black
                , padding medium
                ]
            ]
            [ text "I'm centered with auto margins and a width of 400px" ]
        , div
            [ style
                [ Elegant.width (Px 600)
                , marginAuto
                , border black
                , padding medium
                ]
            ]
            [ text "I'm centered with auto margins and a width of 600px" ]
        , div
            [ style
                [ textCenter
                ]
            ]
            [ text "I'm centered" ]
        , div
            [ style
                [ textRight
                ]
            ]
            [ text "I'm right aligned" ]
        , div
            [ style
                [ textLeft
                ]
            ]
            [ text "I'm left aligned" ]
        , div
            [ style
                [ backgroundColor (Color.rgb 40 160 240)
                , textColor (Color.rgb (255 - 40) (255 - 160) (255 - 240))
                , padding medium
                ]
            ]
            [ text "I'm colored" ]
        , div
            [ style
                [ border black
                , borderWidth 3
                ]
            ]
            [ text "I have a big black border" ]
        , h2
            [ style
                [ paddingBottom tiny
                ]
            ]
            [ text "Flex" ]
        , div [ style [ displayFlex, spaceBetween ] ]
            [ div [ style [ padding medium ] ] [ text "Some" ]
            , div [ style [ padding medium ] ] [ text "Flex" ]
            , div [ style [ padding medium ] ] [ text "Elements" ]
            , div [ style [ padding medium ] ] [ text "With" ]
            , div [ style [ padding medium ] ] [ text "Space" ]
            , div [ style [ padding medium ] ] [ text "Between" ]
            ]
        , div [ style [ displayFlex, spaceAround ] ]
            [ div [ style [ padding medium ] ] [ text "Some" ]
            , div [ style [ padding medium ] ] [ text "Flex" ]
            , div [ style [ padding medium ] ] [ text "Elements" ]
            , div [ style [ padding medium ] ] [ text "With" ]
            , div [ style [ padding medium ] ] [ text "Space" ]
            , div [ style [ padding medium ] ] [ text "Around" ]
            ]
        , div [ style [ displayFlex, spaceBetween, alignItemsCenter ] ]
            [ div [ style [ padding medium ] ] [ text "Some" ]
            , div [ style [ padding medium ] ] [ text "Flex" ]
            , div [ style [ padding medium ] ] [ text "Elements" ]
            , div [ style [ padding medium ] ] [ text "With" ]
            , div [ style [ padding medium ] ] [ text "Space" ]
            , div [ style [ padding medium ] ] [ text "Between" ]
            , div [ style [ padding medium, flex 1, textRight ] ] [ text "And one element taking the rest of the place" ]
            ]
        , h1 []
            [ text "I am h1" ]
        , h2 []
            [ text "I am h2" ]
        , h3 []
            [ text "I am h3" ]
        , h4 []
            [ text "I am h4" ]
        , h5 []
            [ text "I am h5" ]
        , h6 []
            [ text "I am h6" ]
        , div [ style [ h1S ] ]
            [ text "I am h1 styled" ]
        , div [ style [ h2S ] ]
            [ text "I am h2 styled" ]
        , div [ style [ h3S ] ]
            [ text "I am h3 styled" ]
        , div [ style [ h4S ] ]
            [ text "I am h4 styled" ]
        , div [ style [ h5S ] ]
            [ text "I am h5 styled" ]
        , div [ style [ h6S ] ]
            [ text "I am h6 styled" ]
        , div [ style [ textCenter, padding medium, displayInlineBlock, Elegant.round, strong, uppercase, border black, padding medium ] ]
            [ text "I am round, strong and uppercase" ]
        , inputColor [ style [ Elegant.displayBlock ], value color, onInput ChangeColor ]
        , BodyBuilder.button
            [ buttonStyle color ]
            [ text "Push me" ]
        , inputText [ style [ Elegant.displayBlock ], name "inputText", value "inputText_" ]
        , div []
            [ inputCheckbox [ style [ Elegant.displayInlineBlock ], checked (bootstrapState && bodybuilderState), onCheck ChangeBoth ]
            , span [] [ text "I like Both" ]
            ]
        , div [ style [ paddingLeft large ] ]
            [ div []
                [ inputCheckbox [ style [ Elegant.displayInlineBlock ], checked bootstrapState, onCheck ChangeBootstrapState ]
                , span [] [ text "I like Bootstrap" ]
                ]
            , div []
                [ inputCheckbox [ style [ Elegant.displayInlineBlock ], checked bodybuilderState, onCheck ChangeBodyBuilderState ]
                , span [] [ text "I like BodyBuilder" ]
                ]
            ]
        , inputFile [ style [ Elegant.displayBlock ] ]
        , inputPassword [ style [ Elegant.displayBlock ], value "" ]
        , inputRadio [ style [ Elegant.displayBlock ], value "Test" ]
        , inputUrl [ style [ Elegant.displayBlock ], name "inputUrl" ]
        , inputSubmit [ style [ Elegant.displayBlock ], value "Submit Form" ]
        , h2 [ style [ paddingTop medium ] ] [ text "Parametrable grid !" ]
        , h3 [] [ text "Gutter width (default 12 px)" ]
        , inputRange [ style [ Elegant.displayInlineBlock ], value gutterWidth, onInput ChangeGutter ]
        , inputNumber [ style [ Elegant.displayInlineBlock ], value gutterWidth, onInput ChangeGutter ]
        , h3 [] [ text "Columns number (default 12)" ]
        , inputRange [ style [ Elegant.displayInlineBlock ], value columnsNumber, BodyBuilder.min 6, BodyBuilder.max 12, BodyBuilder.step 2, onInput ChangeColumnsNumber ]
        , inputNumber [ style [ Elegant.displayInlineBlock ], value columnsNumber, BodyBuilder.min 6, BodyBuilder.max 12, BodyBuilder.step 2, onInput ChangeColumnsNumber ]
        , h3 [] [ text "Columns width : number of units by column (default 2)" ]
        , inputRange [ style [ Elegant.displayInlineBlock ], value columnWidth, BodyBuilder.min 2, BodyBuilder.max 6, onInput ChangeWidth ]
        , inputNumber [ style [ Elegant.displayInlineBlock ], value columnWidth, BodyBuilder.min 2, BodyBuilder.max 6, onInput ChangeWidth ]
        , textarea [ value (gutterWidth |> toString) ]
        , grid (Px gutterWidth)
            [ col columnsNumber columnWidth (exampleGridContent "BodyBuilder")
            , col columnsNumber (columnWidth) (exampleGridContent "is")
            , col columnsNumber (columnWidth) (exampleGridContent "awesome")
            , col columnsNumber (columnWidth) (exampleGridContent "to")
            ]
        , grid (Px gutterWidth)
            [ col 12 6 (exampleGridContent "design")
            , col 12 6 (exampleGridContent "your")
            , col 12 6 (exampleGridContent "own")
            , col 12 6 (exampleGridContent "grids")
            ]
        ]


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        ChangeColor color ->
            ( { model | color = color }, Cmd.none )

        ChangeWidth width ->
            ( { model | columnWidth = width }, Cmd.none )

        ChangeGutter gutter ->
            ( { model | gutterWidth = gutter }, Cmd.none )

        ChangeColumnsNumber columnsNumber ->
            ( { model | columnsNumber = columnsNumber }, Cmd.none )

        ChangeBootstrapState state ->
            ( { model | bootstrapState = state }, Cmd.none )

        ChangeBodyBuilderState state ->
            ( { model | bodybuilderState = state }, Cmd.none )

        ChangeBoth state ->
            ( { model | bootstrapState = state, bodybuilderState = state }, Cmd.none )

        Blah toto ->
            ( model, Cmd.none )


main : Program Basics.Never Model Msg
main =
    program
        { init =
            { color = Color.green
            , columnWidth = 3
            , gutterWidth = 12
            , columnsNumber = 12
            , bodybuilderState = False
            , bootstrapState = False
            }
                ! []
        , update = update
        , subscriptions = always Sub.none
        , view = view
        }
