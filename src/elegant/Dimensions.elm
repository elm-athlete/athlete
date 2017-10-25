module Dimensions
    exposing
        ( Dimensions
        , width
        , height
        , square
        , minHeight
        , maxHeight
        , defaultDimensions
        , dimensionsToCouples
        )

{-|
@docs width
@docs height
@docs square
@docs minHeight
@docs maxHeight
@docs Dimensions
@docs defaultDimensions
@docs dimensionsToCouples
-}

import Helpers.Shared exposing (..)
import Elegant.Setters exposing (..)


{-|
  The type behind the handling of (max-|min-|)width and (max-|min-|)height
-}
type alias Dimensions =
    ( DimensionAxis, DimensionAxis )


type alias DimensionAxis =
    { min : Maybe SizeUnit
    , dimension : Maybe SizeUnit
    , max : Maybe SizeUnit
    }


{-|
-}
defaultDimensions : ( DimensionAxis, DimensionAxis )
defaultDimensions =
    ( defaultDimensionAxis, defaultDimensionAxis )


defaultDimensionAxis : DimensionAxis
defaultDimensionAxis =
    DimensionAxis Nothing Nothing Nothing


{-| -}
width : SizeUnit -> Modifier Dimensions
width value ( x, y ) =
    ( x |> setDimension (Just value), y )


{-| -}
height : SizeUnit -> Modifier Dimensions
height value ( x, y ) =
    ( x, y |> setDimension (Just value) )


{-| -}
square : SizeUnit -> Modifier Dimensions
square value =
    height value << width value


{-| -}
minHeight : SizeUnit -> Modifier Dimensions
minHeight value ( x, y ) =
    ( x, y |> setMin (Just value) )


{-| -}
maxHeight : SizeUnit -> Modifier Dimensions
maxHeight value ( x, y ) =
    ( x, y |> setMax (Just value) )


{-|
-}
dimensionsToCouples : Dimensions -> List ( String, String )
dimensionsToCouples size =
    [ ( "width", Tuple.first >> .dimension )
    , ( "min-width", Tuple.first >> .min )
    , ( "max-width", Tuple.first >> .max )
    , ( "height", Tuple.second >> .dimension )
    , ( "max-height", Tuple.second >> .max )
    , ( "min-height", Tuple.second >> .min )
    ]
        |> List.map (Tuple.mapSecond (callOn size))
        |> keepJustValues
        |> List.map (Tuple.mapSecond sizeUnitToString)
