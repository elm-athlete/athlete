module Surrounded exposing (..)

import Shared exposing (..)
import Setters exposing (..)


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
