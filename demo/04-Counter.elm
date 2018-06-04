module Main exposing (..)

import BodyBuilder as Builder exposing (..)
import BodyBuilder.Attributes as Attributes exposing (..)
import BodyBuilder.Events as Events exposing (..)
import BodyBuilder.Style
import Color
import Elegant exposing (percent, px, vh)
import Elegant.Border
import Elegant.Box
import Elegant.Color.Extra as Color
import Elegant.Constants
import Elegant.Dimensions
import Elegant.Display
import Elegant.Flex
import Elegant.Padding
import Elegant.Typography


buttonStyle =
    [ Style.block [ Display.dimensions [ Dimensions.height (percent 100) ] ]
    , Style.box
        [ Box.padding [ Padding.vertical Constants.zero ]
        , Box.border [ Border.all [ Border.thickness (px 0) ] ]
        , Box.typography [ Typography.size (px 10) ]
        , Box.background [ Elegant.color Color.transparent ]
        , Box.padding [ Padding.horizontal Constants.small ]
        ]
    ]


counter : Int -> Node Msg
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
                        , Box.typography [ Typography.size (px 20) ]
                        , Box.border [ Border.all [ Border.thickness (px 0) ] ]
                        , Box.padding [ Padding.left Constants.small ]
                        ]
                    ]
                , onInput Change
                , value (model |> String.fromInt)
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
            , Style.flexContainerProperties [ Flex.center ]
            ]
        ]
        [ flexItem [ style [ Style.block [] ] ] [ content ] ]


view : Int -> Node Msg
view model =
    windowCentered (counter model)


type Msg
    = Add
    | Substract
    | Change String


update : Msg -> Int -> ( Int, Cmd Msg )
update msg model =
    case msg of
        Add ->
            ( model + 1, Cmd.none )

        Substract ->
            ( model - 1, Cmd.none )

        Change newVal ->
            ( newVal |> String.toInt |> Maybe.withDefault 0, Cmd.none )


main : Program () Int Msg
main =
    embed
        { init = \_ -> ( 0, Cmd.none )
        , update = update
        , subscriptions = always Sub.none
        , view = view
        }
