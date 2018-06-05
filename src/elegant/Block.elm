module Elegant.Block exposing (..)

{-| @docs overflowHidden
@docs alignCenter
@docs alignRight
@docs alignLeft
@docs maxWidth
@docs maxHeight
@docs minWidth
@docs minHeight
@docs width
@docs height
@docs fullWidth
@docs fullHeight
-}

import Elegant.Dimensions as Dimensions
import Elegant.Display as Display
import Elegant.Helpers.Shared exposing (..)
import Elegant.Overflow as Overflow
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
maxHeight : SizeUnit -> Modifier Display.BlockDetails
maxHeight size =
    Display.dimensions [ Dimensions.maxHeight size ]


{-| -}
minWidth : SizeUnit -> Modifier Display.BlockDetails
minWidth size =
    Display.dimensions [ Dimensions.minWidth size ]


{-| -}
minHeight : SizeUnit -> Modifier Display.BlockDetails
minHeight size =
    Display.dimensions [ Dimensions.minHeight size ]


{-| -}
width : SizeUnit -> Modifier Display.BlockDetails
width size =
    Display.dimensions [ Dimensions.width size ]


{-| -}
height : SizeUnit -> Modifier Display.BlockDetails
height size =
    Display.dimensions [ Dimensions.height size ]


{-| -}
fullWidth : Modifier Display.BlockDetails
fullWidth =
    width (Percent 100)


{-| -}
fullHeight : Modifier Display.BlockDetails
fullHeight =
    height (Percent 100)
