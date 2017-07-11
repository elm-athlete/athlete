module Demo exposing (..)

import BodyBuilder exposing (..)
import Elegant
import Color


blah : model -> Node Interactive NotPhrasing Spanning NotListElement Msg
blah model =
    div
        [ style
            [ Elegant.width (Elegant.Px 300)
            , Elegant.marginAuto
            ]
        ]
        [ div []
            [ p [ onClick Click ] [ text "bla bla bla" ]
            , a
                [ style [ Elegant.textColor Color.grey ]
                , href "#"
                , class [ "toto" ]
                , id "titi"
                ]
                [ container
                    [ container
                        [ h1
                            [ style [ Elegant.textColor Color.green ]
                            , hoverStyle [ Elegant.textColor Color.red ]
                            ]
                            [ span [] [ text "Toto" ]
                            , span [] [ img "alt" "toto" [] ]
                            , table [ container [ span [] [] ] ] [ [ leaf [] ], [ leaf [] ] ]
                            ]
                        ]
                    ]
                , olLi []
                    [ p [] [ text "First li in olLi" ]
                    , p [] [ text "Second li in olLi", br [], text "Line breaking" ]
                    ]
                , ulLi []
                    [ p [] [ text "First li in ulLi" ]
                    , text "Second li in ulLi"
                    ]
                , ul []
                    [ li [] [ text "First li in ul" ]
                    , li [] [ text "Second li in ul" ]
                    ]
                , ol []
                    [ li [] [ text "First li in ol" ]
                    , li [] [ text "Second li in ol" ]
                    ]
                ]
            , inputHidden [ name "inputHidden", value "inputHidden_", class [ "class" ], id "id" ]
            , inputText [ style [ Elegant.displayBlock ], name "inputText", value "inputText_", class [ "class" ], id "id" ]
            , inputNumber [ style [ Elegant.displayBlock ], name "inputNumber", value 12, class [ "class" ], id "id" ]
            , inputSlider [ style [ Elegant.displayBlock ], name "inputSlider", value 12, class [ "class" ], id "id" ]
            , inputColor [ style [ Elegant.displayBlock ], name "inputSlider", value Color.yellow, class [ "class" ], id "id" ]
            , inputCheckbox [ style [ Elegant.displayBlock ], name "inputSlider", value "test", class [ "class" ], id "id", checked ]
            , inputCheckbox [ style [ Elegant.displayBlock ], name "inputSlider", value "test", class [ "class" ], id "id" ]
            , inputFile [ style [ Elegant.displayBlock ], name "inputSlider", class [ "class" ], id "id" ]
            , inputPassword [ style [ Elegant.displayBlock ], name "inputSlider", value "", class [ "class" ], id "id" ]
            , inputRadio [ style [ Elegant.displayBlock ], name "inputSlider", value "Test", class [ "class" ], id "id" ]
            , inputSlider [ style [ Elegant.displayBlock ], name "inputSlider", value 15, class [ "class" ], id "id" ]
            , inputSubmit [ style [ Elegant.displayBlock ], class [ "class" ], id "id" ]
            , inputUrl [ style [ Elegant.displayBlock ], class [ "class" ], id "id", name "inputUrl", value "" ]
            , select
                [ options
                    [ option "value" "label"
                    , option "value2" "label2"
                    ]
                , selectedOption "value2"
                ]
            , button [] [ text "toto" ]
            ]
        ]


type Msg
    = Click


main : Program Basics.Never Int Msg
main =
    program
        { init = 0 ! []
        , update = \msg model -> 0 ! []
        , subscriptions = always Sub.none
        , view = blah
        }
