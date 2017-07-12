module Elegant.Grid
    exposing
        ( grid
        , col
        , standardGrid
        , fullGrid
        )

{-|


# Grid

@docs col
@docs fullGrid
@docs grid
@docs standardGrid

-}

import Elegant exposing (..)
import Elegant.Elements as Elements
import Color
import Html exposing (Html)
import Function exposing (compose)
import BodyBuilder exposing (Node, Spanning, NotListElement, div, toHtml, text, style)


type alias Column interactiveContent phrasingContent spanningContent listContent msg =
    { denominator : Int
    , numerator : Int
    , content : List (Node interactiveContent phrasingContent spanningContent listContent msg)
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


columnToHtml :
    SizeUnit
    ->
        { a
            | content :
                List (Node interactiveContent phrasingContent Spanning NotListElement msg)
            , denominator : Int
            , numerator : Int
        }
    -> Node interactiveContent phrasingContent Spanning NotListElement msg
columnToHtml gutter { denominator, numerator, content } =
    div [ style [ columnStyle gutter denominator numerator ] ] content


exampleContent :
    String
    -> List (Node interactiveContent phrasingContent Spanning NotListElement msg)
exampleContent content =
    [ div [ style [ paddingBottom medium ] ]
        [ div [ style [ Elements.border Color.black ] ]
            [ text content
            ]
        ]
    ]


example : Node interactiveContent phrasingContent Spanning NotListElement msg
example =
    div [ style [ maxWidth (Px 800), marginAuto ] ]
        [ div [ style [ fullWidth ] ]
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
        ]


main : Html msg
main =
    toHtml example


{-| Creates a column
-}
col :
    Int
    -> Int
    -> List (Node interactiveIn phrasingIn spanningIn listIn msg)
    -> Column interactiveIn phrasingIn spanningIn listIn msg
col =
    Column


{-| Creates a grid with a custom gutter and columns
-}
grid :
    SizeUnit
    ->
        List
            { a
                | content :
                    List (Node interactiveContent phrasingContent Spanning NotListElement msg)
                , denominator : Int
                , numerator : Int
            }
    -> Node interactiveContent phrasingContent Spanning NotListElement msg
grid gutter columns =
    div [ style [ layoutStyle gutter ] ]
        (columns |> List.map (columnToHtml gutter))


{-| Standard grid creates a grid with a 12px gutter
-}
standardGrid :
    List
        { a
            | content :
                List (Node interactiveContent phrasingContent Spanning NotListElement msg)
            , denominator : Int
            , numerator : Int
        }
    -> Node interactiveContent phrasingContent Spanning NotListElement msg
standardGrid =
    grid medium


{-| Full grid creates a grid with no gutter
-}
fullGrid :
    List
        { a
            | content :
                List (Node interactiveContent phrasingContent Spanning NotListElement msg)
            , denominator : Int
            , numerator : Int
        }
    -> Node interactiveContent phrasingContent Spanning NotListElement msg
fullGrid =
    grid zero
