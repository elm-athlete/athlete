module Elegant.Elements
    exposing
        ( border
        , borderBottom
        , flexnav
        , link
        )

{-|
@docs border
@docs flexnav
@docs borderBottom
@docs link
-}

import Elegant exposing (..)
import Color exposing (Color)
import Elegant.Helpers exposing (..)


{-| Create a nice looking Link
-}
link : Color -> Style -> Style
link color =
    [ textDecorationNone
    , textColor color
    ]
        |> compose


{-| Create a solid border with 1px of width and the color is a parameter
-}
border : Color -> Style -> Style
border color =
    [ borderColor color
    , borderSolid
    , borderWidth 1
    ]
        |> compose


{-| Create a solid border bottom with 1px of width and the color is a parameter
-}
borderBottom : Color -> Style -> Style
borderBottom color =
    [ borderBottomColor color
    , borderBottomSolid
    , borderBottomWidth 1
    ]
        |> compose


{-| Create a flex navigation
-}
flexnav : Style -> Style
flexnav =
    [ listStyleNone
    , displayFlex
    , alignItemsCenter
    , justifyContentSpaceBetween
    , widthPercent 100
    ]
        |> compose
