module Counter exposing (..)

import BodyBuilder as Builder exposing (..)
import BodyBuilder.Attributes as Attributes exposing (..)
import BodyBuilder.Events as Events exposing (..)
import Display
import Dimensions
import Flex
import Box
import Constants
import Border
import Elegant exposing (px, percent, vh)
import Typography
import Padding
import Color
import Color.Extra as Color
import Typography.Character as Character
import Style


buttonStyle =
    [ Style.block [ Display.dimensions [ Dimensions.height (percent 100) ] ]
    , Style.box
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
            [ Style.block [ Display.dimensions [ Dimensions.minHeight (px 50) ] ]
            , Style.flexContainerProperties
                [ Flex.align Flex.stretch
                ]
            , Style.box
                [ Box.border [ Border.full Color.gray ]
                ]
            ]
        ]
        [ flexItem []
            [ inputText
                [ style
                    [ Style.block [ Display.dimensions [ Dimensions.height (percent 100) ] ]
                    , Style.box
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
                    [ Style.block [ Display.dimensions [ Dimensions.height (percent 100) ] ]
                    , Style.flexContainerProperties [ Flex.direction Flex.column, Flex.align Flex.stretch ]
                    ]
                ]
                [ flexItem [ style [ Style.flexItemProperties [ Flex.basis (percent 100) ] ] ] [ button [ onClick Add, style buttonStyle ] [ text "+" ] ]
                , flexItem [ style [ Style.flexItemProperties [ Flex.basis (percent 100) ] ] ] [ button [ onClick Substract, style buttonStyle ] [ text "-" ] ]
                ]
            ]
        ]


windowCentered : Node msg -> Node msg
windowCentered content =
    Builder.flex
        [ style
            [ Style.block [ Display.dimensions [ Dimensions.height (vh 100) ] ]
            , Style.flexContainerProperties
                [ Flex.align Flex.center
                , Flex.justifyContent Flex.justifyContentCenter
                ]
            ]
        ]
        [ flexItem [ style [ Style.block [] ] ] [ content ] ]


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
