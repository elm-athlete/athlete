module Counter exposing (..)

import BodyBuilder exposing (..)
import Elegant exposing (textCenter, padding, SizeUnit(..), fontSize, Style)
import Elegant.Elements
import Function exposing (compose)
import Color


buttonStyle : Style -> Style
buttonStyle =
    [ Elegant.paddingVertical Elegant.zero
    , Elegant.borderWidth 0
    , Elegant.fontSize (Px 10)
    , Elegant.backgroundColor Elegant.transparent
    ]
        |> compose


counter : a -> Node Interactive NotPhrasing Spanning NotListElement Msg
counter model =
    div [ style [ Elegant.displayInlineBlock ] ]
        [ div
            [ style
                [ Elegant.displayFlex
                , Elegant.alignItemsCenter
                , Elegant.Elements.border Color.gray
                ]
            ]
            [ inputText
                [ style
                    [ padding Elegant.zero
                    , fontSize (Px 20)
                    , Elegant.borderWidth 0
                    ]
                , onInput Change
                , value (model |> toString)
                ]
            , div
                [ style
                    [ Elegant.displayFlex
                    , Elegant.flexDirectionColumn
                    ]
                ]
                [ button [ onClick Add, style [ buttonStyle ] ] [ text "+" ]
                , button [ onClick Substract, style [ buttonStyle ] ] [ text "-" ]
                ]
            ]
        ]


view : a -> Node Interactive NotPhrasing Spanning NotListElement Msg
view model =
    div [ style [ Elegant.displayFlex, Elegant.alignItemsCenter, Elegant.height (Vh 100), Elegant.justifyContentCenter ] ]
        [ counter model
        ]


type Msg
    = Add
    | Substract
    | Change String


update : Msg -> number -> ( number, Cmd msg )
update msg model =
    case msg of
        Add ->
            ( model + 1, Cmd.none )

        Substract ->
            ( model - 1, Cmd.none )

        Change newVal ->
            ( newVal |> String.toInt |> Result.withDefault 0, Cmd.none )


main : Program Basics.Never Int Msg
main =
    program
        { init = ( 0, Cmd.none )
        , update = update
        , subscriptions = always Sub.none
        , view = view
        }
