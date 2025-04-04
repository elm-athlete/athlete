module BodyBuilder.Events exposing
    ( checkEventToHtmlEvent
    , focusEventToHtmlAttributes
    , inputEventToHtmlEvent
    , mouseEventsToHtmlAttributes
    , on
    , onCustom
    , onBlur
    , OnBlurEvent
    , onBlurEventToHtmlAttributes
    , onCheck
    , OnCheckEvent
    , onClick
    , OnColorInputEvent
    , onDoubleClick
    , onContextMenu
    , OnEvent
    , onEventToHtmlAttributes
    , onFocus
    , OnFocusEvent
    , onInput
    , OnIntInputEvent
    , onMouseDown
    , onMouseEnter
    , OnMouseEvents
    , OnMouseEventsInside
    , onMouseLeave
    , onMouseOut
    , onMouseOver
    , onMouseUp
    , OnStringInputEvent
    , onSubmit
    , OnSubmitEvent
    , submitEventToHtmlEvent
    )

{-| This module entirely replaces Html.Events, providing a type-safer alternative.
This is designed to work with BodyBuilder.
It is not compatible with Html, though.

@docs checkEventToHtmlEvent
@docs focusEventToHtmlAttributes
@docs inputEventToHtmlEvent
@docs mouseEventsToHtmlAttributes
@docs on
@docs onCustom
@docs onBlur
@docs OnBlurEvent
@docs onBlurEventToHtmlAttributes
@docs onCheck
@docs OnCheckEvent
@docs onClick
@docs OnColorInputEvent
@docs onDoubleClick
@docs onContextMenu
@docs OnEvent
@docs onEventToHtmlAttributes
@docs onFocus
@docs OnFocusEvent
@docs onInput
@docs OnIntInputEvent
@docs onMouseDown
@docs onMouseEnter
@docs OnMouseEvents
@docs OnMouseEventsInside
@docs onMouseLeave
@docs onMouseOut
@docs onMouseOver
@docs onMouseUp
@docs OnStringInputEvent
@docs onSubmit
@docs OnSubmitEvent
@docs submitEventToHtmlEvent

-}

import BodyBuilder.Internals.Setters exposing (..)
import Color exposing (Color)
import Elegant.Helpers.Shared exposing (..)
import Function exposing (callOn)
import Html
import Html.Events
import Json.Decode exposing (Decoder)
import Modifiers exposing (..)
import VirtualDom


defaultOnMouseEvents : OnMouseEventsInside msg
defaultOnMouseEvents =
    OnMouseEventsInside
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing


withDefaultOnMouse : Modifier (OnMouseEventsInside msg) -> Modifier (OnMouseEvents msg a)
withDefaultOnMouse setter ({ onMouseEvents } as attrs) =
    onMouseEvents
        |> Maybe.withDefault defaultOnMouseEvents
        |> setter
        |> setOnMouseEventsIn attrs


{-| -}
onClick : msg -> Modifier (OnMouseEvents msg a)
onClick val =
    withDefaultOnMouse (setClick val)


{-| -}
onDoubleClick : msg -> Modifier (OnMouseEvents msg a)
onDoubleClick val =
    withDefaultOnMouse (setDoubleClick val)


{-| -}
onContextMenu : msg -> Modifier (OnMouseEvents msg a)
onContextMenu val =
    withDefaultOnMouse (setContextMenu val)


{-| -}
onMouseUp : msg -> Modifier (OnMouseEvents msg a)
onMouseUp val =
    withDefaultOnMouse (setOnMouseUp val)


{-| -}
onMouseOut : msg -> Modifier (OnMouseEvents msg a)
onMouseOut val =
    withDefaultOnMouse (setOnMouseOut val)


{-| -}
onMouseOver : msg -> Modifier (OnMouseEvents msg a)
onMouseOver val =
    withDefaultOnMouse (setOnMouseOver val)


{-| -}
onMouseDown : msg -> Modifier (OnMouseEvents msg a)
onMouseDown val =
    withDefaultOnMouse (setOnMouseDown val)


{-| -}
onMouseLeave : msg -> Modifier (OnMouseEvents msg a)
onMouseLeave val =
    withDefaultOnMouse (setOnMouseLeave val)


{-| -}
onMouseEnter : msg -> Modifier (OnMouseEvents msg a)
onMouseEnter val =
    withDefaultOnMouse (setOnMouseEnter val)


{-| -}
mouseEventsToHtmlAttributes : OnMouseEventsInside msg -> List (Html.Attribute msg)
mouseEventsToHtmlAttributes events =
    List.concatMap (callOn events)
        [ unwrapEmptyList (Html.Events.onClick >> List.singleton) << .click
        , unwrapEmptyList (Html.Events.onDoubleClick >> List.singleton) << .doubleClick
        , unwrapEmptyList (Json.Decode.succeed >> Html.Events.on "contextmenu" >> List.singleton) << .contextMenu
        , unwrapEmptyList (Html.Events.onMouseDown >> List.singleton) << .mouseDown
        , unwrapEmptyList (Html.Events.onMouseUp >> List.singleton) << .mouseUp
        , unwrapEmptyList (Html.Events.onMouseEnter >> List.singleton) << .mouseEnter
        , unwrapEmptyList (Html.Events.onMouseLeave >> List.singleton) << .mouseLeave
        , unwrapEmptyList (Html.Events.onMouseOver >> List.singleton) << .mouseOver
        , unwrapEmptyList (Html.Events.onMouseOut >> List.singleton) << .mouseOut
        ]


