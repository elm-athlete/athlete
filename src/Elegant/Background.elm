module Elegant.Background
    exposing
        ( Angle
        , Background
        , BackgroundImage
        , ColorStop
        , Degree
        , Gradient
        , Image
        , Radiant
        , at
        , backgroundToCouples
        , colorStop
        , default
        , degree
        , gradient
        , image
        , images
        , intermediateColors
        , linear
        , rad
        , radial
        )

{-| Background contains everything about background rendering: using photos or gradient,
and positionning them on the page.


# Types

@docs Background
@docs Image
@docs BackgroundImage
@docs Gradient
@docs Angle
@docs Degree
@docs Radiant
@docs ColorStop


# Background creation

@docs default
@docs images
@docs image
@docs gradient
@docs linear
@docs radial


# Background modifiers

@docs intermediateColors
@docs colorStop
@docs at
@docs degree
@docs rad


# Compilation

@docs backgroundToCouples

-}

import Color exposing (Color)
import Color.Convert
import Elegant.Helpers.Css
import Elegant.Helpers.Shared exposing (..)
import Elegant.Helpers.Vector exposing (Vector)
import Elegant.Internals.Setters exposing (..)
import Function exposing (callOn)
import Maybe.Extra
import Modifiers exposing (..)


{-| The `Background` record contains everything about background rendering,
including character rendering. You probably won't use it as is, but instead using
`Box.background` which automatically generate an empty `Background` record. You
can then use modifiers. I.E.

    Box.background
        [ Elegant.color Color.white
        , Background.images
            [ Background.image "/example.photo" ]
        ]

-}
type alias Background =
    { color : Maybe Color
    , images : List BackgroundImage
    }


{-| Generates an empty `Background`.
-}
default : Background
default =
    Background Nothing []


{-| Modify the background rendering to add photos and gradients.
It modifies the images list in `Background`.

    Background.images
        [ Background.image "/example.photo" ]

-}
images : List BackgroundImage -> Modifier Background
images images_ =
    setImages images_


{-| Represents an image in CSS. It can be an image, represented by a source url, or
a gradiant. They are instanciated by `image` (which instanciate an Image inside a
`BackgroundImage`) or by `linear` or `radial`, instanciating a gradiant.
-}
type Image
    = Gradient Gradient
    | Source String


{-| Represents a Background Image, i.e. an image in Background. Contrary to `Image`,
a `BackgroundImage` contains an image and a position. This position set the position of the image
on the background.
-}
type alias BackgroundImage =
    { image : Maybe Image
    , position : Maybe (Vector SizeUnit)
    }


defaultBackgroundImage : BackgroundImage
defaultBackgroundImage =
    BackgroundImage Nothing (Just ( Percent 0, Percent 0 ))


{-| Accepts an Url, and returns a `BackgroundImage`. This image can be modified
to add a position to it.
-}
image : String -> BackgroundImage
image url =
    BackgroundImage (Just <| Source url) (Just ( Percent 0, Percent 0 ))


{-| Sets a position on both a gradient and a `BackgroundImage`.
-}
at : a -> { b | position : Maybe a } -> { b | position : Maybe a }
at =
    setPosition << Just


{-| Defines a gradient, which can be either linear or radial. They are instanciated
by the corresponding functions.
-}
type Gradient
    = Linear LinearGradient
    | Radial RadialGradient


asGradient : Gradient -> BackgroundImage
asGradient =
    Gradient
        >> Just
        >> setImageIn defaultBackgroundImage


type alias LinearGradient =
    { angle : Angle
    , first : ColorStop
    , colorStops : Maybe (List ColorStop)
    , last : ColorStop
    }


{-| Creates a linear gradient. The angle, and two colors (one for starting color,
the second for the ending color) are required, and more colors can be added in the
gradient using `intermediateColors`.
-}
linear : Angle -> ColorStop -> ColorStop -> Gradient
linear angle first last =
    LinearGradient angle first Nothing last
        |> Linear


type alias RadialGradient =
    { first : ColorStop
    , colorStops : Maybe (List ColorStop)
    , last : ColorStop
    }


{-| Creates a radial gradient. Two colors (one for starting color, the second
for the ending color) are required, and more colors can be added in the gradient
using `intermediateColors`.
-}
radial : ColorStop -> ColorStop -> Gradient
radial first last =
    RadialGradient first Nothing last
        |> Radial


{-| Accepts a gradient, and creates a `BackgroundImage`.
-}
gradient : Gradient -> BackgroundImage
gradient =
    asGradient


