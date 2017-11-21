module Block exposing (..)

{-|
@docs overflowHidden
@docs alignCenter
@docs alignRight
@docs alignLeft
@docs maxWidth
@docs height
@docs fullHeight
@docs width
-}

import Helpers.Shared exposing (..)
import Overflow
import Display
import Dimensions
import Modifiers exposing (..)


{-| -}
overflowHidden : Modifier Display.BlockDetails
overflowHidden =
    Display.overflow [ Overflow.overflowXY Overflow.hidden ]


{-| -}
alignCenter : Modifier Display.BlockDetails
alignCenter =
    Display.alignment Display.center


{-| -}
alignRight : Modifier Display.BlockDetails
alignRight =
    Display.alignment Display.right


{-| -}
alignLeft : Modifier Display.BlockDetails
alignLeft =
    Display.alignment Display.left


{-| -}
maxWidth : SizeUnit -> Modifier Display.BlockDetails
maxWidth size =
    Display.dimensions [ Dimensions.maxWidth size ]


{-| -}
height : SizeUnit -> Modifier Display.BlockDetails
height size =
    Display.dimensions [ Dimensions.height size ]


{-| -}
fullHeight : Modifier Display.BlockDetails
fullHeight =
    height (Percent 100)


{-| -}
width : SizeUnit -> Modifier Display.BlockDetails
width size =
    Display.dimensions [ Dimensions.width size ]
