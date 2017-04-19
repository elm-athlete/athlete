module Demo exposing (..)

import Elegant exposing (..)
import Elegant.Elements exposing (..)
import Color exposing (..)
import Html exposing (text, div, h3)


type alias Model =
    Elegant.State


type Msg
    = Elegant Elegant.Msg


init : ( Model, Cmd Msg )
init =
    ( Elegant.emptyState, Cmd.none )


view : Model -> Html.Html Msg
view model =
    div (simpleStyle [ maxWidth (Percent 100), width (Px 1024), marginAuto, padding medium ])
        [ h3
            (simpleStyle
                [ paddingBottom tiny
                ]
            )
            [ text "Alignment" ]
        , div
            (simpleStyle
                [ width (Px 400)
                , marginAuto
                , border black
                , padding medium
                ]
            )
            [ text "I'm centered with auto margins and a width of 400px" ]
        , div
            (simpleStyle
                [ width (Px 600)
                , marginAuto
                , border black
                , padding medium
                ]
            )
            [ text "I'm centered with auto margins and a width of 600px" ]
        , div
            (simpleStyle
                [ textCenter
                ]
            )
            [ text "I'm centered" ]
        , div
            (simpleStyle
                [ textRight
                ]
            )
            [ text "I'm right aligned" ]
        , div
            (simpleStyle
                [ textLeft
                ]
            )
            [ text "I'm left aligned" ]
        , div
            (simpleStyle
                [ backgroundColor (Color.rgb 40 160 240)
                , textColor (Color.rgb (255 - 40) (255 - 160) (255 - 240))
                , padding medium
                ]
            )
            [ text "I'm colored" ]
        , div
            (simpleStyle
                [ border black
                , borderWidth 3
                ]
            )
            [ text "I have a big black border" ]
        , h3
            (simpleStyle
                [ paddingBottom tiny
                ]
            )
            [ text "Flex" ]
        , div (simpleStyle [ displayFlex, spaceBetween ])
            [ div (simpleStyle [ padding medium ]) [ text "Some" ]
            , div (simpleStyle [ padding medium ]) [ text "Flex" ]
            , div (simpleStyle [ padding medium ]) [ text "Elements" ]
            , div (simpleStyle [ padding medium ]) [ text "With" ]
            , div (simpleStyle [ padding medium ]) [ text "Space" ]
            , div (simpleStyle [ padding medium ]) [ text "Between" ]
            ]
        , div (simpleStyle [ displayFlex, spaceAround ])
            [ div (simpleStyle [ padding medium ]) [ text "Some" ]
            , div (simpleStyle [ padding medium ]) [ text "Flex" ]
            , div (simpleStyle [ padding medium ]) [ text "Elements" ]
            , div (simpleStyle [ padding medium ]) [ text "With" ]
            , div (simpleStyle [ padding medium ]) [ text "Space" ]
            , div (simpleStyle [ padding medium ]) [ text "Around" ]
            ]
        , div (simpleStyle [ displayFlex, spaceBetween, alignItemsCenter ])
            [ div (simpleStyle [ padding medium ]) [ text "Some" ]
            , div (simpleStyle [ padding medium ]) [ text "Flex" ]
            , div (simpleStyle [ padding medium ]) [ text "Elements" ]
            , div (simpleStyle [ padding medium ]) [ text "With" ]
            , div (simpleStyle [ padding medium ]) [ text "Space" ]
            , div (simpleStyle [ padding medium ]) [ text "Between" ]
            , div (simpleStyle [ padding medium, flex 1, textRight ]) [ text "And one element taking the rest of the place" ]
            ]
        , div (simpleStyle [ textCenter, padding medium, fontSize alpha ])
            [ text "I am the alpha" ]
        , div (simpleStyle [ textCenter, padding medium, fontSize beta ])
            [ text "I am the beta" ]
        , div (simpleStyle [ textCenter, padding medium, fontSize gamma ])
            [ text "I am the gamma" ]
        , div (simpleStyle [ textCenter, padding medium, fontSize delta ])
            [ text "I am the delta" ]
        , div (simpleStyle [ textCenter, padding medium, fontSize epsilon ])
            [ text "I am the epsilon" ]
        , div (simpleStyle [ textCenter, padding medium, displayInlineBlock, roundCorner, strong, uppercase, border black, padding medium ])
            [ text "I am round, strong and uppercase" ]
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Elegant msg_ ->
            ( Elegant.update msg_ model, Cmd.none )


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    Elegant.resizeWindow Elegant
