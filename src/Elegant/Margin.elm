module Elegant.Margin
    exposing
        ( Margin
        , all
        , auto
        , bottom
        , default
        , horizontal
        , left
        , marginToCouples
        , right
        , top
        , vertical
        , width
        )

{-| Margin contains everything about margins rendering.


# Types

@docs Margin


# Default margin

@docs default


# Margin setters

@docs auto
@docs width


# Margin selectors

@docs top
@docs right
@docs bottom
@docs left
@docs horizontal
@docs vertical
@docs all


# Compilation

@docs marginToCouples

-}

import Either exposing (Either(..))
import Elegant.Helpers.Shared exposing (..)
import Elegant.Surrounded as Surrounded exposing (Surrounded)
import Modifiers exposing (..)


{-| The `Margin` record contains everything about one margin side.
You probably won't use it as is, but instead using `Elegant.margin`
which automatically generate an empty `Margin` record. You
can then use modifiers. I.E.

    Elegant.margin
        [ Margin.top <| Margin.width (px 30)
        , Margin.vertical Margin.auto
        ]

-}
type alias Margin =
    Either SizeUnit Auto


{-| Generate an empty `Margin` record, equal to auto.
You are free to use it as you wish, but it is instanciated automatically by `Elegant.margin`.
-}
default : Margin
default =
    Right Auto


{-| Set the margin value to auto.
-}
auto : Modifier Margin
auto margin =
    Right Auto


{-| Set the margin value to the desired value.
-}
width : SizeUnit -> Modifier Margin
width value margin =
    Left value


{-| Accepts a margin modifier, and modify the top side of the margin.
-}
top : Modifier Margin -> Modifier (Surrounded Margin)
top =
    Surrounded.top default << List.singleton


{-| Accepts a margin modifier, and modify the bottom side of the margin.
-}
bottom : Modifier Margin -> Modifier (Surrounded Margin)
bottom =
    Surrounded.bottom default << List.singleton


{-| Accepts a margin modifier, and modify the left side of the margin.
-}
left : Modifier Margin -> Modifier (Surrounded Margin)
left =
    Surrounded.left default << List.singleton


{-| Accepts a margin modifier, and modify the right side of the margin.
-}
right : Modifier Margin -> Modifier (Surrounded Margin)
right =
    Surrounded.right default << List.singleton


{-| Accepts a margin modifier, and modify both the top and the bottom side of the margin.
-}
horizontal : Modifier Margin -> Modifier (Surrounded Margin)
horizontal =
    Surrounded.horizontal default << List.singleton


{-| Accepts a margin modifier, and modify both the right and left side of the margin.
-}
vertical : Modifier Margin -> Modifier (Surrounded Margin)
vertical =
    Surrounded.vertical default << List.singleton


{-| Accepts a margin modifier, and modify the four sides of the margin.
-}
all : Modifier Margin -> Modifier (Surrounded Margin)
all =
    Surrounded.all default << List.singleton


{-| Compiles a `Surrounded Margin` record to the corresponding CSS list of tuples.
Compiles only styles which are defined, ignoring `Nothing` fields.
-}
marginToCouples : Surrounded Margin -> List ( String, String )
marginToCouples =
    Surrounded.surroundedToCouples (Just "margin") marginSideToCouples



-- Internals


marginSideToCouples : Margin -> List ( String, String )
marginSideToCouples margin =
    margin
        |> valueToCouple
        |> List.singleton


valueToCouple : Either SizeUnit Auto -> ( String, String )
valueToCouple value =
    ( "", valueToString value )


valueToString : Either SizeUnit Auto -> String
valueToString val =
    case val of
        Left su ->
            sizeUnitToString su

        Right _ ->
            "auto"
