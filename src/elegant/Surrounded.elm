module Surrounded exposing (..)

import Function
import List.Extra
import Helpers.Shared exposing (..)
import Elegant.Setters exposing (..)


type alias Surrounded surroundType =
    { top : Maybe surroundType
    , right : Maybe surroundType
    , bottom : Maybe surroundType
    , left : Maybe surroundType
    }


default : Surrounded a
default =
    Surrounded Nothing Nothing Nothing Nothing


{-| -}
top : a -> Modifiers a -> Modifier (Surrounded a)
top default =
    getModifyAndSet .top setTopIn default


{-| -}
bottom : a -> Modifiers a -> Modifier (Surrounded a)
bottom default =
    getModifyAndSet .bottom setBottomIn default


{-| -}
right : a -> Modifiers a -> Modifier (Surrounded a)
right default =
    getModifyAndSet .right setRightIn default


{-| -}
left : a -> Modifiers a -> Modifier (Surrounded a)
left default =
    getModifyAndSet .left setLeftIn default


horizontal : a -> Modifiers a -> Modifier (Surrounded a)
horizontal default modifiers =
    left default modifiers >> right default modifiers


vertical : a -> Modifiers a -> Modifier (Surrounded a)
vertical default modifiers =
    top default modifiers >> bottom default modifiers


all : a -> Modifiers a -> Modifier (Surrounded a)
all default modifiers =
    vertical default modifiers
        >> horizontal default modifiers


applyModifiersOnDefault : Modifiers (Surrounded a) -> Surrounded a
applyModifiersOnDefault modifiers =
    default
        |> Function.compose modifiers


surroundedToCouples :
    Maybe String
    -> (a -> List ( String, String ))
    -> Surrounded a
    -> List ( String, String )
surroundedToCouples prefix toCouple border =
    [ unwrapToCouples .top toCouple
    , unwrapToCouples .bottom toCouple
    , unwrapToCouples .right toCouple
    , unwrapToCouples .left toCouple
    ]
        |> List.map (callOn border)
        |> flip List.Extra.andMap
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

                name ->
                    case qualifier of
                        Nothing ->
                            [ orientation, name ]

                        Just qual ->
                            [ qual, orientation, name ]
    in
        ( name |> String.join "-", value )
