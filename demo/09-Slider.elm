-- input[type=range] {
--   -webkit-appearance: none;
--   margin: 10px 0;
--   width: 100%;
-- }
-- input[type=range]:focus {
--   outline: none;
-- }
-- input[type=range]::-webkit-slider-runnable-track {
--   width: 100%;
--   height: 12.8px;
--   cursor: pointer;
--   animate: 0.2s;
--   box-shadow: 0px 0px 0px #000000, 0px 0px 0px #0d0d0d;
--   background: #ac51b5;
--   border-radius: 25px;
--   border: 0px solid #000101;
-- }
-- input[type=range]::-webkit-slider-thumb {
--   box-shadow: 0px 0px 0px #000000, 0px 0px 0px #0d0d0d;
--   border: 0px solid #000000;
--   height: 20px;
--   width: 39px;
--   border-radius: 7px;
--   background: #65001c;
--   cursor: pointer;
--   -webkit-appearance: none;
--   margin-top: -3.6px;
-- }
-- input[type=range]:focus::-webkit-slider-runnable-track {
--   background: #ac51b5;
-- }
-- input[type=range]::-moz-range-track {
--   width: 100%;
--   height: 12.8px;
--   cursor: pointer;
--   animate: 0.2s;
--   box-shadow: 0px 0px 0px #000000, 0px 0px 0px #0d0d0d;
--   background: #ac51b5;
--   border-radius: 25px;
--   border: 0px solid #000101;
-- }
-- input[type=range]::-moz-range-thumb {
--   box-shadow: 0px 0px 0px #000000, 0px 0px 0px #0d0d0d;
--   border: 0px solid #000000;
--   height: 20px;
--   width: 39px;
--   border-radius: 7px;
--   background: #65001c;
--   cursor: pointer;
-- }
-- input[type=range]::-ms-track {
--   width: 100%;
--   height: 12.8px;
--   cursor: pointer;
--   animate: 0.2s;
--   background: transparent;
--   border-color: transparent;
--   border-width: 39px 0;
--   color: transparent;
-- }
-- input[type=range]::-ms-fill-lower {
--   background: #ac51b5;
--   border: 0px solid #000101;
--   border-radius: 50px;
--   box-shadow: 0px 0px 0px #000000, 0px 0px 0px #0d0d0d;
-- }
-- input[type=range]::-ms-fill-upper {
--   background: #ac51b5;
--   border: 0px solid #000101;
--   border-radius: 50px;
--   box-shadow: 0px 0px 0px #000000, 0px 0px 0px #0d0d0d;
-- }
-- input[type=range]::-ms-thumb {
--   box-shadow: 0px 0px 0px #000000, 0px 0px 0px #0d0d0d;
--   border: 0px solid #000000;
--   height: 20px;
--   width: 39px;
--   border-radius: 7px;
--   background: #65001c;
--   cursor: pointer;
-- }
-- input[type=range]:focus::-ms-fill-lower {
--   background: #ac51b5;
-- }
-- input[type=range]:focus::-ms-fill-upper {
--   background: #ac51b5;
-- }
--
-- body {
--   padding: 30px;
-- }


module Slider exposing (..)

import BodyBuilder as Builder exposing (Node)
import BodyBuilder.Attributes as Attributes exposing (style, block, box)
import Display
import Box
import Border
import Color
import Elegant exposing (px)
import Padding
import Constants
import Dimensions


theFontSize : number
theFontSize =
    15


view : a -> Node msg
view model =
    Builder.node
        [ Attributes.style
            [ Attributes.block
                [ Display.alignCenter
                ]
            , Attributes.box
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
                        [ Box.background [ Elegant.color (Color.blue) ]
                        , Box.appearanceNone
                        , Box.border [ Border.all [ Border.none ] ]
                        ]
                        |> Attributes.pseudoClass ":-webkit-slider-thumb"
                    , box
                        [ Box.border [ Border.full (Color.black) ]
                        , Box.background [ Elegant.color (Color.red) ]
                        , Box.border [ Border.all [ Border.none ] ]
                        ]
                        |> Attributes.pseudoClass ":-webkit-slider-runnable-track"
                    , block
                        [ Display.dimensions [ Dimensions.square (px 50) ]
                        ]
                        |> Attributes.pseudoClass ":-webkit-slider-thumb"
                    ]
                ]
            ]
        ]


main : Program Basics.Never Int msg
main =
    Builder.program
        { init = ( 0, Cmd.none )
        , update = (\msg model -> ( model, Cmd.none ))
        , subscriptions = always Sub.none
        , view = view
        }
