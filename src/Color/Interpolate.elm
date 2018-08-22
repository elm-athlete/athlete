module Color.Interpolate exposing (Space(..), interpolate)

{-|


# Interpolate

Interpolate between two colors

@docs Space, interpolate

-}

import Color exposing (Color, toRgb, rgba, toHsl, hsla)
import Color.Convert exposing (labToColor, colorToLab)


{-| The color space that is used for the interpolation
-}
type Space
    = RGB
    | HSL
    | LAB


degree180 : Float
degree180 =
    degrees 180


degree360 : Float
degree360 =
    degrees 360


{-| Linear interpolation of two colors by a factor between `0` and `1`.
-}
interpolate : Space -> Color -> Color -> Float -> Color
interpolate space cl1 cl2 t =
    let
        i =
            linear t
    in
        case space of
            RGB ->
                let
                    cl1_ =
                        toRgb cl1

                    cl2_ =
                        toRgb cl2
                in
                    rgba (round (i (toFloat cl1_.red) (toFloat cl2_.red)))
                        (round (i (toFloat cl1_.green) (toFloat cl2_.green)))
                        (round (i (toFloat cl1_.blue) (toFloat cl2_.blue)))
                        (i cl1_.alpha cl2_.alpha)

            HSL ->
                let
                    cl1_ =
                        toHsl cl1

                    cl2_ =
                        toHsl cl2

                    h1 =
                        cl1_.hue

                    h2 =
                        cl2_.hue

                    dH =
                        if h2 > h1 && h2 - h1 > degree180 then
                            h2 - h1 + degree360
                        else if h2 < h1 && h1 - h2 > degree180 then
                            h2 + degree360 - h1
                        else
                            h2 - h1
                in
                    hsla (h1 + t * dH)
                        (i cl1_.saturation cl2_.saturation)
                        (i cl1_.lightness cl2_.lightness)
                        (i cl1_.alpha cl2_.alpha)

            LAB ->
                let
                    lab1 =
                        colorToLab cl1

                    lab2 =
                        colorToLab cl2
                in
                    labToColor
                        { l = i lab1.l lab2.l
                        , a = i lab1.a lab2.a
                        , b = i lab1.b lab2.b
                        }


linear : Float -> Float -> Float -> Float
linear t i1 i2 =
    i1 + (i2 - i1) * t
