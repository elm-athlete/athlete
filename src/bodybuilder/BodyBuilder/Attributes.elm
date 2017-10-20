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


{-| -}
type alias TitleAttribute a =
    { a | title : Maybe String }


{-| -}
type alias IdAttribute a =
    { a | id : Maybe String }


{-| -}
type alias StepAttribute a =
    { a | step : Maybe Int }


{-| -}
type alias MaxAttribute a =
    { a | max : Maybe Int }


{-| -}
type alias MinAttribute a =
    { a | min : Maybe Int }


{-| -}
type alias OptionsAttribute a =
    { a | options : List { value : String, label : String } }


{-| -}
type alias ClassAttribute a =
    { a | class : List String }


{-| -}
type alias TabindexAttribute a =
    { a | tabindex : Maybe Int }


{-| -}
type alias TargetAttribute a =
    { a | target : Maybe String }


{-| -}
type alias HrefAttribute a =
    { a | href : Maybe String }


type alias NameAttribute a =
    { a | name : Maybe String }


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


{-| -}
type alias DisabledAttribute a =
    { a | disabled : Bool }


type alias MaybeBlockContainer a =
    { a | block : Maybe (List (BlockDetails -> BlockDetails)) }


type alias BlockContainer a =
    { a | block : List (BlockDetails -> BlockDetails) }


{-| -}
type alias AutocompleteAttribute a =
    { a | autocomplete : Bool }


{-| -}
type alias PlaceholderAttribute a =
    { a | placeholder : Maybe String }


type alias PositionAttribute a =
    { a | position : Position }


type alias DataAttribute a =
    { a | data : List ( String, String ) }


type alias TypeContainer a =
    { a | type_ : String }


type alias BoxContainer a =
    { a | box : List (Box.Box -> Box.Box) }


type alias CheckedContainer a =
    { a | checked : Bool }


type alias UniversalContainer a =
    { a | universal : UniversalAttributes }


type alias FlexContainerProperties a =
    { a | flexContainerProperties : List (Display.FlexContainerDetails -> Display.FlexContainerDetails) }


type alias FlexItemProperties a =
    { a | flexItemProperties : List (Display.FlexItemDetails -> Display.FlexItemDetails) }


{-| -}
type Position
    = Before
    | After


type alias VisibleAttributes a =
    BoxContainer (UniversalContainer a)


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


{-| -}
type alias InputSubmitAttributes msg =
    ValueAttribute String (OnSubmitEvent msg (ButtonAttributesBase msg (TypeContainer {})))


{-| -}
type alias InputUrlAttributes msg =
    InputTextAttributes msg


{-| -}
type alias InputNumberAttributes msg =
    StepAttribute (MaxAttribute (MinAttribute (OnIntInputEvent msg (IntValue (InputVisibleAttributes msg {})))))


{-| -}
type alias InputColorAttributes msg =
    OnColorInputEvent msg (ColorValue (InputVisibleAttributes msg {}))


{-| -}
type alias InputCheckboxAttributes msg =
    CheckedContainer (OnCheckEvent msg (InputStringValueAttributes msg {}))


{-| -}
type alias InputFileAttributes msg =
    InputVisibleAttributes msg {}


{-| -}
type alias InputPasswordAttributes msg =
    InputTextAttributes msg


{-| -}
type alias InputRadioAttributes msg =
    InputStringValueAttributes msg {}


{-| -}
type alias InputRangeAttributes msg =
    InputNumberAttributes msg


{-| -}
type alias SelectAttributes msg =
    StringValue (OptionsAttribute (FlowAttributes msg))


type alias UniversalAttributes =
    TitleAttribute (TabindexAttribute (IdAttribute (ClassAttribute {})))


{-| -}
type alias FlowAttributes msg =
    VisibleAttributesAndEvents msg {}


type alias NodeAttributes msg =
    MaybeBlockContainer (FlowAttributes msg)


type alias FlexContainerAttributes msg =
    FlexContainerProperties (NodeAttributes msg)


type alias FlexItemAttributes msg =
    FlexItemProperties (NodeAttributes msg)


type alias HeadingAttributes msg =
    BlockContainer (FlowAttributes msg)


{-| -}
type alias ButtonAttributesBase msg a =
    DisabledAttribute (VisibleAttributesAndEvents msg a)


type alias ButtonAttributes msg =
    ButtonAttributesBase msg {}


{-| -}
type alias AAttributes msg =
    TargetAttribute (HrefAttribute (FlowAttributes msg))


{-| -}
type alias TextareaAttributes msg =
    OnStringInputEvent msg (NameAttribute (StringValue (FlowAttributes msg)))


{-| -}
type alias ImgAttributes msg =
    HeightAttribute (WidthAttribute (AltAttribute (SrcAttribute (FlowAttributes msg))))


{-| -}
type alias AudioAttributes msg =
    SrcAttribute (FlowAttributes msg)


{-| -}
type alias ProgressAttributes msg =
    FlowAttributes msg


