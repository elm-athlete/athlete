module Demo exposing (..)

import Color exposing (..)
import Color.Manipulate as Color
import BodyBuilder as Builder exposing (..)
import BodyBuilder.Attributes as Attributes exposing (..)
import Function exposing (..)
import Elegant exposing (SizeUnit, px, pt, percent, vh)
import Padding
import Constants
import Elegant
import Display
import Dimensions
import Box
import Cursor
import Border
import Outline
import Typography
import Typography.Character as Character


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


boxStyle a =
    style [ box a ]


blockStyle a =
    style [ block a ]


buttonStyle color =
    [ style
        [ box
            [ Box.outlineNone
            , Box.backgroundColor color
            , Box.cornerRound
            , Box.borderNone
            , Box.paddingAll Constants.medium
            ]
        , box
            [ Box.backgroundColor (Color.saturate 0.5 color)
            , Box.shadowCenteredBlurry (Px 1) Color.black
            ]
            |> focus
        , block
            [ Block.overflowHidden
            ]
        ]
    ]
        |> compose


exampleGridContent content =
    [ node [ boxStyle [ paddingBottom medium ] ]
        [ node
            [ style
                [ box
                    [ Box.coloredBorder Color.black
                    , Box.paddingAll Constants.large
                    ]
                , block
                    [ Block.alignCenter
                    ]
                ]
            ]
            [ text content
            ]
        ]
    ]


customCounter title min max step val msg =
    node [ style [ textCenter ] ]
        [ h3 [ style [ fontSize (Px 14), uppercase ] ] [ text title ]
        , inputRange
            [ style [ Attributes.block ]
            , Attributes.value val
            , Attributes.onInput msg
            , Attributes.min min
            , Attributes.max max
            , Attributes.step step
            ]
        , span [ style [ paddingHorizontal tiny ] ] []
        , inputNumber
            [ style
                [ Attributes.block [ Block.alignCenter ]
                , Attributes.box
                    [ Box.borderRadius 4
                    , Box.coloredBorder (Color.rgba 149 152 154 0.23)
                    , Box.paddingVertical (Px 15)
                    , Box.paddingHorizontal (Px 10)
                    ]
                , textCenter
                ]
            , customNumberFieldParameters
            ]
        ]


