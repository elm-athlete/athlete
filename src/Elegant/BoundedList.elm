module Elegant.BoundedList exposing (BoundedList, content, head, insert, new)

import Function


type BoundedList a
    = BoundedList
        { length : Int
        , content : List a
        }


new : Int -> BoundedList a
new length =
    BoundedList <|
        { length = length
        , content = []
        }


insert : a -> BoundedList a -> BoundedList a
insert elem (BoundedList l) =
    l.content
        |> (::) elem
        |> List.take l.length
        |> setContentIn l
        |> BoundedList


content : BoundedList a -> List a
content (BoundedList l) =
    l.content


head : BoundedList a -> Maybe a
head (BoundedList l) =
    List.head l.content



-- Internals


setContent : content -> { a | content : content } -> { a | content : content }
setContent content_ record =
    { record | content = content_ }


setContentIn : { a | content : content } -> content -> { a | content : content }
setContentIn =
    Function.flip setContent
