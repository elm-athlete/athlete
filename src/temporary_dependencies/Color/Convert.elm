module Color.Convert
    exposing
        ( colorToCssRgb
        , colorToCssRgba
        , colorToHex
        , hexToColor
        )

{-| #Convert
Convert colors to differnt string formats and hexadecimal strings to colors.

@docs colorToCssRgb, colorToCssRgba, colorToCssHsl, colorToCssHsla, colorToHex
@docs hexToColor, colorToLab, labToColor

-}

import Char
import Color exposing (..)
import ParseInt exposing (parseIntHex)
import Regex
import String
import Function


type alias XYZ =
    { x : Float, y : Float, z : Float }


type alias Lab =
    { l : Float, a : Float, b : Float }


{-| Converts a color to an css rgb string.

    colorToCssRgb (rgb 255 0 0) -- "rgb(255, 0, 0)"

-}
colorToCssRgb : Color -> String
colorToCssRgb cl =
    cssColorString "rgb"
        [ String.fromInt cl.red
        , String.fromInt cl.green
        , String.fromInt cl.blue
        ]


{-| Converts a color to an css rgba string.

    colorToCssRgba (rgba 255 0 0 0.5) -- "rgba(255, 0, 0, 0.5)"

-}
colorToCssRgba : Color -> String
colorToCssRgba { red, green, blue, alpha } =
    cssColorString "rgba"
        [ String.fromInt red
        , String.fromInt green
        , String.fromInt blue
        , String.fromFloat alpha
        ]


hueToString : Float -> String
hueToString =
    (*) 180 >> Function.flip (/) pi >> round >> String.fromInt


toPercentString : Float -> String
toPercentString =
    (*) 100 >> round >> String.fromInt >> Function.flip (++) "%"


cssColorString : String -> List String -> String
cssColorString kind values =
    kind ++ "(" ++ String.join ", " values ++ ")"


{-| Converts a color to a hexadecimal string.

    colorToHex (rgb 255 0 0) -- "#ff0000"

-}
colorToHex : Color -> String
colorToHex { red, green, blue } =
    List.map toHex [ red, green, blue ]
        |> (::) "#"
        |> String.join ""


toHex : Int -> String
toHex =
    toRadix >> String.padLeft 2 '0'


toRadix : Int -> String
toRadix n =
    let
        getChr c =
            if c < 10 then
                String.fromInt c
            else
                String.fromChar <| Char.fromCode (87 + c)
    in
        if n < 16 then
            getChr n
        else
            toRadix (n // 16) ++ getChr (modBy 16 n)


{-| Converts a string to `Maybe` of color.
hexToColor "#ff0000" -- "Ok (RGB 255 0 0)"
hexToColor "#f00" -- "Ok (RGB 255 0 0)"
hexToColor "ff0000" -- "Ok (RGB 255 0 0)"
hexToColor "f00" -- "Ok (RGB 255 0 0)"
hexToColor "1234" -- "Err "Parsing hex regex failed""
-}
hexToColor : String -> Result String Color
hexToColor =
    let
        {- Converts "f" to "ff" and "ff" to "ff" -}
        extend : String -> String
        extend token =
            case String.toList token of
                [ token_ ] ->
                    String.fromList [ token_, token_ ]

                _ ->
                    token

        pattern =
            ""
                ++ "^"
                ++ "#?"
                ++ "(?:"
                ++ "(?:([a-f\\d]{2})([a-f\\d]{2})([a-f\\d]{2}))"
                ++ "|"
                ++ "(?:([a-f\\d])([a-f\\d])([a-f\\d]))"
                ++ ")"
                ++ "$"
    in
        String.toLower
            >> Regex.findAtMost 1 (Maybe.withDefault Regex.never <| Regex.fromString pattern)
            >> List.head
            >> Maybe.map .submatches
            >> Maybe.map (List.filterMap identity)
            >> Result.fromMaybe "Parsing hex regex failed"
            >> Result.andThen
                (\colors ->
                    case List.map (extend >> parseIntHex) colors of
                        [ Ok r, Ok g, Ok b ] ->
                            Ok <| rgb r g b

                        _ ->
                            -- there could be more descriptive error cases per channel
                            Err "Parsing ints from hex failed"
                )
