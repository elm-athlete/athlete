module BodyBuilder.Attributes exposing (..)

import Html exposing (Html)
import Html.Attributes
import Elegant
import Color exposing (Color)


-- import Function

import Helpers.Shared exposing (..)
import BodyBuilder.Setters exposing (..)
import BodyBuilder.Events exposing (..)


type alias ValueAttribute b a =
    { a | value : Maybe b }


{-| -}
type alias StringValue a =
    ValueAttribute String a


{-| -}
type alias IntValue a =
    ValueAttribute Int a


{-| -}
type alias ColorValue a =
    ValueAttribute Color a


type alias VisibleAttributesAndEvents msg a =
    OnEvent msg (OnFocusEvent msg (OnBlurEvent msg (OnMouseEvents msg (VisibleAttributes a))))


type alias VisibleAttributes a =
    { a
        | style : Maybe StyleAttribute
        , universal : UniversalAttributes {}
    }


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


type alias UniversalAttributes a =
    TitleAttribute (TabindexAttribute (IdAttribute (ClassAttribute a)))


defaultUniversalAttributes : UniversalAttributes {}
defaultUniversalAttributes =
    { class = []
    , id = Nothing
    , tabindex = Nothing
    , title = Nothing
    }


universalAttributesToHtmlAttributes : UniversalAttributes a -> List (Html.Attribute msg)
universalAttributesToHtmlAttributes universal =
    [ .class >> List.map Html.Attributes.class
    , .id >> unwrapEmptyList (Html.Attributes.id >> List.singleton)
    , .tabindex >> unwrapEmptyList (Html.Attributes.tabindex >> List.singleton)
    , .title >> unwrapEmptyList (Html.Attributes.title >> List.singleton)
    ]
        |> List.concatMap (callOn universal)


{-| -}
type alias StyleAttribute =
    { standard : Maybe Elegant.Style
    , hover : Maybe Elegant.Style
    , focus : Maybe Elegant.Style
    }


defaultStyleAttribute : StyleAttribute
defaultStyleAttribute =
    { standard = Nothing
    , hover = Nothing
    , focus = Nothing
    }


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


{-| -}
type alias FlowAttributes msg =
    VisibleAttributesAndEvents msg {}


defaultFlowAttributes : FlowAttributes msg
defaultFlowAttributes =
    { onBlurEvent = Nothing
    , onEvent = Nothing
    , onFocusEvent = Nothing
    , onMouseEvents = Nothing
    , style = Nothing
    , universal = defaultUniversalAttributes
    }


visibleAttributesToHtmlAttributes : VisibleAttributesAndEvents msg a -> List (Html.Attribute msg)
visibleAttributesToHtmlAttributes visibleAttributes =
    [ unwrapEmptyList mouseEventsToHtmlAttributes << .onMouseEvents
    , unwrapEmptyList focusEventToHtmlAttributes << .onFocusEvent
    , unwrapEmptyList onEventToHtmlAttributes << .onEvent
    , unwrapEmptyList onBlurEventToHtmlAttributes << .onBlurEvent
    , universalAttributesToHtmlAttributes << .universal
    ]
        |> List.concatMap (callOn visibleAttributes)


flowAttributesToHtmlAttributes : FlowAttributes msg -> List (Html.Attribute msg)
flowAttributesToHtmlAttributes =
    visibleAttributesToHtmlAttributes


{-| -}
type alias DisabledAttribute a =
    { a | disabled : Bool }


disabledAttributeToHtmlAttributes : Bool -> List (Html.Attribute msg)
disabledAttributeToHtmlAttributes =
    Html.Attributes.disabled >> List.singleton


{-| -}
type alias ButtonAttributes msg =
    DisabledAttribute (VisibleAttributesAndEvents msg {})


defaultButtonAttributes : ButtonAttributes msg
defaultButtonAttributes =
    { disabled = False
    , onBlurEvent = Nothing
    , onEvent = Nothing
    , onFocusEvent = Nothing
    , onMouseEvents = Nothing
    , style = Nothing
    , universal = defaultUniversalAttributes
    }


buttonAttributesToHtmlAttributes : ButtonAttributes msg -> List (Html.Attribute msg)
buttonAttributesToHtmlAttributes buttonAttributes =
    buttonAttributes.disabled
        |> disabledAttributeToHtmlAttributes
        |> List.append
            (visibleAttributesToHtmlAttributes buttonAttributes)


{-| -}
type alias AAttributes msg =
    TargetAttribute (HrefAttribute (VisibleAttributesAndEvents msg {}))


{-| -}
type alias TargetAttribute a =
    { a | target : Maybe String }


{-| -}
type alias HrefAttribute a =
    { a | href : Maybe String }


defaultAattributes : AAttributes msg
defaultAattributes =
    { href = Nothing
    , target = Nothing
    , style = Nothing
    , universal = defaultUniversalAttributes
    , onMouseEvents = Nothing
    , onEvent = Nothing
    , onBlurEvent = Nothing
    , onFocusEvent = Nothing
    }


aAttributesToHtmlAttributes : AAttributes msg -> List (Html.Attribute msg)
aAttributesToHtmlAttributes _ =
    []


{-| -}
type alias TextareaAttributes msg =
    OnStringInputEvent msg (NameAttribute (StringValue (VisibleAttributesAndEvents msg {})))


{-| -}
type alias NameAttribute a =
    { a | name : Maybe String }


