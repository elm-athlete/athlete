module Main exposing (..)

import Html exposing (Html)
import Html.Attributes
import Elegant exposing (SizeUnit(..))
import Color exposing (Color)

main : Html msg
main =
  Html.div
    [ Html.Attributes.style
      <| Elegant.toInlineStyles
      <| flip Elegant.style []
      <| Just
      <| Elegant.displayBlock []
        [ Elegant.typography
          [ Elegant.color Color.blue
          , Elegant.character
            [ Elegant.weight 900
            , Elegant.size (Px 200)
            , Elegant.italic
            ]
          ]
        , Elegant.padding (Px 30)
        ]
    ]
    [ Html.text "Just a text." ]