view :
    Model
    -> BodyBuilder.Node Msg
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
                , fontFamily
                    (FontFamilyCustom
                        [ SystemFont "cursive" ]
                    )
                ]
            ]
            [ text "Elegant" ]
        , h2
            [ style
                [ paddingBottom tiny
                ]
            ]
            [ text "Alignment" ]
        , node
            [ style
                [ Elegant.width (Px 400)
                , marginAuto
                , border black
                , padding medium
                ]
            ]
            [ text "I'm centered with auto margins and a width of 400px" ]
        , node
            [ style
                [ Elegant.width (Px 600)
                , marginAuto
                , border black
                , padding medium
                ]
            ]
            [ text "I'm centered with auto margins and a width of 600px" ]
        , node
            [ style
                [ textCenter
                ]
            ]
            [ text "I'm centered" ]
        , node
            [ style
                [ textRight
                ]
            ]
            [ text "I'm right aligned" ]
        , node
            [ style
                [ textLeft
                ]
            ]
            [ text "I'm left aligned" ]
        , node
            [ style
                [ backgroundColor (Color.rgb 40 160 240)
                , textColor (Color.rgb (255 - 40) (255 - 160) (255 - 240))
                , padding medium
                ]
            ]
            [ text "I'm colored" ]
        , node
            [ style
                [ border black
                , borderWidth 3
                ]
            ]
            [ text "I have a big black border" ]
        , h2
            [ style
                [ box [ Box.padding [ Padding.bottom Constants.tiny ] ]
                ]
            ]
            [ text "Flex" ]

        -- , flex [ style [ spaceBetween ] ]
        --     [ flexItem [ style [ padding medium ] ] [ text "Some" ]
        --     , flexItem [ style [ padding medium ] ] [ text "Flex" ]
        --     , flexItem [ style [ padding medium ] ] [ text "Elements" ]
        --     , flexItem [ style [ padding medium ] ] [ text "With" ]
        --     , flexItem [ style [ padding medium ] ] [ text "Space" ]
        --     , flexItem [ style [ padding medium ] ] [ text "Between" ]
        --     ]
        -- , flex [ style [ spaceAround ] ]
        --     [ flexItem [ style [ padding medium ] ] [ text "Some" ]
        --     , flexItem [ style [ padding medium ] ] [ text "Flex" ]
        --     , flexItem [ style [ padding medium ] ] [ text "Elements" ]
        --     , flexItem [ style [ padding medium ] ] [ text "With" ]
        --     , flexItem [ style [ padding medium ] ] [ text "Space" ]
        --     , flexItem [ style [ padding medium ] ] [ text "Around" ]
        --     ]
        -- , flex [ style [ spaceBetween, alignItemsCenter ] ]
        --     [ flexItem [ style [ padding medium ] ] [ text "Some" ]
        --     , flexItem [ style [ padding medium ] ] [ text "Flex" ]
        --     , flexItem [ style [ padding medium ] ] [ text "Elements" ]
        --     , flexItem [ style [ padding medium ] ] [ text "With" ]
        --     , flexItem [ style [ padding medium ] ] [ text "Space" ]
        --     , flexItem [ style [ padding medium ] ] [ text "Between" ]
        --     , flexItem [ style [ padding medium, flex 1, textRight ] ] [ text "And one element taking the rest of the place" ]
        --     ]
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
        , node [ style [ textCenter, padding medium, displayInlineBlock, Elegant.round, strong, uppercase, border black, padding medium ] ]
            [ text "I am round, strong and uppercase" ]
        , inputColor [ style [ Elegant.displayBlock ], value color, onInput ChangeColor ]
        , BodyBuilder.button
            [ buttonStyle color, hoverStyle [ textColor Color.blue ] ]
            [ text "Push me" ]
        , inputText [ style [ Elegant.displayBlock ], name "inputText", value "inputText_" ]
        , node []
            [ inputCheckbox [ style [ Elegant.displayInlineBlock ], checked (bootstrapState && bodybuilderState), onCheck ChangeBoth ]
            , span [] [ text "I like Both" ]
            ]
        , node [ style [ paddingLeft large ] ]
            [ node []
                [ inputCheckbox [ style [ Elegant.displayInlineBlock ], checked bootstrapState, onCheck ChangeBootstrapState ]
                , span [] [ text "I like Bootstrap" ]
                ]
            , node []
                [ inputCheckbox [ style [ Elegant.displayInlineBlock ], checked bodybuilderState, onCheck ChangeBodyBuilderState ]
                , span [] [ text "I like BodyBuilder" ]
                ]
            ]
        , inputFile [ style [ Attributes.block [] ] ]
        , inputPassword [ style [ Attributes.block [] ], value "" ]
        , inputRadio [ style [ Attributes.block [] ], value "Test" ]
        , inputUrl [ style [ Elegant.displayBlock ], name "inputUrl" ]
        , textarea []
        , inputSubmit [ style [ Elegant.displayBlock ], value "Submit Form" ]
        , h2 [ style [ paddingVertical (Px 75), fontSize (Px 64), textCenter, uppercase, bold ] ] [ text "Parametrable grid" ]

        -- , grid (Px 26)
        --     [ (col 3 1)
        --         [ customCounter "Gutter width" 0 100 1 gutterWidth ChangeGutter ]
        --     , (col 3 1)
        --         [ customCounter "Columns number" 6 12 2 columnsNumber ChangeColumnsNumber ]
        --     , (col 3 1)
        --         [ customCounter "Columns width : number of units by column" 2 6 1 columnWidth ChangeWidth ]
        --     ]
        -- , grid (Px gutterWidth)
        --     [ col columnsNumber columnWidth (exampleGridContent "BodyBuilder")
        --     , col columnsNumber (columnWidth) (exampleGridContent "is")
        --     , col columnsNumber (columnWidth) (exampleGridContent "awesome")
        --     , col columnsNumber (columnWidth) (exampleGridContent "to")
        --     ]
        -- , grid (Px gutterWidth)
        --     [ col 12 6 (exampleGridContent "design")
        --     , col 12 6 (exampleGridContent "your")
        --     , col 12 6 (exampleGridContent "own")
        --     , col 12 6 (exampleGridContent "grids")
        --     ]
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
