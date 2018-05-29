module Helpers.Css
    exposing
        ( addSuffixToClassName
        , applyCssFunction
        , cssValidName
        , generateClassName
        , generateMediaQuery
        , generateMediaQueryId
        , generateProperty
        , generateSelector
        , joiner
        , prependUnderscore
        , surroundWithBraces
        , surroundWithParentheses
        , surroundWithQuotes
        , surroundWithSingleQuotes
        )

import Char


applyCssFunction : String -> String -> String
applyCssFunction funName content =
    funName ++ surroundWithParentheses content


prependUnderscore : String -> String
prependUnderscore =
    (++) "_"


replaceFloatDotByUnderscore : String -> String
replaceFloatDotByUnderscore =
    String.map
        (\c ->
            if c == '.' then
                '_'
            else
                c
        )


cssValidName : String -> String
cssValidName str =
    str
        |> replaceFloatDotByUnderscore
        |> String.filter isValidInCssName


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


joiner : ( String, List a ) -> ( String, List a ) -> ( String, List a )
joiner ( a, b ) ( c, d ) =
    ( a ++ " " ++ c, b ++ d )


generateMediaQueryId : ( Maybe Int, Maybe Int ) -> String
generateMediaQueryId ( min, max ) =
    -- Todo : Fix that (it's very ugly)
    let
        toString a =
            case a of
                Nothing ->
                    "error"

                Just int ->
                    String.fromInt int
    in
    cssValidName (toString min ++ toString max)


generateSelector : Maybe String -> Maybe String
generateSelector =
    Maybe.map ((++) ":")


generateProperty : ( String, String ) -> String
generateProperty ( attribute, value ) =
    attribute ++ ":" ++ value


generateMediaQuery : ( Maybe Int, Maybe Int ) -> String
generateMediaQuery ( min, max ) =
    "@media " ++ mediaQuerySelector min max


mediaQuerySelector : Maybe Int -> Maybe Int -> String
mediaQuerySelector min max =
    case min of
        Nothing ->
            case max of
                Nothing ->
                    ""

                Just max_ ->
                    "(max-width: " ++ String.fromInt max_ ++ "px)"

        Just min_ ->
            case max of
                Nothing ->
                    "(min-width: " ++ String.fromInt min_ ++ "px)"

                Just max_ ->
                    "(min-width: " ++ String.fromInt min_ ++ "px) and (max-width: " ++ String.fromInt max_ ++ "px)"


generateClassName : Maybe String -> ( String, String ) -> String
generateClassName suffix ( attribute, value ) =
    (attribute ++ "-" ++ value)
        |> addSuffixToClassName suffix
        |> cssValidName


addSuffixToClassName : Maybe String -> String -> String
addSuffixToClassName suffix className =
    suffix
        |> Maybe.map prependUnderscore
        |> Maybe.withDefault ""
        |> (++) className



-- Internals


isValidInCssName : Char -> Bool
isValidInCssName char =
    isAlphaNum char || char == '-' || char == '_'


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