type alias ScriptAttributes msg =
    DataAttribute (SrcAttribute (FlowAttributes msg))


type alias InputAttributes a =
    NameAttribute (TypeContainer a)


{-| -}
type alias InputHiddenAttributes =
    UniversalContainer (TypeContainer (InputAttributes (StringValue {})))


type alias LabelAttributes msg =
    PositionAttribute (FlowAttributes msg)


type alias InputVisibleAttributes msg a =
    VisibleAttributesAndEvents msg (InputAttributes a)


type alias InputStringValueAttributes msg a =
    StringValue (InputVisibleAttributes msg a)


{-| -}
type alias InputTextAttributesBase msg a =
    AutocompleteAttribute (PlaceholderAttribute (OnStringInputEvent msg (InputStringValueAttributes msg a)))


type alias InputTextAttributes msg =
    InputTextAttributesBase msg {}


{-| -}
value : a -> { c | value : b } -> { c | value : Maybe a }
value val attrs =
    { attrs | value = Just val }


setUniversal :
    UniversalAttributes
    -> { a | universal : UniversalAttributes }
    -> { a | universal : UniversalAttributes }
setUniversal val attrs =
    { attrs | universal = val }


setUniversalIn :
    { a | universal : UniversalAttributes }
    -> UniversalAttributes
    -> { a | universal : UniversalAttributes }
setUniversalIn =
    flip setUniversal


setValueInUniversal :
    (a -> UniversalAttributes -> UniversalAttributes)
    -> a
    -> { c | universal : UniversalAttributes }
    -> { c | universal : UniversalAttributes }
setValueInUniversal setter val ({ universal } as attrs) =
    universal
        |> setter val
        |> setUniversalIn attrs


{-| -}
box : List (Box.Box -> Box.Box) -> Modifier (VisibleAttributes a)
box val ({ box } as attrs) =
    val
        |> setBoxIn attrs


title : String -> Modifier { a | universal : UniversalAttributes }
title =
    setValueInUniversal setTitle


id : String -> Modifier { a | universal : UniversalAttributes }
id =
    setValueInUniversal setId


class : List String -> Modifier { a | universal : UniversalAttributes }
class =
    setValueInUniversal setClass


tabindex : Int -> Modifier { a | universal : UniversalAttributes }
tabindex =
    setValueInUniversal setTabIndex


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


defaultUniversalAttributes : UniversalAttributes
defaultUniversalAttributes =
    { class = []
    , id = Nothing
    , tabindex = Nothing
    , title = Nothing
    }


universalAttributesToHtmlAttributes : UniversalAttributes -> List (Html.Attribute msg)
universalAttributesToHtmlAttributes universal =
    [ .class >> List.map Html.Attributes.class
    , .id >> unwrapMaybeAttribute Html.Attributes.id
    , .tabindex >> unwrapMaybeAttribute Html.Attributes.tabindex
    , .title >> unwrapMaybeAttribute Html.Attributes.title
    ]
        |> List.concatMap (callOn universal)


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


block : Modifiers BlockDetails -> Modifier (MaybeBlockContainer a)
block modifiers ({ block } as attrs) =
    { attrs | block = Just (Maybe.withDefault [] block ++ modifiers) }


blockProperties : Modifiers BlockDetails -> Modifier (BlockContainer a)
blockProperties modifiers ({ block } as attrs) =
    { attrs | block = block ++ modifiers }


defaultNodeAttributes : NodeAttributes msg
defaultNodeAttributes =
    { onBlurEvent = Nothing
    , onEvent = Nothing
    , onFocusEvent = Nothing
    , onMouseEvents = Nothing
    , box = []
    , universal = defaultUniversalAttributes
    , block = Nothing
    }


flexContainerProperties :
    List (Display.FlexContainerDetails -> Display.FlexContainerDetails)
    -> Modifier (FlexContainerAttributes msg)
flexContainerProperties modifiers ({ flexContainerProperties } as attrs) =
    { attrs | flexContainerProperties = flexContainerProperties ++ modifiers }


defaultFlexContainerAttributes : FlexContainerAttributes msg
defaultFlexContainerAttributes =
    { onBlurEvent = Nothing
    , onEvent = Nothing
    , onFocusEvent = Nothing
    , onMouseEvents = Nothing
    , box = []
    , universal = defaultUniversalAttributes
    , block = Nothing
    , flexContainerProperties = []
    }


defaultHeadingAttributes : HeadingAttributes msg
defaultHeadingAttributes =
    { onBlurEvent = Nothing
    , onEvent = Nothing
    , onFocusEvent = Nothing
    , onMouseEvents = Nothing
    , box = []
    , universal = defaultUniversalAttributes
    , block = []
    }


flexItemProperties :
    List (Display.FlexItemDetails -> Display.FlexItemDetails)
    -> Modifier (FlexItemAttributes msg)
flexItemProperties modifiers ({ flexItemProperties } as attrs) =
    { attrs | flexItemProperties = flexItemProperties ++ modifiers }