{-| Sets multiples intermediate colors in a gradient.
By default, a gradient is created with two colors. This can be used to add
more colors.
-}
intermediateColors : List ColorStop -> Modifier Gradient
intermediateColors colorStops gradient_ =
    case gradient_ of
        Linear linearGradient ->
            linearGradient
                |> setColorStops (Just colorStops)
                |> Linear

        Radial radialGradient ->
            radialGradient
                |> setColorStops (Just colorStops)
                |> Radial


{-| Represents an angle. Can be either radiant or degree.
-}
type Angle
    = Rad Radiant
    | Deg Degree


{-| Represents a radiant.
-}
type alias Radiant =
    Float


{-| Represents a degree.
-}
type alias Degree =
    Float


{-| Generates an angle in radiant from Float.
-}
rad : Float -> Angle
rad =
    Rad


{-| Generates an angle in degree from Float.
-}
degree : Float -> Angle
degree =
    Deg


{-| Represents a CSS Color Stop, which contains a Color, and possibly a position.
This is automatically generated by `colorStop`.
-}
type alias ColorStop =
    { position : Maybe SizeUnit
    , color : Color
    }


{-| Generates a CSS Color Stop from Color to use in gradients.
-}
colorStop : Color -> ColorStop
colorStop =
    ColorStop Nothing


{-| Compiles a `Background` record to the corresponding CSS list of tuples.
Compiles only styles which are defined, ignoring `Nothing` fields.
-}
backgroundToCouples : Background -> List ( String, String )
backgroundToCouples background =
    [ unwrapToCouple .color backgroundColorToCouple background
    , backgroundImagesToCouple background.images
    ]
        |> List.concat



-- Internals


backgroundColorToCouple : Color -> ( String, String )
backgroundColorToCouple color =
    ( "background-color", Color.Convert.colorToCssRgba color )


backgroundImagesToCouple : List BackgroundImage -> List ( String, String )
backgroundImagesToCouple backgroundImages =
    [ extractMaybeValue .image imageToString "background-image"
    , extractMaybeValue .position positionToString "background-position"
    ]
        |> List.concatMap (callOn backgroundImages)


extractMaybeValue :
    (BackgroundImage -> Maybe value)
    -> (value -> String)
    -> String
    -> List BackgroundImage
    -> List ( String, String )
extractMaybeValue getter valueToString property =
    List.map getter
        >> List.map (Maybe.map valueToString)
        >> Maybe.Extra.values
        >> String.join ", "
        >> tupleIfNotEmpty property


tupleIfNotEmpty : String -> String -> List ( String, String )
tupleIfNotEmpty property value =
    if String.isEmpty value then
        []
    else
        [ ( property, value ) ]


positionToString : Vector SizeUnit -> String
positionToString ( a, b ) =
    sizeUnitToString a ++ " " ++ sizeUnitToString b


imageToString : Image -> String
imageToString image_ =
    case image_ of
        Gradient gradient_ ->
            gradientToString gradient_

        Source string ->
            string
                |> Elegant.Helpers.Css.surroundWithSingleQuotes
                |> Elegant.Helpers.Css.applyCssFunction "url"


gradientToString : Gradient -> String
gradientToString gradient_ =
    case gradient_ of
        Linear { angle, first, colorStops, last } ->
            [ [ angleToString angle
              , colorStopToString first
              ]
            , colorStopsToList colorStops
            , [ colorStopToString last ]
            ]
                |> List.concat
                |> String.join ", "
                |> Elegant.Helpers.Css.applyCssFunction "linear-gradient"

        Radial { first, colorStops, last } ->
            [ [ colorStopToString first ]
            , colorStopsToList colorStops
            , [ colorStopToString last ]
            ]
                |> List.concat
                |> String.join ", "
                |> Elegant.Helpers.Css.applyCssFunction "radial-gradient"


colorStopsToList : Maybe (List ColorStop) -> List String
colorStopsToList =
    Maybe.map
        (colorStopsToString
            >> List.singleton
        )
        >> Maybe.withDefault []


angleToString : Angle -> String
angleToString angle =
    case angle of
        Rad a ->
            (a |> String.fromFloat) ++ "rad"

        Deg a ->
            (a |> String.fromFloat) ++ "deg"


colorStopToString : ColorStop -> String
colorStopToString colorStop_ =
    case colorStop_ of
        { color, position } ->
            [ color
                |> Color.Convert.colorToCssRgba
                |> Just
            , position
                |> Maybe.map sizeUnitToString
            ]
                |> Maybe.Extra.values
                |> String.join " "


colorStopsToString : List ColorStop -> String
colorStopsToString =
    List.map colorStopToString
        >> String.join ", "
