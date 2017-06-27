module BodyBuilderDemo exposing (..)

import BodyBuilder
import Elegant exposing (SizeUnit(..))
import Html exposing (Html)
import Color


main : Html msg
main =
    BodyBuilder.toHtml view


view : BodyBuilder.HtmlAttributes
view =
    BodyBuilder.div
        [ BodyBuilder.style
            [ Elegant.width (Px 100)
            , Elegant.height (Px 100)
            , Elegant.backgroundColor (Color.red)
            ]
        , BodyBuilder.hoverStyle
            [ Elegant.backgroundColor (Color.blue) ]
        ]
