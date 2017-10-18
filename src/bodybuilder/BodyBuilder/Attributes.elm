module BodyBuilder.Attributes exposing (..)

import Html exposing (Html)
import Html.Attributes
import Elegant
import Color exposing (Color)
import Color.Convert


-- import Function

import Helpers.Shared exposing (..)
import BodyBuilder.Setters exposing (..)
import BodyBuilder.Events exposing (..)


type alias ValueAttribute b a =
    { a | value : Maybe b }


value : a -> { c | value : b } -> { c | value : Maybe a }
value val attrs =
    { attrs | value = Just val }


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
        | style : List Elegant.Style
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
    , .id >> unwrapMaybeAttribute Html.Attributes.id
    , .tabindex >> unwrapMaybeAttribute Html.Attributes.tabindex
    , .title >> unwrapMaybeAttribute Html.Attributes.title
    ]
        |> List.concatMap (callOn universal)


{-| -}
style :
    List Elegant.Style
    -> { a | style : List Elegant.Style }
    -> { a | style : List Elegant.Style }
style val ({ style } as attrs) =
    (val ++ style)
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
    , style = []
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
type alias ButtonAttributesBase msg a =
    DisabledAttribute (VisibleAttributesAndEvents msg a)


type alias ButtonAttributes msg =
    ButtonAttributesBase msg {}


defaultButtonAttributes : ButtonAttributes msg
defaultButtonAttributes =
    { disabled = False
    , onBlurEvent = Nothing
    , onEvent = Nothing
    , onFocusEvent = Nothing
    , onMouseEvents = Nothing
    , style = []
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


defaultAAttributes : AAttributes msg
defaultAAttributes =
    { href = Nothing
    , target = Nothing
    , style = []
    , universal = defaultUniversalAttributes
    , onMouseEvents = Nothing
    , onEvent = Nothing
    , onBlurEvent = Nothing
    , onFocusEvent = Nothing
    }


aAttributesToHtmlAttributes : AAttributes msg -> List (Html.Attribute msg)
aAttributesToHtmlAttributes attributes =
    [ unwrapMaybeAttribute Html.Attributes.href << .href
    , unwrapMaybeAttribute Html.Attributes.target << .target
    ]
        |> List.concatMap (callOn attributes)
        |> List.append (visibleAttributesToHtmlAttributes attributes)


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
    , style = []
    , onMouseEvents = Nothing
    , onInputEvent = Nothing
    , fromStringInput = identity
    , onEvent = Nothing
    , onBlurEvent = Nothing
    , onFocusEvent = Nothing
    }


textareaAttributesToHtmlAttributes : TextareaAttributes msg -> List (Html.Attribute msg)
textareaAttributesToHtmlAttributes attributes =
    [ unwrapMaybeAttribute Html.Attributes.value << .value
    , unwrapMaybeAttribute Html.Attributes.name << .name
    ]
        |> List.concatMap (callOn attributes)
        |> List.append (inputEventToHtmlEvent ( attributes.onInputEvent, attributes.fromStringInput ))
        |> List.append (visibleAttributesToHtmlAttributes attributes)


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
    , style = []
    , onMouseEvents = Nothing
    , width = Nothing
    , height = Nothing
    , onEvent = Nothing
    , onBlurEvent = Nothing
    , onFocusEvent = Nothing
    }


imgAttributesToHtmlAttributes : ImgAttributes msg -> List (Html.Attribute msg)
imgAttributesToHtmlAttributes attributes =
    [ unwrapMaybeAttribute Html.Attributes.height << .height
    , unwrapMaybeAttribute Html.Attributes.width << .width
    ]
        |> List.concatMap (callOn attributes)
        |> List.append
            ([ Html.Attributes.alt << .alt
             , Html.Attributes.src << .src
             ]
                |> List.map (callOn attributes)
            )
        |> List.append (visibleAttributesToHtmlAttributes attributes)


{-| -}
type alias AudioAttributes msg =
    SrcAttribute (VisibleAttributesAndEvents msg {})


defaultAudioAttributes : AudioAttributes msg
defaultAudioAttributes =
    { universal = defaultUniversalAttributes
    , style = []
    , onMouseEvents = Nothing
    , src = ""
    , onEvent = Nothing
    , onBlurEvent = Nothing
    , onFocusEvent = Nothing
    }


