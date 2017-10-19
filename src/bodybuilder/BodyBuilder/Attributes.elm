module BodyBuilder.Attributes exposing (..)

import Html exposing (Html)
import Html.Attributes
import Color exposing (Color)
import Color.Convert
import Box
import Display exposing (BlockDetails)


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
        | box : Modifiers Box.Box
        , universal : UniversalAttributes {}
    }


setUniversal :
    UniversalAttributes b
    -> { a | universal : UniversalAttributes b }
    -> { a | universal : UniversalAttributes b }
setUniversal val attrs =
    { attrs | universal = val }


setUniversalIn :
    { a | universal : UniversalAttributes b }
    -> UniversalAttributes b
    -> { a | universal : UniversalAttributes b }
setUniversalIn =
    flip setUniversal


setValueInUniversal :
    (a -> UniversalAttributes b -> UniversalAttributes b)
    -> a
    -> { c | universal : UniversalAttributes b }
    -> { c | universal : UniversalAttributes b }
setValueInUniversal setter val ({ universal } as attrs) =
    universal
        |> setter val
        |> setUniversalIn attrs


{-| -}
box : Modifiers Box.Box -> Modifier (VisibleAttributes a)
box val attrs =
    val
        |> setBoxIn attrs


{-| -}
type alias TitleAttribute a =
    { a | title : Maybe String }


title : String -> Modifier { a | universal : UniversalAttributes b }
title =
    setValueInUniversal setTitle


{-| -}
type alias IdAttribute a =
    { a | id : Maybe String }


id : String -> Modifier { a | universal : UniversalAttributes b }
id =
    setValueInUniversal setId


{-| -}
type alias ClassAttribute a =
    { a | class : List String }


class : List String -> Modifier { a | universal : UniversalAttributes b }
class =
    setValueInUniversal setClass


{-| -}
type alias TabindexAttribute a =
    { a | tabindex : Maybe Int }


tabindex : Int -> Modifier { a | universal : UniversalAttributes b }
tabindex =
    setValueInUniversal setTabIndex


type alias UniversalAttributes a =
    TitleAttribute (TabindexAttribute (IdAttribute (ClassAttribute a)))


setTitle : String -> { a | title : Maybe String } -> { a | title : Maybe String }
setTitle val attrs =
    { attrs | title = Just val }


setTabIndex : Int -> { a | tabindex : Maybe Int } -> { a | tabindex : Maybe Int }
setTabIndex val attrs =
    { attrs | tabindex = Just val }


setId : String -> { a | id : Maybe String } -> { a | id : Maybe String }
setId val attrs =
    { attrs | id = Just val }


setClass : List String -> { a | class : List String } -> { a | class : List String }
setClass val attrs =
    { attrs | class = val }


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
type alias FlowAttributes msg =
    VisibleAttributesAndEvents msg {}


