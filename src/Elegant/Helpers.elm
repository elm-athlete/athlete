module Elegant.Helpers exposing (isValidInCssName, emptyListOrApply, betweenBraces)

import Char


isBetween : Char -> Char -> Char -> Bool
isBetween low high char =
    let
        code =
            Char.toCode char
    in
        (code >= Char.toCode low) && (code <= Char.toCode high)


isValidInCssName : Char -> Bool
isValidInCssName char =
    Char.isDigit char
        || isBetween 'a' 'z' char
        || isBetween 'A' 'Z' char
        || (char == '-')
        || (char == '_')


emptyListOrApply : (a -> b) -> Maybe a -> List b
emptyListOrApply fun =
    Maybe.map (fun >> List.singleton)
        >> Maybe.withDefault []


betweenBraces : String -> String
betweenBraces content =
    "{" ++ content ++ "}"