audioAttributesToHtmlAttributes : AudioAttributes msg -> List (Html.Attribute msg)
audioAttributesToHtmlAttributes attributes =
    Html.Attributes.src attributes.src :: visibleAttributesToHtmlAttributes attributes


{-| -}
type alias ProgressAttributes msg =
    VisibleAttributesAndEvents msg {}


defaultProgressAttributes : ProgressAttributes msg
defaultProgressAttributes =
    { universal = defaultUniversalAttributes
    , style = []
    , onMouseEvents = Nothing
    , onEvent = Nothing
    , onBlurEvent = Nothing
    , onFocusEvent = Nothing
    }


progressAttributesToHtmlAttributes : ProgressAttributes msg -> List (Html.Attribute msg)
progressAttributesToHtmlAttributes =
    visibleAttributesToHtmlAttributes


type alias ScriptAttributes msg =
    DataAttribute (SrcAttribute (VisibleAttributesAndEvents msg {}))


type alias DataAttribute a =
    { a | data : List ( String, String ) }


defaultScriptAttributes : ScriptAttributes msg
defaultScriptAttributes =
    { universal = defaultUniversalAttributes
    , src = ""
    , style = []
    , onMouseEvents = Nothing
    , onEvent = Nothing
    , onBlurEvent = Nothing
    , onFocusEvent = Nothing
    , data = []
    }


scriptAttributesToHtmlAttributes : ScriptAttributes msg -> List (Html.Attribute msg)
scriptAttributesToHtmlAttributes attributes =
    Html.Attributes.src attributes.src :: visibleAttributesToHtmlAttributes attributes


type alias InputAttributes a =
    NameAttribute { a | type_ : String }


inputAttributesToHtmlAttributes : InputAttributes a -> List (Html.Attribute msg)
inputAttributesToHtmlAttributes attributes =
    Html.Attributes.type_ attributes.type_ :: unwrapMaybeAttribute Html.Attributes.name attributes.name


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
inputHiddenAttributesToHtmlAttributes attributes =
    unwrapMaybeAttribute Html.Attributes.value attributes.value
        |> List.append (inputAttributesToHtmlAttributes attributes)
        |> List.append (universalAttributesToHtmlAttributes attributes.universal)


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


inputVisibleToHtmlAttributes :
    VisibleAttributesAndEvents msg { a | name : Maybe String, type_ : String }
    -> List (Html.Attribute msg)
inputVisibleToHtmlAttributes attributes =
    List.append
        (visibleAttributesToHtmlAttributes attributes)
        (inputAttributesToHtmlAttributes attributes)


type alias InputStringValueAttributes msg a =
    StringValue (InputVisibleAttributes msg a)


{-| -}
type alias AutocompleteAttribute a =
    { a | autocomplete : Bool }


{-| -}
type alias PlaceholderAttribute a =
    { a | placeholder : Maybe String }


{-| -}
type alias InputTextAttributesBase msg a =
    AutocompleteAttribute (PlaceholderAttribute (OnStringInputEvent msg (InputStringValueAttributes msg a)))


type alias InputTextAttributes msg =
    InputTextAttributesBase msg {}


