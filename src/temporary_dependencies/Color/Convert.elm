module Color.Convert
    exposing
        ( colorToCssHsl
        , colorToCssHsla
        , colorToCssRgb
        , colorToCssRgba
        , colorToHex
        , colorToLab
        , hexToColor
        , labToColor
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


type alias XYZ =
    { x : Float, y : Float, z : Float }


type alias Lab =
    { l : Float, a : Float, b : Float }


{-| Converts a color to an css rgb string.

    colorToCssRgb (rgb 255 0 0) -- "rgb(255, 0, 0)"

-}
colorToCssRgb : Color -> String
colorToCssRgb cl =
    let
        { red, green, blue, alpha } =
            toRgb cl
    in
    cssColorString "rgb"
        [ toString red
        , toString green
        , toString blue
        ]


{-| Converts a color to an css rgba string.

    colorToCssRgba (rgba 255 0 0 0.5) -- "rgba(255, 0, 0, 0.5)"

-}
colorToCssRgba : Color -> String
colorToCssRgba cl =
    let
        { red, green, blue, alpha } =
            toRgb cl
    in
    cssColorString "rgba"
        [ toString red
        , toString green
        , toString blue
        , toString alpha
        ]


{-| Converts a color to an css hsl string.

    colorToCssHsl (hsl 1 1 0.5) -- "hsl(1, 1, 0.5)"

-}
colorToCssHsl : Color -> String
colorToCssHsl cl =
    let
        { hue, saturation, lightness, alpha } =
            toHsl cl
    in
    cssColorString "hsl"
        [ hueToString hue
        , toPercentString saturation
        , toPercentString lightness
        ]


{-| Converts a color to an css hsla string.

    colorToCssHsla (hsla 1 1 0.5 1) -- "hsla(56, 100%, 50%, 1)"

-}
colorToCssHsla : Color -> String
colorToCssHsla cl =
    let
        { hue, saturation, lightness, alpha } =
            toHsl cl
    in
    cssColorString "hsla"
        [ hueToString hue
        , toPercentString saturation
        , toPercentString lightness
        , toString alpha
        ]


hueToString : Float -> String
hueToString =
    (*) 180 >> Function.flip (/) pi >> round >> toString


toPercentString : Float -> String
toPercentString =
    (*) 100 >> round >> toString >> Function.flip (++) "%"


cssColorString : String -> List String -> String
cssColorString kind values =
    kind ++ "(" ++ String.join ", " values ++ ")"


{-| Converts a string to `Maybe` of color.

    hexToColor "#ff0000" -- "Ok (RGB 255 0 0)"
    hexToColor "#f00" -- "Ok (RGB 255 0 0)"
    hexToColor "ff0000" -- "Ok (RGB 255 0 0)"
    hexToColor "f00" -- "Ok (RGB 255 0 0)"
    hexToColor "1234" -- "Err \"Parsing hex regex failed\""

-}
hexToColor : String -> Result String Color
hexToColor =
    let
        {- Converts "f" to "ff" and "ff" to "ff" -}
        extend : String -> String
        extend token =
            case String.toList token of
                [ token ] ->
                    String.fromList [ token, token ]

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
        >> Regex.find (Regex.AtMost 1) (Regex.regex pattern)
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


{-| Converts a color to a hexadecimal string.

    colorToHex (rgb 255 0 0) -- "#ff0000"

-}
colorToHex : Color -> String
colorToHex cl =
    let
        { red, green, blue } =
            toRgb cl
    in
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
                toString c
            else
                String.fromChar <| Char.fromCode (87 + c)
    in
    if n < 16 then
        getChr n
    else
        toRadix (n // 16) ++ getChr (n % 16)


{-| Convert color to CIELAB- color space
-}
colorToLab : Color -> { l : Float, a : Float, b : Float }
colorToLab =
    colorToXyz >> xyzToLab


colorToXyz : Color -> XYZ
colorToXyz cl =
    let
        c ch =
            let
                ch_ =
                    toFloat ch / 255

                ch__ =
                    if ch_ > 4.045e-2 then
                        ((ch_ + 5.5e-2) / 1.055) ^ 2.4
                    else
                        ch_ / 12.92
            in
            ch__ * 100

        { red, green, blue } =
            toRgb cl

        r =
            c red

        g =
            c green

        b =
            c blue
    in
    { x = r * 0.4124 + g * 0.3576 + b * 0.1805
    , y = r * 0.2126 + g * 0.7152 + b * 7.22e-2
    , z = r * 1.93e-2 + g * 0.1192 + b * 0.9505
    }


xyzToLab : XYZ -> Lab
xyzToLab { x, y, z } =
    let
        c ch =
            if ch > 8.856e-3 then
                ch ^ (1 / 3)
            else
                (7.787 * ch) + (16 / 116)

        x_ =
            c (x / 95.047)

        y_ =
            c (y / 100)

        z_ =
            c (z / 108.883)
    in
    { l = (116 * y_) - 16
    , a = 500 * (x_ - y_)
    , b = 200 * (y_ - z_)
    }


{-| Convert a color in CIELAB- color space to Elm `Color`
-}
labToColor : { l : Float, a : Float, b : Float } -> Color
labToColor =
    labToXyz >> xyzToColor


labToXyz : Lab -> XYZ
labToXyz { l, a, b } =
    let
        c ch =
            let
                ch_ =
                    ch * ch * ch
            in
            if ch_ > 8.856e-3 then
                ch_
            else
                (ch - 16 / 116) / 7.787

        y =
            (l + 16) / 116
    in
    { y = c y * 100
    , x = c (y + a / 500) * 95.047
    , z = c (y - b / 200) * 108.883
    }


xyzToColor : XYZ -> Color
xyzToColor { x, y, z } =
    let
        x_ =
            x / 100

        y_ =
            y / 100

        z_ =
            z / 100

        r =
            x_ * 3.2404542 + y_ * -1.5371385 + z_ * -0.4986

        g =
            x_ * -0.969266 + y_ * 1.8760108 + z_ * 4.1556e-2

        b =
            x_ * 5.56434e-2 + y_ * -0.2040259 + z_ * 1.0572252

        c ch =
            let
                ch_ =
                    if ch > 3.1308e-3 then
                        1.055 * (ch ^ (1 / 2.4)) - 5.5e-2
                    else
                        12.92 * ch
            in
            round <| clamp 0 255 (ch_ * 255)
    in
    rgb (c r) (c g) (c b)
