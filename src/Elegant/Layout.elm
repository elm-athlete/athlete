module Elegant.Layout exposing (..)

type alias Layout =
    { position : Maybe Position
    , visibility : Maybe Visibility
    , typography : Maybe Typography
    , padding : Maybe Padding
    , border : Maybe CompleteBorder
    , radius : Maybe BorderRadius
    , margin : Maybe Margin
    , outline : Maybe Outline
    , boxShadow : Maybe BoxShadow
    , background : Maybe Background
    , opacity : Maybe Float
    , cursor : Maybe String
    , zIndex : Maybe Int
    }
