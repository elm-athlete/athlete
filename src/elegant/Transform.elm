module Transform
    exposing
        ( Transform
        , default
        , translateX
        , translateY
        , translateZ
        , transformToCouples
        , rotateX
        , rotateY
        , rotateZ
        , origin
        , backfaceVisibilityHidden
        , backfaceVisibilityVisible
        , preserve3d
        , perspective
        , perspectiveOrigin
        )

{-| Transform contains everything about css transformations : translate, rotate and scale.


# Types

@docs Transform


# Default transform

@docs default


# Shadow modifiers

@docs translateX
@docs translateY
@docs translateZ
@docs rotateX
@docs rotateY
@docs rotateZ
@docs origin
@docs backfaceVisibilityHidden
@docs backfaceVisibilityVisible
@docs preserve3d
@docs perspective
@docs perspectiveOrigin


# Compilation

@docs transformToCouples

-}

import Helpers.Shared exposing (..)
import Elegant.Setters exposing (..)
import Modifiers exposing (..)


type alias Triplet a =
    ( a, a, a )


{-| The Transform record contains everything about transformations.
You probably won't use it as is, but instead using `Box.transform`
which automatically generate an empty `Transform` record. You
can then use modifiers. I.E.

    Box.transform
        [ Transform.translateX (px 30)
        , Transform.translateY (vw 30)
        ]

-}
type alias Transform =
    { translate : Triplet (Maybe SizeUnit)
    , rotate : Triplet (Maybe Angle)
    , origin : Maybe (Triplet SizeUnit)
    , backfaceVisibility : Maybe BackfaceVisibility
    , transformStyle : Maybe TransformStyle
    , perspective : Maybe SizeUnit
    , perspectiveOrigin : Maybe ( SizeUnit, SizeUnit )

    -- , scale : Triplet Scale
    }


type TransformStyle
    = Flat
    | Preserve3d


{-| Change the perspective of a scene. It represents the distance between the
z=0 plane and the user in order to give a 3D-positioned element some
perspective. Each 3D element with z>0 becomes larger; each 3D-element with z<0
becomes smaller. The strength of the effect is determined by the value of this
property.
-}
perspective : SizeUnit -> Transform -> Transform
perspective a transform =
    { transform | perspective = Just a }


{-| Define the origin of the perspective of a scene. It represents the position
at which the viewer is looking. It is used as the vanishing point by the
perspective property.
-}
perspectiveOrigin : ( SizeUnit, SizeUnit ) -> Transform -> Transform
perspectiveOrigin perspectiveOrigin transform =
    { transform | perspectiveOrigin = Just perspectiveOrigin }


{-| Generate an empty `Translate` record, with every field equal to Nothing.
You are free to use it as you wish, but it is instanciated automatically by `Box.translate`.
-}
default : Transform
default =
    Transform ( Nothing, Nothing, Nothing ) ( Nothing, Nothing, Nothing ) Nothing Nothing Nothing Nothing Nothing


{-| Set the origin of the Transform.
-}
origin : ( SizeUnit, SizeUnit, SizeUnit ) -> Modifier Transform
origin coordinates =
    setOrigin (Just coordinates)


{-| Set the translateX of the Transform.
-}
translateX : SizeUnit -> Modifier Transform
translateX a transform =
    case transform.translate of
        ( x, y, z ) ->
            setTranslate ( Just a, y, z ) transform


{-| Set the translateY of the Transform.
-}
translateY : SizeUnit -> Modifier Transform
translateY a transform =
    case transform.translate of
        ( x, y, z ) ->
            setTranslate ( x, Just a, z ) transform


{-| Set the translateZ of the Transform.
-}
translateZ : SizeUnit -> Modifier Transform
translateZ a transform =
    case transform.translate of
        ( x, y, z ) ->
            setTranslate ( x, y, Just a ) transform


{-| Set the rotateX of the Transform.
-}
rotateX : Angle -> Modifier Transform
rotateX a transform =
    case transform.rotate of
        ( x, y, z ) ->
            setRotate ( Just a, y, z ) transform


{-| Set the rotateY of the Transform.
-}
rotateY : Angle -> Modifier Transform
rotateY a transform =
    case transform.rotate of
        ( x, y, z ) ->
            setRotate ( x, Just a, z ) transform


{-| Set the translateZ of the Transform.
-}
rotateZ : Angle -> Modifier Transform
rotateZ a transform =
    case transform.rotate of
        ( x, y, z ) ->
            setRotate ( x, y, Just a ) transform


