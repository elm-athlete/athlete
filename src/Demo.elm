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
            , Elegant.backgroundImage (Elegant.withUrl "http://www.me-okinawa.com/wp-content/uploads/2013/05/may22-cat-whiskers.jpg")
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
                            , span [] [ img "choux cat" "http://www.me-okinawa.com/wp-content/uploads/2013/05/may22-cat-whiskers.jpg" [] ]
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
            , inputHidden [ name "inputHidden", value "inputHidden_" ]
            , inputText [ style [ Elegant.displayBlock ], name "inputText", value "inputText_" ]
            , inputNumber [ style [ Elegant.displayBlock ], name "inputNumber", value 12 ]
            , inputSlider [ style [ Elegant.displayBlock ], name "inputSlider", value 12 ]
            , inputColor [ style [ Elegant.displayBlock ], name "inputSlider", value Color.yellow ]
            , inputCheckbox [ style [ Elegant.displayBlock ], name "inputSlider", value "test", checked ]
            , inputCheckbox [ style [ Elegant.displayBlock ], name "inputSlider", value "test" ]
            , inputFile [ style [ Elegant.displayBlock ], name "inputSlider" ]
            , inputPassword [ style [ Elegant.displayBlock ], name "inputSlider", value "" ]
            , inputRadio [ style [ Elegant.displayBlock ], name "inputSlider", value "Test" ]
            , inputSlider [ style [ Elegant.displayBlock ], name "inputSlider", value 15 ]
            , inputSubmit [ style [ Elegant.displayBlock ] ]
            , inputUrl [ style [ Elegant.displayBlock ], name "inputUrl", value "" ]
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
