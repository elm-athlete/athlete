module Background
    exposing
        ( Background
        , default
        , images
        , Image
        , BackgroundImage
        , image
        , at
        , Gradient
        , linear
        , radial
        , gradient
        , intermediateColors
        , Angle
        , Radiant
        , Degree
        , rad
        , degree
        , colorStop
        , ColorStop
        , backgroundToCouples
        )

import Color exposing (Color)
import Color.Convert
import Maybe.Extra
import Helpers.Vector exposing (Vector)
import Helpers.Shared exposing (..)
import Helpers.Setters exposing (..)
import Helpers.Css


type alias Background =
    { color : Maybe Color
    , images : List BackgroundImage
    }


default : Background
default =
    Background Nothing []


images : List BackgroundImage -> Modifier Background
images images =
    setImages images


type Image
    = Gradient Gradient
    | Source String


type alias BackgroundImage =
    { image : Maybe Image
    , position : Maybe (Vector SizeUnit)
    }


defaultBackgroundImage : BackgroundImage
defaultBackgroundImage =
    BackgroundImage Nothing Nothing


image : String -> BackgroundImage
image url =
    BackgroundImage (Just <| Source url) Nothing


at : a -> { b | position : Maybe a } -> { b | position : Maybe a }
at =
    setPosition << Just


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


linear : Angle -> ColorStop -> ColorStop -> Gradient
linear angle first last =
    LinearGradient angle first Nothing last
        |> Linear


type alias RadialGradient =
    { first : ColorStop
    , colorStops : Maybe (List ColorStop)
    , last : ColorStop
    }


radial : ColorStop -> ColorStop -> Gradient
radial first last =
    RadialGradient first Nothing last
        |> Radial


gradient : Gradient -> BackgroundImage
gradient =
    asGradient


intermediateColors : List ColorStop -> Gradient -> Gradient
intermediateColors colorStops gradient =
    case gradient of
        Linear linearGradient ->
            linearGradient
                |> setColorStops (Just colorStops)
                |> Linear

        Radial radialGradient ->
            radialGradient
                |> setColorStops (Just colorStops)
                |> Radial


type Angle
    = Rad Radiant
    | Deg Degree


type alias Radiant =
    Float


type alias Degree =
    Float


rad : Float -> Angle
rad =
    Rad


degree : Float -> Angle
degree =
    Deg


colorStop : Color -> ColorStop
colorStop =
    ColorStop Nothing


type alias ColorStop =
    { position : Maybe SizeUnit
    , color : Color
    }


backgroundToCouples : Background -> List ( String, String )
backgroundToCouples background =
    [ unwrapToCouple .color colorToCouple background
    , backgroundImagesToCouple background.images
    ]
        |> List.concat



-- Internals


backgroundImagesToCouple : List BackgroundImage -> List ( String, String )
backgroundImagesToCouple backgroundImages =
    backgroundImages
        |> List.map .image
        |> List.map (Maybe.map imageToString)
        |> Maybe.Extra.values
        |> String.join ", "
        |> (,) "background-image"
        |> List.singleton


imageToString : Image -> String
imageToString image =
    case image of
        Gradient gradient ->
            gradientToString gradient

        Source string ->
            string
                |> Helpers.Css.surroundWithSingleQuotes
                |> Helpers.Css.applyCssFunction "url"


gradientToString : Gradient -> String
gradientToString gradient =
    case gradient of
        Linear { angle, first, colorStops, last } ->
            [ [ angleToString angle
              , colorStopToString first
              ]
            , colorStopsToList colorStops
            , [ colorStopToString last ]
            ]
                |> List.concat
                |> String.join ", "
                |> Helpers.Css.applyCssFunction "linear-gradient"

        Radial { first, colorStops, last } ->
            [ [ colorStopToString first ]
            , colorStopsToList colorStops
            , [ colorStopToString last ]
            ]
                |> List.concat
                |> String.join ", "
                |> Helpers.Css.applyCssFunction "radial-gradient"


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
            (a |> toString) ++ "rad"

        Deg a ->
            (a |> toString) ++ "deg"


colorStopToString : ColorStop -> String
colorStopToString colorStop =
    case colorStop of
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
