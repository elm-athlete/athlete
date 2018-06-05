module Modifiers exposing (Modifier, Modifiers)

{-| Modifiers for shorter types signatures.

@docs Modifier
@docs Modifiers

-}


{-| -}
type alias Modifier a =
    a -> a


{-| -}
type alias Modifiers a =
    List (Modifier a)
