module Elegant.Border
    exposing
        ( Border
        , BorderStyle
        , all
        , borderToCouples
        , bottom
        , color
        , dashed
        , default
        , full
        , horizontal
        , left
        , none
        , right
        , solid
        , thickness
        , top
        , vertical
        )

{-| Border contains everything about borders rendering.


# Types

@docs Border
@docs BorderStyle


# Default border

@docs default


# Border modifiers


## Appearance

@docs thickness
@docs none
@docs solid
@docs dashed
@docs color


## Sides

@docs top
@docs bottom
@docs left
@docs right
@docs horizontal
@docs vertical
@docs all


# Compilation

@docs borderToCouples


# Sugar

@docs full

-}

import Color exposing (Color)
import Elegant.Setters exposing (..)
import Helpers.Shared exposing (..)
import Modifiers exposing (..)
import Surrounded exposing (Surrounded)


{-| The `Border` record contains everything about one border side.
You probably won't use it as is, but instead using `Elegant.border`
which automatically generate an empty `Border` record. You
can then use modifiers. I.E.

    Elegant.border
        [ Border.solid
        , Border.color Color.blue
        ]

-}
type alias Border =
    { color : Maybe Color
    , thickness : Maybe SizeUnit
    , style : Maybe BorderStyle
    }


{-| Generate an empty `Border` record, with every field equal to Nothing.
You are free to use it as you wish, but it is instanciated automatically by `Elegant.border`.
-}
default : Border
default =
    Border Nothing Nothing Nothing


{-| Represents the possible styles of the border.
It can be Solid or Dashed. They are created by `solid` and `dashed`.
-}
type BorderStyle
    = Solid
    | Dashed
    | None


{-| Set the border to none.
-}
none : Modifier Border
none =
    setStyle <| Just None


{-| Set the border as solid.
-}
solid : Modifier Border
solid =
    setStyle <| Just Solid


{-| Set the border as dashed.
-}
dashed : Modifier Border
dashed =
    setStyle <| Just Dashed


{-| Set the thickness of the border.
-}
thickness : SizeUnit -> Modifier Border
thickness =
    setThickness << Just


{-| Set the color of the border.
-}
color : Color -> Modifier Border
color =
    setColor << Just


{-| Accepts a list of border modifiers, and modify the top side of the border.
-}
top : Modifiers Border -> Modifier (Surrounded Border)
top =
    Surrounded.top default


{-| Accepts a list of border modifiers, and modify the bottom side of the border.
-}
bottom : Modifiers Border -> Modifier (Surrounded Border)
bottom =
    Surrounded.bottom default


{-| Accepts a list of border modifiers, and modify the left side of the border.
-}
left : Modifiers Border -> Modifier (Surrounded Border)
left =
    Surrounded.left default


{-| Accepts a list of border modifiers, and modify the right side of the border.
-}
right : Modifiers Border -> Modifier (Surrounded Border)
right =
    Surrounded.right default


{-| Accepts a list of border modifiers, and modify both the top and the bottom side of the border.
-}
horizontal : Modifiers Border -> Modifier (Surrounded Border)
horizontal =
    Surrounded.horizontal default


{-| Accepts a list of border modifiers, and modify both the right and left side of the border.
-}
vertical : Modifiers Border -> Modifier (Surrounded Border)
vertical =
    Surrounded.vertical default


{-| Accepts a list of border modifiers, and modify the four sides of the border.
-}
all : Modifiers Border -> Modifier (Surrounded Border)
all =
    Surrounded.all default


{-| Accepts a color modifier
-}
full : Color -> Modifier (Surrounded Border)
full borderColor =
    all [ color borderColor, thickness (Px 1), solid ]


{-| Compiles a `Surrounded Border` record to the corresponding CSS list of tuples.
Compiles only styles which are defined, ignoring `Nothing` fields.
-}
borderToCouples : Surrounded Border -> List ( String, String )
borderToCouples =
    Surrounded.surroundedToCouples (Just "border") borderSideToCouples



-- Internals


borderSideToCouples : Border -> List ( String, String )
borderSideToCouples border =
    [ unwrapToCouple .thickness thicknessToCouple
    , unwrapToCouple .style styleToCouple
    , unwrapToCouple .color colorToCouple
    ]
        |> List.concatMap (callOn border)


thicknessToCouple : SizeUnit -> ( String, String )
thicknessToCouple value =
    ( "width", sizeUnitToString value )


styleToCouple : BorderStyle -> ( String, String )
styleToCouple style =
    ( "style", styleToString style )


styleToString : BorderStyle -> String
styleToString val =
    case val of
        Solid ->
            "solid"

        Dashed ->
            "dashed"

        None ->
            "none"
