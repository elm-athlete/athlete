module BodyBuilder.Events
    exposing
        ( OnMouseEvents
        , OnMouseEventsInside
        , onClick
        , onDoubleClick
        , onMouseUp
        , onMouseOut
        , onMouseOver
        , onMouseDown
        , onMouseLeave
        , onMouseEnter
        , mouseEventsToHtmlAttributes
        , OnStringInputEvent
        , OnIntInputEvent
        , OnColorInputEvent
        , onInput
        , inputEventToHtmlEvent
        , OnCheckEvent
        , onCheck
        , checkEventToHtmlEvent
        , OnSubmitEvent
        , onSubmit
        , submitEventToHtmlEvent
        , OnFocusEvent
        , onFocus
        , focusEventToHtmlAttributes
        , OnBlurEvent
        , onBlur
        , onBlurEventToHtmlAttributes
        , OnEvent
        , on
        , onEventToHtmlAttributes
        )

{-|

@docs OnMouseEvents
@docs OnMouseEventsInside
@docs onClick
@docs onDoubleClick
@docs onMouseUp
@docs onMouseOut
@docs onMouseOver
@docs onMouseDown
@docs onMouseLeave
@docs onMouseEnter
@docs mouseEventsToHtmlAttributes
@docs OnStringInputEvent
@docs OnIntInputEvent
@docs OnColorInputEvent
@docs onInput
@docs inputEventToHtmlEvent
@docs OnCheckEvent
@docs onCheck
@docs checkEventToHtmlEvent
@docs OnSubmitEvent
@docs onSubmit
@docs submitEventToHtmlEvent
@docs OnFocusEvent
@docs onFocus
@docs focusEventToHtmlAttributes
@docs OnBlurEvent
@docs onBlur
@docs onBlurEventToHtmlAttributes
@docs OnEvent
@docs on
@docs onEventToHtmlAttributes
-}

import Html
import Html.Events
import Json.Decode exposing (Decoder)
import Color exposing (Color)
import Helpers.Shared exposing (..)
import BodyBuilder.Setters exposing (..)


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
    [ unwrapEmptyList (Html.Events.onClick >> List.singleton) << .click
    , unwrapEmptyList (Html.Events.onDoubleClick >> List.singleton) << .doubleClick
    , unwrapEmptyList (Html.Events.onMouseDown >> List.singleton) << .mouseDown
    , unwrapEmptyList (Html.Events.onMouseUp >> List.singleton) << .mouseUp
    , unwrapEmptyList (Html.Events.onMouseEnter >> List.singleton) << .mouseEnter
    , unwrapEmptyList (Html.Events.onMouseLeave >> List.singleton) << .mouseLeave
    , unwrapEmptyList (Html.Events.onMouseOver >> List.singleton) << .mouseOver
    , unwrapEmptyList (Html.Events.onMouseOut >> List.singleton) << .mouseOut
    ]
        |> List.concatMap (callOn events)


{-| -}
type alias OnMouseEvents msg a =
    { a | onMouseEvents : Maybe (OnMouseEventsInside msg) }


{-| -}
type alias OnMouseEventsInside msg =
    { click : Maybe msg
    , doubleClick : Maybe msg
    , mouseDown : Maybe msg
    , mouseUp : Maybe msg
    , mouseEnter : Maybe msg
    , mouseLeave : Maybe msg
    , mouseOver : Maybe msg
    , mouseOut : Maybe msg
    }


type alias OnInputEvent b msg a =
    { a
        | onInputEvent : Maybe (b -> msg)
        , fromStringInput : String -> b
    }


{-| -}
type alias OnStringInputEvent msg a =
    OnInputEvent String msg a


{-| -}
type alias OnIntInputEvent msg a =
    OnInputEvent Int msg a


{-| -}
type alias OnColorInputEvent msg a =
    OnInputEvent Color msg a


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
    { a | onEvent : Maybe ( String, Decoder msg ) }


{-| -}
onInput : (a -> msg) -> Modifier (OnInputEvent a msg b)
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
    { attrs | onEvent = Just ( event, decoder ) }


{-| -}
onEventToHtmlAttributes : ( String, Decoder msg ) -> List (Html.Attribute msg)
onEventToHtmlAttributes ( event, decoder ) =
    [ Html.Events.on event decoder ]