defaultFlexItemAttributes : FlexItemAttributes msg
defaultFlexItemAttributes =
    { onBlurEvent = Nothing
    , onEvent = Nothing
    , onFocusEvent = Nothing
    , onMouseEvents = Nothing
    , box = []
    , block = Nothing
    , universal = defaultUniversalAttributes
    , flexItemProperties = []
    }


nodeAttributesToHtmlAttributes : NodeAttributes msg -> List (Html.Attribute msg)
nodeAttributesToHtmlAttributes =
    visibleAttributesToHtmlAttributes


flexContainerAttributesToHtmlAttributes : FlexContainerAttributes msg -> List (Html.Attribute msg)
flexContainerAttributesToHtmlAttributes =
    visibleAttributesToHtmlAttributes


flexItemAttributesToHtmlAttributes : FlexItemAttributes msg -> List (Html.Attribute msg)
flexItemAttributesToHtmlAttributes =
    visibleAttributesToHtmlAttributes


headingAttributesToHtmlAttributes : HeadingAttributes msg -> List (Html.Attribute msg)
headingAttributesToHtmlAttributes =
    visibleAttributesToHtmlAttributes


disabled : Modifier (DisabledAttribute a)
disabled attrs =
    { attrs | disabled = False }


disabledAttributeToHtmlAttributes : Bool -> List (Html.Attribute msg)
disabledAttributeToHtmlAttributes =
    Html.Attributes.disabled >> List.singleton


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


target : String -> Modifier (TargetAttribute a)
target val attrs =
    { attrs | target = Just val }


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


width : Int -> Modifier (WidthAttribute a)
width val attrs =
    { attrs | width = Just val }


height : Int -> Modifier (HeightAttribute a)
height val attrs =
    { attrs | height = Just val }


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


inputAttributesToHtmlAttributes : InputAttributes a -> List (Html.Attribute msg)
inputAttributesToHtmlAttributes attributes =
    Html.Attributes.type_ attributes.type_ :: unwrapMaybeAttribute Html.Attributes.name attributes.name


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


inputVisibleToHtmlAttributes :
    VisibleAttributesAndEvents msg { a | name : Maybe String, type_ : String }
    -> List (Html.Attribute msg)
inputVisibleToHtmlAttributes attributes =
    List.append
        (visibleAttributesToHtmlAttributes attributes)
        (inputAttributesToHtmlAttributes attributes)


autocomplete : Bool -> Modifier (AutocompleteAttribute a)
autocomplete val attrs =
    { attrs | autocomplete = val }


placeholder : String -> Modifier (PlaceholderAttribute a)
placeholder val attrs =
    { attrs | placeholder = Just val }


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



-- From HERE


step : Int -> Modifier (StepAttribute a)
step val attrs =
    { attrs | step = Just val }


max : Int -> Modifier (MaxAttribute a)
max val attrs =
    { attrs | max = Just val }


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
    }


inputColorAttributesToHtmlAttributes : InputColorAttributes msg -> List (Html.Attribute msg)
inputColorAttributesToHtmlAttributes attributes =
    unwrapMaybeAttribute Html.Attributes.value (Maybe.map Color.Convert.colorToCssRgb <| attributes.value)
        |> List.append (inputVisibleToHtmlAttributes attributes)
        |> List.append (inputEventToHtmlEvent ( attributes.onInputEvent, attributes.fromStringInput ))


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
    }


inputCheckboxAttributesToHtmlAttributes : InputCheckboxAttributes msg -> List (Html.Attribute msg)
inputCheckboxAttributesToHtmlAttributes attributes =
    Html.Attributes.checked attributes.checked
        |> flip (::) (unwrapMaybeAttribute Html.Attributes.value (Maybe.map toString <| attributes.value))
        |> List.append (inputVisibleToHtmlAttributes attributes)
        |> List.append (checkEventToHtmlEvent attributes)


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
    }


inputFileAttributesToHtmlAttributes : InputFileAttributes msg -> List (Html.Attribute msg)
inputFileAttributesToHtmlAttributes =
    inputVisibleToHtmlAttributes


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
    }


inputPasswordAttributesToHtmlAttributes : InputPasswordAttributes msg -> List (Html.Attribute msg)
inputPasswordAttributesToHtmlAttributes =
    inputTextAttributesToHtmlAttributes


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
    }


inputRadioAttributesToHtmlAttributes : InputRadioAttributes msg -> List (Html.Attribute msg)
inputRadioAttributesToHtmlAttributes attributes =
    List.append
        (unwrapMaybeAttribute Html.Attributes.value attributes.value)
        (inputVisibleToHtmlAttributes attributes)


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
    }


inputRangeAttributesToHtmlAttributes : InputRangeAttributes msg -> List (Html.Attribute msg)
inputRangeAttributesToHtmlAttributes =
    inputNumberAttributesToHtmlAttributes


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
    }


inputUrlAttributesToHtmlAttributes : InputUrlAttributes msg -> List (Html.Attribute msg)
inputUrlAttributesToHtmlAttributes =
    inputTextAttributesToHtmlAttributes


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
