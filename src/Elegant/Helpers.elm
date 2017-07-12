module Elegant.Helpers
    exposing
        ( isValidInCssName
        , emptyListOrApply
        , surroundWithBraces
        , surroundWithParentheses
        , surroundWithQuotes
        )

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


surroundWith : String -> String -> String -> String
surroundWith surrounderLeft surrounderRight val =
    surrounderLeft ++ val ++ surrounderRight


surroundWithBraces : String -> String
surroundWithBraces =
    surroundWith "{" "}"


surroundWithParentheses : String -> String
surroundWithParentheses =
    surroundWith "(" ")"


surroundWithQuotes : String -> String
surroundWithQuotes =
    surroundWith "\"" "\""
