module Color.Helpers.ParseInt exposing (..)

{-| Possible Result.Err returns from these functions.
-}


type Error
    = InvalidChar Char
    | OutOfRange Char
    | InvalidRadix Int


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
