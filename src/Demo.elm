module Demo exposing (..)

import BodyBuilder exposing (..)
import Elegant
import Color


type alias Model =
    { color : Color.Color
    , width : Int
    }


blah : Model -> Node Interactive NotPhrasing Spanning NotListElement Msg
blah model =
    div
        [ style
            [ Elegant.width (Elegant.Px (300 + model.width))
            , Elegant.marginAuto

            -- , Elegant.backgroundImage (Elegant.withUrl "http://www.me-okinawa.com/wp-content/uploads/2013/05/may22-cat-whiskers.jpg")
            , Elegant.fontFamilySansSerif
            , Elegant.roundCorner model.width
            , Elegant.backgroundColor (model.color |> Color.complement)
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
                            [ style [ Elegant.textColor Color.green, Elegant.screenWidthLE 300 [ Elegant.displayNone ] ]
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
            , inputNumber [ style [ Elegant.displayBlock ], name "inputNumber", value 14 ]
            , inputRange [ style [ Elegant.displayBlock ], name "inputSlider", value 12 ]
            , inputColor [ style [ Elegant.displayBlock ], name "inputSlider", value model.color, onColorInput ChangeColor ]
            , inputCheckbox [ style [ Elegant.displayBlock ], name "inputSlider", value "test", checked ]
            , inputCheckbox [ style [ Elegant.displayBlock ], name "inputSlider", value "test" ]
            , inputFile [ style [ Elegant.displayBlock ], name "inputSlider" ]
            , inputPassword [ style [ Elegant.displayBlock ], name "inputSlider", value "" ]
            , inputRadio [ style [ Elegant.displayBlock ], name "inputSlider", value "Test" ]
            , inputRange [ style [ Elegant.displayBlock ], name "inputSlider", value model.width, onIntInput ChangeNumber ]
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
    | ChangeNumber Int
    | ChangeColor Color.Color


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        Click ->
            ( { model | width = model.width + 10 }, Cmd.none )

        ChangeNumber val ->
            ( { model | width = val }, Cmd.none )

        ChangeColor val ->
            ( { model | color = val }, Cmd.none )


main : Program Basics.Never Model Msg
main =
    program
        { init = { width = 10, color = Color.blue } ! []
        , update = update
        , subscriptions = always Sub.none
        , view = blah
        }
