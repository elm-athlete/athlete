module Display.Overflow exposing (..)

import Helpers.Vector exposing (Vector)
import Helpers.Shared exposing (..)


type Overflow
    = OverflowVisible
    | OverflowHidden
    | OverflowAuto
    | OverflowScroll


type alias FullOverflow =
    Vector (Maybe Overflow)


default : Vector (Maybe Overflow)
default =
    ( Nothing, Nothing )


overflowX : Overflow -> Modifier FullOverflow
overflowX val ( x, y ) =
    ( Just val, y )


overflowY : Overflow -> Modifier FullOverflow
overflowY val ( x, y ) =
    ( x, Just val )


overflowXY : Overflow -> Modifier FullOverflow
overflowXY val ( x, y ) =
    ( Just val, Just val )


visible : Overflow
visible =
    OverflowVisible


hidden : Overflow
hidden =
    OverflowHidden


auto : Overflow
auto =
    OverflowAuto


scroll : Overflow
scroll =
    OverflowScroll
