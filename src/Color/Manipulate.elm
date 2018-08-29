module Color.Manipulate exposing (darken, lighten, saturate, desaturate, rotateHue, fadeIn, fadeOut, grayscale, scaleHsl, scaleRgb, mix, weightedMix)

{-| A library for creating and manipulating colors.


# Color adjustment

@docs darken, lighten, saturate, desaturate, rotateHue, fadeIn, fadeOut, grayscale, scaleHsl, scaleRgb, mix, weightedMix

-}

import Color exposing (Color, toHsl, hsla, toRgb, rgba)
import Debug exposing (log)


limit : Float -> Float
limit =
    clamp 0 1


{-| Decrease the lightning of a color
-}
darken : Float -> Color -> Color
darken offset cl =
    let
        { hue, saturation, lightness, alpha } =
            toHsl cl
    in
        hsla hue saturation (limit (lightness - offset)) alpha


{-| Increase the lightning of a color
-}
lighten : Float -> Color -> Color
lighten offset cl =
    darken -offset cl


{-| Increase the saturation of a color
-}
saturate : Float -> Color -> Color
saturate offset cl =
    let
        { hue, saturation, lightness, alpha } =
            toHsl cl
    in
        hsla hue (limit (saturation + offset)) lightness alpha


{-| Decrease the saturation of a color
-}
desaturate : Float -> Color -> Color
desaturate offset cl =
    saturate -offset cl


{-| Convert the color to a greyscale version, aka set saturation to 0
-}
grayscale : Color -> Color
grayscale cl =
    saturate -1 cl


{-| Increase the opacity of a color
-}
fadeIn : Float -> Color -> Color
fadeIn offset cl =
    let
        { hue, saturation, lightness, alpha } =
            toHsl cl
    in
        hsla hue saturation lightness (limit (alpha + offset))


{-| Decrease the opacity of a color
-}
fadeOut : Float -> Color -> Color
fadeOut offset cl =
    fadeIn -offset cl


{-| Change the hue of a color. The angle value must be in degrees
-}
rotateHue : Float -> Color -> Color
rotateHue angle cl =
    let
        { hue, saturation, lightness, alpha } =
            toHsl cl
    in
        hsla (hue + (degrees angle)) saturation lightness alpha


{-| Fluidly scale saturation, lightness and alpha channel.

That means that lightening an already-light color with `scaleHsl` won’t change the lightness much, but lightening
a dark color by the same amount will change it more dramatically.

For example, the lightness of a color can be anywhere between 0 and 1.0. If `scaleHsl (0, 0.4, 0) color` is called,
the resulting color’s lightness will be 40% of the way between its original lightness and 1.0. If
`scaleHsl (0, -0.4, 0) color` is called instead, the lightness will be 40% of the way between the original
and 0.

The values of the supplied tuple scale saturation, lightness, and opacity, respectively, and have a valid range of
-1.0 to 1.0.

This function is inspired by the Sass function [scale-color](http://sass-lang.com/documentation/Sass/Script/Functions.html#scale_color-instance_method).

-}
scaleHsl : ( Float, Float, Float ) -> Color -> Color
scaleHsl scaleBy color =
    let
        ( saturationScale, lightnessScale, alphaScale ) =
            scaleBy

        hsl =
            toHsl color
    in
        hsla hsl.hue
            (scale 1.0 saturationScale hsl.saturation)
            (scale 1.0 lightnessScale hsl.lightness)
            (scale 1.0 alphaScale hsl.alpha)


{-| Fluidly scale red, green, blue, and alpha channels.

That means that reddening a already-red color with `scaleRgb` won’t change the redness much, but reddening a color
with little or no red by the same amount will change it more dramatically.

For example, the redness of a color can be anywhere between 0 and 255. If `scaleRgb 0.4 0 0 0 color` is called,
the resulting color’s redness will be 40% of the way between its original redness and 255. If
`scaleRgb -0.4 0 0 0 color` is called instead, the redness will be 40% of the way between the original
and 0.

The values of the supplied tuple scale red, green, blue, and alpha channels, respectively, and have a valid range of
-1.0 to 1.0.

This function is inspired by the Sass function [scale-color](http://sass-lang.com/documentation/Sass/Script/Functions.html#scale_color-instance_method).

-}
scaleRgb : Float -> Float -> Float -> Float -> Color -> Color
scaleRgb rScale gScale bScale aScale color =
    let
        rgb =
            toRgb color
    in
        rgba
            (round (scale 255 rScale (toFloat rgb.red)))
            (round (scale 255 gScale (toFloat rgb.green)))
            (round (scale 255 bScale (toFloat rgb.blue)))
            (scale 1.0 aScale rgb.alpha)


scale : Float -> Float -> Float -> Float
scale max scaleAmount value =
    let
        clampedScale =
            clamp -1.0 1.0 scaleAmount

        clampedValue =
            clamp 0 max value

        diff =
            if clampedScale > 0 then
                max - clampedValue
            else
                clampedValue
    in
        clampedValue + diff * clampedScale


{-| Mixes two colors together.

This function takes the average of each of the RGB components, weighted by a provided value between 0 and 1.0. The
opacity of the colors is also considered when weighting the components.

The weight specifies the amount of the first color that should be included in the returned color. For example, a weight
of 0.5 means that half the first color and half the second color should be used. A weight of 0.25 means that a quarter
of the first color and three quarters of the second color should be used.

This function uses the same algorithm as the [mix](http://sass-lang.com/documentation/Sass/Script/Functions.html#mix-instance_method) function in Sass.

-}
weightedMix : Color -> Color -> Float -> Color
weightedMix color1 color2 weight =
    let
        clampedWeight =
            clamp 0 1 weight

        c1 =
            toRgb color1

        c2 =
            toRgb color2

        w =
            calculateWeight c1.alpha c2.alpha clampedWeight

        rMixed =
            mixChannel w c1.red c2.red

        gMixed =
            mixChannel w c1.green c2.green

        bMixed =
            mixChannel w c1.blue c2.blue

        alphaMixed =
            c1.alpha * clampedWeight + c2.alpha * (1 - clampedWeight)
    in
        rgba rMixed gMixed bMixed alphaMixed


{-| Mixes two colors together. This is the same as calling `weightedMix` with a weight of 0.5.
-}
mix : Color -> Color -> Color
mix c1 c2 =
    weightedMix c1 c2 0.5


calculateWeight : Float -> Float -> Float -> Float
calculateWeight a1 a2 weight =
    let
        a =
            a1 - a2

        w1 =
            weight * 2 - 1

        w2 =
            if w1 * a == -1 then
                w1
            else
                (w1 + a) / (1 + w1 * a)
    in
        (w2 + 1) / 2


mixChannel : Float -> Int -> Int -> Int
mixChannel weight c1 c2 =
    round <| (toFloat c1) * weight + (toFloat c2) * (1 - weight)
