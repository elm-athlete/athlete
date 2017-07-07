module Main exposing (..)


type Compatible
    = Compatible


type Incompatible
    = Incompatible


type PhantomNode divCompatible
    = PhantomSpan (List (PhantomNode Incompatible))


phantomSpan : List (PhantomNode Incompatible) -> PhantomNode Compatible
phantomSpan children =
    PhantomSpan children


type alias NodeCompatibility divCompatible interactiveCompatible =
    { div : divCompatible
    , interactive : interactiveCompatible
    }


type alias InsideDivCompatibility interactiveCompatible =
    NodeCompatibility Compatible interactiveCompatible


type Node compatibility interactiveCompatible
    = Span (List (Node { div : Incompatible }))
    | Div (List (Node (InsideDivCompatibility interactiveCompatible)))
    | A (List (Node { div : Compatible, interactive : Incompatible }))


span : List (Node { div : Incompatible }) -> Node { compatibility | div : Compatible }
span children =
    Span children


div : List (Node { div : Compatible }) -> Node { compatibility | div : Compatible }
div children =
    Div children


a : List (Node { div : Compatible, interactive : Incompatible }) -> Node { compatibility | div : Compatible, interactive : Compatible }
a children =
    A children


blah =
    a [ div [ a [] ] ]
