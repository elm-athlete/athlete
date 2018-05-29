module Either
    exposing
        ( Either(..)
        )

{-| A generic structure for a type with two possibilities: a `Left a` or
a `Right b`.


# Definition

@docs Either


# Mapping (Functor & Bifunctor)

@docs map, mapLeft, mapRight, voidRight, voidLeft, mapBoth, mapEach


# Applying (Applicative)

@docs singleton, andMap, andMapLeft, andMapRight, map2, map3, map4


# Folding (Foldable)

@docs length, foldl, foldr


# Chaining (Monad)

@docs andThen, andThenLeft, andThenRight


# List Helpers

@docs lefts, rights, partition, biList


# Maybe Helpers

@docs toMaybe, leftToMaybe, rightToMaybe, fromMaybe, leftFromMaybe, rightFromMaybe


# Result Helpers

@docs toResult, fromResult


# Rest of the Helpers

@docs isLeft, isRight, fromLeft, fromRight, withDefault, unpack, unwrap, swap

-}

-- TYPE DEFINITION --


{-| The only implementation
-}
type Either a b
    = Left a
    | Right b
