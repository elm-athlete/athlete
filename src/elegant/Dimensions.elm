module Elegant.Dimensions
    exposing
        ( Dimensions
        , defaultDimensions
        , dimensionsToCouples
        , height
        , maxHeight
        , maxWidth
        , minHeight
        , minWidth
        , square
        , width
        )

{-|

@docs width
@docs height
@docs square
@docs minWidth
@docs maxWidth
@docs minHeight
@docs maxHeight
@docs Dimensions
@docs defaultDimensions
@docs dimensionsToCouples

-}

import Elegant.Helpers.Shared exposing (..)
import Elegant.Internals.Setters exposing (..)
import Function exposing (callOn)
import Modifiers exposing (..)


{-| The type behind the handling of (max-|min-|)width and (max-|min-|)height
-}
type alias Dimensions =
    ( DimensionAxis, DimensionAxis )


type alias DimensionAxis =
    { min : Maybe SizeUnit
    , dimension : Maybe SizeUnit
    , max : Maybe SizeUnit
    }


{-| -}
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
minWidth : SizeUnit -> Modifier Dimensions
minWidth value ( x, y ) =
    ( x |> setMin (Just value), y )


{-| -}
maxWidth : SizeUnit -> Modifier Dimensions
maxWidth value ( x, y ) =
    ( x |> setMax (Just value), y )


{-| -}
minHeight : SizeUnit -> Modifier Dimensions
minHeight value ( x, y ) =
    ( x, y |> setMin (Just value) )


{-| -}
maxHeight : SizeUnit -> Modifier Dimensions
maxHeight value ( x, y ) =
    ( x, y |> setMax (Just value) )


{-| -}
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
