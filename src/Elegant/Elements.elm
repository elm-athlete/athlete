module Elegant.Elements
    exposing
        ( btn
        , border
        )

{-|
@docs border
@docs btn
-}

import Elegant exposing (..)
import Color exposing (Color)


compose : List (a -> a) -> (a -> a)
compose =
    List.foldr (>>) identity


{-| -}
btn : ( SizeUnit, SizeUnit ) -> Style -> Style
btn ( paddingVertical_, paddingHorizontal_ ) =
    [ displayInlineBlock
    , verticalAlignMiddle
    , fontInherit
    , textCenter
    , margin (Px 0)
    , paddingVertical paddingVertical_
    , paddingHorizontal paddingHorizontal_
    ]
        |> compose


{-| -}
border : Color -> Style -> Style
border color =
    [ borderColor color
    , borderStyle "solid"
    , borderWidth 1
    ]
        |> compose
