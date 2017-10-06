module Padding
    exposing
        ( Padding
        , default
        , width
        , top
        , bottom
        , left
        , right
        , horizontal
        , vertical
        , all
        , paddingToCouples
        )

{-| Padding contains everything about paddings rendering.


# Types

@docs Padding


# Default padding

@docs default


# Padding setters

@docs width


# Padding selectors

@docs top
@docs right
@docs bottom
@docs left
@docs horizontal
@docs vertical
@docs all


# Compilation

@docs paddingToCouples

-}

import Surrounded exposing (Surrounded)
import Shared exposing (..)


{-| The `Padding` record contains everything about one padding side.
You probably won't use it as is, but instead using `Elegant.padding`
which automatically generate an empty `Padding` record. You
can then use modifiers. I.E.

    Elegant.padding
        [ Padding.top <| Padding.width (px 30)
        , Padding.vertical <| Padding.width (px 40)
        ]

-}
type alias Padding =
    SizeUnit


{-| Generate an empty `Padding` record, equal to 0 px.
You are free to use it as you wish, but it is instanciated automatically by `Elegant.padding`.
-}
default : Padding
default =
    Px 0


{-| Set the padding width to the desired value.
-}
width : SizeUnit -> Modifier Padding
width value padding =
    value


{-| Accepts a padding modifier, and modify the top side of the padding.
-}
top : Modifier Padding -> Modifier (Surrounded Padding)
top =
    Surrounded.top default << List.singleton


{-| Accepts a padding modifier, and modify the bottom side of the padding.
-}
bottom : Modifier Padding -> Modifier (Surrounded Padding)
bottom =
    Surrounded.bottom default << List.singleton


{-| Accepts a padding modifier, and modify the left side of the padding.
-}
left : Modifier Padding -> Modifier (Surrounded Padding)
left =
    Surrounded.left default << List.singleton


{-| Accepts a padding modifier, and modify the right side of the padding.
-}
right : Modifier Padding -> Modifier (Surrounded Padding)
right =
    Surrounded.right default << List.singleton


{-| Accepts a padding modifier, and modify both the top and the bottom side of the padding.
-}
horizontal : Modifier Padding -> Modifier (Surrounded Padding)
horizontal =
    Surrounded.horizontal default << List.singleton


{-| Accepts a padding modifier, and modify both the right and left side of the padding.
-}
vertical : Modifier Padding -> Modifier (Surrounded Padding)
vertical =
    Surrounded.vertical default << List.singleton


{-| Accepts a padding modifier, and modify the four sides of the padding.
-}
all : Modifier Padding -> Modifier (Surrounded Padding)
all =
    Surrounded.all default << List.singleton


{-| Compiles a `Surrounded Padding` record to the corresponding CSS list of tuples.


## Compiles only styles which are defined, ignoring `Nothing` fields.

-}
paddingToCouples : Surrounded Padding -> List ( String, String )
paddingToCouples =
    Surrounded.surroundedToCouples "padding" paddingSideToCouples



-- Internals


paddingSideToCouples : Padding -> List ( String, String )
paddingSideToCouples padding =
    padding
        |> valueToCouple
        |> List.singleton


valueToCouple : SizeUnit -> ( String, String )
valueToCouple value =
    ( "", sizeUnitToString value )
