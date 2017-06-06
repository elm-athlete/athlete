module Elegant.Grid
    exposing
        ( grid
        , col
        , standardGrid
        , fullGrid
        )

{-|
@docs col
@docs fullGrid
@docs grid
@docs standardGrid
-}

import Elegant exposing (..)
import Elegant.Elements as Elements
import Color
import Elegant.Helpers exposing (..)
import Html exposing (Html)


type alias Column msg =
    { denominator : Int
    , numerator : Int
    , content : List (Html msg)
    }


columnStyle : SizeUnit -> Int -> Int -> Style -> Style
columnStyle gutter denominator numerator =
    [ width (((numerator |> toFloat) / (denominator |> toFloat)) * 100 |> Percent)
    , displayInlineBlock
    , paddingLeft gutter
    ]
        |> compose


layoutStyle : SizeUnit -> Style -> Style
layoutStyle gutter =
    [ marginLeft (opposite gutter)
    , displayBlock
    ]
        |> compose


columnToHtml : SizeUnit -> Column msg -> Html msg
columnToHtml gutter { denominator, numerator, content } =
    Html.div [ style [ columnStyle gutter denominator numerator ] ] content


exampleContent : String -> List (Html msg)
exampleContent content =
    [ Html.div [ style [ paddingBottom medium ] ]
        [ Html.div [ style [ Elements.border Color.black ] ]
            [ Html.text content
            ]
        ]
    ]


example : Html msg
example =
    Html.div [ style [ fullWidth ] ]
        [ standardGrid
            [ col 12 3 (exampleContent "I")
            , col 12 3 (exampleContent "am")
            , col 12 3 (exampleContent "a")
            , col 12 3 (exampleContent "grid")
            , col 12 9 (exampleContent "with some asymetric")
            , col 12 3 (exampleContent "elements")
            ]
        , fullGrid
            [ col 2 1 (exampleContent "toto")
            , col 2 1 (exampleContent "toto")
            ]
        , grid large
            [ col 2 1 (exampleContent "toto")
            , col 2 1 (exampleContent "toto")
            ]
        ]


main : Html msg
main =
    example


{-| Creates a column
-}
col : Int -> Int -> List (Html msg) -> Column msg
col =
    Column


{-| Creates a grid with a custom gutter and columns
-}
grid : SizeUnit -> List (Column msg) -> Html msg
grid gutter columns =
    Html.div [ style [ layoutStyle gutter ] ]
        (columns |> List.map (columnToHtml gutter))


{-| Standard grid creates a grid with a 12px gutter
-}
standardGrid : List (Column msg) -> Html msg
standardGrid =
    grid medium


{-| Full grid creates a grid with no gutter
-}
fullGrid : List (Column msg) -> Html msg
fullGrid =
    grid zero
