module BodyBuilder.Finders exposing (..)


find_by : (a -> b) -> b -> List a -> Maybe a
find_by insideDataFun data =
    List.filter (\e -> insideDataFun e == data)
        >> List.head