{-| Compiles a `Transform` record to the corresponding CSS tuple.
Compiles only parts which are defined, ignoring `Nothing` fields.
-}
transformToCouples : Transform -> List ( String, String )
transformToCouples transform =
    [ ( "transform", transformToString transform )
    ]
        ++ unwrapToCouple .backfaceVisibility backfaceVisibilityToCouple transform
        ++ unwrapToCouple .transformStyle transformStyleToCouple transform
        ++ unwrapToCouple .perspective perspectiveToCouple transform
        ++ unwrapToCouple .perspectiveOrigin perspectiveOriginToCouple transform
        ++ unwrapToCouple .origin originToCouple transform



-- Internals


translateCoordinateToString : ( String, Maybe SizeUnit ) -> List String
translateCoordinateToString ( coord, val ) =
    case val of
        Nothing ->
            []

        Just val ->
            [ "translate" ++ coord ++ "(" ++ (sizeUnitToString val) ++ ")"
            ]


rotateCoordinateToString : ( String, Maybe Angle ) -> List String
rotateCoordinateToString ( coord, val ) =
    case val of
        Nothing ->
            []

        Just val ->
            [ "rotate" ++ coord ++ "(" ++ (angleToString val) ++ ")"
            ]


translateToStringList : Triplet (Maybe SizeUnit) -> List String
translateToStringList ( maybeX, maybeY, maybeZ ) =
    [ ( "X", maybeX )
    , ( "Y", maybeY )
    , ( "Z", maybeZ )
    ]
        |> List.concatMap
            translateCoordinateToString


rotateToStringList : Triplet (Maybe Angle) -> List String
rotateToStringList ( maybeX, maybeY, maybeZ ) =
    [ ( "X", maybeX )
    , ( "Y", maybeY )
    , ( "Z", maybeZ )
    ]
        |> List.concatMap
            rotateCoordinateToString


transformToString : Transform -> String
transformToString { translate, rotate } =
    ([ rotateToStringList rotate
     , translateToStringList translate
     ]
        |> List.concat
        |> String.join " "
    )


type BackfaceVisibility
    = BackfaceVisible
    | BackfaceHidden


{-| in a (css) 3d rendered scene, we hide back facing elements.
-}
backfaceVisibilityHidden : Transform -> Transform
backfaceVisibilityHidden =
    setBackfaceVisibility (Just BackfaceHidden)


{-| in a (css) 3d rendered scene, we show back facing elements.
-}
backfaceVisibilityVisible : Transform -> Transform
backfaceVisibilityVisible =
    setBackfaceVisibility (Just BackfaceVisible)


backfaceVisibilityToString : BackfaceVisibility -> String
backfaceVisibilityToString val =
    case val of
        BackfaceVisible ->
            "visible"

        BackfaceHidden ->
            "hidden"


backfaceVisibilityToCouple : BackfaceVisibility -> ( String, String )
backfaceVisibilityToCouple =
    (,) "backface-visibility" << backfaceVisibilityToString


{-| in a (css) 3d rendered scene, we hide back facing elements.
-}
preserve3d : Transform -> Transform
preserve3d =
    setTransformStyle (Just Preserve3d)


transformStyleToString : TransformStyle -> String
transformStyleToString val =
    case val of
        Preserve3d ->
            "preserve-3d"

        Flat ->
            "flat"


transformStyleToCouple : TransformStyle -> ( String, String )
transformStyleToCouple =
    (,) "transform-style" << transformStyleToString


perspectiveToCouple : SizeUnit -> ( String, String )
perspectiveToCouple =
    (,) "perspective" << sizeUnitToString


perspectiveOriginToString : ( SizeUnit, SizeUnit ) -> String
perspectiveOriginToString ( x, y ) =
    [ x, y ]
        |> List.map sizeUnitToString
        |> String.join " "


perspectiveOriginToCouple : ( SizeUnit, SizeUnit ) -> ( String, String )
perspectiveOriginToCouple =
    (,) "perspective-origin" << perspectiveOriginToString


originToString : ( SizeUnit, SizeUnit, SizeUnit ) -> String
originToString ( x, y, z ) =
    [ x, y, z ]
        |> List.map sizeUnitToString
        |> String.join " "


originToCouple : ( SizeUnit, SizeUnit, SizeUnit ) -> ( String, String )
originToCouple =
    (,) "transform-origin" << originToString
