module ParseInt
    exposing
        ( Error(..)
        , charFromInt
        , intFromChar
        , parseInt
        , parseIntHex
        , parseIntOct
        , parseIntRadix
        , toHex
        , toOct
        , toRadix
        , toRadixUnsafe
        )

{-| Convert String value to Int, or Int to String, with given radix.


# Functions

@docs parseInt, parseIntOct, parseIntHex, parseIntRadix, toRadix, toRadixUnsafe, toOct, toHex, intFromChar, charFromInt


# Errors

@docs Error

-}

import Char
import Result
import String


{-| Possible Result.Err returns from these functions.
-}
type Error
    = InvalidChar Char
    | OutOfRange Char
    | InvalidRadix Int


{-| Convert String to Int assuming base 10.
parseInt "314159" == Ok 314159
parseInt "foo" = Err (OutOfRange 'o')
-}
parseInt : String -> Result Error Int
parseInt =
    parseIntRadix 10


{-| Convert String to Int assuming base 8 (octal). No leading '0' is required.
-}
parseIntOct : String -> Result Error Int
parseIntOct =
    parseIntRadix 8


{-| Convert String to Int assuming base 16 (hexadecimal). No leading characters
are expected; input starting with "0x" (or any other out of range character)
will cause an `Err` return.
-}
parseIntHex : String -> Result Error Int
parseIntHex =
    parseIntRadix 16


{-| Convert String to Int assuming given radix. Radix can be any of
2..36. Leading zeroes are ignored. Valid characters are the alphanumerics: those
in the ASCII range [0-9a-zA-Z]. Case does not matter. For radixes beyond 16 the
normal [A-F] range for hexadecimal is extended in the natural way. Any invalid
character results in a `Err` return. Any valid character outside of the range
defined by the radix also results in an `Err`. In particular, any initial '-' or
' ' (space) is an error. An `Ok` return means that the entire input string was
consumed. The empty string results in `Ok 0`
parseIntRadix 16 "DEADBEEF" = Ok 3735928559
-}
parseIntRadix : Int -> String -> Result Error Int
parseIntRadix radix string =
    if 2 <= radix && radix <= 36 then
        parseIntR radix (String.reverse string)
    else
        Err (InvalidRadix radix)


parseIntR : Int -> String -> Result Error Int
parseIntR radix rstring =
    case String.uncons rstring of
        Nothing ->
            Ok 0

        Just ( c, rest ) ->
            intFromChar radix c
                |> Result.andThen
                    (\ci ->
                        parseIntR radix rest
                            |> Result.andThen (\ri -> Ok (ci + ri * radix))
                    )


{-| Offset of character from basis character in the ASCII table.
-}
charOffset : Char -> Char -> Int
charOffset basis c =
    Char.toCode c - Char.toCode basis


{-| Test if character falls in given range (inclusive of the limits) in the ASCII table.
-}
isBetween : Char -> Char -> Char -> Bool
isBetween lower upper c =
    let
        ci =
            Char.toCode c
    in
    Char.toCode lower <= ci && ci <= Char.toCode upper


{-| Convert an alphanumeric character to an int value as a "digit", validating
against the given radix. Alphabetic characters past "F" are extended in the
natural way: 'G' == 16, 'H' == 17, etc. Upper and lower case are treated the
same. Passing a non-alphanumeric character results in the `InvalidChar`
error. If the resulting value would be greater than the given radix, an
`OutOfRange` error results instead.
-}
intFromChar : Int -> Char -> Result Error Int
intFromChar radix c =
    let
        toInt =
            if isBetween '0' '9' c then
                Ok (charOffset '0' c)
            else if isBetween 'a' 'z' c then
                Ok (10 + charOffset 'a' c)
            else if isBetween 'A' 'Z' c then
                Ok (10 + charOffset 'A' c)
            else
                Err (InvalidChar c)

        validInt i =
            if i < radix then
                Ok i
            else
                Err (OutOfRange c)
    in
    toInt |> Result.andThen validInt


{-| Convert Int to corresponding Char representing it as a digit. Values from
10..15 are represented as upper-case 'A'..'F'. Values 16 and above extend the
hexadecimal characters in the natural way. This function assumes that the input
value is in the range 0 .. 36.
-}
charFromInt : Int -> Char
charFromInt i =
    if i < 10 then
        Char.fromCode <| i + Char.toCode '0'
    else
        Char.fromCode <| i - 10 + Char.toCode 'A'


{-| Convert Int to String assuming given radix. Radix values from 2..36 are
allowed; others result in an `Err InvalidRadix`. Negative numbers get an initial
'-'.
toRadix 16 1234 == Ok "4D2"
toRadix 8 -99 == Ok "-143"
-}
toRadix : Int -> Int -> Result Error String
toRadix radix i =
    if 2 <= radix && radix <= 36 then
        if i < 0 then
            Ok <| "-" ++ toRadixUnsafe radix -i
        else
            Ok <| toRadixUnsafe radix i
    else
        Err <| InvalidRadix radix


{-| Convert Int to String assuming given radix. Radix value must be in 2..36
(not checked, so it can crash).
toRadixUnsafe 16 3735928559 == "DEADBEEF"
toRadixUnsafe 37 36 --> crash
-}
toRadixUnsafe : Int -> Int -> String
toRadixUnsafe radix i =
    if i < radix then
        String.fromChar <| charFromInt i
    else
        toRadixUnsafe radix (i // radix) ++ (String.fromChar <| charFromInt (modBy radix i))


{-| Convert Int to octal String.
-}
toOct : Int -> String
toOct =
    toRadixUnsafe 8


{-| Convert Int to hexadecimal String.
-}
toHex : Int -> String
toHex =
    toRadixUnsafe 16
