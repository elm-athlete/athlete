module Main exposing (..)

import Block
import BodyBuilder as Builder exposing (..)
import BodyBuilder.Attributes as Attributes exposing (..)
import BodyBuilder.Events as Events
import Box
import Color exposing (..)
import Color.Manipulate as Color
import Constants
import Display
import Elegant exposing (SizeUnit, percent, pt, px, vh)
import Flex
import Function exposing (..)
import Modifiers exposing (..)
import Style
import Typography


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


boxStyle : Modifiers Box.Box -> Modifier (BoxContainer a)
boxStyle a =
    style [ Style.box a ]


blockStyle : Modifiers Display.BlockDetails -> Modifier (MaybeBlockContainer a)
blockStyle a =
    style [ Style.block a ]


buttonStyle :
    Color
    -> MaybeBlockContainer { a | box : List ( Modifiers Box.Box, StyleSelector ) }
    -> MaybeBlockContainer { a | box : List ( Modifiers Box.Box, StyleSelector ) }
buttonStyle color =
    [ style
        [ Style.box
            [ Box.outlineNone
            , Box.backgroundColor color
            , Box.cornerRound
            , Box.borderNone
            , Box.paddingAll Constants.medium
            ]
        , Style.box
            [ Box.backgroundColor (Color.saturate 0.5 color)
            , Box.shadowCenteredBlurry (px 1) Color.black
            ]
            |> Style.focus
        , Style.box [ Box.textColor Color.blue ]
            |> Style.hover
        , Style.block
            [ Block.overflowHidden ]
        ]
    ]
        |> compose


exampleGridContent : String -> List (NodeWithStyle msg)
exampleGridContent content =
    [ node
        [ boxStyle
            [ Box.paddingBottom Constants.medium ]
        ]
        [ node
            [ style
                [ Style.box
                    [ Box.borderColor Color.black
                    , Box.paddingAll Constants.large
                    ]
                , Style.block
                    [ Block.alignCenter ]
                ]
            ]
            [ text content ]
        ]
    ]


customCounter : String -> Int -> Int -> Int -> Int -> (Int -> msg) -> NodeWithStyle msg
customCounter title min max step val msg =
    node
        [ blockStyle [ Block.alignCenter ] ]
        [ h3
            [ boxStyle
                [ Box.typography
                    [ Typography.size (px 14)
                    , Typography.uppercase
                    ]
                ]
            ]
            [ text title ]
        , inputRange
            [ blockStyle []
            , Attributes.value val
            , Attributes.min min
            , Attributes.max max
            , Attributes.step step
            , Events.onInput msg
            ]
        , node
            [ boxStyle [ Box.paddingHorizontal Constants.tiny ] ]
            []
        , inputNumber
            [ style
                [ Style.block [ Block.alignCenter ]
                , Style.box
                    [ Box.cornerRadius 4
                    , Box.borderColor (Color.rgba 149 152 154 0.23)
                    , Box.paddingVertical (px 15)
                    , Box.paddingHorizontal (px 10)
                    ]
                ]

            -- , customNumberFieldParameters
            ]
        ]


