module Demo exposing (..)

import Elegant exposing (..)
import Elegant.Elements exposing (..)
import Color exposing (..)
import Color.Manipulate as Color
import BodyBuilder exposing (text, div, h1, h2, h3, h4, h5, h6, style, focusStyle, program, inputColor, onColorInput, value)
import Function exposing (..)


type Msg
    = ChangeColor Color


type alias Model =
    { color : Color }



-- view : Model -> BodyBuilder.Node interactiveContent BodyBuilder.NotPhrasing BodyBuilder.Spanning BodyBuilder.NotListElement Msg


buttonStyle color =
    [ style [ outlineNone, backgroundColor color, Elegant.round, borderNone, h1S, padding medium, overflowHidden ]
    , focusStyle [ backgroundColor (Color.saturate 0.5 color), boxShadowCenteredBlurry (Px 10) Color.black ]
    ]
        |> compose


view :
    Model
    -> BodyBuilder.Node BodyBuilder.Interactive BodyBuilder.NotPhrasing BodyBuilder.Spanning BodyBuilder.NotListElement Msg
view { color } =
    div
        [ style
            [ maxWidth (Percent 100)
            , width (Px 1024)
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
        , h3
            [ style
                [ paddingBottom tiny
                ]
            ]
            [ text "Alignment" ]
        , div
            [ style
                [ width (Px 400)
                , marginAuto
                , border black
                , padding medium
                ]
            ]
            [ text "I'm centered with auto margins and a width of 400px" ]
        , div
            [ style
                [ width (Px 600)
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
        , h3
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
        , inputColor [ style [ Elegant.displayBlock ], value color, onColorInput ChangeColor ]
        , BodyBuilder.button
            [ buttonStyle color ]
            [ text "Push me" ]
        ]


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        ChangeColor color ->
            ( { model | color = color }, Cmd.none )


main : Program Basics.Never Model Msg
main =
    program
        { init = { color = Color.green } ! []
        , update = update
        , subscriptions = always Sub.none
        , view = view
        }
