module Function exposing (compose, flip)

{-|


# Helpers for function manipulation

@docs compose

-}


{-| Compose function composes a list of functions into one function
-}
compose : List (a -> a) -> a -> a
compose =
    List.foldl (<<) identity


flip f b a =
    f a b
