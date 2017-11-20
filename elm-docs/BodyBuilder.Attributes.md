# BodyBuilder.Attributes

This module entirely replaces Html.Attributes, providing a type-safer alternatives.
This is designed to work with BodyBuilder.
It is not compatible with Html.Attributes, though.

- [StyleSelector](#styleselector)
- [defaultStyleSelector](#defaultstyleselector)

### **type alias StyleSelector**
```elm
type alias StyleSelector  =  
    { media : Maybe BodyBuilder.Attributes.MediaQuery , pseudoClass : Maybe String }
```



---

### **defaultStyleSelector**
```elm
defaultStyleSelector : BodyBuilder.Attributes.StyleSelector
```


- [MediaQuery](#mediaquery)

### **type MediaQuery**
```elm
type MediaQuery   
    = Greater Int  
    | Lesser Int  
    | Between Int Int
```


- [StyleModifier](#stylemodifier)
- [style](#style)
- [rawStyle](#rawstyle)

### **type alias StyleModifier**
```elm
type alias StyleModifier a =  
    BodyBuilder.Attributes.StyleSelector -> Helpers.Shared.Modifier a
```



---

### **style**
```elm
style : List (BodyBuilder.Attributes.StyleModifier a) -> Helpers.Shared.Modifier a
```



---

### **rawStyle**
```elm
rawStyle : a -> { c | rawStyle : b } -> { c | rawStyle : Maybe a }
```


- [AutocompleteAttribute](#autocompleteattribute)
- [WidthAttribute](#widthattribute)

### **type alias AutocompleteAttribute**
```elm
type alias AutocompleteAttribute a =  
    { a | autocomplete : Bool }
```



---

### **type alias WidthAttribute**
```elm
type alias WidthAttribute a =  
    { a | width : Maybe Int }
```


- [HeightAttribute](#heightattribute)

### **type alias HeightAttribute**
```elm
type alias HeightAttribute a =  
    { a | height : Maybe Int }
```


- [ValueAttribute](#valueattribute)

### **type alias ValueAttribute**
```elm
type alias ValueAttribute b a =  
    { a | value : Maybe b }
```


- [StepAttribute](#stepattribute)

### **type alias StepAttribute**
```elm
type alias StepAttribute a =  
    { a | step : Maybe Int }
```


- [MaxAttribute](#maxattribute)

### **type alias MaxAttribute**
```elm
type alias MaxAttribute a =  
    { a | max : Maybe Int }
```


- [MinAttribute](#minattribute)

### **type alias MinAttribute**
```elm
type alias MinAttribute a =  
    { a | min : Maybe Int }
```


- [TargetAttribute](#targetattribute)

### **type alias TargetAttribute**
```elm
type alias TargetAttribute a =  
    { a | target : Maybe String }
```


- [HrefAttribute](#hrefattribute)

### **type alias HrefAttribute**
```elm
type alias HrefAttribute a =  
    { a | href : Maybe String }
```


- [NameAttribute](#nameattribute)

### **type alias NameAttribute**
```elm
type alias NameAttribute a =  
    { a | name : Maybe String }
```


- [DisabledAttribute](#disabledattribute)

### **type alias DisabledAttribute**
```elm
type alias DisabledAttribute a =  
    { a | disabled : Bool }
```


- [PlaceholderAttribute](#placeholderattribute)

### **type alias PlaceholderAttribute**
```elm
type alias PlaceholderAttribute a =  
    { a | placeholder : Maybe String }
```


- [DataAttribute](#dataattribute)
- [data](#data)

### **type alias DataAttribute**
```elm
type alias DataAttribute a =  
    { a | data : List ( String, String ) }
```



---

### **data**
```elm
data : a -> { c | data : b } -> { c | data : a }
```


- [TypeContainer](#typecontainer)

### **type alias TypeContainer**
```elm
type alias TypeContainer a =  
    { a | type_ : String }
```


- [BoxContainer](#boxcontainer)

### **type alias BoxContainer**
```elm
type alias BoxContainer a =  
    { a | box : List ( Helpers.Shared.Modifiers Box , BodyBuilder.Attributes.StyleSelector ) }
```


- [CheckedContainer](#checkedcontainer)

### **type alias CheckedContainer**
```elm
type alias CheckedContainer a =  
    { a | checked : Bool }
```


- [UniversalContainer](#universalcontainer)
- [title](#title)
- [id](#id)
- [class](#class)
- [tabindex](#tabindex)

### **type alias UniversalContainer**
```elm
type alias UniversalContainer a =  
    { a | universal : BodyBuilder.Attributes.UniversalAttributes }
```



---

### **title**
```elm
title : String -> Helpers.Shared.Modifier { a | universal : BodyBuilder.Attributes.UniversalAttributes }
```



---

### **id**
```elm
id : String -> Helpers.Shared.Modifier { a | universal : BodyBuilder.Attributes.UniversalAttributes }
```



---

### **class**
```elm
class : List String -> Helpers.Shared.Modifier { a | universal : BodyBuilder.Attributes.UniversalAttributes }
```



---

### **tabindex**
```elm
tabindex : Int -> Helpers.Shared.Modifier { a | universal : BodyBuilder.Attributes.UniversalAttributes }
```


- [MaybeBlockContainer](#maybeblockcontainer)

### **type alias MaybeBlockContainer**
```elm
type alias MaybeBlockContainer a =  
    { a | block : Maybe (List ( Helpers.Shared.Modifiers Display.BlockDetails , BodyBuilder.Attributes.StyleSelector )) }
```


- [BlockContainer](#blockcontainer)

### **type alias BlockContainer**
```elm
type alias BlockContainer a =  
    { a | block : List ( Helpers.Shared.Modifiers Display.BlockDetails , BodyBuilder.Attributes.StyleSelector ) }
```


- [FlexContainerProperties](#flexcontainerproperties)

### **type alias FlexContainerProperties**
```elm
type alias FlexContainerProperties a =  
    { a | flexContainerProperties : List ( Helpers.Shared.Modifiers Flex.FlexContainerDetails , BodyBuilder.Attributes.StyleSelector ) }
```


- [FlexItemProperties](#flexitemproperties)

### **type alias FlexItemProperties**
```elm
type alias FlexItemProperties a =  
    { a | flexItemProperties : List ( Helpers.Shared.Modifiers Flex.FlexItemDetails , BodyBuilder.Attributes.StyleSelector ) }
```


- [GridContainerProperties](#gridcontainerproperties)

### **type alias GridContainerProperties**
```elm
type alias GridContainerProperties a =  
    { a | gridContainerProperties : List ( Helpers.Shared.Modifiers Grid.GridContainerDetails , BodyBuilder.Attributes.StyleSelector ) }
```


- [GridItemProperties](#griditemproperties)

### **type alias GridItemProperties**
```elm
type alias GridItemProperties a =  
    { a | gridItemProperties : List ( Helpers.Shared.Modifiers Grid.GridItemDetails , BodyBuilder.Attributes.StyleSelector ) }
```


- [VisibleAttributes](#visibleattributes)
- [visibleAttributesToHtmlAttributes](#visibleattributestohtmlattributes)
- [rawStyleToHtmlAttributes](#rawstyletohtmlattributes)

### **type alias VisibleAttributes**
```elm
type alias VisibleAttributes a =  
    { a | box : List ( Helpers.Shared.Modifiers Box , BodyBuilder.Attributes.StyleSelector ), universal : BodyBuilder.Attributes.UniversalAttributes, rawStyle : Maybe Elegant.Style }
```

Computed : BoxContainer (UniversalContainer a)

---

### **visibleAttributesToHtmlAttributes**
```elm
visibleAttributesToHtmlAttributes : BodyBuilder.Attributes.VisibleAttributesAndEvents msg a -> List (Html.Attribute msg)
```



---

### **rawStyleToHtmlAttributes**
```elm
rawStyleToHtmlAttributes : Elegant.Style -> List (Html.Attribute msg)
```


- [VisibleAttributesAndEvents](#visibleattributesandevents)

### **type alias VisibleAttributesAndEvents**
```elm
type alias VisibleAttributesAndEvents msg a =  
    { a | onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg), onEvent : Maybe ( String, Json.Decode.Decoder msg ), onBlurEvent : Maybe msg, onFocusEvent : Maybe msg, box : List ( Helpers.Shared.Modifiers Box , BodyBuilder.Attributes.StyleSelector ), universal : BodyBuilder.Attributes.UniversalAttributes, rawStyle : Maybe Elegant.Style }
```

OnEvent msg (OnFocusEvent msg (OnBlurEvent msg (OnMouseEvents msg (VisibleAttributes a))))
- [UniversalAttributes](#universalattributes)
- [defaultUniversalAttributes](#defaultuniversalattributes)
- [universalAttributesToHtmlAttributes](#universalattributestohtmlattributes)

### **type alias UniversalAttributes**
```elm
type alias UniversalAttributes  =  
    { title : Maybe String , tabindex : Maybe Int , id : Maybe String , class : List String }
```

TitleAttribute (TabindexAttribute (IdAttribute (ClassAttribute {})))

---

### **defaultUniversalAttributes**
```elm
defaultUniversalAttributes : BodyBuilder.Attributes.UniversalAttributes
```



---

### **universalAttributesToHtmlAttributes**
```elm
universalAttributesToHtmlAttributes : BodyBuilder.Attributes.UniversalAttributes -> List (Html.Attribute msg)
```


- [NodeAttributes](#nodeattributes)
- [defaultNodeAttributes](#defaultnodeattributes)
- [nodeAttributesToHtmlAttributes](#nodeattributestohtmlattributes)

### **type alias NodeAttributes**
```elm
type alias NodeAttributes msg =  
    { onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) , onEvent : Maybe ( String, Json.Decode.Decoder msg ) , onBlurEvent : Maybe msg , onFocusEvent : Maybe msg , box : List ( Helpers.Shared.Modifiers Box , BodyBuilder.Attributes.StyleSelector ) , universal : BodyBuilder.Attributes.UniversalAttributes , block : Maybe (List ( Helpers.Shared.Modifiers Display.BlockDetails , BodyBuilder.Attributes.StyleSelector )) , rawStyle : Maybe Elegant.Style }
```

Computed : MaybeBlockContainer (FlowAttributes msg)

---

### **defaultNodeAttributes**
```elm
defaultNodeAttributes : BodyBuilder.Attributes.NodeAttributes msg
```



---

### **nodeAttributesToHtmlAttributes**
```elm
nodeAttributesToHtmlAttributes : BodyBuilder.Attributes.NodeAttributes msg -> List (Html.Attribute msg)
```


- [BlockAttributes](#blockattributes)
- [width](#width)
- [height](#height)

### **type alias BlockAttributes**
```elm
type alias BlockAttributes msg =  
    { block : List ( Helpers.Shared.Modifiers Display.BlockDetails , BodyBuilder.Attributes.StyleSelector ) , onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) , onEvent : Maybe ( String, Json.Decode.Decoder msg ) , onBlurEvent : Maybe msg , onFocusEvent : Maybe msg , box : List ( Helpers.Shared.Modifiers Box , BodyBuilder.Attributes.StyleSelector ) , universal : BodyBuilder.Attributes.UniversalAttributes , rawStyle : Maybe Elegant.Style }
```



---

### **width**
```elm
width : Int -> Helpers.Shared.Modifier (BodyBuilder.Attributes.WidthAttribute a)
```



---

### **height**
```elm
height : Int -> Helpers.Shared.Modifier (BodyBuilder.Attributes.HeightAttribute a)
```


- [HeadingAttributes](#headingattributes)
- [defaultHeadingAttributes](#defaultheadingattributes)
- [headingAttributesToHtmlAttributes](#headingattributestohtmlattributes)

### **type alias HeadingAttributes**
```elm
type alias HeadingAttributes msg =  
    BodyBuilder.Attributes.BlockAttributes msg
```



---

### **defaultHeadingAttributes**
```elm
defaultHeadingAttributes : BodyBuilder.Attributes.HeadingAttributes msg
```



---

### **headingAttributesToHtmlAttributes**
```elm
headingAttributesToHtmlAttributes : BodyBuilder.Attributes.HeadingAttributes msg -> List (Html.Attribute msg)
```


- [FlowAttributes](#flowattributes)
- [defaultFlowAttributes](#defaultflowattributes)
- [flowAttributesToHtmlAttributes](#flowattributestohtmlattributes)

### **type alias FlowAttributes**
```elm
type alias FlowAttributes msg =  
    { onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) , onEvent : Maybe ( String, Json.Decode.Decoder msg ) , onBlurEvent : Maybe msg , onFocusEvent : Maybe msg , box : List ( Helpers.Shared.Modifiers Box , BodyBuilder.Attributes.StyleSelector ) , universal : BodyBuilder.Attributes.UniversalAttributes , rawStyle : Maybe Elegant.Style }
```



---

### **defaultFlowAttributes**
```elm
defaultFlowAttributes : BodyBuilder.Attributes.FlowAttributes msg
```



---

### **flowAttributesToHtmlAttributes**
```elm
flowAttributesToHtmlAttributes : BodyBuilder.Attributes.FlowAttributes msg -> List (Html.Attribute msg)
```


- [FlexContainerAttributes](#flexcontainerattributes)
- [defaultFlexContainerAttributes](#defaultflexcontainerattributes)
- [flexContainerAttributesToHtmlAttributes](#flexcontainerattributestohtmlattributes)

### **type alias FlexContainerAttributes**
```elm
type alias FlexContainerAttributes msg =  
    { flexContainerProperties : List ( Helpers.Shared.Modifiers Flex.FlexContainerDetails , BodyBuilder.Attributes.StyleSelector ) , onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) , onEvent : Maybe ( String, Json.Decode.Decoder msg ) , onBlurEvent : Maybe msg , onFocusEvent : Maybe msg , box : List ( Helpers.Shared.Modifiers Box , BodyBuilder.Attributes.StyleSelector ) , universal : BodyBuilder.Attributes.UniversalAttributes , block : Maybe (List ( Helpers.Shared.Modifiers Display.BlockDetails , BodyBuilder.Attributes.StyleSelector )) , rawStyle : Maybe Elegant.Style }
```



---

### **defaultFlexContainerAttributes**
```elm
defaultFlexContainerAttributes : BodyBuilder.Attributes.FlexContainerAttributes msg
```



---

### **flexContainerAttributesToHtmlAttributes**
```elm
flexContainerAttributesToHtmlAttributes : BodyBuilder.Attributes.FlexContainerAttributes msg -> List (Html.Attribute msg)
```


- [FlexItemAttributes](#flexitemattributes)
- [defaultFlexItemAttributes](#defaultflexitemattributes)
- [flexItemAttributesToHtmlAttributes](#flexitemattributestohtmlattributes)

### **type alias FlexItemAttributes**
```elm
type alias FlexItemAttributes msg =  
    { flexItemProperties : List ( Helpers.Shared.Modifiers Flex.FlexItemDetails , BodyBuilder.Attributes.StyleSelector ) , onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) , onEvent : Maybe ( String, Json.Decode.Decoder msg ) , onBlurEvent : Maybe msg , onFocusEvent : Maybe msg , box : List ( Helpers.Shared.Modifiers Box , BodyBuilder.Attributes.StyleSelector ) , universal : BodyBuilder.Attributes.UniversalAttributes , block : Maybe (List ( Helpers.Shared.Modifiers Display.BlockDetails , BodyBuilder.Attributes.StyleSelector )) , rawStyle : Maybe Elegant.Style }
```



---

### **defaultFlexItemAttributes**
```elm
defaultFlexItemAttributes : BodyBuilder.Attributes.FlexItemAttributes msg
```



---

### **flexItemAttributesToHtmlAttributes**
```elm
flexItemAttributesToHtmlAttributes : BodyBuilder.Attributes.FlexItemAttributes msg -> List (Html.Attribute msg)
```


- [GridContainerAttributes](#gridcontainerattributes)
- [defaultGridContainerAttributes](#defaultgridcontainerattributes)
- [gridContainerAttributesToHtmlAttributes](#gridcontainerattributestohtmlattributes)

### **type alias GridContainerAttributes**
```elm
type alias GridContainerAttributes msg =  
    { gridContainerProperties : List ( Helpers.Shared.Modifiers Grid.GridContainerDetails , BodyBuilder.Attributes.StyleSelector ) , onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) , onEvent : Maybe ( String, Json.Decode.Decoder msg ) , onBlurEvent : Maybe msg , onFocusEvent : Maybe msg , box : List ( Helpers.Shared.Modifiers Box , BodyBuilder.Attributes.StyleSelector ) , universal : BodyBuilder.Attributes.UniversalAttributes , block : Maybe (List ( Helpers.Shared.Modifiers Display.BlockDetails , BodyBuilder.Attributes.StyleSelector )) , rawStyle : Maybe Elegant.Style }
```



---

### **defaultGridContainerAttributes**
```elm
defaultGridContainerAttributes : BodyBuilder.Attributes.GridContainerAttributes msg
```



---

### **gridContainerAttributesToHtmlAttributes**
```elm
gridContainerAttributesToHtmlAttributes : BodyBuilder.Attributes.GridContainerAttributes msg -> List (Html.Attribute msg)
```


- [GridItemAttributes](#griditemattributes)
- [defaultGridItemAttributes](#defaultgriditemattributes)
- [gridItemAttributesToHtmlAttributes](#griditemattributestohtmlattributes)

### **type alias GridItemAttributes**
```elm
type alias GridItemAttributes msg =  
    { gridItemProperties : List ( Helpers.Shared.Modifiers Grid.GridItemDetails , BodyBuilder.Attributes.StyleSelector ) , onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) , onEvent : Maybe ( String, Json.Decode.Decoder msg ) , onBlurEvent : Maybe msg , onFocusEvent : Maybe msg , box : List ( Helpers.Shared.Modifiers Box , BodyBuilder.Attributes.StyleSelector ) , universal : BodyBuilder.Attributes.UniversalAttributes , block : Maybe (List ( Helpers.Shared.Modifiers Display.BlockDetails , BodyBuilder.Attributes.StyleSelector )) , rawStyle : Maybe Elegant.Style }
```



---

### **defaultGridItemAttributes**
```elm
defaultGridItemAttributes : BodyBuilder.Attributes.GridItemAttributes msg
```



---

### **gridItemAttributesToHtmlAttributes**
```elm
gridItemAttributesToHtmlAttributes : BodyBuilder.Attributes.GridItemAttributes msg -> List (Html.Attribute msg)
```


- [ButtonAttributes](#buttonattributes)
- [defaultButtonAttributes](#defaultbuttonattributes)
- [buttonAttributesToHtmlAttributes](#buttonattributestohtmlattributes)

### **type alias ButtonAttributes**
```elm
type alias ButtonAttributes msg =  
    { disabled : Bool , block : Maybe (List ( Helpers.Shared.Modifiers Display.BlockDetails , BodyBuilder.Attributes.StyleSelector )) , onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) , onEvent : Maybe ( String, Json.Decode.Decoder msg ) , onBlurEvent : Maybe msg , onFocusEvent : Maybe msg , box : List ( Helpers.Shared.Modifiers Box , BodyBuilder.Attributes.StyleSelector ) , universal : BodyBuilder.Attributes.UniversalAttributes , rawStyle : Maybe Elegant.Style }
```



---

### **defaultButtonAttributes**
```elm
defaultButtonAttributes : BodyBuilder.Attributes.ButtonAttributes msg
```



---

### **buttonAttributesToHtmlAttributes**
```elm
buttonAttributesToHtmlAttributes : BodyBuilder.Attributes.ButtonAttributes msg -> List (Html.Attribute msg)
```


- [AAttributes](#aattributes)
- [target](#target)
- [href](#href)
- [defaultAAttributes](#defaultaattributes)
- [aAttributesToHtmlAttributes](#aattributestohtmlattributes)

### **type alias AAttributes**
```elm
type alias AAttributes msg =  
    { onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) , onEvent : Maybe ( String, Json.Decode.Decoder msg ) , onBlurEvent : Maybe msg , onFocusEvent : Maybe msg , box : List ( Helpers.Shared.Modifiers Box , BodyBuilder.Attributes.StyleSelector ) , universal : BodyBuilder.Attributes.UniversalAttributes , href : Maybe String , target : Maybe String , block : Maybe (List ( Helpers.Shared.Modifiers Display.BlockDetails , BodyBuilder.Attributes.StyleSelector )) , rawStyle : Maybe Elegant.Style }
```



---

### **target**
```elm
target : String -> Helpers.Shared.Modifier (BodyBuilder.Attributes.TargetAttribute a)
```



---

### **href**
```elm
href : String -> Helpers.Shared.Modifier (BodyBuilder.Attributes.HrefAttribute a)
```



---

### **defaultAAttributes**
```elm
defaultAAttributes : BodyBuilder.Attributes.AAttributes msg
```



---

### **aAttributesToHtmlAttributes**
```elm
aAttributesToHtmlAttributes : BodyBuilder.Attributes.AAttributes msg -> List (Html.Attribute msg)
```


- [ImgAttributes](#imgattributes)
- [defaultImgAttributes](#defaultimgattributes)
- [imgAttributesToHtmlAttributes](#imgattributestohtmlattributes)

### **type alias ImgAttributes**
```elm
type alias ImgAttributes msg =  
    { onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) , onEvent : Maybe ( String, Json.Decode.Decoder msg ) , onBlurEvent : Maybe msg , onFocusEvent : Maybe msg , box : List ( Helpers.Shared.Modifiers Box , BodyBuilder.Attributes.StyleSelector ) , universal : BodyBuilder.Attributes.UniversalAttributes , src : String , alt : String , width : Maybe Int , height : Maybe Int , block : Maybe (List ( Helpers.Shared.Modifiers Display.BlockDetails , BodyBuilder.Attributes.StyleSelector )) , rawStyle : Maybe Elegant.Style }
```



---

### **defaultImgAttributes**
```elm
defaultImgAttributes : String -> String -> BodyBuilder.Attributes.ImgAttributes msg
```



---

### **imgAttributesToHtmlAttributes**
```elm
imgAttributesToHtmlAttributes : BodyBuilder.Attributes.ImgAttributes msg -> List (Html.Attribute msg)
```


- [AudioAttributes](#audioattributes)
- [defaultAudioAttributes](#defaultaudioattributes)
- [audioAttributesToHtmlAttributes](#audioattributestohtmlattributes)

### **type alias AudioAttributes**
```elm
type alias AudioAttributes msg =  
    { onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) , onEvent : Maybe ( String, Json.Decode.Decoder msg ) , onBlurEvent : Maybe msg , onFocusEvent : Maybe msg , box : List ( Helpers.Shared.Modifiers Box , BodyBuilder.Attributes.StyleSelector ) , universal : BodyBuilder.Attributes.UniversalAttributes , src : String , block : Maybe (List ( Helpers.Shared.Modifiers Display.BlockDetails , BodyBuilder.Attributes.StyleSelector )) , rawStyle : Maybe Elegant.Style }
```



---

### **defaultAudioAttributes**
```elm
defaultAudioAttributes : BodyBuilder.Attributes.AudioAttributes msg
```



---

### **audioAttributesToHtmlAttributes**
```elm
audioAttributesToHtmlAttributes : BodyBuilder.Attributes.AudioAttributes msg -> List (Html.Attribute msg)
```


- [ScriptAttributes](#scriptattributes)
- [defaultScriptAttributes](#defaultscriptattributes)
- [scriptAttributesToHtmlAttributes](#scriptattributestohtmlattributes)

### **type alias ScriptAttributes**
```elm
type alias ScriptAttributes msg =  
    { onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) , onEvent : Maybe ( String, Json.Decode.Decoder msg ) , onBlurEvent : Maybe msg , onFocusEvent : Maybe msg , box : List ( Helpers.Shared.Modifiers Box , BodyBuilder.Attributes.StyleSelector ) , universal : BodyBuilder.Attributes.UniversalAttributes , src : String , data : List ( String, String ) , rawStyle : Maybe Elegant.Style }
```



---

### **defaultScriptAttributes**
```elm
defaultScriptAttributes : BodyBuilder.Attributes.ScriptAttributes msg
```



---

### **scriptAttributesToHtmlAttributes**
```elm
scriptAttributesToHtmlAttributes : BodyBuilder.Attributes.ScriptAttributes msg -> List (Html.Attribute msg)
```


- [ProgressAttributes](#progressattributes)
- [defaultProgressAttributes](#defaultprogressattributes)
- [progressAttributesToHtmlAttributes](#progressattributestohtmlattributes)

### **type alias ProgressAttributes**
```elm
type alias ProgressAttributes msg =  
    { onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) , onEvent : Maybe ( String, Json.Decode.Decoder msg ) , onBlurEvent : Maybe msg , onFocusEvent : Maybe msg , box : List ( Helpers.Shared.Modifiers Box , BodyBuilder.Attributes.StyleSelector ) , universal : BodyBuilder.Attributes.UniversalAttributes , block : Maybe (List ( Helpers.Shared.Modifiers Display.BlockDetails , BodyBuilder.Attributes.StyleSelector )) , rawStyle : Maybe Elegant.Style }
```



---

### **defaultProgressAttributes**
```elm
defaultProgressAttributes : BodyBuilder.Attributes.ProgressAttributes msg
```



---

### **progressAttributesToHtmlAttributes**
```elm
progressAttributesToHtmlAttributes : BodyBuilder.Attributes.ProgressAttributes msg -> List (Html.Attribute msg)
```


- [SelectAttributes](#selectattributes)
- [defaultSelectAttributes](#defaultselectattributes)
- [selectAttributesToHtmlAttributes](#selectattributestohtmlattributes)

### **type alias SelectAttributes**
```elm
type alias SelectAttributes msg =  
    { block : Maybe (List ( Helpers.Shared.Modifiers Display.BlockDetails , BodyBuilder.Attributes.StyleSelector )) , value : Maybe String , onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) , onEvent : Maybe ( String, Json.Decode.Decoder msg ) , onBlurEvent : Maybe msg , onFocusEvent : Maybe msg , box : List ( Helpers.Shared.Modifiers Box , BodyBuilder.Attributes.StyleSelector ) , universal : BodyBuilder.Attributes.UniversalAttributes , rawStyle : Maybe Elegant.Style , onInputEvent : Maybe (String -> msg) , fromStringInput : String -> String }
```

Computed : -- MaybeBlockContainer (StringValue (FlowAttributes msg))

---

### **defaultSelectAttributes**
```elm
defaultSelectAttributes : BodyBuilder.Attributes.SelectAttributes msg
```



---

### **selectAttributesToHtmlAttributes**
```elm
selectAttributesToHtmlAttributes : BodyBuilder.Attributes.SelectAttributes msg -> List (Html.Attribute msg)
```


- [LabelAttributes](#labelattributes)
- [label](#label)
- [PositionAttribute](#positionattribute)
- [Position](#position)

### **type alias LabelAttributes**
```elm
type alias LabelAttributes msg =  
    { onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) , onEvent : Maybe ( String, Json.Decode.Decoder msg ) , onBlurEvent : Maybe msg , onFocusEvent : Maybe msg , box : List ( Helpers.Shared.Modifiers Box , BodyBuilder.Attributes.StyleSelector ) , universal : BodyBuilder.Attributes.UniversalAttributes , position : BodyBuilder.Attributes.Position , block : Maybe (List ( Helpers.Shared.Modifiers Display.BlockDetails , BodyBuilder.Attributes.StyleSelector )) , rawStyle : Maybe Elegant.Style }
```



---

### **label**
```elm
label : List (Html msg) -> { c | label : Maybe (BodyBuilder.Shared.Label msg) } -> { c | label : Maybe (BodyBuilder.Shared.Label msg) }
```



---

### **type alias PositionAttribute**
```elm
type alias PositionAttribute a =  
    { a | position : BodyBuilder.Attributes.Position }
```



---

### **type Position**
```elm
type Position   
    = 
```


- [InputAttributes](#inputattributes)
- [value](#value)
- [disabled](#disabled)
- [name](#name)
- [disabledAttributeToHtmlAttributes](#disabledattributetohtmlattributes)
- [inputAttributesToHtmlAttributes](#inputattributestohtmlattributes)
- [inputVisibleToHtmlAttributes](#inputvisibletohtmlattributes)

### **type alias InputAttributes**
```elm
type alias InputAttributes a =  
    { a | type_ : String, name : Maybe String }
```



---

### **value**
```elm
value : a -> { c | value : Maybe a } -> { c | value : Maybe a }
```



---

### **disabled**
```elm
disabled : Helpers.Shared.Modifier (BodyBuilder.Attributes.DisabledAttribute a)
```



---

### **name**
```elm
name : String -> Helpers.Shared.Modifier (BodyBuilder.Attributes.NameAttribute a)
```



---

### **disabledAttributeToHtmlAttributes**
```elm
disabledAttributeToHtmlAttributes : Bool -> List (Html.Attribute msg)
```



---

### **inputAttributesToHtmlAttributes**
```elm
inputAttributesToHtmlAttributes : BodyBuilder.Attributes.InputAttributes a -> List (Html.Attribute msg)
```



---

### **inputVisibleToHtmlAttributes**
```elm
inputVisibleToHtmlAttributes : BodyBuilder.Attributes.VisibleAttributesAndEvents msg { a | name : Maybe String, type_ : String } -> List (Html.Attribute msg)
```


- [InputHiddenAttributes](#inputhiddenattributes)
- [name](#name-1)
- [defaultInputHiddenAttributes](#defaultinputhiddenattributes)
- [inputHiddenAttributesToHtmlAttributes](#inputhiddenattributestohtmlattributes)

### **type alias InputHiddenAttributes**
```elm
type alias InputHiddenAttributes  =  
    { name : Maybe String , type_ : String , value : Maybe String , universal : BodyBuilder.Attributes.UniversalAttributes }
```



---

### **name**
```elm
name : String -> Helpers.Shared.Modifier (BodyBuilder.Attributes.NameAttribute a)
```



---

### **defaultInputHiddenAttributes**
```elm
defaultInputHiddenAttributes : BodyBuilder.Attributes.InputHiddenAttributes
```



---

### **inputHiddenAttributesToHtmlAttributes**
```elm
inputHiddenAttributesToHtmlAttributes : BodyBuilder.Attributes.InputHiddenAttributes -> List (Html.Attribute msg)
```


- [InputPasswordAttributes](#inputpasswordattributes)
- [name](#name-2)
- [defaultInputPasswordAttributes](#defaultinputpasswordattributes)
- [inputPasswordAttributesToHtmlAttributes](#inputpasswordattributestohtmlattributes)

### **type alias InputPasswordAttributes**
```elm
type alias InputPasswordAttributes msg =  
    BodyBuilder.Attributes.InputTextAttributes msg
```



---

### **name**
```elm
name : String -> Helpers.Shared.Modifier (BodyBuilder.Attributes.NameAttribute a)
```



---

### **defaultInputPasswordAttributes**
```elm
defaultInputPasswordAttributes : BodyBuilder.Attributes.InputPasswordAttributes msg
```



---

### **inputPasswordAttributesToHtmlAttributes**
```elm
inputPasswordAttributesToHtmlAttributes : BodyBuilder.Attributes.InputPasswordAttributes msg -> List (Html.Attribute msg)
```


- [InputRangeAttributes](#inputrangeattributes)
- [name](#name-3)
- [step](#step)
- [max](#max)
- [min](#min)
- [defaultInputRangeAttributes](#defaultinputrangeattributes)
- [inputRangeAttributesToHtmlAttributes](#inputrangeattributestohtmlattributes)

### **type alias InputRangeAttributes**
```elm
type alias InputRangeAttributes msg =  
    BodyBuilder.Attributes.InputNumberAttributes msg
```



---

### **name**
```elm
name : String -> Helpers.Shared.Modifier (BodyBuilder.Attributes.NameAttribute a)
```



---

### **step**
```elm
step : Int -> Helpers.Shared.Modifier (BodyBuilder.Attributes.StepAttribute a)
```



---

### **max**
```elm
max : Int -> Helpers.Shared.Modifier (BodyBuilder.Attributes.MaxAttribute a)
```



---

### **min**
```elm
min : Int -> Helpers.Shared.Modifier (BodyBuilder.Attributes.MinAttribute a)
```



---

### **defaultInputRangeAttributes**
```elm
defaultInputRangeAttributes : BodyBuilder.Attributes.InputRangeAttributes msg
```



---

### **inputRangeAttributesToHtmlAttributes**
```elm
inputRangeAttributesToHtmlAttributes : BodyBuilder.Attributes.InputRangeAttributes msg -> List (Html.Attribute msg)
```


- [InputRadioAttributes](#inputradioattributes)
- [name](#name-4)
- [defaultInputRadioAttributes](#defaultinputradioattributes)
- [inputRadioAttributesToHtmlAttributes](#inputradioattributestohtmlattributes)

### **type alias InputRadioAttributes**
```elm
type alias InputRadioAttributes msg =  
    { name : Maybe String , type_ : String , universal : BodyBuilder.Attributes.UniversalAttributes , box : List ( Helpers.Shared.Modifiers Box , BodyBuilder.Attributes.StyleSelector ) , onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) , onEvent : Maybe ( String, Json.Decode.Decoder msg ) , onBlurEvent : Maybe msg , onFocusEvent : Maybe msg , value : Maybe String , block : Maybe (List ( Helpers.Shared.Modifiers Display.BlockDetails , BodyBuilder.Attributes.StyleSelector )) , label : Maybe (BodyBuilder.Shared.Label msg) , rawStyle : Maybe Elegant.Style }
```



---

### **name**
```elm
name : String -> Helpers.Shared.Modifier (BodyBuilder.Attributes.NameAttribute a)
```



---

### **defaultInputRadioAttributes**
```elm
defaultInputRadioAttributes : BodyBuilder.Attributes.InputRadioAttributes msg
```



---

### **inputRadioAttributesToHtmlAttributes**
```elm
inputRadioAttributesToHtmlAttributes : BodyBuilder.Attributes.InputRadioAttributes msg -> List (Html.Attribute msg)
```


- [InputCheckboxAttributes](#inputcheckboxattributes)
- [name](#name-5)
- [checked](#checked)
- [defaultInputCheckboxAttributes](#defaultinputcheckboxattributes)
- [inputCheckboxAttributesToHtmlAttributes](#inputcheckboxattributestohtmlattributes)

### **type alias InputCheckboxAttributes**
```elm
type alias InputCheckboxAttributes msg =  
    { name : Maybe String , type_ : String , universal : BodyBuilder.Attributes.UniversalAttributes , box : List ( Helpers.Shared.Modifiers Box , BodyBuilder.Attributes.StyleSelector ) , onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) , onEvent : Maybe ( String, Json.Decode.Decoder msg ) , onBlurEvent : Maybe msg , onFocusEvent : Maybe msg , value : Maybe String , label : Maybe (BodyBuilder.Shared.Label msg) , block : Maybe (List ( Helpers.Shared.Modifiers Display.BlockDetails , BodyBuilder.Attributes.StyleSelector )) , checked : Bool , onCheckEvent : Maybe (Bool -> msg) , rawStyle : Maybe Elegant.Style }
```



---

### **name**
```elm
name : String -> Helpers.Shared.Modifier (BodyBuilder.Attributes.NameAttribute a)
```



---

### **checked**
```elm
checked : Bool -> Helpers.Shared.Modifier (BodyBuilder.Attributes.InputCheckboxAttributes msg)
```



---

### **defaultInputCheckboxAttributes**
```elm
defaultInputCheckboxAttributes : BodyBuilder.Attributes.InputCheckboxAttributes msg
```



---

### **inputCheckboxAttributesToHtmlAttributes**
```elm
inputCheckboxAttributesToHtmlAttributes : BodyBuilder.Attributes.InputCheckboxAttributes msg -> List (Html.Attribute msg)
```


- [InputTextAttributes](#inputtextattributes)
- [name](#name-6)
- [autocomplete](#autocomplete)
- [placeholder](#placeholder)
- [defaultInputTextAttributes](#defaultinputtextattributes)
- [inputTextAttributesToHtmlAttributes](#inputtextattributestohtmlattributes)

### **type alias InputTextAttributes**
```elm
type alias InputTextAttributes msg =  
    { name : Maybe String , type_ : String , universal : BodyBuilder.Attributes.UniversalAttributes , box : List ( Helpers.Shared.Modifiers Box , BodyBuilder.Attributes.StyleSelector ) , onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) , onEvent : Maybe ( String, Json.Decode.Decoder msg ) , onBlurEvent : Maybe msg , onFocusEvent : Maybe msg , value : Maybe String , label : Maybe (BodyBuilder.Shared.Label msg) , placeholder : Maybe String , autocomplete : Bool , onInputEvent : Maybe (String -> msg) , fromStringInput : String -> String , block : Maybe (List ( Helpers.Shared.Modifiers Display.BlockDetails , BodyBuilder.Attributes.StyleSelector )) , rawStyle : Maybe Elegant.Style }
```



---

### **name**
```elm
name : String -> Helpers.Shared.Modifier (BodyBuilder.Attributes.NameAttribute a)
```



---

### **autocomplete**
```elm
autocomplete : Bool -> Helpers.Shared.Modifier (BodyBuilder.Attributes.AutocompleteAttribute a)
```



---

### **placeholder**
```elm
placeholder : String -> Helpers.Shared.Modifier (BodyBuilder.Attributes.PlaceholderAttribute a)
```



---

### **defaultInputTextAttributes**
```elm
defaultInputTextAttributes : BodyBuilder.Attributes.InputTextAttributes msg
```



---

### **inputTextAttributesToHtmlAttributes**
```elm
inputTextAttributesToHtmlAttributes : BodyBuilder.Attributes.InputTextAttributes msg -> List (Html.Attribute msg)
```


- [InputSubmitAttributes](#inputsubmitattributes)
- [name](#name-7)
- [defaultInputSubmitAttributes](#defaultinputsubmitattributes)
- [inputSubmitAttributesToHtmlAttributes](#inputsubmitattributestohtmlattributes)

### **type alias InputSubmitAttributes**
```elm
type alias InputSubmitAttributes msg =  
    { label : Maybe (BodyBuilder.Shared.Label msg) , type_ : String , disabled : Bool , block : Maybe (List ( Helpers.Shared.Modifiers Display.BlockDetails , BodyBuilder.Attributes.StyleSelector )) , onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) , onEvent : Maybe ( String, Json.Decode.Decoder msg ) , onBlurEvent : Maybe msg , onFocusEvent : Maybe msg , onSubmitEvent : Maybe msg , box : List ( Helpers.Shared.Modifiers Box , BodyBuilder.Attributes.StyleSelector ) , universal : BodyBuilder.Attributes.UniversalAttributes , rawStyle : Maybe Elegant.Style }
```



---

### **name**
```elm
name : String -> Helpers.Shared.Modifier (BodyBuilder.Attributes.NameAttribute a)
```



---

### **defaultInputSubmitAttributes**
```elm
defaultInputSubmitAttributes : BodyBuilder.Attributes.InputSubmitAttributes msg
```



---

### **inputSubmitAttributesToHtmlAttributes**
```elm
inputSubmitAttributesToHtmlAttributes : BodyBuilder.Attributes.InputSubmitAttributes msg -> List (Html.Attribute msg)
```


- [InputUrlAttributes](#inputurlattributes)
- [name](#name-8)
- [placeholder](#placeholder-1)
- [defaultInputUrlAttributes](#defaultinputurlattributes)
- [inputUrlAttributesToHtmlAttributes](#inputurlattributestohtmlattributes)

### **type alias InputUrlAttributes**
```elm
type alias InputUrlAttributes msg =  
    BodyBuilder.Attributes.InputTextAttributes msg
```



---

### **name**
```elm
name : String -> Helpers.Shared.Modifier (BodyBuilder.Attributes.NameAttribute a)
```



---

### **placeholder**
```elm
placeholder : String -> Helpers.Shared.Modifier (BodyBuilder.Attributes.PlaceholderAttribute a)
```



---

### **defaultInputUrlAttributes**
```elm
defaultInputUrlAttributes : BodyBuilder.Attributes.InputUrlAttributes msg
```



---

### **inputUrlAttributesToHtmlAttributes**
```elm
inputUrlAttributesToHtmlAttributes : BodyBuilder.Attributes.InputUrlAttributes msg -> List (Html.Attribute msg)
```


- [InputNumberAttributes](#inputnumberattributes)
- [name](#name-9)
- [step](#step-1)
- [max](#max-1)
- [min](#min-1)
- [defaultInputNumberAttributes](#defaultinputnumberattributes)
- [inputNumberAttributesToHtmlAttributes](#inputnumberattributestohtmlattributes)

### **type alias InputNumberAttributes**
```elm
type alias InputNumberAttributes msg =  
    { name : Maybe String , type_ : String , universal : BodyBuilder.Attributes.UniversalAttributes , box : List ( Helpers.Shared.Modifiers Box , BodyBuilder.Attributes.StyleSelector ) , onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) , onEvent : Maybe ( String, Json.Decode.Decoder msg ) , onBlurEvent : Maybe msg , onFocusEvent : Maybe msg , label : Maybe (BodyBuilder.Shared.Label msg) , rawStyle : Maybe Elegant.Style , value : Maybe Int , onInputEvent : Maybe (Int -> msg) , fromStringInput : String -> Int , step : Maybe Int , max : Maybe Int , min : Maybe Int , block : Maybe (List ( Helpers.Shared.Modifiers Display.BlockDetails , BodyBuilder.Attributes.StyleSelector )) , disabled : Bool }
```



---

### **name**
```elm
name : String -> Helpers.Shared.Modifier (BodyBuilder.Attributes.NameAttribute a)
```



---

### **step**
```elm
step : Int -> Helpers.Shared.Modifier (BodyBuilder.Attributes.StepAttribute a)
```



---

### **max**
```elm
max : Int -> Helpers.Shared.Modifier (BodyBuilder.Attributes.MaxAttribute a)
```



---

### **min**
```elm
min : Int -> Helpers.Shared.Modifier (BodyBuilder.Attributes.MinAttribute a)
```



---

### **defaultInputNumberAttributes**
```elm
defaultInputNumberAttributes : BodyBuilder.Attributes.InputNumberAttributes msg
```



---

### **inputNumberAttributesToHtmlAttributes**
```elm
inputNumberAttributesToHtmlAttributes : BodyBuilder.Attributes.InputNumberAttributes msg -> List (Html.Attribute msg)
```


- [InputColorAttributes](#inputcolorattributes)
- [name](#name-10)
- [defaultInputColorAttributes](#defaultinputcolorattributes)
- [inputColorAttributesToHtmlAttributes](#inputcolorattributestohtmlattributes)

### **type alias InputColorAttributes**
```elm
type alias InputColorAttributes msg =  
    { name : Maybe String , type_ : String , universal : BodyBuilder.Attributes.UniversalAttributes , box : List ( Helpers.Shared.Modifiers Box , BodyBuilder.Attributes.StyleSelector ) , onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) , onEvent : Maybe ( String, Json.Decode.Decoder msg ) , onBlurEvent : Maybe msg , onFocusEvent : Maybe msg , label : Maybe (BodyBuilder.Shared.Label msg) , rawStyle : Maybe Elegant.Style , value : Maybe Color , onInputEvent : Maybe (Color -> msg) , fromStringInput : String -> Color , block : Maybe (List ( Helpers.Shared.Modifiers Display.BlockDetails , BodyBuilder.Attributes.StyleSelector )) }
```



---

### **name**
```elm
name : String -> Helpers.Shared.Modifier (BodyBuilder.Attributes.NameAttribute a)
```



---

### **defaultInputColorAttributes**
```elm
defaultInputColorAttributes : BodyBuilder.Attributes.InputColorAttributes msg
```



---

### **inputColorAttributesToHtmlAttributes**
```elm
inputColorAttributesToHtmlAttributes : BodyBuilder.Attributes.InputColorAttributes msg -> List (Html.Attribute msg)
```


- [InputFileAttributes](#inputfileattributes)
- [name](#name-11)
- [defaultInputFileAttributes](#defaultinputfileattributes)
- [inputFileAttributesToHtmlAttributes](#inputfileattributestohtmlattributes)

### **type alias InputFileAttributes**
```elm
type alias InputFileAttributes msg =  
    { name : Maybe String , type_ : String , universal : BodyBuilder.Attributes.UniversalAttributes , box : List ( Helpers.Shared.Modifiers Box , BodyBuilder.Attributes.StyleSelector ) , onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) , onEvent : Maybe ( String, Json.Decode.Decoder msg ) , onBlurEvent : Maybe msg , onFocusEvent : Maybe msg , label : Maybe (BodyBuilder.Shared.Label msg) , rawStyle : Maybe Elegant.Style , block : Maybe (List ( Helpers.Shared.Modifiers Display.BlockDetails , BodyBuilder.Attributes.StyleSelector )) }
```



---

### **name**
```elm
name : String -> Helpers.Shared.Modifier (BodyBuilder.Attributes.NameAttribute a)
```



---

### **defaultInputFileAttributes**
```elm
defaultInputFileAttributes : BodyBuilder.Attributes.InputFileAttributes msg
```



---

### **inputFileAttributesToHtmlAttributes**
```elm
inputFileAttributesToHtmlAttributes : BodyBuilder.Attributes.InputFileAttributes msg -> List (Html.Attribute msg)
```


- [TextareaAttributes](#textareaattributes)
- [autocomplete](#autocomplete-1)
- [placeholder](#placeholder-2)
- [defaultTextareaAttributes](#defaulttextareaattributes)
- [textareaAttributesToHtmlAttributes](#textareaattributestohtmlattributes)

### **type alias TextareaAttributes**
```elm
type alias TextareaAttributes msg =  
    { onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) , onEvent : Maybe ( String, Json.Decode.Decoder msg ) , onBlurEvent : Maybe msg , onFocusEvent : Maybe msg , box : List ( Helpers.Shared.Modifiers Box , BodyBuilder.Attributes.StyleSelector ) , universal : BodyBuilder.Attributes.UniversalAttributes , value : Maybe String , onInputEvent : Maybe (String -> msg) , fromStringInput : String -> String , name : Maybe String , block : Maybe (List ( Helpers.Shared.Modifiers Display.BlockDetails , BodyBuilder.Attributes.StyleSelector )) , rawStyle : Maybe Elegant.Style }
```



---

### **autocomplete**
```elm
autocomplete : Bool -> Helpers.Shared.Modifier (BodyBuilder.Attributes.AutocompleteAttribute a)
```



---

### **placeholder**
```elm
placeholder : String -> Helpers.Shared.Modifier (BodyBuilder.Attributes.PlaceholderAttribute a)
```



---

### **defaultTextareaAttributes**
```elm
defaultTextareaAttributes : BodyBuilder.Attributes.TextareaAttributes msg
```



---

### **textareaAttributesToHtmlAttributes**
```elm
textareaAttributesToHtmlAttributes : BodyBuilder.Attributes.TextareaAttributes msg -> List (Html.Attribute msg)
```



