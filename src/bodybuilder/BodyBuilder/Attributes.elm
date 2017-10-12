module BodyBuilder.Attributes exposing (..)

import VirtualDom
import Color exposing (Color)
import Json.Decode exposing (Decoder)
import Elegant
import Function


type alias VisibleAttributesAndEvents msg a =
    OnEvent msg (OnFocusEvent msg (OnBlurEvent msg (OnMouseEvents msg (VisibleAttributes a))))


type alias UniversalAttributes a =
    TitleAttribute (TabindexAttribute (IdAttribute (ClassAttribute a)))


{-| -}
type alias TitleAttribute a =
    { a | title : Maybe String }


{-| -}
type alias IdAttribute a =
    { a | id : Maybe String }


{-| -}
type alias ClassAttribute a =
    { a | class : List String }


{-| -}
type alias TabindexAttribute a =
    { a | tabindex : Maybe Int }


defaultUniversalAttributes : UniversalAttributes {}
defaultUniversalAttributes =
    { class = []
    , id = Nothing
    , tabindex = Nothing
    , title = Nothing
    }


{-| -}
type alias StyleAttribute =
    { standard : Maybe Elegant.Style
    , hover : Maybe Elegant.Style
    , focus : Maybe Elegant.Style
    }


setStyleIn : { a | style : Maybe StyleAttribute } -> StyleAttribute -> { a | style : Maybe StyleAttribute }
setStyleIn record styleAttribute =
    { record | style = Just styleAttribute }


setStandardIn : { a | standard : Maybe Elegant.Style } -> Elegant.Style -> { a | standard : Maybe Elegant.Style }
setStandardIn record styleElegant =
    { record | standard = Just styleElegant }


setStandard : Elegant.Style -> { a | standard : Maybe Elegant.Style } -> { a | standard : Maybe Elegant.Style }
setStandard styleElegant record =
    { record | standard = Just styleElegant }


setFocus : Elegant.Style -> { a | focus : Maybe Elegant.Style } -> { a | focus : Maybe Elegant.Style }
setFocus styleElegant record =
    { record | focus = Just styleElegant }


setHover : Elegant.Style -> { a | hover : Maybe Elegant.Style } -> { a | hover : Maybe Elegant.Style }
setHover styleElegant record =
    { record | hover = Just styleElegant }


{-| -}
style :
    Elegant.Style
    -> { a | style : Maybe StyleAttribute }
    -> { a | style : Maybe StyleAttribute }
style val ({ style } as attrs) =
    style
        |> Maybe.withDefault defaultStyleAttribute
        |> setStandard val
        |> setStyleIn attrs


{-| -}
hoverStyle :
    Elegant.Style
    -> { a | style : Maybe StyleAttribute }
    -> { a | style : Maybe StyleAttribute }
hoverStyle val ({ style } as attrs) =
    style
        |> Maybe.withDefault defaultStyleAttribute
        |> setHover val
        |> setStyleIn attrs


{-| -}
focusStyle :
    Elegant.Style
    -> { a | style : Maybe StyleAttribute }
    -> { a | style : Maybe StyleAttribute }
focusStyle val ({ style } as attrs) =
    style
        |> Maybe.withDefault defaultStyleAttribute
        |> setFocus val
        |> setStyleIn attrs


type alias VisibleAttributes a =
    { a
        | style : Maybe StyleAttribute
        , universal : UniversalAttributes {}
    }


{-| -}
type alias OnMouseEvents msg a =
    { a | onMouseEvents : OnMouseEventsInside msg }


type alias OnInputEvent b msg a =
    { a
        | onInputEvent : Maybe (b -> msg)
        , fromStringInput : String -> b
    }


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


mouseEventsToVirtualDom : OnMouseEventsInside msg -> List (VirtualDom.Property msg)
mouseEventsToVirtualDom events =
    -- [ VirtualDom.on "click" Json.succeed events.click ]
    []


{-| -}
onClick :
    msg
    -> OnMouseEvents msg a
    -> OnMouseEvents msg a
onClick val ({ onMouseEvents } as attrs) =
    let
        newOnClick =
            { onMouseEvents | click = Just val }
    in
        { attrs | onMouseEvents = newOnClick }


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
type alias FlowAttributes msg =
    VisibleAttributesAndEvents msg {}


{-| -}
type alias ButtonAttributes msg a =
    DisabledAttribute (VisibleAttributesAndEvents msg a)


{-| -}
type alias DisabledAttribute a =
    { a | disabled : Bool }


defaultsComposedToAttrs : a -> List (a -> a) -> a
defaultsComposedToAttrs defaults attrs =
    (defaults |> (attrs |> Function.compose))


defaultStyleAttribute : StyleAttribute
defaultStyleAttribute =
    { standard = Nothing
    , hover = Nothing
    , focus = Nothing
    }


defaultOnMouseEvents : OnMouseEventsInside msg
defaultOnMouseEvents =
    OnMouseEventsInside Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing


defaultFlowAttributes : FlowAttributes msg
defaultFlowAttributes =
    { onBlurEvent = Nothing
    , onEvent = Nothing
    , onFocusEvent = Nothing
    , onMouseEvents = defaultOnMouseEvents
    , style = Nothing
    , universal = defaultUniversalAttributes
    }


flowAttributesToVirtualDom : FlowAttributes msg -> List (VirtualDom.Property msg)
flowAttributesToVirtualDom msgFlowAttributes =
    -- [ mouseEventsToVirtualDom msgFlowAttributes.onMouseEvents
    -- , focusEventToVirtualDom msgFlowAttributes.onFocusEvent
    -- , onEventToVirtualDom msgFlowAttributes.onEvent
    -- , onBlurToVirtualDom msgFlowAttributes.onBlurEvent
    -- , universalToVirtualDom msgFlowAttributes.universal
    -- ]
    --     |> List.concat
    []


defaultButtonAttributes : ButtonAttributes msg {}
defaultButtonAttributes =
    { disabled = False
    , onBlurEvent = Nothing
    , onEvent = Nothing
    , onFocusEvent = Nothing
    , onMouseEvents = defaultOnMouseEvents
    , style = Nothing
    , universal = defaultUniversalAttributes
    }


buttonAttributesToVirtualDom : ButtonAttributes msg {} -> List (VirtualDom.Property msg)
buttonAttributesToVirtualDom msgFlowAttributes =
    []