defaultFlowAttributes : FlowAttributes msg
defaultFlowAttributes =
    { onBlurEvent = Nothing
    , onEvent = Nothing
    , onFocusEvent = Nothing
    , onMouseEvents = Nothing
    , box = []
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


type alias BlockAttributes msg =
    VisibleAttributesAndEvents msg { block : Modifiers BlockDetails }


block : Modifiers BlockDetails -> Modifier (BlockAttributes msg)
block modifiers attrs =
    { attrs | block = modifiers }


defaultBlockAttributes : BlockAttributes msg
defaultBlockAttributes =
    { onBlurEvent = Nothing
    , onEvent = Nothing
    , onFocusEvent = Nothing
    , onMouseEvents = Nothing
    , box = []
    , universal = defaultUniversalAttributes
    , block = []
    }


blockAttributesToHtmlAttributes : BlockAttributes msg -> List (Html.Attribute msg)
blockAttributesToHtmlAttributes =
    visibleAttributesToHtmlAttributes


{-| -}
type alias DisabledAttribute a =
    { a | disabled : Bool }


disabled : Modifier (DisabledAttribute a)
disabled attrs =
    { attrs | disabled = False }


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
    , box = []
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


target : String -> Modifier (TargetAttribute a)
target val attrs =
    { attrs | target = Just val }


{-| -}
type alias HrefAttribute a =
    { a | href : Maybe String }


href : String -> Modifier (HrefAttribute a)
href val attrs =
    { attrs | href = Just val }


defaultAAttributes : AAttributes msg
defaultAAttributes =
    { href = Nothing
    , target = Nothing
    , box = []
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


name : String -> Modifier (NameAttribute a)
name val attrs =
    { attrs | name = Just val }


defaultTextareaAttributes : TextareaAttributes msg
defaultTextareaAttributes =
    { value = Nothing
    , name = Nothing
    , universal = defaultUniversalAttributes
    , box = []
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


width : Int -> Modifier (WidthAttribute a)
width val attrs =
    { attrs | width = Just val }


{-| -}
type alias HeightAttribute a =
    { a | height : Maybe Int }


height : Int -> Modifier (HeightAttribute a)
height val attrs =
    { attrs | height = Just val }


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
    , box = []
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
    , box = []
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
    , box = []
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


data : List ( String, String ) -> Modifier (DataAttribute a)
data val attrs =
    { attrs | data = val }


defaultScriptAttributes : ScriptAttributes msg
defaultScriptAttributes =
    { universal = defaultUniversalAttributes
    , src = ""
    , box = []
    , onMouseEvents = Nothing
    , onEvent = Nothing
    , onBlurEvent = Nothing
    , onFocusEvent = Nothing
    , data = []
    }


scriptAttributesToHtmlAttributes : ScriptAttributes msg -> List (Html.Attribute msg)
scriptAttributesToHtmlAttributes attributes =
    -- TODO data handler
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


autocomplete : Bool -> Modifier (AutocompleteAttribute a)
autocomplete val attrs =
    { attrs | autocomplete = val }


{-| -}
type alias PlaceholderAttribute a =
    { a | placeholder : Maybe String }


placeholder : String -> Modifier (PlaceholderAttribute a)
placeholder val attrs =
    { attrs | placeholder = Just val }


{-| -}
type alias InputTextAttributesBase msg a =
    AutocompleteAttribute (PlaceholderAttribute (OnStringInputEvent msg (InputStringValueAttributes msg a)))


type alias InputTextAttributes msg =
    InputTextAttributesBase msg {}


defaultInputTextAttributes : InputTextAttributes msg
defaultInputTextAttributes =
    { universal = defaultUniversalAttributes
    , box = []
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


step : Int -> Modifier (StepAttribute a)
step val attrs =
    { attrs | step = Just val }


{-| -}
type alias MaxAttribute a =
    { a | max : Maybe Int }


max : Int -> Modifier (MaxAttribute a)
max val attrs =
    { attrs | max = Just val }


{-| -}
type alias MinAttribute a =
    { a | min : Maybe Int }


min : Int -> Modifier (MinAttribute a)
min val attrs =
    { attrs | min = Just val }


defaultInputNumberAttributes : InputNumberAttributes msg
defaultInputNumberAttributes =
    { universal = defaultUniversalAttributes
    , box = []
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
    , box = []
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


checked : Bool -> Modifier (InputCheckboxAttributes msg)
checked val attrs =
    { attrs | checked = val }


defaultInputCheckboxAttributes : InputCheckboxAttributes msg
defaultInputCheckboxAttributes =
    { name = Nothing
    , type_ = "checkbox"
    , value = Nothing
    , checked = False
    , universal = defaultUniversalAttributes
    , box = []
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
    , box = []
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
    , box = []
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
    , box = []
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
    , box = []
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
    , box = []
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
    , box = []
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
    , box = []
    , onMouseEvents = Nothing
    , onEvent = Nothing
    , onBlurEvent = Nothing
    , onFocusEvent = Nothing
    }


selectAttributesToHtmlAttributes : SelectAttributes msg -> List (Html.Attribute msg)
selectAttributesToHtmlAttributes attributes =
    unwrapMaybeAttribute Html.Attributes.value attributes.value
        |> List.append (visibleAttributesToHtmlAttributes attributes)
