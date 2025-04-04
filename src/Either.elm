{-
   Copyright © 2018–2021 toastal <toastal@posteo.net> (https://toast.al)

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
-}


module Either exposing
    ( Either(..)
    , map, mapLeft, mapRight, voidRight, voidLeft, mapBoth, mapEach
    , singleton, andMap, andMapLeft, andMapRight, map2, map3, map4
    , length, foldl, foldr
    , andThen, andThenLeft, andThenRight, andThenBoth
    , appendLeft, appendRight
    , equals
    , toList, toListVia, lefts, rights, partition, biList
    , toArray, toArrayVia
    , toSet, toSetVia
    , toDict, toDictVia
    , toMaybe, toMaybeVia, leftToMaybe, rightToMaybe, fromMaybe, leftFromMaybe, rightFromMaybe
    , toResult, toResultVia, fromResult
    , toTask, toTaskVia
    , isLeft, isRight, fromLeft, fromRight, withDefault, unpack, unwrap, swap
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

@docs andThen, andThenLeft, andThenRight, andThenBoth


# Appending (Semigroup)

@docs appendLeft, appendRight


# Equals (Eq)

@docs equals


# List Helpers

@docs toList, toListVia, lefts, rights, partition, biList


# Array Helpers

@docs toArray, toArrayVia


# Set Helpers

@docs toSet, toSetVia


# Dict Helpers

@docs toDict, toDictVia


# Maybe Helpers

@docs toMaybe, toMaybeVia, leftToMaybe, rightToMaybe, fromMaybe, leftFromMaybe, rightFromMaybe


# Result Helpers

@docs toResult, toResultVia, fromResult


# Task Helpers

@docs toTask, toTaskVia


# Rest of the Helpers

@docs isLeft, isRight, fromLeft, fromRight, withDefault, unpack, unwrap, swap

-}

import Array exposing (Array)
import Dict exposing (Dict)
import List
import Set exposing (Set)
import Task exposing (Task)



-- TYPE DEFINITION --


{-| The only implementation
-}
type Either a b
    = Left a
    | Right b



-- TYPE CLASSES --
-- FUNCTOR & BIFUNCTOR


{-| Apply a function to an `Either`. If the argument is `Right`, it
will be converted. If the argument is an `Left`, the same left value
will propogate through.

    map ((+) 1) (Left "Hello") == Left "Hello"

    map ((+) 1) (Right 2) == Right 3

-}
map : (a -> b) -> Either x a -> Either x b
map f e =
    case e of
        Right b ->
            Right (f b)

        Left a ->
            Left a


{-| Apply a function to the `Left` of an `Either`.

    mapLeft ((+) 1) (Left 2) == Left 3

    mapLeft ((+) 1) (Right 2) == Right 2

-}
mapLeft : (a -> b) -> Either a x -> Either b x
mapLeft f e =
    case e of
        Left a ->
            Left (f a)

        Right b ->
            Right b


{-| Alias for `map`.
-}
mapRight : (a -> b) -> Either x a -> Either x b
mapRight =
    map


{-| Ignore the return value of the `Right` using the specified value instead.
Exactly the same as `<$` in other languages.

    voidRight 2 (Right True) == Right 2

    voidRight 2 (Left "banana") == Left "banana"

-}
voidRight : a -> Either x b -> Either x a
voidRight f =
    map (always f)


{-| Ignore the return value of the `Left` using the specified value instead.
_NOT_ the same as `$>` in other languages.

    voidLeft "two" (Right True) == Right True

    voidLeft "two" (Left 6) == Left "two"

-}
voidLeft : a -> Either b x -> Either a x
voidLeft f =
    mapLeft (always f)


{-| Apply the first argument function to a `Left` and the second
argument function to a `Right` of an `Either`.

    mapBoth (\s -> s ++ "!!") ((+) 1) (Left "Hello") == Left "Hello!!"

    mapBoth (\s -> s ++ "!!") ((+) 1) (Right 2) == Right 3

-}
mapBoth : (a -> b) -> (c -> d) -> Either a c -> Either b d
mapBoth f g e =
    case e of
        Left a ->
            Left (f a)

        Right b ->
            Right (g b)


{-| Not crazy on the name, but apply a function to either the `Left`
or the `Right` where the `Left` and the `Right` are of the same type.

    mapEach ((+) 1) (Left 2) == Left 3

    mapEach ((+) 1) (Right 3) == Right 4

-}
mapEach : (a -> b) -> Either a a -> Either b b
mapEach f e =
    case e of
        Right b ->
            Right (f b)

        Left a ->
            Left (f a)



-- FOLDABLE


{-| Returns the length of an `Either`. This happens to be `0` for a
`Left` and `1` for a `Right`.

    length (Left 2) == 0

    length (Right "Sharks") == 1

-}
length : Either a b -> Int
length e =
    case e of
        Left _ ->
            0

        _ ->
            1



-- foldl and foldr requires that the return be a Monoid
-- which I can't do without typeclasses


{-| Folds an `Either` over a function with an accumulator. If
it is a `Left` the function is applied with the accumulator.
If it is a `Right` only the accumulator is returned.

    foldl (*) 2 (Left 3) == 6

    foldl (*) 2 (Right 3) == 2

-}
foldl : (a -> b -> b) -> b -> Either a a -> b
foldl f acc e =
    case e of
        Right _ ->
            acc

        Left x ->
            f x acc


{-| Folds an `Either` over a function with an accumulator. If
it is a `Right` the function is applied with the accumulator.
If it is a `Left` only the accumulator is returned.

    foldr (*) 2 (Left 3) == 2

    foldr (*) 2 (Right 3) == 6

-}
foldr : (a -> b -> b) -> b -> Either a a -> b
foldr f acc e =
    case e of
        Left _ ->
            acc

        Right x ->
            f x acc



-- APPLICATIVE


{-| Create a `singleton` from a value to an `Either` with a `Right`
of the same type. Also known as `pure`. Use the `Left` constructor
for a singleton of the `Left` variety.

    singleton 2 == Right 2

-}
singleton : b -> Either x b
singleton =
    Right


{-| Apply the function that is inside `Either` to a value that is inside
`Either`. Return the result inside `Either`. If one of the `Either`
arguments is `Left x`, return `Left x`. Also known as `apply`.

    Left "Hello" |> andMap (Left "World") == Left "Hello"

    Left "Hello" |> andMap (Right 2) == Left "Hello"

    Right ((+) 1) |> andMap (Left "World") == Left "World"

    Right ((+) 1) |> andMap (Right 2) == Right 3

-}
andMap : Either x a -> Either x (a -> b) -> Either x b
andMap e e1 =
    case e1 of
        Right f ->
            map f e

        Left x ->
            Left x


{-| Apply the function that is inside `Either` to a value that is inside
`Either`. Return the result inside `Either`. If one of the `Either`
arguments is `Right x`, return `Right x`. Also known as `apply`.

    Left (\s -> s ++ "!!") |> andMap (Left "Hello") == Left "Hello!!"

    Left (\s -> s ++ "!!") |> andMap (Right 2) == Right 2

    Right 99 |> andMap (Left "World") == Right 99

    Right 99 |> andMap (Right 2) == Right 99

-}
andMapLeft : Either a x -> Either (a -> b) x -> Either b x
andMapLeft e e1 =
    case e1 of
        Left f ->
            mapLeft f e

        Right x ->
            Right x


{-| Alias for `andMap`.
-}
andMapRight : Either x a -> Either x (a -> b) -> Either x b
andMapRight =
    andMap


{-| Apply a function to two eithers, if both arguments are `Right`.
If not, the first argument which is a `Left` will propagate through.
Also known as `liftA2`.

    map2 (+) (Left "Hello") (Left "World") == Left "Hello"

    map2 (+) (Left "Hello") (Right 3) == Left "Hello"

    map2 (+) (Right 2) (Left "World") == Left "World"

    map2 (+) (Right 2) (Right 3) == Right 5

It’s essentially a helper for (and why it’s under applicative)

    singleton (+) |> andMap (Right 2) |> andMap (Right 3) == Right 5

-}
map2 : (a -> b -> c) -> Either x a -> Either x b -> Either x c
map2 f e e1 =
    map f e |> andMap e1


{-| Like `map2`, but with 3 eithers. Also known as `liftA3`
-}
map3 : (a -> b -> c -> d) -> Either x a -> Either x b -> Either x c -> Either x d
map3 f e e1 e2 =
    map f e |> andMap e1 |> andMap e2


{-| Like `map2`, but with 4 eithers. Also known as `liftA4`
-}
map4 : (a -> b -> c -> d -> e) -> Either x a -> Either x b -> Either x c -> Either x d -> Either x e
map4 f e e1 e2 e3 =
    map f e |> andMap e1 |> andMap e2 |> andMap e3



-- MONAD


{-| Chain together in many computations that will stop computing if
a chain is on a `Left`. Also known as `bind`.

    Left "Hello" |> andThen (\i -> Right (i + 1)) == Left "Hello"

    Right 2 |> andThen (\i -> Right (i + 1)) == Right 3

-}
andThen : (a -> Either x b) -> Either x a -> Either x b
andThen f e =
    case e of
        Right b ->
            f b

        Left a ->
            Left a


{-| Chain together in many computations that will stop computing if
a chain is on a `Right`. Also known as `bind`.

    Left "Hello" |> andThen (\s -> Left (s ++ "!!")) == Left "Hello!!"

    Right 2 |> andThen (\s -> Left (s ++ "!!")) == Right 2

-}
andThenLeft : (a -> Either b x) -> Either a x -> Either b x
andThenLeft f e =
    case e of
        Left a ->
            f a

        Right b ->
            Right b


{-| Alias for `andThen`.
-}
andThenRight : (a -> Either x b) -> Either x a -> Either x b
andThenRight =
    andThen


{-| -}
andThenBoth : (a -> Either c d) -> (b -> Either c d) -> Either a b -> Either c d
andThenBoth f g e =
    case e of
        Right b ->
            g b

        Left a ->
            f a



-- SEMIGROUP


{-| Append inner values of a `Left`.

    appendLeft (Left [ 1, 2 ]) (Left [ 3, 4 ]) == Left [ 1, 2, 3, 4 ]

    appendLeft (Left [ 1, 2 ]) (Right 'b') == Left [ 1, 2 ]

    appendLeft (Right 'a') (Left [ 3, 4 ]) == Left [ 3, 4 ]

    appendLeft (Right 'a') (Right 'b') == Right 'a'

-}
appendLeft : Either appendable x -> Either appendable x -> Either appendable x
appendLeft e e1 =
    mapLeft (++) e |> andMapLeft e1


{-| Append inner values of a `Right`.

    appendRight (Right "Hello") (Right "World") == Right "HelloWorld"

    appendRight (Right "Hello") (Left 1) == Right "Hello"

    appendRight (Left 0) (Right "World") == Right "World"

    appendRight (Left 0) (Left 1) == Left 0

-}
appendRight : Either x appendable -> Either x appendable -> Either x appendable
appendRight e e1 =
    map (++) e |> andMap e1



-- EQ


{-| One rendition of equals assuming both sides of the `Either` are comparable.

    equals (Right "Hello") (Right "Hello") == True

    equals (Right "Hello") (Right "World") == False

    equals (Right "Hello") (Left "Hello") == False

    equals (Right "Hello") (Left 1) == False

    equals (Left 0) (Right "World") == False

    equals (Left 0) (Left 0) == True

    equals (Left 0) (Left 1) == False

    equals (Left 0) (Right 0) == False

-}
equals : Either comparable comparable1 -> Either comparable comparable1 -> Bool
equals e e1 =
    case ( e, e1 ) of
        ( Right a, Right b ) ->
            a == b

        ( Left a, Left b ) ->
            a == b

        _ ->
            False



-- LIST HELPERS


{-| Converts a `Either x b` to a `List` of `b`.

    toList (Right 1) == [ 1 ]

    toList (Left 'a') == []

-}
toList : Either x a -> List a
toList =
    toListVia identity


{-| Folds a `Either x b` to a `List` of `c` via a transforming function.

    toList ((+) 1) (Right 1) == [ 2 ]

    toList ((+) 1) (Left 'a') == []

-}
toListVia : (a -> b) -> Either x a -> List b
toListVia f =
    unwrap [] (f >> List.singleton)


{-| Converts a `List` of `Either a x` to a List of `a`.

    lefts [ Left "Hello", Left "world", Right 2 ] == [ "Hello", "world" ]

-}
lefts : List (Either a x) -> List a
lefts =
    List.foldr (\e acc -> unwrapLeft acc (\a -> a :: acc) e) []


{-| Converts a `List` of `Either x b` to a List of `b`.

    rights [ Left "Hello", Left, "world", Right 2 ] == [ 2 ]

-}
rights : List (Either x a) -> List a
rights =
    List.foldr (\e acc -> unwrap acc (\a -> a :: acc) e) []


{-| Converts a `List` of `Either a b`, into a tuple2 where
the first value is a `List a` and the second is `List b`.

    partition [ Left "Hello", Left "world", Right 2 ] == ( [ "Hello", "World" ], [ 2 ] )

-}
partition : List (Either a b) -> ( List a, List b )
partition =
    let
        fn e ( ls, rs ) =
            case e of
                Right b ->
                    ( ls, b :: rs )

                Left a ->
                    ( a :: ls, rs )
    in
    List.foldr fn ( [], [] )


{-| Collects the list of elements of a structure, from left to right.

    biList (Left 4) == [ 4 ]

    biList (Right 9) == [ 9 ]

-}
biList : Either a a -> List a
biList =
    unpack List.singleton List.singleton



-- ARRAY HELPERS


{-| Convert from `Either` to `Array`

    toArray (Right 1) == Array.fromList [ 1 ]

    toArray (Left 'a') == Array.fromList []

-}
toArray : Either x b -> Array b
toArray =
    toArrayVia identity


{-| Folds from `Either` to `Array` via a transforming function.

    toArrayVia ((+) 1) (Right 1) == Array.fromList [ 2 ]

    toArrayVia ((+) 1) (Left 'a') == Array.fromList []

-}
toArrayVia : (a -> b) -> Either x a -> Array b
toArrayVia f =
    unwrap Array.empty (\a -> Array.initialize 1 (\_ -> f a))



-- SET HELPERS


{-| Convert from `Either` to `Set`

    toSet (Right 1) == Set.fromList [ 1 ]

    toSet (Left 'a') == Set.fromList []

-}
toSet : Either x comparable -> Set comparable
toSet =
    toSetVia identity


{-| Folds from `Either` to `Set` via a transforming function.

    toSetVia ((+) 1) (Right 1) == Set.fromList [ 2 ]

    toSetVia ((+) 1) (Left 'a') == Set.fromList []

-}
toSetVia : (a -> comparable) -> Either x a -> Set comparable
toSetVia f =
    unwrap Set.empty (f >> Set.singleton)



-- DICT HELPERS


{-| Convert from `Either` to `Dict`

    toDict (Right ( "KEY", 1 )) == Dict.fromList [ ( "KEY", 1 ) ]

    toDict (Left 'a') == Dict.fromList []

-}
toDict : Either x ( comparable, v ) -> Dict comparable v
toDict =
    toDictVia identity


{-| Folds from `Either` to `Dict` via a transforming function.

    toDictVia (Right ( "KEY", 1 )) == Dict.fromList [ ( "KEY", 1 ) ]

    toDictVia (Left 'a') == Dict.fromList []

-}
toDictVia : (a -> ( comparable, v )) -> Either x a -> Dict comparable v
toDictVia f =
    unwrap Dict.empty (f >> (\( k, v ) -> Dict.singleton k v))



-- MAYBE HELPERS


{-| `Maybe` get the `Right` side of an `Either`.

    toMaybe (Right 2) == Just 2

    toMaybe (Left "World") == Nothing

-}
toMaybe : Either x b -> Maybe b
toMaybe =
    toMaybeVia identity


{-| Folds a `Maybe` get the `Right` side of an `Either` via a transforming
function.

    toMaybeVia ((*) 3) (Right 2) == Just 6

    toMaybeVia ((*) 3) (Left "World") == Nothing

-}
toMaybeVia : (b -> c) -> Either x b -> Maybe c
toMaybeVia f =
    unwrap Nothing (f >> Just)


{-| `Maybe` get the `Left` side of an `Either`.

    leftToMaybe (Left "World") == Just "World"

    leftToMaybe (Right 2) == Nothing

-}
leftToMaybe : Either a x -> Maybe a
leftToMaybe e =
    case e of
        Right _ ->
            Nothing

        Left x ->
            Just x


{-| Alias for `toMaybe`.
-}
rightToMaybe : Either x b -> Maybe b
rightToMaybe =
    toMaybe


{-| Convert from a `Maybe` to `Either` with a default value
for `Left` for `Nothing`.

    fromMaybe "Hello" (Just 2) == Right 2

    fromMaybe "Hello" Nothing == Left "Hello"

-}
fromMaybe : a -> Maybe b -> Either a b
fromMaybe d m =
    case m of
        Nothing ->
            Left d

        Just v ->
            Right v


{-| Convert from a `Maybe` to `Either` with a default value
for `Right` for `Nothing`.

    leftFromMaybe 3 (Just "World") == Left "World"

    leftFromMaybe 3 Nothing == Right 3

-}
leftFromMaybe : b -> Maybe a -> Either a b
leftFromMaybe d m =
    case m of
        Nothing ->
            Right d

        Just v ->
            Left v


{-| Alias for `fromMaybe`.
-}
rightFromMaybe : a -> Maybe b -> Either a b
rightFromMaybe =
    fromMaybe



-- RESULT HELPERS


{-| Convert from `Either` to `Result`.

    toResult (Right 2) == Ok 2

    toResult (Left "World") == Err "World"

-}
toResult : Either a b -> Result a b
toResult =
    toResultVia identity


{-| Fold from `Either` to `Result` via transforming function.

    toResultVia ((+) 3) (Left "World") == Err "World"

    toResultVia ((+) 3) (Right 2) == Ok 5

-}
toResultVia : (b -> c) -> Either a b -> Result a c
toResultVia f =
    unpack Err (f >> Ok)


{-| Convert from `Result` to `Either`.

    fromResult (Ok 2) == Right 2

    fromResult (Err "World") == Left "World"

-}
fromResult : Result a b -> Either a b
fromResult r =
    case r of
        Err a ->
            Left a

        Ok b ->
            Right b



-- TASK HELPERS


{-| Convert from `Either` to `Task`

    toTask (Right "World") -- succeed "World"

    toTask (Left 2) -- fail 2

-}
toTask : Either a b -> Task a b
toTask =
    toTaskVia identity


{-| Fold from `Either` to `Task` via transforming function.

    toTaskVia (\s -> s ++ "!!") (Right "World") -- succeed "World!!"

    toTaskVia (\s -> s ++ "!!") (Left 2) -- fail 2

-}
toTaskVia : (b -> c) -> Either a b -> Task a c
toTaskVia f =
    unpack Task.fail (f >> Task.succeed)



-- REST OF THE HELPERS


{-| Returns `True` if argument is `Left _`

    isLeft (Left "World") == True

    isLeft (Right 2) == False

-}
isLeft : Either a b -> Bool
isLeft e =
    case e of
        Left _ ->
            True

        _ ->
            False


{-| Returns `True` if argument is `Right _`

    isRight (Left "World") == False

    isRight (Right 2) == True

-}
isRight : Either a b -> Bool
isRight e =
    case e of
        Right _ ->
            True

        _ ->
            False


{-| Extract left value or a default.

    fromLeft "World" (Left "Hello") == "Hello"

    fromLeft "World" (Right 2) == "World"

-}
fromLeft : a -> Either a b -> a
fromLeft d e =
    case e of
        Left a ->
            a

        _ ->
            d


{-| Extract right value or a default.

    fromRight 3 (Left "Hello") == 3

    fromRight 3 (Right 2) == 2

-}
fromRight : b -> Either a b -> b
fromRight d e =
    case e of
        Right b ->
            b

        _ ->
            d


{-| Alias for `fromRight`.
-}
withDefault : b -> Either a b -> b
withDefault =
    fromRight


{-| Given a function for both `Left` and `Right` to to type a generic
type `c`, collapse down the `Either` to a value of that type.

    unpack identity toString (Left "World") == "World"

    unpack identity toString (Right 2) == "2"

-}
unpack : (a -> c) -> (b -> c) -> Either a b -> c
unpack f g e =
    case e of
        Right b ->
            g b

        Left a ->
            f a


{-| Apply a function to `Right` value. If argument was a `Left` use the
default value. Equivalent to `Either.map >> Either.fromRight`.

    unwrap 99 ((+) 1) (Left "Hello") == 99

    unwrap 99 ((+) 1) (Right 2) == 3

-}
unwrap : b -> (a -> b) -> Either x a -> b
unwrap d f e =
    case e of
        Left _ ->
            d

        Right a ->
            f a


unwrapLeft : b -> (a -> b) -> Either a x -> b
unwrapLeft d f e =
    case e of
        Right _ ->
            d

        Left a ->
            f a


{-| Swap the `Left` and `Right` sides of an `Either`.

    swap (Left "World") == Right "World"

    swap (Right 2) == Left 2

-}
swap : Either a b -> Either b a
swap =
    unpack Right Left
