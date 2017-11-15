# BodyBuilder.Attributes

This module entirely replaces Html.Attributes, providing a type-safer alternatives.
This is designed to work with BodyBuilder.
It is not compatible with Html.Attributes, though.

- [AAttributes](#aattributes)

### **type alias AAttributes**
```elm
type alias AAttributes msg =  
    { onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) , onEvent : Maybe ( String, Json.Decode.Decoder msg ) , onBlurEvent : Maybe msg , onFocusEvent : Maybe msg , box : List ( Helpers.Shared.Modifiers Box , BodyBuilder.Attributes.StyleSelector ) , universal : BodyBuilder.Attributes.UniversalAttributes , href : Maybe String , target : Maybe String , block : Maybe (List ( Helpers.Shared.Modifiers Display.BlockDetails , BodyBuilder.Attributes.StyleSelector )) , rawStyle : Maybe Elegant.Style }
```


- [aAttributesToHtmlAttributes](#aattributestohtmlattributes)

### **aAttributesToHtmlAttributes**
```elm
aAttributesToHtmlAttributes : BodyBuilder.Attributes.AAttributes msg -> List (Html.Attribute msg)
```


- [AudioAttributes](#audioattributes)

### **type alias AudioAttributes**
```elm
type alias AudioAttributes msg =  
    { onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) , onEvent : Maybe ( String, Json.Decode.Decoder msg ) , onBlurEvent : Maybe msg , onFocusEvent : Maybe msg , box : List ( Helpers.Shared.Modifiers Box , BodyBuilder.Attributes.StyleSelector ) , universal : BodyBuilder.Attributes.UniversalAttributes , src : String , block : Maybe (List ( Helpers.Shared.Modifiers Display.BlockDetails , BodyBuilder.Attributes.StyleSelector )) , rawStyle : Maybe Elegant.Style }
```


- [audioAttributesToHtmlAttributes](#audioattributestohtmlattributes)

### **audioAttributesToHtmlAttributes**
```elm
audioAttributesToHtmlAttributes : BodyBuilder.Attributes.AudioAttributes msg -> List (Html.Attribute msg)
```


- [autocomplete](#autocomplete)

### **autocomplete**
```elm
autocomplete : a -> { c | autocomplete : b } -> { c | autocomplete : a }
```


- [BlockAttributes](#blockattributes)

### **type alias BlockAttributes**
```elm
type alias BlockAttributes msg =  
    { block : List ( Helpers.Shared.Modifiers Display.BlockDetails , BodyBuilder.Attributes.StyleSelector ) , onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) , onEvent : Maybe ( String, Json.Decode.Decoder msg ) , onBlurEvent : Maybe msg , onFocusEvent : Maybe msg , box : List ( Helpers.Shared.Modifiers Box , BodyBuilder.Attributes.StyleSelector ) , universal : BodyBuilder.Attributes.UniversalAttributes , rawStyle : Maybe Elegant.Style }
```


- [BlockContainer](#blockcontainer)

### **type alias BlockContainer**
```elm
type alias BlockContainer a =  
    { a | block : List ( Helpers.Shared.Modifiers Display.BlockDetails , BodyBuilder.Attributes.StyleSelector ) }
```


- [BoxContainer](#boxcontainer)

### **type alias BoxContainer**
```elm
type alias BoxContainer a =  
    { a | box : List ( Helpers.Shared.Modifiers Box , BodyBuilder.Attributes.StyleSelector ) }
```


- [ButtonAttributes](#buttonattributes)

### **type alias ButtonAttributes**
```elm
type alias ButtonAttributes msg =  
    { disabled : Bool , block : Maybe (List ( Helpers.Shared.Modifiers Display.BlockDetails , BodyBuilder.Attributes.StyleSelector )) , onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) , onEvent : Maybe ( String, Json.Decode.Decoder msg ) , onBlurEvent : Maybe msg , onFocusEvent : Maybe msg , box : List ( Helpers.Shared.Modifiers Box , BodyBuilder.Attributes.StyleSelector ) , universal : BodyBuilder.Attributes.UniversalAttributes , rawStyle : Maybe Elegant.Style }
```


- [buttonAttributesToHtmlAttributes](#buttonattributestohtmlattributes)

### **buttonAttributesToHtmlAttributes**
```elm
buttonAttributesToHtmlAttributes : BodyBuilder.Attributes.ButtonAttributes msg -> List (Html.Attribute msg)
```


- [checked](#checked)

### **checked**
```elm
checked : Bool -> Helpers.Shared.Modifier (BodyBuilder.Attributes.InputCheckboxAttributes msg)
```


- [CheckedContainer](#checkedcontainer)

### **type alias CheckedContainer**
```elm
type alias CheckedContainer a =  
    { a | checked : Bool }
```


- [class](#class)

### **class**
```elm
class : List String -> Helpers.Shared.Modifier { a | universal : BodyBuilder.Attributes.UniversalAttributes }
```


- [ColorValue](#colorvalue)

### **type alias ColorValue**
```elm
type alias ColorValue a =  
    BodyBuilder.Attributes.ValueAttribute Color a
```


- [data](#data)

### **data**
```elm
data : a -> { c | data : b } -> { c | data : a }
```


- [DataAttribute](#dataattribute)

### **type alias DataAttribute**
```elm
type alias DataAttribute a =  
    { a | data : List ( String, String ) }
```


- [defaultAAttributes](#defaultaattributes)

### **defaultAAttributes**
```elm
defaultAAttributes : BodyBuilder.Attributes.AAttributes msg
```


- [defaultAudioAttributes](#defaultaudioattributes)

### **defaultAudioAttributes**
```elm
defaultAudioAttributes : BodyBuilder.Attributes.AudioAttributes msg
```


- [defaultButtonAttributes](#defaultbuttonattributes)

### **defaultButtonAttributes**
```elm
defaultButtonAttributes : BodyBuilder.Attributes.ButtonAttributes msg
```


- [defaultFlexContainerAttributes](#defaultflexcontainerattributes)

### **defaultFlexContainerAttributes**
```elm
defaultFlexContainerAttributes : BodyBuilder.Attributes.FlexContainerAttributes msg
```


- [defaultFlexItemAttributes](#defaultflexitemattributes)

### **defaultFlexItemAttributes**
```elm
defaultFlexItemAttributes : BodyBuilder.Attributes.FlexItemAttributes msg
```


- [defaultFlowAttributes](#defaultflowattributes)

### **defaultFlowAttributes**
```elm
defaultFlowAttributes : BodyBuilder.Attributes.FlowAttributes msg
```


- [defaultGridContainerAttributes](#defaultgridcontainerattributes)

### **defaultGridContainerAttributes**
```elm
defaultGridContainerAttributes : BodyBuilder.Attributes.GridContainerAttributes msg
```


- [defaultGridItemAttributes](#defaultgriditemattributes)

### **defaultGridItemAttributes**
```elm
defaultGridItemAttributes : BodyBuilder.Attributes.GridItemAttributes msg
```


- [defaultHeadingAttributes](#defaultheadingattributes)

### **defaultHeadingAttributes**
```elm
defaultHeadingAttributes : BodyBuilder.Attributes.HeadingAttributes msg
```


- [defaultImgAttributes](#defaultimgattributes)

### **defaultImgAttributes**
```elm
defaultImgAttributes : String -> String -> BodyBuilder.Attributes.ImgAttributes msg
```


- [defaultInputCheckboxAttributes](#defaultinputcheckboxattributes)

### **defaultInputCheckboxAttributes**
```elm
defaultInputCheckboxAttributes : BodyBuilder.Attributes.InputCheckboxAttributes msg
```


- [defaultInputColorAttributes](#defaultinputcolorattributes)

### **defaultInputColorAttributes**
```elm
defaultInputColorAttributes : BodyBuilder.Attributes.InputColorAttributes msg
```


- [defaultInputFileAttributes](#defaultinputfileattributes)

### **defaultInputFileAttributes**
```elm
defaultInputFileAttributes : BodyBuilder.Attributes.InputFileAttributes msg
```


- [defaultInputHiddenAttributes](#defaultinputhiddenattributes)

### **defaultInputHiddenAttributes**
```elm
defaultInputHiddenAttributes : BodyBuilder.Attributes.InputHiddenAttributes
```


- [defaultInputNumberAttributes](#defaultinputnumberattributes)

### **defaultInputNumberAttributes**
```elm
defaultInputNumberAttributes : BodyBuilder.Attributes.InputNumberAttributes msg
```


- [defaultInputPasswordAttributes](#defaultinputpasswordattributes)

### **defaultInputPasswordAttributes**
```elm
defaultInputPasswordAttributes : BodyBuilder.Attributes.InputPasswordAttributes msg
```


- [defaultInputRadioAttributes](#defaultinputradioattributes)

### **defaultInputRadioAttributes**
```elm
defaultInputRadioAttributes : BodyBuilder.Attributes.InputRadioAttributes msg
```


- [defaultInputRangeAttributes](#defaultinputrangeattributes)

### **defaultInputRangeAttributes**
```elm
defaultInputRangeAttributes : BodyBuilder.Attributes.InputRangeAttributes msg
```


- [defaultInputSubmitAttributes](#defaultinputsubmitattributes)

### **defaultInputSubmitAttributes**
```elm
defaultInputSubmitAttributes : BodyBuilder.Attributes.InputSubmitAttributes msg
```


- [defaultInputTextAttributes](#defaultinputtextattributes)

### **defaultInputTextAttributes**
```elm
defaultInputTextAttributes : BodyBuilder.Attributes.InputTextAttributes msg
```


- [defaultInputUrlAttributes](#defaultinputurlattributes)

### **defaultInputUrlAttributes**
```elm
defaultInputUrlAttributes : BodyBuilder.Attributes.InputUrlAttributes msg
```


- [defaultNodeAttributes](#defaultnodeattributes)

### **defaultNodeAttributes**
```elm
defaultNodeAttributes : BodyBuilder.Attributes.NodeAttributes msg
```


- [defaultProgressAttributes](#defaultprogressattributes)

### **defaultProgressAttributes**
```elm
defaultProgressAttributes : BodyBuilder.Attributes.ProgressAttributes msg
```


- [defaultScriptAttributes](#defaultscriptattributes)

### **defaultScriptAttributes**
```elm
defaultScriptAttributes : BodyBuilder.Attributes.ScriptAttributes msg
```


- [defaultSelectAttributes](#defaultselectattributes)

### **defaultSelectAttributes**
```elm
defaultSelectAttributes : BodyBuilder.Attributes.SelectAttributes msg
```


- [defaultStyleSelector](#defaultstyleselector)

### **defaultStyleSelector**
```elm
defaultStyleSelector : BodyBuilder.Attributes.StyleSelector
```


- [defaultTextareaAttributes](#defaulttextareaattributes)

### **defaultTextareaAttributes**
```elm
defaultTextareaAttributes : BodyBuilder.Attributes.TextareaAttributes msg
```


- [defaultUniversalAttributes](#defaultuniversalattributes)

### **defaultUniversalAttributes**
```elm
defaultUniversalAttributes : BodyBuilder.Attributes.UniversalAttributes
```


- [disabled](#disabled)

### **disabled**
```elm
disabled : Helpers.Shared.Modifier (BodyBuilder.Attributes.DisabledAttribute a)
```


- [DisabledAttribute](#disabledattribute)

### **type alias DisabledAttribute**
```elm
type alias DisabledAttribute a =  
    { a | disabled : Bool }
```


- [disabledAttributeToHtmlAttributes](#disabledattributetohtmlattributes)

### **disabledAttributeToHtmlAttributes**
```elm
disabledAttributeToHtmlAttributes : Bool -> List (Html.Attribute msg)
```


- [FlexContainerAttributes](#flexcontainerattributes)

### **type alias FlexContainerAttributes**
```elm
type alias FlexContainerAttributes msg =  
    { flexContainerProperties : List ( Helpers.Shared.Modifiers Flex.FlexContainerDetails , BodyBuilder.Attributes.StyleSelector ) , onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) , onEvent : Maybe ( String, Json.Decode.Decoder msg ) , onBlurEvent : Maybe msg , onFocusEvent : Maybe msg , box : List ( Helpers.Shared.Modifiers Box , BodyBuilder.Attributes.StyleSelector ) , universal : BodyBuilder.Attributes.UniversalAttributes , block : Maybe (List ( Helpers.Shared.Modifiers Display.BlockDetails , BodyBuilder.Attributes.StyleSelector )) , rawStyle : Maybe Elegant.Style }
```


- [flexContainerAttributesToHtmlAttributes](#flexcontainerattributestohtmlattributes)

### **flexContainerAttributesToHtmlAttributes**
```elm
flexContainerAttributesToHtmlAttributes : BodyBuilder.Attributes.FlexContainerAttributes msg -> List (Html.Attribute msg)
```


- [FlexContainerProperties](#flexcontainerproperties)

### **type alias FlexContainerProperties**
```elm
type alias FlexContainerProperties a =  
    { a | flexContainerProperties : List ( Helpers.Shared.Modifiers Flex.FlexContainerDetails , BodyBuilder.Attributes.StyleSelector ) }
```


- [FlexItemAttributes](#flexitemattributes)

### **type alias FlexItemAttributes**
```elm
type alias FlexItemAttributes msg =  
    { flexItemProperties : List ( Helpers.Shared.Modifiers Flex.FlexItemDetails , BodyBuilder.Attributes.StyleSelector ) , onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) , onEvent : Maybe ( String, Json.Decode.Decoder msg ) , onBlurEvent : Maybe msg , onFocusEvent : Maybe msg , box : List ( Helpers.Shared.Modifiers Box , BodyBuilder.Attributes.StyleSelector ) , universal : BodyBuilder.Attributes.UniversalAttributes , block : Maybe (List ( Helpers.Shared.Modifiers Display.BlockDetails , BodyBuilder.Attributes.StyleSelector )) , rawStyle : Maybe Elegant.Style }
```


- [flexItemAttributesToHtmlAttributes](#flexitemattributestohtmlattributes)

### **flexItemAttributesToHtmlAttributes**
```elm
flexItemAttributesToHtmlAttributes : BodyBuilder.Attributes.FlexItemAttributes msg -> List (Html.Attribute msg)
```


- [FlexItemProperties](#flexitemproperties)

### **type alias FlexItemProperties**
```elm
type alias FlexItemProperties a =  
    { a | flexItemProperties : List ( Helpers.Shared.Modifiers Flex.FlexItemDetails , BodyBuilder.Attributes.StyleSelector ) }
```


- [FlowAttributes](#flowattributes)

### **type alias FlowAttributes**
```elm
type alias FlowAttributes msg =  
    { onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) , onEvent : Maybe ( String, Json.Decode.Decoder msg ) , onBlurEvent : Maybe msg , onFocusEvent : Maybe msg , box : List ( Helpers.Shared.Modifiers Box , BodyBuilder.Attributes.StyleSelector ) , universal : BodyBuilder.Attributes.UniversalAttributes , rawStyle : Maybe Elegant.Style }
```


- [flowAttributesToHtmlAttributes](#flowattributestohtmlattributes)

### **flowAttributesToHtmlAttributes**
```elm
flowAttributesToHtmlAttributes : BodyBuilder.Attributes.FlowAttributes msg -> List (Html.Attribute msg)
```


- [GridContainerAttributes](#gridcontainerattributes)

### **type alias GridContainerAttributes**
```elm
type alias GridContainerAttributes msg =  
    { gridContainerProperties : List ( Helpers.Shared.Modifiers Grid.GridContainerDetails , BodyBuilder.Attributes.StyleSelector ) , onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) , onEvent : Maybe ( String, Json.Decode.Decoder msg ) , onBlurEvent : Maybe msg , onFocusEvent : Maybe msg , box : List ( Helpers.Shared.Modifiers Box , BodyBuilder.Attributes.StyleSelector ) , universal : BodyBuilder.Attributes.UniversalAttributes , block : Maybe (List ( Helpers.Shared.Modifiers Display.BlockDetails , BodyBuilder.Attributes.StyleSelector )) , rawStyle : Maybe Elegant.Style }
```


- [gridContainerAttributesToHtmlAttributes](#gridcontainerattributestohtmlattributes)

### **gridContainerAttributesToHtmlAttributes**
```elm
gridContainerAttributesToHtmlAttributes : BodyBuilder.Attributes.GridContainerAttributes msg -> List (Html.Attribute msg)
```


- [GridContainerProperties](#gridcontainerproperties)

### **type alias GridContainerProperties**
```elm
type alias GridContainerProperties a =  
    { a | gridContainerProperties : List ( Helpers.Shared.Modifiers Grid.GridContainerDetails , BodyBuilder.Attributes.StyleSelector ) }
```


- [GridItemAttributes](#griditemattributes)

### **type alias GridItemAttributes**
```elm
type alias GridItemAttributes msg =  
    { gridItemProperties : List ( Helpers.Shared.Modifiers Grid.GridItemDetails , BodyBuilder.Attributes.StyleSelector ) , onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) , onEvent : Maybe ( String, Json.Decode.Decoder msg ) , onBlurEvent : Maybe msg , onFocusEvent : Maybe msg , box : List ( Helpers.Shared.Modifiers Box , BodyBuilder.Attributes.StyleSelector ) , universal : BodyBuilder.Attributes.UniversalAttributes , block : Maybe (List ( Helpers.Shared.Modifiers Display.BlockDetails , BodyBuilder.Attributes.StyleSelector )) , rawStyle : Maybe Elegant.Style }
```


- [gridItemAttributesToHtmlAttributes](#griditemattributestohtmlattributes)

### **gridItemAttributesToHtmlAttributes**
```elm
gridItemAttributesToHtmlAttributes : BodyBuilder.Attributes.GridItemAttributes msg -> List (Html.Attribute msg)
```


- [GridItemProperties](#griditemproperties)

### **type alias GridItemProperties**
```elm
type alias GridItemProperties a =  
    { a | gridItemProperties : List ( Helpers.Shared.Modifiers Grid.GridItemDetails , BodyBuilder.Attributes.StyleSelector ) }
```


- [HeadingAttributes](#headingattributes)

### **type alias HeadingAttributes**
```elm
type alias HeadingAttributes msg =  
    BodyBuilder.Attributes.BlockAttributes msg
```


- [headingAttributesToHtmlAttributes](#headingattributestohtmlattributes)

### **headingAttributesToHtmlAttributes**
```elm
headingAttributesToHtmlAttributes : BodyBuilder.Attributes.HeadingAttributes msg -> List (Html.Attribute msg)
```


- [height](#height)

### **height**
```elm
height : a -> { c | height : b } -> { c | height : Maybe a }
```


- [href](#href)

### **href**
```elm
href : String -> Helpers.Shared.Modifier (BodyBuilder.Attributes.HrefAttribute a)
```


- [HrefAttribute](#hrefattribute)

### **type alias HrefAttribute**
```elm
type alias HrefAttribute a =  
    { a | href : Maybe String }
```


- [id](#id)

### **id**
```elm
id : String -> Helpers.Shared.Modifier { a | universal : BodyBuilder.Attributes.UniversalAttributes }
```


- [ImgAttributes](#imgattributes)

### **type alias ImgAttributes**
```elm
type alias ImgAttributes msg =  
    { onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) , onEvent : Maybe ( String, Json.Decode.Decoder msg ) , onBlurEvent : Maybe msg , onFocusEvent : Maybe msg , box : List ( Helpers.Shared.Modifiers Box , BodyBuilder.Attributes.StyleSelector ) , universal : BodyBuilder.Attributes.UniversalAttributes , src : String , alt : String , width : Maybe Int , height : Maybe Int , block : Maybe (List ( Helpers.Shared.Modifiers Display.BlockDetails , BodyBuilder.Attributes.StyleSelector )) , rawStyle : Maybe Elegant.Style }
```


- [imgAttributesToHtmlAttributes](#imgattributestohtmlattributes)

### **imgAttributesToHtmlAttributes**
```elm
imgAttributesToHtmlAttributes : BodyBuilder.Attributes.ImgAttributes msg -> List (Html.Attribute msg)
```


- [InputAttributes](#inputattributes)

### **type alias InputAttributes**
```elm
type alias InputAttributes a =  
    { a | type_ : String, name : Maybe String }
```


- [inputAttributesToHtmlAttributes](#inputattributestohtmlattributes)

### **inputAttributesToHtmlAttributes**
```elm
inputAttributesToHtmlAttributes : BodyBuilder.Attributes.InputAttributes a -> List (Html.Attribute msg)
```


- [InputCheckboxAttributes](#inputcheckboxattributes)

### **type alias InputCheckboxAttributes**
```elm
type alias InputCheckboxAttributes msg =  
    { name : Maybe String , type_ : String , universal : BodyBuilder.Attributes.UniversalAttributes , box : List ( Helpers.Shared.Modifiers Box , BodyBuilder.Attributes.StyleSelector ) , onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) , onEvent : Maybe ( String, Json.Decode.Decoder msg ) , onBlurEvent : Maybe msg , onFocusEvent : Maybe msg , value : Maybe String , label : Maybe (BodyBuilder.Shared.Label msg) , block : Maybe (List ( Helpers.Shared.Modifiers Display.BlockDetails , BodyBuilder.Attributes.StyleSelector )) , checked : Bool , onCheckEvent : Maybe (Bool -> msg) , rawStyle : Maybe Elegant.Style }
```


- [inputCheckboxAttributesToHtmlAttributes](#inputcheckboxattributestohtmlattributes)

### **inputCheckboxAttributesToHtmlAttributes**
```elm
inputCheckboxAttributesToHtmlAttributes : BodyBuilder.Attributes.InputCheckboxAttributes msg -> List (Html.Attribute msg)
```


- [InputColorAttributes](#inputcolorattributes)

### **type alias InputColorAttributes**
```elm
type alias InputColorAttributes msg =  
    { name : Maybe String , type_ : String , universal : BodyBuilder.Attributes.UniversalAttributes , box : List ( Helpers.Shared.Modifiers Box , BodyBuilder.Attributes.StyleSelector ) , onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) , onEvent : Maybe ( String, Json.Decode.Decoder msg ) , onBlurEvent : Maybe msg , onFocusEvent : Maybe msg , label : Maybe (BodyBuilder.Shared.Label msg) , rawStyle : Maybe Elegant.Style , value : Maybe Color , onInputEvent : Maybe (Color -> msg) , fromStringInput : String -> Color , block : Maybe (List ( Helpers.Shared.Modifiers Display.BlockDetails , BodyBuilder.Attributes.StyleSelector )) }
```


- [inputColorAttributesToHtmlAttributes](#inputcolorattributestohtmlattributes)

### **inputColorAttributesToHtmlAttributes**
```elm
inputColorAttributesToHtmlAttributes : BodyBuilder.Attributes.InputColorAttributes msg -> List (Html.Attribute msg)
```


- [InputFileAttributes](#inputfileattributes)

### **type alias InputFileAttributes**
```elm
type alias InputFileAttributes msg =  
    { name : Maybe String , type_ : String , universal : BodyBuilder.Attributes.UniversalAttributes , box : List ( Helpers.Shared.Modifiers Box , BodyBuilder.Attributes.StyleSelector ) , onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) , onEvent : Maybe ( String, Json.Decode.Decoder msg ) , onBlurEvent : Maybe msg , onFocusEvent : Maybe msg , label : Maybe (BodyBuilder.Shared.Label msg) , rawStyle : Maybe Elegant.Style , block : Maybe (List ( Helpers.Shared.Modifiers Display.BlockDetails , BodyBuilder.Attributes.StyleSelector )) }
```


- [inputFileAttributesToHtmlAttributes](#inputfileattributestohtmlattributes)

### **inputFileAttributesToHtmlAttributes**
```elm
inputFileAttributesToHtmlAttributes : BodyBuilder.Attributes.InputFileAttributes msg -> List (Html.Attribute msg)
```


- [InputHiddenAttributes](#inputhiddenattributes)

### **type alias InputHiddenAttributes**
```elm
type alias InputHiddenAttributes  =  
    { name : Maybe String , type_ : String , value : Maybe String , universal : BodyBuilder.Attributes.UniversalAttributes }
```


- [inputHiddenAttributesToHtmlAttributes](#inputhiddenattributestohtmlattributes)

### **inputHiddenAttributesToHtmlAttributes**
```elm
inputHiddenAttributesToHtmlAttributes : BodyBuilder.Attributes.InputHiddenAttributes -> List (Html.Attribute msg)
```


- [InputNumberAttributes](#inputnumberattributes)

### **type alias InputNumberAttributes**
```elm
type alias InputNumberAttributes msg =  
    { name : Maybe String , type_ : String , universal : BodyBuilder.Attributes.UniversalAttributes , box : List ( Helpers.Shared.Modifiers Box , BodyBuilder.Attributes.StyleSelector ) , onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) , onEvent : Maybe ( String, Json.Decode.Decoder msg ) , onBlurEvent : Maybe msg , onFocusEvent : Maybe msg , label : Maybe (BodyBuilder.Shared.Label msg) , rawStyle : Maybe Elegant.Style , value : Maybe Int , onInputEvent : Maybe (Int -> msg) , fromStringInput : String -> Int , step : Maybe Int , max : Maybe Int , min : Maybe Int , block : Maybe (List ( Helpers.Shared.Modifiers Display.BlockDetails , BodyBuilder.Attributes.StyleSelector )) , disabled : Bool }
```


- [inputNumberAttributesToHtmlAttributes](#inputnumberattributestohtmlattributes)

### **inputNumberAttributesToHtmlAttributes**
```elm
inputNumberAttributesToHtmlAttributes : BodyBuilder.Attributes.InputNumberAttributes msg -> List (Html.Attribute msg)
```


- [InputPasswordAttributes](#inputpasswordattributes)

### **type alias InputPasswordAttributes**
```elm
type alias InputPasswordAttributes msg =  
    BodyBuilder.Attributes.InputTextAttributes msg
```


- [inputPasswordAttributesToHtmlAttributes](#inputpasswordattributestohtmlattributes)

### **inputPasswordAttributesToHtmlAttributes**
```elm
inputPasswordAttributesToHtmlAttributes : BodyBuilder.Attributes.InputPasswordAttributes msg -> List (Html.Attribute msg)
```


- [InputRadioAttributes](#inputradioattributes)

### **type alias InputRadioAttributes**
```elm
type alias InputRadioAttributes msg =  
    { name : Maybe String , type_ : String , universal : BodyBuilder.Attributes.UniversalAttributes , box : List ( Helpers.Shared.Modifiers Box , BodyBuilder.Attributes.StyleSelector ) , onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) , onEvent : Maybe ( String, Json.Decode.Decoder msg ) , onBlurEvent : Maybe msg , onFocusEvent : Maybe msg , value : Maybe String , block : Maybe (List ( Helpers.Shared.Modifiers Display.BlockDetails , BodyBuilder.Attributes.StyleSelector )) , label : Maybe (BodyBuilder.Shared.Label msg) , rawStyle : Maybe Elegant.Style }
```

InputStringValueAttributes msg {}
- [inputRadioAttributesToHtmlAttributes](#inputradioattributestohtmlattributes)

### **inputRadioAttributesToHtmlAttributes**
```elm
inputRadioAttributesToHtmlAttributes : BodyBuilder.Attributes.InputRadioAttributes msg -> List (Html.Attribute msg)
```


- [InputRangeAttributes](#inputrangeattributes)

### **type alias InputRangeAttributes**
```elm
type alias InputRangeAttributes msg =  
    BodyBuilder.Attributes.InputNumberAttributes msg
```


- [inputRangeAttributesToHtmlAttributes](#inputrangeattributestohtmlattributes)

### **inputRangeAttributesToHtmlAttributes**
```elm
inputRangeAttributesToHtmlAttributes : BodyBuilder.Attributes.InputRangeAttributes msg -> List (Html.Attribute msg)
```


- [InputSubmitAttributes](#inputsubmitattributes)

### **type alias InputSubmitAttributes**
```elm
type alias InputSubmitAttributes msg =  
    { label : Maybe (BodyBuilder.Shared.Label msg) , type_ : String , disabled : Bool , block : Maybe (List ( Helpers.Shared.Modifiers Display.BlockDetails , BodyBuilder.Attributes.StyleSelector )) , onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) , onEvent : Maybe ( String, Json.Decode.Decoder msg ) , onBlurEvent : Maybe msg , onFocusEvent : Maybe msg , onSubmitEvent : Maybe msg , box : List ( Helpers.Shared.Modifiers Box , BodyBuilder.Attributes.StyleSelector ) , universal : BodyBuilder.Attributes.UniversalAttributes , rawStyle : Maybe Elegant.Style }
```


- [inputSubmitAttributesToHtmlAttributes](#inputsubmitattributestohtmlattributes)

### **inputSubmitAttributesToHtmlAttributes**
```elm
inputSubmitAttributesToHtmlAttributes : BodyBuilder.Attributes.InputSubmitAttributes msg -> List (Html.Attribute msg)
```


- [InputTextAttributes](#inputtextattributes)

### **type alias InputTextAttributes**
```elm
type alias InputTextAttributes msg =  
    { name : Maybe String , type_ : String , universal : BodyBuilder.Attributes.UniversalAttributes , box : List ( Helpers.Shared.Modifiers Box , BodyBuilder.Attributes.StyleSelector ) , onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) , onEvent : Maybe ( String, Json.Decode.Decoder msg ) , onBlurEvent : Maybe msg , onFocusEvent : Maybe msg , value : Maybe String , label : Maybe (BodyBuilder.Shared.Label msg) , placeholder : Maybe String , autocomplete : Bool , onInputEvent : Maybe (String -> msg) , fromStringInput : String -> String , block : Maybe (List ( Helpers.Shared.Modifiers Display.BlockDetails , BodyBuilder.Attributes.StyleSelector )) , rawStyle : Maybe Elegant.Style }
```


- [inputTextAttributesToHtmlAttributes](#inputtextattributestohtmlattributes)

### **inputTextAttributesToHtmlAttributes**
```elm
inputTextAttributesToHtmlAttributes : BodyBuilder.Attributes.InputTextAttributes msg -> List (Html.Attribute msg)
```


- [InputUrlAttributes](#inputurlattributes)

### **type alias InputUrlAttributes**
```elm
type alias InputUrlAttributes msg =  
    BodyBuilder.Attributes.InputTextAttributes msg
```


- [inputUrlAttributesToHtmlAttributes](#inputurlattributestohtmlattributes)

### **inputUrlAttributesToHtmlAttributes**
```elm
inputUrlAttributesToHtmlAttributes : BodyBuilder.Attributes.InputUrlAttributes msg -> List (Html.Attribute msg)
```


- [inputVisibleToHtmlAttributes](#inputvisibletohtmlattributes)

### **inputVisibleToHtmlAttributes**
```elm
inputVisibleToHtmlAttributes : BodyBuilder.Attributes.VisibleAttributesAndEvents msg { a | name : Maybe String, type_ : String } -> List (Html.Attribute msg)
```


- [IntValue](#intvalue)

### **type alias IntValue**
```elm
type alias IntValue a =  
    BodyBuilder.Attributes.ValueAttribute Int a
```


- [label](#label)

### **label**
```elm
label : List (Html msg) -> { c | label : Maybe (BodyBuilder.Shared.Label msg) } -> { c | label : Maybe (BodyBuilder.Shared.Label msg) }
```


- [LabelAttributes](#labelattributes)

### **type alias LabelAttributes**
```elm
type alias LabelAttributes msg =  
    { onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) , onEvent : Maybe ( String, Json.Decode.Decoder msg ) , onBlurEvent : Maybe msg , onFocusEvent : Maybe msg , box : List ( Helpers.Shared.Modifiers Box , BodyBuilder.Attributes.StyleSelector ) , universal : BodyBuilder.Attributes.UniversalAttributes , position : BodyBuilder.Attributes.Position , block : Maybe (List ( Helpers.Shared.Modifiers Display.BlockDetails , BodyBuilder.Attributes.StyleSelector )) , rawStyle : Maybe Elegant.Style }
```


- [max](#max)

### **max**
```elm
max : Int -> Helpers.Shared.Modifier (BodyBuilder.Attributes.MaxAttribute a)
```


- [MaxAttribute](#maxattribute)

### **type alias MaxAttribute**
```elm
type alias MaxAttribute a =  
    { a | max : Maybe Int }
```


- [MaybeBlockContainer](#maybeblockcontainer)

### **type alias MaybeBlockContainer**
```elm
type alias MaybeBlockContainer a =  
    { a | block : Maybe (List ( Helpers.Shared.Modifiers Display.BlockDetails , BodyBuilder.Attributes.StyleSelector )) }
```


- [MediaQuery](#mediaquery)

### **type MediaQuery**
```elm
type MediaQuery   
    = Greater Int  
    | Lesser Int  
    | Between Int Int
```


- [min](#min)

### **min**
```elm
min : Int -> Helpers.Shared.Modifier (BodyBuilder.Attributes.MinAttribute a)
```


- [MinAttribute](#minattribute)

### **type alias MinAttribute**
```elm
type alias MinAttribute a =  
    { a | min : Maybe Int }
```


- [name](#name)

### **name**
```elm
name : String -> Helpers.Shared.Modifier (BodyBuilder.Attributes.NameAttribute a)
```


- [NameAttribute](#nameattribute)

### **type alias NameAttribute**
```elm
type alias NameAttribute a =  
    { a | name : Maybe String }
```


- [NodeAttributes](#nodeattributes)

### **type alias NodeAttributes**
```elm
type alias NodeAttributes msg =  
    { onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) , onEvent : Maybe ( String, Json.Decode.Decoder msg ) , onBlurEvent : Maybe msg , onFocusEvent : Maybe msg , box : List ( Helpers.Shared.Modifiers Box , BodyBuilder.Attributes.StyleSelector ) , universal : BodyBuilder.Attributes.UniversalAttributes , block : Maybe (List ( Helpers.Shared.Modifiers Display.BlockDetails , BodyBuilder.Attributes.StyleSelector )) , rawStyle : Maybe Elegant.Style }
```

Computed : MaybeBlockContainer (FlowAttributes msg)
- [nodeAttributesToHtmlAttributes](#nodeattributestohtmlattributes)

### **nodeAttributesToHtmlAttributes**
```elm
nodeAttributesToHtmlAttributes : BodyBuilder.Attributes.NodeAttributes msg -> List (Html.Attribute msg)
```


- [placeholder](#placeholder)

### **placeholder**
```elm
placeholder : a -> { c | placeholder : b } -> { c | placeholder : Maybe a }
```


- [PlaceholderAttribute](#placeholderattribute)

### **type alias PlaceholderAttribute**
```elm
type alias PlaceholderAttribute a =  
    { a | placeholder : Maybe String }
```


- [Position](#position)

### **type Position**
```elm
type Position   
    = Before   
    | After 
```


- [PositionAttribute](#positionattribute)

### **type alias PositionAttribute**
```elm
type alias PositionAttribute a =  
    { a | position : BodyBuilder.Attributes.Position }
```


- [ProgressAttributes](#progressattributes)

### **type alias ProgressAttributes**
```elm
type alias ProgressAttributes msg =  
    { onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) , onEvent : Maybe ( String, Json.Decode.Decoder msg ) , onBlurEvent : Maybe msg , onFocusEvent : Maybe msg , box : List ( Helpers.Shared.Modifiers Box , BodyBuilder.Attributes.StyleSelector ) , universal : BodyBuilder.Attributes.UniversalAttributes , block : Maybe (List ( Helpers.Shared.Modifiers Display.BlockDetails , BodyBuilder.Attributes.StyleSelector )) , rawStyle : Maybe Elegant.Style }
```


- [progressAttributesToHtmlAttributes](#progressattributestohtmlattributes)

### **progressAttributesToHtmlAttributes**
```elm
progressAttributesToHtmlAttributes : BodyBuilder.Attributes.ProgressAttributes msg -> List (Html.Attribute msg)
```


- [rawStyle](#rawstyle)

### **rawStyle**
```elm
rawStyle : a -> { c | rawStyle : b } -> { c | rawStyle : Maybe a }
```


- [rawStyleToHtmlAttributes](#rawstyletohtmlattributes)

### **rawStyleToHtmlAttributes**
```elm
rawStyleToHtmlAttributes : Elegant.Style -> List (Html.Attribute msg)
```


- [ScriptAttributes](#scriptattributes)

### **type alias ScriptAttributes**
```elm
type alias ScriptAttributes msg =  
    { onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) , onEvent : Maybe ( String, Json.Decode.Decoder msg ) , onBlurEvent : Maybe msg , onFocusEvent : Maybe msg , box : List ( Helpers.Shared.Modifiers Box , BodyBuilder.Attributes.StyleSelector ) , universal : BodyBuilder.Attributes.UniversalAttributes , src : String , data : List ( String, String ) , rawStyle : Maybe Elegant.Style }
```


- [scriptAttributesToHtmlAttributes](#scriptattributestohtmlattributes)

### **scriptAttributesToHtmlAttributes**
```elm
scriptAttributesToHtmlAttributes : BodyBuilder.Attributes.ScriptAttributes msg -> List (Html.Attribute msg)
```


- [SelectAttributes](#selectattributes)

### **type alias SelectAttributes**
```elm
type alias SelectAttributes msg =  
    { block : Maybe (List ( Helpers.Shared.Modifiers Display.BlockDetails , BodyBuilder.Attributes.StyleSelector )) , value : Maybe String , onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) , onEvent : Maybe ( String, Json.Decode.Decoder msg ) , onBlurEvent : Maybe msg , onFocusEvent : Maybe msg , box : List ( Helpers.Shared.Modifiers Box , BodyBuilder.Attributes.StyleSelector ) , universal : BodyBuilder.Attributes.UniversalAttributes , rawStyle : Maybe Elegant.Style , onInputEvent : Maybe (String -> msg) , fromStringInput : String -> String }
```

Computed : -- MaybeBlockContainer (StringValue (FlowAttributes msg))
- [selectAttributesToHtmlAttributes](#selectattributestohtmlattributes)

### **selectAttributesToHtmlAttributes**
```elm
selectAttributesToHtmlAttributes : BodyBuilder.Attributes.SelectAttributes msg -> List (Html.Attribute msg)
```


- [setClass](#setclass)

### **setClass**
```elm
setClass : List String -> { a | class : List String } -> { a | class : List String }
```


- [setId](#setid)

### **setId**
```elm
setId : String -> { a | id : Maybe String } -> { a | id : Maybe String }
```


- [setTabIndex](#settabindex)

### **setTabIndex**
```elm
setTabIndex : Int -> { a | tabindex : Maybe Int } -> { a | tabindex : Maybe Int }
```


- [setTitle](#settitle)

### **setTitle**
```elm
setTitle : String -> { a | title : Maybe String } -> { a | title : Maybe String }
```


- [setUniversal](#setuniversal)

### **setUniversal**
```elm
setUniversal : BodyBuilder.Attributes.UniversalAttributes -> { a | universal : BodyBuilder.Attributes.UniversalAttributes } -> { a | universal : BodyBuilder.Attributes.UniversalAttributes }
```


- [setUniversalIn](#setuniversalin)

### **setUniversalIn**
```elm
setUniversalIn : { a | universal : BodyBuilder.Attributes.UniversalAttributes } -> BodyBuilder.Attributes.UniversalAttributes -> { a | universal : BodyBuilder.Attributes.UniversalAttributes }
```


- [setValueInUniversal](#setvalueinuniversal)

### **setValueInUniversal**
```elm
setValueInUniversal : (a -> BodyBuilder.Attributes.UniversalAttributes -> BodyBuilder.Attributes.UniversalAttributes) -> a -> { c | universal : BodyBuilder.Attributes.UniversalAttributes } -> { c | universal : BodyBuilder.Attributes.UniversalAttributes }
```


- [step](#step)

### **step**
```elm
step : Int -> Helpers.Shared.Modifier (BodyBuilder.Attributes.StepAttribute a)
```


- [StepAttribute](#stepattribute)

### **type alias StepAttribute**
```elm
type alias StepAttribute a =  
    { a | step : Maybe Int }
```


- [StringValue](#stringvalue)

### **type alias StringValue**
```elm
type alias StringValue a =  
    BodyBuilder.Attributes.ValueAttribute String a
```


- [style](#style)

### **style**
```elm
style : List (BodyBuilder.Attributes.StyleModifier a) -> Helpers.Shared.Modifier a
```


- [StyleModifier](#stylemodifier)

### **type alias StyleModifier**
```elm
type alias StyleModifier a =  
    BodyBuilder.Attributes.StyleSelector -> Helpers.Shared.Modifier a
```


- [StyleSelector](#styleselector)

### **type alias StyleSelector**
```elm
type alias StyleSelector  =  
    { media : Maybe BodyBuilder.Attributes.MediaQuery , pseudoClass : Maybe String }
```


- [tabindex](#tabindex)

### **tabindex**
```elm
tabindex : Int -> Helpers.Shared.Modifier { a | universal : BodyBuilder.Attributes.UniversalAttributes }
```


- [target](#target)

### **target**
```elm
target : String -> Helpers.Shared.Modifier (BodyBuilder.Attributes.TargetAttribute a)
```


- [TargetAttribute](#targetattribute)

### **type alias TargetAttribute**
```elm
type alias TargetAttribute a =  
    { a | target : Maybe String }
```


- [TextareaAttributes](#textareaattributes)

### **type alias TextareaAttributes**
```elm
type alias TextareaAttributes msg =  
    { onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) , onEvent : Maybe ( String, Json.Decode.Decoder msg ) , onBlurEvent : Maybe msg , onFocusEvent : Maybe msg , box : List ( Helpers.Shared.Modifiers Box , BodyBuilder.Attributes.StyleSelector ) , universal : BodyBuilder.Attributes.UniversalAttributes , value : Maybe String , onInputEvent : Maybe (String -> msg) , fromStringInput : String -> String , name : Maybe String , block : Maybe (List ( Helpers.Shared.Modifiers Display.BlockDetails , BodyBuilder.Attributes.StyleSelector )) , rawStyle : Maybe Elegant.Style }
```


- [textareaAttributesToHtmlAttributes](#textareaattributestohtmlattributes)

### **textareaAttributesToHtmlAttributes**
```elm
textareaAttributesToHtmlAttributes : BodyBuilder.Attributes.TextareaAttributes msg -> List (Html.Attribute msg)
```


- [title](#title)

### **title**
```elm
title : String -> Helpers.Shared.Modifier { a | universal : BodyBuilder.Attributes.UniversalAttributes }
```


- [TypeContainer](#typecontainer)

### **type alias TypeContainer**
```elm
type alias TypeContainer a =  
    { a | type_ : String }
```


- [UniversalAttributes](#universalattributes)

### **type alias UniversalAttributes**
```elm
type alias UniversalAttributes  =  
    { title : Maybe String , tabindex : Maybe Int , id : Maybe String , class : List String }
```

TitleAttribute (TabindexAttribute (IdAttribute (ClassAttribute {})))
- [universalAttributesToHtmlAttributes](#universalattributestohtmlattributes)

### **universalAttributesToHtmlAttributes**
```elm
universalAttributesToHtmlAttributes : BodyBuilder.Attributes.UniversalAttributes -> List (Html.Attribute msg)
```


- [UniversalContainer](#universalcontainer)

### **type alias UniversalContainer**
```elm
type alias UniversalContainer a =  
    { a | universal : BodyBuilder.Attributes.UniversalAttributes }
```


- [value](#value)

### **value**
```elm
value : a -> { c | value : b } -> { c | value : Maybe a }
```


- [ValueAttribute](#valueattribute)

### **type alias ValueAttribute**
```elm
type alias ValueAttribute b a =  
    { a | value : Maybe b }
```


- [VisibleAttributes](#visibleattributes)

### **type alias VisibleAttributes**
```elm
type alias VisibleAttributes a =  
    { a | box : List ( Helpers.Shared.Modifiers Box , BodyBuilder.Attributes.StyleSelector ), universal : BodyBuilder.Attributes.UniversalAttributes, rawStyle : Maybe Elegant.Style }
```

Computed : BoxContainer (UniversalContainer a)
- [VisibleAttributesAndEvents](#visibleattributesandevents)

### **type alias VisibleAttributesAndEvents**
```elm
type alias VisibleAttributesAndEvents msg a =  
    { a | onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg), onEvent : Maybe ( String, Json.Decode.Decoder msg ), onBlurEvent : Maybe msg, onFocusEvent : Maybe msg, box : List ( Helpers.Shared.Modifiers Box , BodyBuilder.Attributes.StyleSelector ), universal : BodyBuilder.Attributes.UniversalAttributes, rawStyle : Maybe Elegant.Style }
```

OnEvent msg (OnFocusEvent msg (OnBlurEvent msg (OnMouseEvents msg (VisibleAttributes a))))
- [visibleAttributesToHtmlAttributes](#visibleattributestohtmlattributes)

### **visibleAttributesToHtmlAttributes**
```elm
visibleAttributesToHtmlAttributes : BodyBuilder.Attributes.VisibleAttributesAndEvents msg a -> List (Html.Attribute msg)
```


- [width](#width)

### **width**
```elm
width : Int -> Helpers.Shared.Modifier (BodyBuilder.Attributes.WidthAttribute a)
```


- [WidthAttribute](#widthattribute)

### **type alias WidthAttribute**
```elm
type alias WidthAttribute a =  
    { a | width : Maybe Int }
```



