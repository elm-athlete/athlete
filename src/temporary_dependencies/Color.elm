module Color exposing (..)


type alias Color =
    { red : Int
    , green : Int
    , blue : Int
    , alpha : Float
    }


rgb : Int -> Int -> Int -> Color
rgb r g b =
    Color r g b 1


{-| -}
white : Color
white =
    Color 255 255 255 1
