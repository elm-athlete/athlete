module BoundedList exposing (BoundedList, new, insert, content, head)

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
insert elem (BoundedList ({ length, content } as boundedList)) =
  content
    |> (::) elem
    |> List.take length
    |> setContentIn boundedList
    |> BoundedList

content : BoundedList a -> List a
content (BoundedList { content }) =
  content

head : BoundedList a -> Maybe a
head (BoundedList { content }) =
  List.head content

-- Internals

setContent : content -> { a | content : content } -> { a | content : content }
setContent content record =
  { record | content = content }

setContentIn : { a | content : content } -> content -> { a | content : content }
setContentIn =
  flip setContent
