module Elegant.Surrounded
    exposing
        ( Surrounded
        , all
        , applyModifiersOnDefault
        , bottom
        , default
        , horizontal
        , left
        , right
        , surroundedToCouples
        , top
        , vertical
        )

{-| Generic module for surrounded values.

@docs Elegant.Surrounded
@docs all
@docs bottom
@docs default
@docs horizontal
@docs left
@docs right
@docs surroundedToCouples
@docs top
@docs vertical
@docs applyModifiersOnDefault

-}

import Elegant.Internals.Setters exposing (..)
import Function
import Elegant.Helpers.Shared exposing (..)
import List.Extra
import Modifiers exposing (..)


{-| -}
type alias Elegant.Surrounded surroundType =
    { top : Maybe surroundType
    , right : Maybe surroundType
    , bottom : Maybe surroundType
    , left : Maybe surroundType
    }


{-| -}
default : Elegant.Surrounded a
default =
    Elegant.Surrounded Nothing Nothing Nothing Nothing


{-| -}
top : a -> Modifiers a -> Modifier (Surrounded a)
top default_ =
    getModifyAndSet .top setTopIn default_


{-| -}
bottom : a -> Modifiers a -> Modifier (Surrounded a)
bottom default_ =
    getModifyAndSet .bottom setBottomIn default_


{-| -}
right : a -> Modifiers a -> Modifier (Surrounded a)
right default_ =
    getModifyAndSet .right setRightIn default_


{-| -}
left : a -> Modifiers a -> Modifier (Surrounded a)
left default_ =
    getModifyAndSet .left setLeftIn default_


{-| -}
horizontal : a -> Modifiers a -> Modifier (Surrounded a)
horizontal default_ modifiers =
    left default_ modifiers >> right default_ modifiers


{-| -}
vertical : a -> Modifiers a -> Modifier (Surrounded a)
vertical default_ modifiers =
    top default_ modifiers >> bottom default_ modifiers


{-| -}
all : a -> Modifiers a -> Modifier (Surrounded a)
all default_ modifiers =
    vertical default_ modifiers
        >> horizontal default_ modifiers


{-| -}
applyModifiersOnDefault : Modifiers (Surrounded a) -> Elegant.Surrounded a
applyModifiersOnDefault modifiers =
    default
        |> Function.compose modifiers


{-| -}
surroundedToCouples :
    Maybe String
    -> (a -> List ( String, String ))
    -> Elegant.Surrounded a
    -> List ( String, String )
surroundedToCouples prefix toCouple border =
    [ unwrapToCouples .top toCouple
    , unwrapToCouples .bottom toCouple
    , unwrapToCouples .right toCouple
    , unwrapToCouples .left toCouple
    ]
        |> List.map (callOn border)
        |> Function.flip List.Extra.andMap
            [ List.map (addPrefix prefix "top")
            , List.map (addPrefix prefix "bottom")
            , List.map (addPrefix prefix "right")
            , List.map (addPrefix prefix "left")
            ]
        |> List.concat


addPrefix : Maybe String -> String -> ( String, String ) -> ( String, String )
addPrefix qualifier orientation ( selector, value ) =
    let
        name =
            case selector of
                "" ->
                    case qualifier of
                        Nothing ->
                            [ orientation ]

                        Just qual ->
                            [ qual, orientation ]

                name_ ->
                    case qualifier of
                        Nothing ->
                            [ orientation, name_ ]

                        Just qual ->
                            [ qual, orientation, name_ ]
    in
    ( name |> String.join "-", value )
