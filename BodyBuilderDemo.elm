module BodyBuilderDemo exposing (..)

import BodyBuilderHtml as BodyBuilder
import Elegant exposing (SizeUnit(..), Style)
import Html exposing (Html)
import Color
import Html exposing (Html)


type Msg
    = ChangeWidth String


main : Program Never String Msg
main =
    Html.beginnerProgram
        { model = "200"
        , update = update
        , view = BodyBuilder.view << view
        }


square : Int -> Style -> Style
square x =
    Elegant.width (Px x) << Elegant.height (Px x)


update : Msg -> String -> String
update msg model =
    case msg of
        ChangeWidth width ->
            width


view : String -> BodyBuilder.HtmlAttributes Msg
view model =
    BodyBuilder.div []
        [ BodyBuilder.node
            [ BodyBuilder.range
                200
                700
                ChangeWidth
            ]
        , BodyBuilder.div
            [ BodyBuilder.style
                [ model
                    |> String.toInt
                    |> Result.withDefault 200
                    |> square
                , Elegant.backgroundColor Color.red
                ]
            , BodyBuilder.hoverStyle
                [ Elegant.backgroundColor Color.blue ]
            ]
            [ BodyBuilder.div
                [ BodyBuilder.style
                    [ square 90
                    , Elegant.backgroundColor Color.blue
                    , Elegant.textRight
                    , Elegant.paddingRight Elegant.medium
                    ]
                ]
                [ BodyBuilder.div
                    [ BodyBuilder.style
                        [ square 60
                        , Elegant.backgroundColor Color.green
                        , Elegant.textRight
                        , Elegant.paddingRight Elegant.medium
                        ]
                    ]
                    [ BodyBuilder.div
                        [ BodyBuilder.style
                            [ square 30
                            , Elegant.backgroundColor Color.red
                            , Elegant.textRight
                            , Elegant.paddingRight Elegant.medium
                            ]
                        ]
                        [ BodyBuilder.text "e" ]
                    , BodyBuilder.text "l"
                    ]
                , BodyBuilder.text "m"
                ]
            ]
        ]
