module Outline
    exposing
        ( Outline
        , default
        , OutlineStyle
        , none
        , solid
        , dashed
        , thickness
        , outlineToCouples
        )

{-| Outline contains everything about outline rendering.


# Types

@docs Outline
@docs OutlineStyle


# Default border

@docs default


# Border modifiers


## Appearance

@docs thickness
@docs none
@docs solid
@docs dashed


# Compilation

@docs outlineToCouples

-}

import Color exposing (Color)
import Setters exposing (..)
import Shared exposing (..)


{-| The `Outline` record contains everything about one outline side.
You probably won't use it as is, but instead using `Elegant.outline`
which automatically generate an empty `Outline` record. You
can then use modifiers. I.E.

    Elegant.outline
        [ Outline.solid
        , Elegant.color Color.blue
        ]

-}
type alias Outline =
    { color : Maybe Color
    , thickness : Maybe SizeUnit
    , style : Maybe OutlineStyle
    }


{-| Generate an empty `Outline` record, with every field equal to Nothing.
You are free to use it as you wish, but it is instanciated automatically by `Elegant.outline`.
-}
default : Outline
default =
    Outline Nothing Nothing Nothing


{-| Represents the possible styles of the outline.
It can be Solid or Dashed. They are created by `solid` and `dashed`.
-}
type OutlineStyle
    = Solid
    | Dashed
    | None


{-| Set the outline to none.
-}
none : Modifier Outline
none =
    setStyle <| Just None


{-| Set the outline as solid.
-}
solid : Modifier Outline
solid =
    setStyle <| Just Solid


{-| Set the outline as dashed.
-}
dashed : Modifier Outline
dashed =
    setStyle <| Just Dashed


{-| Set the thickness of the outline.
-}
thickness : SizeUnit -> Modifier Outline
thickness =
    setThickness << Just


{-| Compiles an `Outline` record to the corresponding CSS list of tuples.
Compiles only styles which are defined, ignoring `Nothing` fields.
-}
outlineToCouples : Outline -> List ( String, String )
outlineToCouples outline =
    [ unwrapToCouple .thickness thicknessToCouple
    , unwrapToCouple .style styleToCouple
    , unwrapToCouple .color colorToCouple
    ]
        |> List.concatMap (callOn outline)



-- Internals


thicknessToCouple : SizeUnit -> ( String, String )
thicknessToCouple value =
    ( "outline-width", sizeUnitToString value )


styleToCouple : OutlineStyle -> ( String, String )
styleToCouple style =
    ( "outline-style", styleToString style )


styleToString : OutlineStyle -> String
styleToString val =
    case val of
        Solid ->
            "solid"

        Dashed ->
            "dashed"

        None ->
            "none"
