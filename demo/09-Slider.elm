module Slider exposing (..)

import Block
import BodyBuilder as Builder exposing (NodeWithStyle)
import BodyBuilder.Attributes as Attributes exposing (style)
import Border
import Box
import Color
import Constants
import Dimensions
import Display
import Elegant exposing (px)
import Padding
import Style exposing (block, box)


theFontSize : number
theFontSize =
    15


view : a -> NodeWithStyle msg
view model =
    Builder.node
        [ Attributes.style
            [ Style.block
                [ Block.alignCenter
                ]
            , Style.box
                [ Box.padding [ Padding.all Constants.medium ]
                ]
            ]
        ]
        [ Builder.h1 []
            [ Builder.text "Let's style a slider" ]
        , Builder.node [ style [ block [ Display.fullWidth ] ] ]
            [ Builder.inputRange [ style [ block [ Display.fullWidth ] ] ]
            , Builder.inputRange
                [ style
                    [ block [ Display.fullWidth ]
                    , box
                        [ Box.appearanceNone ]
                    , box
                        [ Box.background [ Elegant.color Color.blue ]
                        , Box.appearanceNone
                        , Box.border [ Border.all [ Border.none ] ]
                        ]
                        |> Style.pseudoClass ":-webkit-slider-thumb"
                    , box
                        [ Box.border [ Border.full Color.black ]
                        , Box.background [ Elegant.color Color.red ]
                        , Box.border [ Border.all [ Border.none ] ]
                        ]
                        |> Style.pseudoClass ":-webkit-slider-runnable-track"
                    , block
                        [ Display.dimensions [ Dimensions.square (px 50) ]
                        ]
                        |> Style.pseudoClass ":-webkit-slider-thumb"
                    ]
                ]
            ]
        ]


main : Program () Int msg
main =
    Builder.embed
        { init = \_ -> ( 0, Cmd.none )
        , update = \msg model -> ( model, Cmd.none )
        , subscriptions = always Sub.none
        , view = view
        }
