module Display.Overflow
    exposing
        ( overflowX
        , overflowY
        , overflowXY
        , visible
        , hidden
        , auto
        , scroll
        , default
        , FullOverflow
        , Overflow(..)
        )

{-|
  Handles Overflow

@docs FullOverflow
@docs overflowX
@docs overflowY
@docs overflowXY
@docs visible
@docs hidden
@docs auto
@docs default
@docs scroll
@docs Overflow
-}

import Helpers.Vector exposing (Vector)
import Helpers.Shared exposing (..)


{-| -}
type Overflow
    = OverflowVisible
    | OverflowHidden
    | OverflowAuto
    | OverflowScroll


{-| -}
type alias FullOverflow =
    Vector (Maybe Overflow)


{-|
-}
default : Vector (Maybe Overflow)
default =
    ( Nothing, Nothing )


{-|
 OverflowX to handle overflow X of an element
-}
overflowX : Overflow -> Modifier FullOverflow
overflowX val ( x, y ) =
    ( Just val, y )


{-|
 OverflowY to handle overflow Y of an element
-}
overflowY : Overflow -> Modifier FullOverflow
overflowY val ( x, y ) =
    ( x, Just val )


{-|
 OverflowY to handle overflow XY of an element
-}
overflowXY : Overflow -> Modifier FullOverflow
overflowXY val ( x, y ) =
    ( Just val, Just val )


{-|
 always visible overflow)
-}
visible : Overflow
visible =
    OverflowVisible


{-|
  hidden overflow
-}
hidden : Overflow
hidden =
    OverflowHidden


{-|
  auto overflow
-}
auto : Overflow
auto =
    OverflowAuto


{-|
  scroll overflow
-}
scroll : Overflow
scroll =
    OverflowScroll
