module BodyBuilderDemo exposing (..)

import BodyBuilder
import Elegant exposing (SizeUnit(..), Style)
import Html exposing (Html)
import Color


main : Html msg
main =
    BodyBuilder.toHtml view


square : Int -> Style -> Style
square x =
    Elegant.width (Px x) << Elegant.height (Px x)


view : BodyBuilder.HtmlAttributes
view =
    BodyBuilder.div
        [ BodyBuilder.style
            [ square 100
            , Elegant.backgroundColor (Color.red)
            ]
        , BodyBuilder.hoverStyle
            [ Elegant.backgroundColor (Color.blue) ]
        ]
        [ BodyBuilder.div
            [ BodyBuilder.style
                [ square 50
                , Elegant.backgroundColor (Color.green)
                ]
            ]
            [ BodyBuilder.div
                [ BodyBuilder.style
                    [ square 30
                    , Elegant.backgroundColor (Color.red)
                    ]
                ]
                []
            ]
        ]
