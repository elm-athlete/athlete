module Main exposing (main)

import Html exposing (Html, text)


{-| Capitalize only the first word of a sentence.
toCapital "hello world" -- "Hello world"
-}
capitalize : String -> String
capitalize str =
    String.toUpper (String.left 1 str) ++ String.dropLeft 1 str


generateSetter : String -> String
generateSetter field =
    let
        fieldMaj =
            capitalize field
    in
        "set" ++ fieldMaj ++ " : c -> { b | " ++ field ++ " : a } -> { b | " ++ field ++ """ : c }
set""" ++ fieldMaj ++ """ v o =
    { o | """ ++ field ++ """ = v }


set""" ++ fieldMaj ++ "In : { b | " ++ field ++ " : a } -> c -> { b | " ++ field ++ """ : c }
set""" ++ fieldMaj ++ """In =
    flip set""" ++ fieldMaj


generateSetters =
    List.map generateSetter >> String.join "\n\n"


props =
    [ "padding"
    , "margin"
    ]


main : Html msg
main =
    Html.pre [] [ text (generateSetters props) ]
