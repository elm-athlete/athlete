module Padding
    exposing
        ( Padding
        , default
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


{-| Accepts a padding modifier, and modify the top side of the padding.
-}
top : SizeUnit -> Modifier (Surrounded Padding)
top =
    Surrounded.top default << modifiersFrom


{-| Accepts a padding modifier, and modify the bottom side of the padding.
-}
bottom : SizeUnit -> Modifier (Surrounded Padding)
bottom =
    Surrounded.bottom default << modifiersFrom


{-| Accepts a padding modifier, and modify the left side of the padding.
-}
left : SizeUnit -> Modifier (Surrounded Padding)
left =
    Surrounded.left default << modifiersFrom


{-| Accepts a padding modifier, and modify the right side of the padding.
-}
right : SizeUnit -> Modifier (Surrounded Padding)
right =
    Surrounded.right default << modifiersFrom


{-| Accepts a padding modifier, and modify both the top and the bottom side of the padding.
-}
horizontal : SizeUnit -> Modifier (Surrounded Padding)
horizontal =
    Surrounded.horizontal default << modifiersFrom


{-| Accepts a padding modifier, and modify both the right and left side of the padding.
-}
vertical : SizeUnit -> Modifier (Surrounded Padding)
vertical =
    Surrounded.vertical default << modifiersFrom


{-| Accepts a padding modifier, and modify the four sides of the padding.
-}
all : SizeUnit -> Modifier (Surrounded Padding)
all =
    Surrounded.all default << modifiersFrom


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
