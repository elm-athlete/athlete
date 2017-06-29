module BodyBuilderDemo exposing (..)

import BodyBuilderHtml as BodyBuilder exposing (..)
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


coloredSquare : Int -> Color.Color -> HtmlAttributes msg -> HtmlAttributes msg
coloredSquare size color =
    style
        [ square size
        , Elegant.backgroundColor color
        , Elegant.textRight
        , Elegant.paddingRight Elegant.medium
        ]


view : String -> BodyBuilder.HtmlAttributes Msg
view model =
    container
        [ leaf [ range 200 700 ChangeWidth ]
        , node
            [ style
                [ square
                    (model
                        |> String.toInt
                        |> Result.withDefault 200
                    )
                , Elegant.backgroundColor Color.red
                , Elegant.screenWidthBetween 300 700 [ Elegant.backgroundColor Color.blue ]
                , Elegant.screenWidthGE 700 [ Elegant.backgroundColor Color.green ]
                , Elegant.screenWidthLE 300 [ Elegant.backgroundColor Color.purple ]
                ]
            , hoverStyle
                [ Elegant.backgroundColor Color.yellow
                , Elegant.screenWidthBetween 300 700 [ Elegant.opacity 0.5 ]
                , Elegant.screenWidthGE 700 [ Elegant.backgroundColor Color.charcoal ]
                , Elegant.screenWidthLE 300 [ Elegant.backgroundColor Color.lightRed ]
                ]
            ]
            [ node
                [ coloredSquare 90 Color.red ]
                [ node
                    [ coloredSquare 60 Color.green ]
                    [ node
                        [ coloredSquare 30 Color.red ]
                        [ text "e" ]
                    , text "l"
                    ]
                , text "m"
                ]
            ]
        ]
