module Counter exposing (..)

import BodyBuilder as Builder exposing (..)
import BodyBuilder.Attributes as Attributes exposing (..)
import BodyBuilder.Events as Events exposing (..)
import Display
import Box
import Constants
import Border
import Elegant exposing (px, percent, vh)
import Typography
import Padding
import Function exposing (compose)
import Color
import Color.Extra as Color
import Typography.Character as Character
import Background


buttonStyle =
    [ Attributes.box
        [ Box.padding [ Padding.vertical Constants.zero ]
        , Box.border [ Border.all [ Border.thickness 0 ] ]
        , Box.typography [ Typography.character [ Character.size (px 10) ] ]
        , Box.background [ Elegant.color Color.transparent ]
        ]
    ]
        |> compose


counter : a -> Node Msg
counter model =
    node [ style [ Display.block [] ] ]
        [ flex
            [ style
                [ Attributes.flexContainerProperties
                    [ Display.alignCenter
                    ]
                , Attributes.box
                    [ Box.border [ Border.all [ Elegant.color Color.gray ] ] ]
                ]
            ]
            [ inputText
                [ style
                    [ Attributes.box
                        [ Box.padding [ Padding.all Constants.zero ]
                        , Box.typography [ Typography.character [ Character.size (px 20) ] ]
                        , Box.border [ Border.all [ Border.thickness 0 ] ]
                        ]
                    ]
                , onInput Change
                , value (model |> toString)
                ]
            , flex
                [ style
                    [ Attributes.flexContainerProperties [ Display.column ]
                    ]
                ]
                [ button [ onClick Add, style [ buttonStyle ] ] [ text "+" ]
                , button [ onClick Substract, style [ buttonStyle ] ] [ text "-" ]
                ]
            ]
        ]


view : a -> Node Msg
view model =
    Builder.flex
        [ style
            [ Attributes.block [ Display.dimensions [ Display.height (vh 100) ] ]
            , Attributes.flexContainerProperties
                [ Display.alignCenter
                , Display.justifyContent Display.justifyContentCenter
                ]
            ]
        ]
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
