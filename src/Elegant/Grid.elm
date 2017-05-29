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


columnStyle : Int -> Int -> Int -> Style -> Style
columnStyle gutter denominator numerator =
    [ width (((numerator |> toFloat) / (denominator |> toFloat)) * 100 |> Percent)
    , displayInlineBlock
    , paddingLeft (Px gutter)
    , fullWidth
    ]
        |> compose


layoutStyle : Int -> Style -> Style
layoutStyle gutter =
    [ listStyleNone
    , margin (Px 0)
    , padding (Px 0)
    , marginLeft (Px (-gutter))
    ]
        |> compose


columnToHtml : Int -> Column msg -> Html msg
columnToHtml gutter { denominator, numerator, content } =
    Html.div [ style [ columnStyle gutter denominator numerator ] ] content


example : Html msg
example =
    Html.div []
        [ standardGrid
            [ col 12 3 [ Html.div [] [ Html.text "toto" ] ]
            , col 12 3 [ Html.div [] [ Html.text "toto" ] ]
            , col 12 3 [ Html.div [] [ Html.text "toto" ] ]
            , col 12 3 [ Html.div [] [ Html.text "toto" ] ]
            , col 12 3 [ Html.div [] [ Html.text "toto" ] ]
            ]
        , fullGrid
            [ col 2 1 [ Html.div [ style [ Elements.border Color.black ] ] [ Html.text "toto" ] ]
            , col 2 1 [ Html.div [] [ Html.text "toto" ] ]
            ]
        , grid 24
            [ col 2 1 [ Html.div [ style [ Elements.border Color.black ] ] [ Html.text "toto" ] ]
            , col 2 1 [ Html.div [] [ Html.text "toto" ] ]
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
grid : Int -> List (Column msg) -> Html msg
grid gutter columns =
    Html.div [ style [ layoutStyle gutter ] ]
        (columns |> List.map (columnToHtml gutter))


{-| Standard grid creates a grid with a 12px gutter
-}
standardGrid : List (Column msg) -> Html msg
standardGrid =
    grid mediumNumber


{-| Full grid creates a grid with no gutter
-}
fullGrid : List (Column msg) -> Html msg
fullGrid =
    grid 0