view : Model -> NodeWithStyle Msg
view { color, columnWidth, gutterWidth, columnsNumber, bodybuilderState, bootstrapState } =
    node
        [ style
            [ Style.block
                [ Block.maxWidth (percent 100)
                , Block.width (px 1024)
                ]
            , Style.box
                [ Box.marginAuto
                , Box.paddingAll Constants.medium
                , Box.fontFamilySansSerif
                ]
            ]
        ]
        [ h1
            [ style
                [ Style.blockProperties [ Block.alignCenter ]
                , Style.box
                    [ Box.paddingBottom Constants.tiny
                    , Box.systemFont "cursive"
                    ]
                ]
            ]
            [ text "Elegant" ]
        , h2
            [ boxStyle [ Box.paddingBottom Constants.tiny ] ]
            [ text "Alignment" ]
        , node
            [ style
                [ Style.block [ Block.width (px 400) ]
                , Style.box
                    [ Box.marginAuto
                    , Box.borderColor Color.black
                    , Box.paddingAll Constants.medium
                    ]
                ]
            ]
            [ text "I'm centered with auto margins and a width of 400px" ]
        , node
            [ style
                [ Style.block [ Block.width (px 600) ]
                , Style.box
                    [ Box.marginAuto
                    , Box.borderColor black
                    , Box.paddingAll Constants.medium
                    ]
                ]
            ]
            [ text "I'm centered with auto margins and a width of 600px" ]
        , node
            [ blockStyle [ Block.alignCenter ] ]
            [ text "I'm centered" ]
        , node
            [ blockStyle [ Block.alignRight ] ]
            [ text "I'm right aligned" ]
        , node
            [ blockStyle [ Block.alignLeft ] ]
            [ text "I'm left aligned" ]
        , node
            [ style
                [ Style.box
                    [ Box.backgroundColor (Color.rgb 40 160 240)
                    , Box.textColor (Color.rgb (255 - 40) (255 - 160) (255 - 240))
                    , Box.paddingAll Constants.medium
                    ]
                , Style.block []
                ]
            ]
            [ text "I'm colored" ]
        , node
            [ style
                [ Style.box
                    [ Box.borderColor black
                    , Box.borderWidth 3
                    , Box.borderSolid
                    ]
                , Style.block []
                ]
            ]
            [ text "I have a big black border" ]
        , h2
            [ boxStyle [ Box.paddingBottom Constants.tiny ] ]
            [ text "Flex" ]
        , flex
            [ style [ Style.flexContainerProperties [ Flex.justifyContent Flex.spaceBetween ], Style.block [] ] ]
            [ flexItem [ boxStyle [ Box.paddingAll Constants.medium ] ] [ text "Some" ]
            , flexItem [ boxStyle [ Box.paddingAll Constants.medium ] ] [ text "Flex" ]
            , flexItem [ boxStyle [ Box.paddingAll Constants.medium ] ] [ text "Elements" ]
            , flexItem [ boxStyle [ Box.paddingAll Constants.medium ] ] [ text "With" ]
            , flexItem [ boxStyle [ Box.paddingAll Constants.medium ] ] [ text "Space" ]
            , flexItem [ boxStyle [ Box.paddingAll Constants.medium ] ] [ text "Between" ]
            ]
        , flex
            [ style [ Style.flexContainerProperties [ Flex.justifyContent Flex.spaceAround ], Style.block [] ] ]
            [ flexItem [ boxStyle [ Box.paddingAll Constants.medium ] ] [ text "Some" ]
            , flexItem [ boxStyle [ Box.paddingAll Constants.medium ] ] [ text "Flex" ]
            , flexItem [ boxStyle [ Box.paddingAll Constants.medium ] ] [ text "Elements" ]
            , flexItem [ boxStyle [ Box.paddingAll Constants.medium ] ] [ text "With" ]
            , flexItem [ boxStyle [ Box.paddingAll Constants.medium ] ] [ text "Space" ]
            , flexItem [ boxStyle [ Box.paddingAll Constants.medium ] ] [ text "Around" ]
            ]
        , flex
            [ style
                [ Style.flexContainerProperties
                    [ Flex.justifyContent Flex.spaceBetween
                    , Flex.center
                    ]
                , Style.block []
                ]
            ]
            [ flexItem [ boxStyle [ Box.paddingAll Constants.medium ] ] [ text "Some" ]
            , flexItem [ boxStyle [ Box.paddingAll Constants.medium ] ] [ text "Flex" ]
            , flexItem [ boxStyle [ Box.paddingAll Constants.medium ] ] [ text "Elements" ]
            , flexItem [ boxStyle [ Box.paddingAll Constants.medium ] ] [ text "With" ]
            , flexItem [ boxStyle [ Box.paddingAll Constants.medium ] ] [ text "Space" ]
            , flexItem [ boxStyle [ Box.paddingAll Constants.medium ] ] [ text "Between" ]
            , flexItem
                [ style
                    [ Style.box [ Box.paddingAll Constants.medium ]
                    , Style.flexItemProperties [ Flex.grow 1 ]
                    , Style.block [ Block.alignRight ]
                    ]
                ]
                [ text "And one element taking the rest of the place" ]
            ]
        , h1 [] [ text "I am h1" ]
        , h2 [] [ text "I am h2" ]
        , h3 [] [ text "I am h3" ]
        , h4 [] [ text "I am h4" ]
        , h5 [] [ text "I am h5" ]
        , h6 [] [ text "I am h6" ]
        , node
            [ style
                [ Style.box
                    [ Box.paddingAll Constants.medium
                    , Box.cornerRound
                    , Box.typography [ Typography.uppercase, Typography.bold ]
                    , Box.borderColor black
                    , Box.borderWidth 1
                    , Box.borderSolid
                    ]
                , Style.block
                    [ Block.alignCenter ]
                ]
            ]
            [ text "I am round, strong and uppercase" ]
        , inputColor
            [ blockStyle []
            , value color
            , Events.onInput ChangeColor
            ]
        , button
            [ buttonStyle color ]
            [ text "Push me" ]
        , inputText
            [ blockStyle []
            , name "inputText"
            , value "inputText_"
            ]
        , flex
            [ blockStyle [] ]
            [ flexItem []
                [ inputCheckbox
                    [ blockStyle []
                    , Attributes.checked (bootstrapState && bodybuilderState)
                    , Events.onCheck ChangeBoth
                    ]
                ]
            , flexItem []
                [ node [] [ text "I like Both" ] ]
            ]
        , node
            [ style
                [ Style.box [ Box.paddingLeft Constants.large ]
                , Style.block []
                ]
            ]
            [ flex [ blockStyle [] ]
                [ flexItem []
                    [ inputCheckbox
                        [ blockStyle []
                        , Attributes.checked bootstrapState
                        , Events.onCheck ChangeBootstrapState
                        ]
                    ]
                , flexItem []
                    [ node [] [ text "I like Bootstrap" ] ]
                ]
            , flex [ blockStyle [] ]
                [ flexItem []
                    [ inputCheckbox
                        [ blockStyle []
                        , Attributes.checked bodybuilderState
                        , Events.onCheck ChangeBodyBuilderState
                        ]
                    ]
                , flexItem []
                    [ node [] [ text "I like BodyBuilder" ] ]
                ]
            ]
        , inputFile
            [ blockStyle [] ]
        , inputPassword
            [ blockStyle []
            , value ""
            ]
        , inputRadio
            [ blockStyle []
            , value "Test"
            ]
        , inputUrl
            [ blockStyle []
            , name "inputUrl"
            ]
        , textarea []
        , button
            [ blockStyle [] ]
            [ text "Submit Form" ]
        , h2
            [ style
                [ Style.box
                    [ Box.paddingVertical (px 75)
                    , Box.typography
                        [ Typography.uppercase
                        , Typography.size (px 64)
                        , Typography.bold
                        ]
                    ]
                , Style.blockProperties
                    [ Block.alignCenter ]
                ]
            ]
            [ text "Parametrable grid" ]

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


main : Program () Model Msg
main =
    embed
        { init =
            \_ ->
                ( { color = Color.green
                  , columnWidth = 3
                  , gutterWidth = 12
                  , columnsNumber = 12
                  , bodybuilderState = False
                  , bootstrapState = False
                  }
                , Cmd.none
                )
        , update = update
        , subscriptions = always Sub.none
        , view = view
        }
