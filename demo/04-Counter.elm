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
import Color
import Color.Extra as Color
import Typography.Character as Character


buttonStyle =
    [ Attributes.block [ Display.dimensions [ Display.height (percent 100) ] ]
    , Attributes.box
        [ Box.padding [ Padding.vertical Constants.zero ]
        , Box.border [ Border.all [ Border.thickness (px 0) ] ]
        , Box.typography [ Typography.character [ Character.size (px 10) ] ]
        , Box.background [ Elegant.color Color.transparent ]
        , Box.padding [ Padding.horizontal Constants.small ]
        ]
    ]


counter model =
    flex
        [ style
            [ Attributes.block [ Display.dimensions [ Display.minHeight (px 50) ] ]
            , Attributes.flexContainerProperties
                [ Display.align Display.stretch
                ]
            , Attributes.box
                [ Box.border [ Border.full Color.gray ]
                ]
            ]
        ]
        [ flexItem []
            [ inputText
                [ style
                    [ Attributes.block [ Display.dimensions [ Display.height (percent 100) ] ]
                    , Attributes.box
                        [ Box.padding [ Padding.all Constants.zero ]
                        , Box.typography [ Typography.character [ Character.size (px 20) ] ]
                        , Box.border [ Border.all [ Border.thickness (px 0) ] ]
                        , Box.padding [ Padding.left Constants.small ]
                        ]
                    ]
                , onInput Change
                , value (model |> toString)
                ]
            ]
        , flexItem []
            [ flex
                [ style
                    [ Attributes.block [ Display.dimensions [ Display.height (percent 100) ] ]
                    , Attributes.flexContainerProperties [ Display.direction Display.column, Display.align Display.stretch ]
                    ]
                ]
                [ flexItem [ style [ Attributes.flexItemProperties [ Display.basis (percent 100) ] ] ] [ button [ onClick Add, style buttonStyle ] [ text "+" ] ]
                , flexItem [ style [ Attributes.flexItemProperties [ Display.basis (percent 100) ] ] ] [ button [ onClick Substract, style buttonStyle ] [ text "-" ] ]
                ]
            ]
        ]


windowCentered : Node msg -> Node msg
windowCentered content =
    Builder.flex
        [ style
            [ Attributes.block [ Display.dimensions [ Display.height (vh 100) ] ]
            , Attributes.flexContainerProperties
                [ Display.align Display.center
                , Display.justifyContent Display.justifyContentCenter
                ]
            ]
        ]
        [ flexItem [ style [ Attributes.block [] ] ] [ content ] ]


view : a -> Node Msg
view model =
    windowCentered (counter model)


type Msg
    = Add
    | Substract
    | Change String


update : Msg -> number -> ( number, Cmd Msg )
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
