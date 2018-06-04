module Elegant.Internals.Helpers exposing (emptyListOrApply)


emptyListOrApply : (a -> b) -> Maybe a -> List b
emptyListOrApply fun =
    Maybe.map (fun >> List.singleton)
        >> Maybe.withDefault []
