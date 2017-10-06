module Helpers.Css
    exposing
        ( applyCssFunction
        , isValidInCssName
        , surroundWithBraces
        , surroundWithParentheses
        , surroundWithQuotes
        , surroundWithSingleQuotes
        )

import Char


applyCssFunction : String -> String -> String
applyCssFunction funName content =
    funName ++ (surroundWithParentheses content)


isValidInCssName : Char -> Bool
isValidInCssName char =
    isAlphaNum char || char == '-' || char == '_'


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


surroundWithSingleQuotes : String -> String
surroundWithSingleQuotes =
    surroundWith "'" "'"



-- Internals


isBetween : Char -> Char -> Char -> Bool
isBetween low high char =
    let
        code =
            Char.toCode char
    in
        (code >= Char.toCode low) && (code <= Char.toCode high)


isAlphaNum : Char -> Bool
isAlphaNum char =
    isLower char || isUpper char || isDigit char


isLower : Char -> Bool
isLower char =
    let
        code =
            toCode char
    in
        0x61 <= code && code <= 0x7A


isUpper : Char -> Bool
isUpper char =
    let
        code =
            toCode char
    in
        code <= 0x5A && 0x41 <= code


isDigit : Char -> Bool
isDigit char =
    let
        code =
            toCode char
    in
        code <= 0x39 && 0x30 <= code


toCode : Char -> Int
toCode =
    Char.toCode
