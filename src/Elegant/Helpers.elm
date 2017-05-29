module Elegant.Helpers exposing (..)


compose : List (a -> a) -> (a -> a)
compose =
    List.foldl (<<) identity
