module Demo exposing (..)

import Elegant exposing (..)
import Elegant.Elements exposing (..)
import Color exposing (..)
import Html exposing (text, div, h1, h3)


view : Html.Html msg
view =
    div [ style [ maxWidth (Percent 100), width (Px 1024), marginAuto, padding medium ] ]
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
        , div [ style [ textCenter, padding medium, fontSize alpha ] ]
            [ text "I am the alpha" ]
        , div [ style [ textCenter, padding medium, fontSize beta ] ]
            [ text "I am the beta" ]
        , div [ style [ textCenter, padding medium, fontSize gamma ] ]
            [ text "I am the gamma" ]
        , div [ style [ textCenter, padding medium, fontSize delta ] ]
            [ text "I am the delta" ]
        , div [ style [ textCenter, padding medium, fontSize epsilon ] ]
            [ text "I am the epsilon" ]
        , div [ style [ textCenter, padding medium, displayInlineBlock, Elegant.round, strong, uppercase, border black, padding medium ] ]
            [ text "I am round, strong and uppercase" ]
        , div [ style [ textCenter, padding medium, userSelectNone ] ]
            [ text "I can't be selected" ]
        , div [ style [ textCenter, padding medium, userSelectAll ] ]
            [ text "I will be selected when clicked" ]
        ]


main : Html.Html msg
main =
    view
