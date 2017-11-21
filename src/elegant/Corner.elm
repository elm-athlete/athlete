module Corner
    exposing
        ( Corner
        , default
        , CornerSet
        , circular
        , elliptic
        , top
        , topLeft
        , topRight
        , right
        , bottom
        , bottomLeft
        , bottomRight
        , left
        , all
        , cornerToCouples
        )

{-| Corner contains everything about corner radius (also called border radius in CSS).


# Types

@docs Corner
@docs CornerSet


# Default corner radius

@docs default


# Corner radius style

@docs circular
@docs elliptic


# Corner radius selector

@docs top
@docs topRight
@docs right
@docs bottomRight
@docs bottom
@docs bottomLeft
@docs left
@docs topLeft
@docs all


# Compilation

@docs cornerToCouples

-}

import Helpers.Shared exposing (..)
import Elegant.Setters as Setters
import Modifiers exposing (..)


{-| The `Corner` record contains everything about corner radius (also called border radius in CSS).
You probably won't use it as is, but instead using `Elegant.corner`
which automatically generate an empty `Corner` record. You
can then use modifiers. I.E.

    Elegant.corner
        [ Corner.circular Corner.all (px 30) ]

-}
type alias Corner =
    { topLeft : Maybe ( SizeUnit, SizeUnit )
    , topRight : Maybe ( SizeUnit, SizeUnit )
    , bottomRight : Maybe ( SizeUnit, SizeUnit )
    , bottomLeft : Maybe ( SizeUnit, SizeUnit )
    }


{-| Generate an empty `Corner` record, with every field equal to Nothing.
You are free to use it as you wish, but it is instanciated automatically by `Elegant.corner`.
-}
default : Corner
default =
    Corner Nothing Nothing Nothing Nothing


{-| Represents the possible selected corner(s).
It can be Top, TopRight, Right, BottomRight, Bottom, BottomLeft, Left, TopLeft or All.
They are created by `top`, `topRight`, `right`, `bottomRight`, `bottom`, `bottomLeft`,
`left`, `topLeft` or `all`.
-}
type CornerSet
    = Top
    | TopRight
    | Right
    | BottomRight
    | Bottom
    | BottomLeft
    | Left
    | TopLeft
    | All


{-| Set the corner(s) to be round (the two angles are the same).
-}
circular : CornerSet -> SizeUnit -> Modifier Corner
circular set value =
    setCorner set value value


{-| Set the corner(s) to be elliptic, i.e. you can specify two different values
for the corner(s).
-}
elliptic : CornerSet -> SizeUnit -> SizeUnit -> Modifier Corner
elliptic set val1 val2 =
    setCorner set val1 val2


{-| Select the two top corners.
-}
top : CornerSet
top =
    Top


{-| Select the top-right corner.
-}
topRight : CornerSet
topRight =
    TopRight


{-| Select the two right corners.
-}
right : CornerSet
right =
    Right


{-| Select the bottom-right corner.
-}
bottomRight : CornerSet
bottomRight =
    BottomRight


{-| Select the two bottom corners.
-}
bottom : CornerSet
bottom =
    Bottom


{-| Select the bottom-left corner.
-}
bottomLeft : CornerSet
bottomLeft =
    BottomLeft


{-| Select the two left corners.
-}
left : CornerSet
left =
    Left


{-| Select the top-left corner.
-}
topLeft : CornerSet
topLeft =
    TopLeft


{-| Select the four corners.
-}
all : CornerSet
all =
    All


{-| Compiles a `Corner` record to the corresponding CSS tuples.
Compiles only parts which are defined, ignoring `Nothing` fields.
-}
cornerToCouples : Corner -> List ( String, String )
cornerToCouples corner =
    [ unwrapToCouple .topLeft (cornerToCouple "border-top-left")
    , unwrapToCouple .topRight (cornerToCouple "border-top-right")
    , unwrapToCouple .bottomLeft (cornerToCouple "border-bottom-left")
    , unwrapToCouple .bottomRight (cornerToCouple "border-bottom-right")
    ]
        |> List.concatMap (callOn corner)



-- Internals


cornerToCouple : String -> ( SizeUnit, SizeUnit ) -> ( String, String )
cornerToCouple corner values =
    ( corner ++ "-radius", cornerToString values )


cornerToString : ( SizeUnit, SizeUnit ) -> String
cornerToString ( val1, val2 ) =
    [ sizeUnitToString val1, sizeUnitToString val2 ] |> String.join " "


setCorner : CornerSet -> SizeUnit -> SizeUnit -> Modifier Corner
setCorner set val1 val2 =
    case set of
        Top ->
            setTop val1 val2

        TopRight ->
            setTopRight val1 val2

        Right ->
            setRight val1 val2

        BottomRight ->
            setBottomRight val1 val2

        Bottom ->
            setBottom val1 val2

        BottomLeft ->
            setBottomLeft val1 val2

        Left ->
            setLeft val1 val2

        TopLeft ->
            setTopLeft val1 val2

        All ->
            setAll val1 val2


setTopLeft : SizeUnit -> SizeUnit -> Modifier Corner
setTopLeft val1 val2 =
    Setters.setTopLeft <| Just ( val1, val2 )


setTopRight : SizeUnit -> SizeUnit -> Modifier Corner
setTopRight val1 val2 =
    Setters.setTopRight <| Just ( val1, val2 )


setBottomLeft : SizeUnit -> SizeUnit -> Modifier Corner
setBottomLeft val1 val2 =
    Setters.setBottomLeft <| Just ( val1, val2 )


setBottomRight : SizeUnit -> SizeUnit -> Modifier Corner
setBottomRight val1 val2 =
    Setters.setBottomRight <| Just ( val1, val2 )


setTop : SizeUnit -> SizeUnit -> Modifier Corner
setTop val1 val2 =
    setTopLeft val1 val2 << setTopRight val1 val2


setBottom : SizeUnit -> SizeUnit -> Modifier Corner
setBottom val1 val2 =
    setBottomLeft val1 val2 << setBottomRight val1 val2


setLeft : SizeUnit -> SizeUnit -> Modifier Corner
setLeft val1 val2 =
    setTopLeft val1 val2 << setBottomLeft val1 val2


setRight : SizeUnit -> SizeUnit -> Modifier Corner
setRight val1 val2 =
    setTopRight val1 val2 << setBottomRight val1 val2


setAll : SizeUnit -> SizeUnit -> Modifier Corner
setAll val1 val2 =
    setTop val1 val2 << setBottom val1 val2