{-| -}
type alias OnMouseEvents msg a =
    { a | onMouseEvents : Maybe (OnMouseEventsInside msg) }


{-| -}
type alias OnMouseEventsInside msg =
    { click : Maybe msg
    , doubleClick : Maybe msg
    , contextMenu : Maybe msg
    , mouseDown : Maybe msg
    , mouseUp : Maybe msg
    , mouseEnter : Maybe msg
    , mouseLeave : Maybe msg
    , mouseOver : Maybe msg
    , mouseOut : Maybe msg
    }

type alias OnStringInputEvent msg a =
    { a
        | onInputEvent : Maybe (String -> msg)
        , fromStringInput : String -> String
    }

type alias OnIntInputEvent msg a =
    { a
        | onInputEvent : Maybe (Int -> msg)
        , fromStringInput : String -> Int
    }

type alias OnColorInputEvent msg a =
    { a
        | onInputEvent : Maybe (Color -> msg)
        , fromStringInput : String -> Color
    }
{-| -}
type alias OnCheckEvent msg a =
    { a | onCheckEvent : Maybe (Bool -> msg) }


{-| -}
type alias OnSubmitEvent msg a =
    { a | onSubmitEvent : Maybe msg }


{-| -}
type alias OnFocusEvent msg a =
    { a | onFocusEvent : Maybe msg }


{-| -}
type alias OnBlurEvent msg a =
    { a | onBlurEvent : Maybe msg }


{-| -}
type alias OnEvent msg a =
    { a | onEvent : Maybe ( String, VirtualDom.Handler msg ) }


{-| -}
onInput val attrs =
    { attrs | onInputEvent = Just val }


{-| -}
inputEventToHtmlEvent : ( Maybe (a -> msg), String -> a ) -> List (Html.Attribute msg)
inputEventToHtmlEvent ( onInputEvent, fromStringInput ) =
    case onInputEvent of
        Just fun ->
            [ Html.Events.onInput (fromStringInput >> fun) ]

        Nothing ->
            []


{-| -}
onCheck : (Bool -> msg) -> Modifier (OnCheckEvent msg a)
onCheck val attrs =
    { attrs | onCheckEvent = Just val }


{-| -}
checkEventToHtmlEvent : OnCheckEvent msg a -> List (Html.Attribute msg)
checkEventToHtmlEvent =
    unwrapMaybeAttribute Html.Events.onCheck << .onCheckEvent


{-| -}
onSubmit : msg -> Modifier (OnSubmitEvent msg a)
onSubmit val attrs =
    { attrs | onSubmitEvent = Just val }


{-| -}
submitEventToHtmlEvent : OnSubmitEvent msg a -> List (Html.Attribute msg)
submitEventToHtmlEvent =
    unwrapMaybeAttribute Html.Events.onSubmit << .onSubmitEvent


{-| -}
onFocus : msg -> Modifier (OnFocusEvent msg a)
onFocus val attrs =
    { attrs | onFocusEvent = Just val }


{-| -}
focusEventToHtmlAttributes : msg -> List (Html.Attribute msg)
focusEventToHtmlAttributes =
    Html.Events.onFocus >> List.singleton


{-| -}
onBlur : msg -> Modifier (OnBlurEvent msg a)
onBlur val attrs =
    { attrs | onBlurEvent = Just val }


{-| -}
onBlurEventToHtmlAttributes : msg -> List (Html.Attribute msg)
onBlurEventToHtmlAttributes =
    Html.Events.onBlur >> List.singleton


{-| -}
on : String -> Decoder msg -> Modifier (OnEvent msg a)
on event decoder attrs =
    { attrs | onEvent = Just ( event, VirtualDom.Normal decoder ) }


{-| -}
onCustom : String -> Decoder { message : msg, stopPropagation : Bool, preventDefault : Bool } -> Modifier (OnEvent msg a)
onCustom event decoder attrs =
    let
        syncRecord { message, stopPropagation, preventDefault } =
            { message = message
            , stopPropagation = stopPropagation
            , preventDefault = preventDefault
            }
    in
    { attrs | onEvent = Just ( event, VirtualDom.Custom (Json.Decode.map syncRecord decoder) ) }


{-| -}
onEventToHtmlAttributes : ( String, VirtualDom.Handler msg ) -> List (Html.Attribute msg)
onEventToHtmlAttributes ( event, handler ) =
    [ VirtualDom.on event handler ]
