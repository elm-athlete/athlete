module BodyBuilder.Elements exposing (..)

import Elegant exposing (..)
import BodyBuilder exposing (..)


-- import Function exposing (..)
-- import Color exposing (..)

import Display
import Layout
import Position


-- stickyView : List (Elegant.Style -> Elegant.Style) -> String -> List (Node msg) -> Node msg


stickyView : a -> String -> List (Node msg) -> Node msg
stickyView sectionStyle sectionName elements =
    div []
        [ div
            [ BodyBuilder.style <|
                Elegant.style <|
                    Display.block
                        [ Display.dimensions [ Display.width (percent 100) ] ]
                        [ Layout.position <|
                            Position.sticky [ Position.top (px 0) ]

                        -- , sectionStyle |> compose
                        ]
            ]
            [ text sectionName ]
        , div [] elements
        ]



-- invertableButton :
--     Color
--     -> Color
--     -> { a | style : StyleAttribute }
--     -> { a | style : StyleAttribute }
-- invertableButton bg fg =
--     [ style [ textColor bg, backgroundColor fg, button ]
--     , hoverStyle [ textColor fg, backgroundColor bg ]
--     ]
--         |> compose
--
--
-- button : Style -> Style
-- button =
--     [ cursorPointer ]
--         |> compose