defaultInputTextAttributes : InputTextAttributes msg
defaultInputTextAttributes =
    { universal = defaultUniversalAttributes
    , style = []
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
inputTextAttributesToHtmlAttributes attributes =
    Html.Attributes.autocomplete attributes.autocomplete
        :: ([ unwrapMaybeAttribute Html.Attributes.placeholder << .placeholder
            , unwrapMaybeAttribute Html.Attributes.value << .value
            ]
                |> List.concatMap (callOn attributes)
                |> List.append (inputVisibleToHtmlAttributes attributes)
                |> List.append (inputEventToHtmlEvent ( attributes.onInputEvent, attributes.fromStringInput ))
           )


{-| -}
type alias InputNumberAttributes msg =
    StepAttribute (MaxAttribute (MinAttribute (OnIntInputEvent msg (IntValue (InputVisibleAttributes msg {})))))


{-| -}
type alias StepAttribute a =
    { a | step : Maybe Int }


{-| -}
type alias MaxAttribute a =
    { a | max : Maybe Int }


{-| -}
type alias MinAttribute a =
    { a | min : Maybe Int }


defaultInputNumberAttributes : InputNumberAttributes msg
defaultInputNumberAttributes =
    { universal = defaultUniversalAttributes
    , style = []
    , name = Nothing
    , type_ = "number"
    , value = Nothing
    , onMouseEvents = Nothing
    , onInputEvent = Nothing
    , fromStringInput = parseInt
    , onEvent = Nothing
    , onBlurEvent = Nothing
    , onFocusEvent = Nothing
    , min = Nothing
    , max = Nothing
    , step = Nothing
    , label = Nothing
    }


inputNumberAttributesToHtmlAttributes : InputNumberAttributes msg -> List (Html.Attribute msg)
inputNumberAttributesToHtmlAttributes attributes =
    [ unwrapMaybeAttribute Html.Attributes.value << (Maybe.map toString << .value)
    , unwrapMaybeAttribute Html.Attributes.min << (Maybe.map toString << .min)
    , unwrapMaybeAttribute Html.Attributes.max << (Maybe.map toString << .max)
    ]
        |> List.concatMap (callOn attributes)
        |> List.append (inputVisibleToHtmlAttributes attributes)
        |> List.append (inputEventToHtmlEvent ( attributes.onInputEvent, attributes.fromStringInput ))


{-| -}
type alias InputColorAttributes msg =
    OnColorInputEvent msg (ColorValue (InputVisibleAttributes msg {}))


defaultInputColorAttributes : InputColorAttributes msg
defaultInputColorAttributes =
    { universal = defaultUniversalAttributes
    , style = []
    , name = Nothing
    , type_ = "color"
    , value = Nothing
    , onMouseEvents = Nothing
    , onInputEvent = Nothing
    , fromStringInput = parseColor
    , onEvent = Nothing
    , onBlurEvent = Nothing
    , onFocusEvent = Nothing
    , label = Nothing
    }


inputColorAttributesToHtmlAttributes : InputColorAttributes msg -> List (Html.Attribute msg)
inputColorAttributesToHtmlAttributes attributes =
    unwrapMaybeAttribute Html.Attributes.value (Maybe.map Color.Convert.colorToCssRgb <| attributes.value)
        |> List.append (inputVisibleToHtmlAttributes attributes)
        |> List.append (inputEventToHtmlEvent ( attributes.onInputEvent, attributes.fromStringInput ))


{-| -}
type alias InputCheckboxAttributes msg =
    OnCheckEvent msg (InputStringValueAttributes msg { checked : Bool })


defaultInputCheckboxAttributes : InputCheckboxAttributes msg
defaultInputCheckboxAttributes =
    { name = Nothing
    , type_ = "checkbox"
    , value = Nothing
    , checked = False
    , universal = defaultUniversalAttributes
    , style = []
    , onMouseEvents = Nothing
    , onCheckEvent = Nothing
    , onEvent = Nothing
    , onBlurEvent = Nothing
    , onFocusEvent = Nothing
    , label = Nothing
    }


inputCheckboxAttributesToHtmlAttributes : InputCheckboxAttributes msg -> List (Html.Attribute msg)
inputCheckboxAttributesToHtmlAttributes attributes =
    Html.Attributes.checked attributes.checked
        |> flip (::) (unwrapMaybeAttribute Html.Attributes.value (Maybe.map toString <| attributes.value))
        |> List.append (inputVisibleToHtmlAttributes attributes)
        |> List.append (checkEventToHtmlEvent attributes)


{-| -}
type alias InputFileAttributes msg =
    InputVisibleAttributes msg {}


defaultInputFileAttributes : InputFileAttributes msg
defaultInputFileAttributes =
    { name = Nothing
    , type_ = "file"
    , universal = defaultUniversalAttributes
    , style = []
    , onMouseEvents = Nothing
    , onEvent = Nothing
    , onBlurEvent = Nothing
    , onFocusEvent = Nothing
    , label = Nothing
    }


inputFileAttributesToHtmlAttributes : InputFileAttributes msg -> List (Html.Attribute msg)
inputFileAttributesToHtmlAttributes =
    inputVisibleToHtmlAttributes


{-| -}
type alias InputPasswordAttributes msg =
    InputTextAttributes msg


defaultInputPasswordAttributes : InputPasswordAttributes msg
defaultInputPasswordAttributes =
    { name = Nothing
    , type_ = "password"
    , value = Nothing
    , universal = defaultUniversalAttributes
    , style = []
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


inputPasswordAttributesToHtmlAttributes : InputPasswordAttributes msg -> List (Html.Attribute msg)
inputPasswordAttributesToHtmlAttributes =
    inputTextAttributesToHtmlAttributes


{-| -}
type alias InputRadioAttributes msg =
    InputStringValueAttributes msg {}


defaultInputRadioAttributes : InputRadioAttributes msg
defaultInputRadioAttributes =
    { name = Nothing
    , type_ = "radio"
    , value = Nothing
    , universal = defaultUniversalAttributes
    , style = []
    , onMouseEvents = Nothing
    , onEvent = Nothing
    , onBlurEvent = Nothing
    , onFocusEvent = Nothing
    , label = Nothing
    }


inputRadioAttributesToHtmlAttributes : InputRadioAttributes msg -> List (Html.Attribute msg)
inputRadioAttributesToHtmlAttributes attributes =
    List.append
        (unwrapMaybeAttribute Html.Attributes.value attributes.value)
        (inputVisibleToHtmlAttributes attributes)


{-| -}
type alias InputRangeAttributes msg =
    InputNumberAttributes msg


defaultInputRangeAttributes : InputRangeAttributes msg
defaultInputRangeAttributes =
    { universal = defaultUniversalAttributes
    , style = []
    , name = Nothing
    , type_ = "range"
    , value = Nothing
    , onMouseEvents = Nothing
    , onInputEvent = Nothing
    , fromStringInput = parseInt
    , onEvent = Nothing
    , onBlurEvent = Nothing
    , onFocusEvent = Nothing
    , min = Nothing
    , max = Nothing
    , step = Nothing
    , label = Nothing
    }


inputRangeAttributesToHtmlAttributes : InputRangeAttributes msg -> List (Html.Attribute msg)
inputRangeAttributesToHtmlAttributes =
    inputNumberAttributesToHtmlAttributes


{-| -}
type alias InputSubmitAttributes msg =
    ValueAttribute String (OnSubmitEvent msg (ButtonAttributesBase msg { type_ : String }))


defaultInputSubmitAttributes : InputSubmitAttributes msg
defaultInputSubmitAttributes =
    { type_ = "submit"
    , universal = defaultUniversalAttributes
    , style = []
    , onMouseEvents = Nothing
    , disabled = False
    , onSubmitEvent = Nothing
    , onEvent = Nothing
    , onBlurEvent = Nothing
    , onFocusEvent = Nothing
    , value = Nothing
    }


inputSubmitAttributesToHtmlAttributes : InputSubmitAttributes msg -> List (Html.Attribute msg)
inputSubmitAttributesToHtmlAttributes attributes =
    List.concat
        [ submitEventToHtmlEvent attributes
        , unwrapMaybeAttribute Html.Attributes.value attributes.value
        , Html.Attributes.disabled attributes.disabled
            :: Html.Attributes.type_ attributes.type_
            :: visibleAttributesToHtmlAttributes attributes
        ]


{-| -}
type alias InputUrlAttributes msg =
    InputTextAttributes msg


defaultInputUrlAttributes : InputUrlAttributes msg
defaultInputUrlAttributes =
    { name = Nothing
    , value = Nothing
    , type_ = "url"
    , universal = defaultUniversalAttributes
    , style = []
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


inputUrlAttributesToHtmlAttributes : InputUrlAttributes msg -> List (Html.Attribute msg)
inputUrlAttributesToHtmlAttributes =
    inputTextAttributesToHtmlAttributes


{-| -}
type alias SelectAttributes msg =
    StringValue (OptionsAttribute (VisibleAttributesAndEvents msg {}))


{-| -}
type alias OptionsAttribute a =
    { a | options : List { value : String, label : String } }


defaultSelectAttributes : SelectAttributes msg
defaultSelectAttributes =
    { value = Nothing
    , options = []
    , universal = defaultUniversalAttributes
    , style = []
    , onMouseEvents = Nothing
    , onEvent = Nothing
    , onBlurEvent = Nothing
    , onFocusEvent = Nothing
    }


selectAttributesToHtmlAttributes : SelectAttributes msg -> List (Html.Attribute msg)
selectAttributesToHtmlAttributes attributes =
    unwrapMaybeAttribute Html.Attributes.value attributes.value
        |> List.append (visibleAttributesToHtmlAttributes attributes)