defaultTextareaAttributes : TextareaAttributes msg
defaultTextareaAttributes =
    { value = Nothing
    , name = Nothing
    , universal = defaultUniversalAttributes
    , style = Nothing
    , onMouseEvents = Nothing
    , onInputEvent = Nothing
    , fromStringInput = identity
    , onEvent = Nothing
    , onBlurEvent = Nothing
    , onFocusEvent = Nothing
    }


textareaAttributesToHtmlAttributes : TextareaAttributes msg -> List (Html.Attribute msg)
textareaAttributesToHtmlAttributes _ =
    []


{-| -}
type alias ImgAttributes msg =
    HeightAttribute (WidthAttribute (AltAttribute (SrcAttribute (VisibleAttributesAndEvents msg {}))))


{-| -}
type alias WidthAttribute a =
    { a | width : Maybe Int }


{-| -}
type alias HeightAttribute a =
    { a | height : Maybe Int }


{-| -}
type alias SrcAttribute a =
    { a | src : String }


{-| -}
type alias AltAttribute a =
    { a | alt : String }


defaultImgAttributes : String -> String -> ImgAttributes msg
defaultImgAttributes alt src =
    { src = src
    , alt = alt
    , universal = defaultUniversalAttributes
    , style = Nothing
    , onMouseEvents = Nothing
    , width = Nothing
    , height = Nothing
    , onEvent = Nothing
    , onBlurEvent = Nothing
    , onFocusEvent = Nothing
    }


imgAttributesToHtmlAttributes : ImgAttributes msg -> List (Html.Attribute msg)
imgAttributesToHtmlAttributes _ =
    []


{-| -}
type alias AudioAttributes msg =
    SrcAttribute (VisibleAttributesAndEvents msg {})


defaultAudioAttributes : AudioAttributes msg
defaultAudioAttributes =
    { universal = defaultUniversalAttributes
    , style = Nothing
    , onMouseEvents = Nothing
    , src = ""
    , onEvent = Nothing
    , onBlurEvent = Nothing
    , onFocusEvent = Nothing
    }


audioAttributesToHtmlAttributes : AudioAttributes msg -> List (Html.Attribute msg)
audioAttributesToHtmlAttributes _ =
    []


{-| -}
type alias ProgressAttributes msg =
    VisibleAttributesAndEvents msg {}


defaultProgressAttributes : ProgressAttributes msg
defaultProgressAttributes =
    { universal = defaultUniversalAttributes
    , style = Nothing
    , onMouseEvents = Nothing
    , onEvent = Nothing
    , onBlurEvent = Nothing
    , onFocusEvent = Nothing
    }


progressAttributesToHtmlAttributes : ProgressAttributes msg -> List (Html.Attribute msg)
progressAttributesToHtmlAttributes _ =
    []


type alias ScriptAttributes msg =
    DataAttribute (SrcAttribute (VisibleAttributesAndEvents msg {}))


type alias DataAttribute a =
    { a | data : List ( String, String ) }


defaultScriptAttributes : ScriptAttributes msg
defaultScriptAttributes =
    { universal = defaultUniversalAttributes
    , src = ""
    , style = Nothing
    , onMouseEvents = Nothing
    , onEvent = Nothing
    , onBlurEvent = Nothing
    , onFocusEvent = Nothing
    , data = []
    }


scriptAttributesToHtmlAttributes : ScriptAttributes msg -> List (Html.Attribute msg)
scriptAttributesToHtmlAttributes _ =
    []


type alias InputAttributes a =
    NameAttribute { a | type_ : String }


{-| -}
type alias InputHiddenAttributes =
    InputAttributes
        (StringValue
            { universal : UniversalAttributes {}
            , type_ : String
            }
        )


defaultInputHiddenAttributes : InputHiddenAttributes
defaultInputHiddenAttributes =
    { name = Nothing
    , universal = defaultUniversalAttributes
    , type_ = "hidden"
    , value = Nothing
    }


inputHiddenAttributesToHtmlAttributes : InputHiddenAttributes -> List (Html.Attribute msg)
inputHiddenAttributesToHtmlAttributes _ =
    []


{-| -}
type Position
    = Before
    | After


type alias PositionAttribute a =
    { a | position : Position }


type alias LabelAttribute msg a =
    { a
        | label :
            Maybe
                { attributes : LabelAttributes msg

                -- , content : Node msg
                }
    }


type alias LabelAttributes msg =
    PositionAttribute (VisibleAttributesAndEvents msg {})


type alias InputVisibleAttributes msg a =
    LabelAttribute msg (VisibleAttributesAndEvents msg (InputAttributes a))


type alias InputStringValueAttributes msg a =
    StringValue (InputVisibleAttributes msg a)


{-| -}
type alias AutocompleteAttribute a =
    { a | autocomplete : Bool }


{-| -}
type alias PlaceholderAttribute a =
    { a | placeholder : Maybe String }


{-| -}
type alias InputTextAttributes msg =
    AutocompleteAttribute (PlaceholderAttribute (OnStringInputEvent msg (InputStringValueAttributes msg {})))


defaultInputTextAttributes : InputTextAttributes msg
defaultInputTextAttributes =
    { universal = defaultUniversalAttributes
    , style = Nothing
    , name = Nothing
    , type_ = "text"
    , value = Nothing
    , onMouseEvents = Nothing
    , onInputEvent = Nothing
    , fromStringInput = identity
    , onEvent = Nothing
    , onBlurEvent = Nothing
    , onFocusEvent = Nothing
    , placeholder = Nothing
    , autocomplete = True
    , label = Nothing
    }


inputTextAttributesToHtmlAttributes : InputTextAttributes msg -> List (Html.Attribute msg)
inputTextAttributesToHtmlAttributes _ =
    []
