# BodyBuilder.Attributes

This module entirely replaces Html.Attributes, providing a type-safer alternatives.
This is designed to work with BodyBuilder.
It is not compatible with Html.Attributes, though.

- [StyleSelector](#styleselector)
- [defaultStyleSelector](#defaultstyleselector)

### **type alias StyleSelector**
```elm
type alias StyleSelector  =
    StyleSelector Nothing Nothing



type MediaQuery
    = Greater Int
    | Lesser Int
    | Between Int Int



type alias StyleModifier a =
    StyleSelector -> Modifier a



style : List (StyleModifier a) -> Modifier a
style styles =
    styles
        |> List.map (callOn defaultStyleSelector)
        |> Function.compose



rawStyle : a -> { c | rawStyle : b }
```



---

### **defaultStyleSelector**
```elm
defaultStyleSelector : StyleSelector

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
    BodyBuilder.Attributes.StyleSelector -> Modifiers.Modifier a
```



---

### **style**
```elm
style : List (StyleModifier a) -> Modifier a

```



---

### **rawStyle**
```elm
rawStyle : a -> { c | 
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
data : List ( String, String ) }



type alias TypeContainer a =
    { a | type_ : String }



type alias BoxContainer a =
    { a | box : List ( Modifiers Box, StyleSelector ) }



type alias CheckedContainer a =
    { a | checked : Bool }



type alias UniversalContainer a =
    { a | universal : UniversalAttributes }



type alias FlexContainerProperties a =
    { a | flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector ) }



type alias FlexItemProperties a =
    { a | flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector ) }



type alias GridContainerProperties a =
    { a | gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector ) }



type alias GridItemProperties a =
    { a | gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector ) }



type Position
    = Before
    | After



type alias VisibleAttributes a =
    { a
        | box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias StringValue a =
    ValueAttribute String a



type alias IntValue a =
    ValueAttribute Int a



type alias ColorValue a =
    ValueAttribute Color a



type alias VisibleAttributesAndEvents msg a =
    { a
        | onMouseEvents : Maybe (OnMouseEventsInside msg)
        , onEvent : Maybe ( String, Decoder msg )
        , onBlurEvent : Maybe msg
        , onFocusEvent : Maybe msg
        , box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias InputPasswordAttributes msg =
    InputTextAttributes msg



type alias InputRangeAttributes msg =
    InputNumberAttributes msg



type alias SelectAttributes msg =
    { block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , value : Maybe String
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    }



type alias UniversalAttributes =
    { title : Maybe String
    , tabindex : Maybe Int
    , id : Maybe String
    , class : List String
    }



type alias FlowAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias NodeAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexContainerProperties (NodeAttributes msg)



type alias FlexContainerAttributes msg =
    { flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexItemProperties (NodeAttributes msg)



type alias FlexItemAttributes msg =
    { flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridContainerProperties (NodeAttributes msg)



type alias GridContainerAttributes msg =
    { gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridItemProperties (NodeAttributes msg)



type alias GridItemAttributes msg =
    { gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- BlockContainer (FlowAttributes msg)



type alias BlockAttributes msg =
    { block : List ( Modifiers BlockDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias HeadingAttributes msg =
    BlockAttributes msg



type alias ButtonAttributes msg =
    { disabled : Bool
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias AAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , href : Maybe String
    , target : Maybe String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias TextareaAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , value : Maybe String
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    , name : Maybe String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias ImgAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , alt : String
    , width : Maybe Int
    , height : Maybe Int
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias AudioAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias ProgressAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias ScriptAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , 
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
    { a | box : List ( Modifiers Box, StyleSelector ) }
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
    { a | universal : UniversalAttributes }
```



---

### **title**
```elm
title : Maybe String
    , tabindex : Maybe Int
    , id : Maybe String
    , class : List String
    }



type alias FlowAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias NodeAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexContainerProperties (NodeAttributes msg)



type alias FlexContainerAttributes msg =
    { flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexItemProperties (NodeAttributes msg)



type alias FlexItemAttributes msg =
    { flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridContainerProperties (NodeAttributes msg)



type alias GridContainerAttributes msg =
    { gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridItemProperties (NodeAttributes msg)



type alias GridItemAttributes msg =
    { gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- BlockContainer (FlowAttributes msg)



type alias BlockAttributes msg =
    { block : List ( Modifiers BlockDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias HeadingAttributes msg =
    BlockAttributes msg



type alias ButtonAttributes msg =
    { disabled : Bool
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias AAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , href : Maybe String
    , target : Maybe String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias TextareaAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , value : Maybe String
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    , name : Maybe String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias ImgAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , alt : String
    , width : Maybe Int
    , height : Maybe Int
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias AudioAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias ProgressAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias ScriptAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , data : List ( String, String )
    , rawStyle : Maybe Elegant.Style
    }



type alias InputAttributes a =
    { a | type_ : String, name : Maybe String }



type alias InputHiddenAttributes =
    { name : Maybe String, type_ : String, value : Maybe String, universal : UniversalAttributes }



type alias LabelAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , position : Position
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias InputRadioAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , value : Maybe String
    , block : Maybe (List ( Modifiers Display.BlockDetails, StyleSelector ))
    , label : Maybe (Shared.Label msg)
    , rawStyle : Maybe Elegant.Style
    }



type alias InputCheckboxAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , value : Maybe String
    , label : Maybe (Shared.Label msg)
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , checked : Bool
    , onCheckEvent : Maybe (Bool -> msg)
    , rawStyle : Maybe Elegant.Style
    }



type alias InputTextAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , value : Maybe String
    , label : Maybe (Shared.Label msg)
    , placeholder : Maybe String
    , autocomplete : Bool
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias InputTelAttributes msg =
    InputTextAttributes msg



type alias InputSubmitAttributes msg =
    { label : Maybe (Shared.Label msg)
    , type_ : String
    , disabled : Bool
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , onSubmitEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias InputUrlAttributes msg =
    InputTextAttributes msg



type alias InputNumberAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , label : Maybe (Shared.Label msg)
    , rawStyle : Maybe Elegant.Style
    , value : Maybe Int
    , onInputEvent : Maybe (Int -> msg)
    , fromStringInput : String -> Int
    , step : Maybe Int
    , max : Maybe Int
    , min : Maybe Int
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , disabled : Bool
    }



type alias InputColorAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , label : Maybe (Shared.Label msg)
    , rawStyle : Maybe Elegant.Style
    , value : Maybe Color
    , onInputEvent : Maybe (Color -> msg)
    , fromStringInput : String -> Color
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    }



type alias InputFileAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , label : Maybe (Shared.Label msg)
    , rawStyle : Maybe Elegant.Style
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    }



label : Position -> List (Html msg) -> { c | label : Maybe (Shared.Label msg) } -> { c | label : Maybe (Shared.Label msg) }
label position content record =
    { record
        | label =
            Just <|
                Shared.label <|
                    \input ->
                        Html.label [] <|
                            case position of
                                Before ->
                                    content ++ [ input ]

                                After ->
                                    input :: content
    }



value : a -> { c | value : Maybe a } -> { c | value : Maybe a }
value =
    setValue


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




```



---

### **id**
```elm
id : Maybe String
    , class : List String
    }



type alias FlowAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsIns
```



---

### **class**
```elm
class : List String
    }



type alias FlowAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias NodeAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexContainerProperties (NodeAttributes msg)



type alias FlexContainerAttributes msg =
    { flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexItemProperties (NodeAttributes msg)



type alias FlexItemAttributes msg =
    { flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridContainerProperties (NodeAttributes msg)



type alias GridContainerAttributes msg =
    { gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridItemProperties (NodeAttributes msg)



type alias GridItemAttributes msg =
    { gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- BlockContainer (FlowAttributes msg)



type alias BlockAttributes msg =
    { block : List ( Modifiers BlockDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias HeadingAttributes msg =
    BlockAttributes msg



type alias ButtonAttributes msg =
    { disabled : Bool
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias AAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , href : Maybe String
    , target : Maybe String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias TextareaAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , value : Maybe String
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    , name : Maybe String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias ImgAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , alt : String
    , width : Maybe Int
    , height : Maybe Int
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias AudioAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias ProgressAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias ScriptAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , data : List ( String, String )
    , rawStyle : Maybe Elegant.Style
    }



type alias InputAttributes a =
    { a | type_ : String, name : Maybe String }



type alias InputHiddenAttributes =
    { name : Maybe String, type_ : String, value : Maybe String, universal : UniversalAttributes }



type alias LabelAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , position : Position
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias InputRadioAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , value : Maybe String
    , block : Maybe (List ( Modifiers Display.BlockDetails, StyleSelector ))
    , label : Maybe (Shared.Label msg)
    , rawStyle : Maybe Elegant.Style
    }



type alias InputCheckboxAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , value : Maybe String
    , label : Maybe (Shared.Label msg)
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , checked : Bool
    , onCheckEvent : Maybe (Bool -> msg)
    , rawStyle : Maybe Elegant.Style
    }



type alias InputTextAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , value : Maybe String
    , label : Maybe (Shared.Label msg)
    , placeholder : Maybe String
    , autocomplete : Bool
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias InputTelAttributes msg =
    InputTextAttributes msg



type alias InputSubmitAttributes msg =
    { label : Maybe (Shared.Label msg)
    , type_ : String
    , disabled : Bool
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , onSubmitEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias InputUrlAttributes msg =
    InputTextAttributes msg



type alias InputNumberAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , label : Maybe (Shared.Label msg)
    , rawStyle : Maybe Elegant.Style
    , value : Maybe Int
    , onInputEvent : Maybe (Int -> msg)
    , fromStringInput : String -> Int
    , step : Maybe Int
    , max : Maybe Int
    , min : Maybe Int
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , disabled : Bool
    }



type alias InputColorAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , label : Maybe (Shared.Label msg)
    , rawStyle : Maybe Elegant.Style
    , value : Maybe Color
    , onInputEvent : Maybe (Color -> msg)
    , fromStringInput : String -> Color
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    }



type alias InputFileAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , label : Maybe (Shared.Label msg)
    , rawStyle : Maybe Elegant.Style
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    }



label : Position -> List (Html msg) -> { c | label : Maybe (Shared.Label msg) } -> { c | label : Maybe (Shared.Label msg) }
label position content record =
    { record
        | label =
            Just <|
                Shared.label <|
                    \input ->
                        Html.label [] <|
                            case position of
                                Before ->
                                    content ++ [ input ]

                                After ->
                                    input :: content
    }



value : a -> { c | value : Maybe a } -> { c | value : Maybe a }
value =
    setValue


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



title : String -> Modifier { a | universal : UniversalAttributes }
title =
    setValueInUniversal setTitle



id : String -> Modifier { a | universal : UniversalAttributes }
id =
    setValueInUniversal setId




```



---

### **tabindex**
```elm
tabindex : Maybe Int
    , id : Maybe String
    , class : List String
    }



type alias FlowAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias NodeAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexContainerProperties (NodeAttributes msg)



type alias FlexContainerAttributes msg =
    { flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexItemProperties (NodeAttributes msg)



type alias FlexItemAttributes msg =
    { flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridContainerProperties (NodeAttributes msg)



type alias GridContainerAttributes msg =
    { gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridItemProperties (NodeAttributes msg)



type alias GridItemAttributes msg =
    { gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- BlockContainer (FlowAttributes msg)



type alias BlockAttributes msg =
    { block : List ( Modifiers BlockDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias HeadingAttributes msg =
    BlockAttributes msg



type alias ButtonAttributes msg =
    { disabled : Bool
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias AAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , href : Maybe String
    , target : Maybe String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias TextareaAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , value : Maybe String
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    , name : Maybe String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias ImgAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , alt : String
    , width : Maybe Int
    , height : Maybe Int
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias AudioAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias ProgressAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias ScriptAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , data : List ( String, String )
    , rawStyle : Maybe Elegant.Style
    }



type alias InputAttributes a =
    { a | type_ : String, name : Maybe String }



type alias InputHiddenAttributes =
    { name : Maybe String, type_ : String, value : Maybe String, universal : UniversalAttributes }



type alias LabelAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , position : Position
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias InputRadioAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , value : Maybe String
    , block : Maybe (List ( Modifiers Display.BlockDetails, StyleSelector ))
    , label : Maybe (Shared.Label msg)
    , rawStyle : Maybe Elegant.Style
    }



type alias InputCheckboxAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , value : Maybe String
    , label : Maybe (Shared.Label msg)
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , checked : Bool
    , onCheckEvent : Maybe (Bool -> msg)
    , rawStyle : Maybe Elegant.Style
    }



type alias InputTextAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , value : Maybe String
    , label : Maybe (Shared.Label msg)
    , placeholder : Maybe String
    , autocomplete : Bool
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias InputTelAttributes msg =
    InputTextAttributes msg



type alias InputSubmitAttributes msg =
    { label : Maybe (Shared.Label msg)
    , type_ : String
    , disabled : Bool
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , onSubmitEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias InputUrlAttributes msg =
    InputTextAttributes msg



type alias InputNumberAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , label : Maybe (Shared.Label msg)
    , rawStyle : Maybe Elegant.Style
    , value : Maybe Int
    , onInputEvent : Maybe (Int -> msg)
    , fromStringInput : String -> Int
    , step : Maybe Int
    , max : Maybe Int
    , min : Maybe Int
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , disabled : Bool
    }



type alias InputColorAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , label : Maybe (Shared.Label msg)
    , rawStyle : Maybe Elegant.Style
    , value : Maybe Color
    , onInputEvent : Maybe (Color -> msg)
    , fromStringInput : String -> Color
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    }



type alias InputFileAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , label : Maybe (Shared.Label msg)
    , rawStyle : Maybe Elegant.Style
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    }



label : Position -> List (Html msg) -> { c | label : Maybe (Shared.Label msg) } -> { c | label : Maybe (Shared.Label msg) }
label position content record =
    { record
        | label =
            Just <|
                Shared.label <|
                    \input ->
                        Html.label [] <|
                            case position of
                                Before ->
                                    content ++ [ input ]

                                After ->
                                    input :: content
    }



value : a -> { c | value : Maybe a } -> { c | value : Maybe a }
value =
    setValue


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



title : String -> Modifier { a | universal : UniversalAttributes }
title =
    setValueInUniversal setTitle



id : String -> Modifier { a | universal : UniversalAttributes }
id =
    setValueInUniversal setId



class : List String -> Modifier { a | universal : UniversalAttributes }
class =
    setValueInUniversal setClass




```


- [MaybeBlockContainer](#maybeblockcontainer)

### **type alias MaybeBlockContainer**
```elm
type alias MaybeBlockContainer a =
    { a | block : Maybe (List ( Modifiers BlockDetails, StyleSelector )) }
```


- [BlockContainer](#blockcontainer)

### **type alias BlockContainer**
```elm
type alias BlockContainer a =
    { a | block : List ( Modifiers BlockDetails, StyleSelector ) }
```


- [FlexContainerProperties](#flexcontainerproperties)

### **type alias FlexContainerProperties**
```elm
type alias FlexContainerProperties a =
    { a | flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector ) }
```


- [FlexItemProperties](#flexitemproperties)

### **type alias FlexItemProperties**
```elm
type alias FlexItemProperties a =
    { a | flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector ) }
```


- [GridContainerProperties](#gridcontainerproperties)

### **type alias GridContainerProperties**
```elm
type alias GridContainerProperties a =
    { a | gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector ) }
```


- [GridItemProperties](#griditemproperties)

### **type alias GridItemProperties**
```elm
type alias GridItemProperties a =
    { a | gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector ) }
```


- [VisibleAttributes](#visibleattributes)
- [visibleAttributesToHtmlAttributes](#visibleattributestohtmlattributes)
- [rawStyleToHtmlAttributes](#rawstyletohtmlattributes)

### **type alias VisibleAttributes**
```elm
type alias VisibleAttributes a =
    { a
        | box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }
```

Computed : BoxContainer (UniversalContainer a)

---

### **visibleAttributesToHtmlAttributes**
```elm
visibleAttributesToHtmlAttributes : VisibleAttributesAndEvents msg a -> List (Html.Attribute msg)

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
    { a | onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg), onEvent : Maybe ( String, Json.Decode.Decoder msg ), onBlurEvent : Maybe msg, onFocusEvent : Maybe msg, box : List ( Modifiers Box, BodyBuilder.Attributes.StyleSelector ), universal : BodyBuilder.Attributes.UniversalAttributes, rawStyle : Maybe Elegant.Style }
```

OnEvent msg (OnFocusEvent msg (OnBlurEvent msg (OnMouseEvents msg (VisibleAttributes a))))
- [UniversalAttributes](#universalattributes)
- [defaultUniversalAttributes](#defaultuniversalattributes)
- [universalAttributesToHtmlAttributes](#universalattributestohtmlattributes)

### **type alias UniversalAttributes**
```elm
type alias UniversalAttributes  =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }
```

TitleAttribute (TabindexAttribute (IdAttribute (ClassAttribute {})))

---

### **defaultUniversalAttributes**
```elm
defaultUniversalAttributes : UniversalAttributes

```



---

### **universalAttributesToHtmlAttributes**
```elm
universalAttributesToHtmlAttributes : UniversalAttributes -> List (Html.Attribute msg)

```


- [NodeAttributes](#nodeattributes)
- [defaultNodeAttributes](#defaultnodeattributes)
- [nodeAttributesToHtmlAttributes](#nodeattributestohtmlattributes)

### **type alias NodeAttributes**
```elm
type alias NodeAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }
```

Computed : MaybeBlockContainer (FlowAttributes msg)

---

### **defaultNodeAttributes**
```elm
defaultNodeAttributes : NodeAttributes msg

```



---

### **nodeAttributesToHtmlAttributes**
```elm
nodeAttributesToHtmlAttributes : NodeAttributes msg -> List (Html.Attribute msg)

```


- [BlockAttributes](#blockattributes)
- [width](#width)
- [height](#height)

### **type alias BlockAttributes**
```elm
type alias BlockAttributes msg =
    { block : List ( Modifiers BlockDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }
```



---

### **width**
```elm
width : Maybe Int }



type alias HeightAttribute a =
    { a | height : Maybe Int }



type alias DisabledAttribute a =
    { a | disabled : Bool }



type alias MaybeBlockContainer a =
    { a | block : Maybe (List ( Modifiers BlockDetails, StyleSelector )) }



type alias BlockContainer a =
    { a | block : List ( Modifiers BlockDetails, StyleSelector ) }



type alias AutocompleteAttribute a =
    { a | autocomplete : Bool }



type alias PlaceholderAttribute a =
    { a | placeholder : Maybe String }



type alias PositionAttribute a =
    { a | position : Position }



type alias DataAttribute a =
    { a | data : List ( String, String ) }



type alias TypeContainer a =
    { a | type_ : String }



type alias BoxContainer a =
    { a | box : List ( Modifiers Box, StyleSelector ) }



type alias CheckedContainer a =
    { a | checked : Bool }



type alias UniversalContainer a =
    { a | universal : UniversalAttributes }



type alias FlexContainerProperties a =
    { a | flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector ) }



type alias FlexItemProperties a =
    { a | flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector ) }



type alias GridContainerProperties a =
    { a | gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector ) }



type alias GridItemProperties a =
    { a | gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector ) }



type Position
    = Before
    | After



type alias VisibleAttributes a =
    { a
        | box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias StringValue a =
    ValueAttribute String a



type alias IntValue a =
    ValueAttribute Int a



type alias ColorValue a =
    ValueAttribute Color a



type alias VisibleAttributesAndEvents msg a =
    { a
        | onMouseEvents : Maybe (OnMouseEventsInside msg)
        , onEvent : Maybe ( String, Decoder msg )
        , onBlurEvent : Maybe msg
        , onFocusEvent : Maybe msg
        , box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias InputPasswordAttributes msg =
    InputTextAttributes msg



type alias InputRangeAttributes msg =
    InputNumberAttributes msg



type alias SelectAttributes msg =
    { block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , value : Maybe String
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    }



type alias UniversalAttributes =
    { title : Maybe String
    , tabindex : Maybe Int
    , id : Maybe String
    , class : List String
    }



type alias FlowAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias NodeAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexContainerProperties (NodeAttributes msg)



type alias FlexContainerAttributes msg =
    { flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexItemProperties (NodeAttributes msg)



type alias FlexItemAttributes msg =
    { flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridContainerProperties (NodeAttributes msg)



type alias GridContainerAttributes msg =
    { gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridItemProperties (NodeAttributes msg)



type alias GridItemAttributes msg =
    { gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- BlockContainer (FlowAttributes msg)



type alias BlockAttributes msg =
    { block : List ( Modifiers BlockDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias HeadingAttributes msg =
    BlockAttributes msg



type alias ButtonAttributes msg =
    { disabled : Bool
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias AAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , href : Maybe String
    , target : Maybe String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias TextareaAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , value : Maybe String
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    , name : Maybe String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias ImgAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , alt : String
    , 
```



---

### **height**
```elm
height : Maybe Int }



type alias DisabledAttribute a =
    { a | disabled : Bool }



type alias MaybeBlockContainer a =
    { a | block : Maybe (List ( Modifiers BlockDetails, StyleSelector )) }



type alias BlockContainer a =
    { a | block : List ( Modifiers BlockDetails, StyleSelector ) }



type alias AutocompleteAttribute a =
    { a | autocomplete : Bool }



type alias PlaceholderAttribute a =
    { a | placeholder : Maybe String }



type alias PositionAttribute a =
    { a | position : Position }



type alias DataAttribute a =
    { a | data : List ( String, String ) }



type alias TypeContainer a =
    { a | type_ : String }



type alias BoxContainer a =
    { a | box : List ( Modifiers Box, StyleSelector ) }



type alias CheckedContainer a =
    { a | checked : Bool }



type alias UniversalContainer a =
    { a | universal : UniversalAttributes }



type alias FlexContainerProperties a =
    { a | flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector ) }



type alias FlexItemProperties a =
    { a | flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector ) }



type alias GridContainerProperties a =
    { a | gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector ) }



type alias GridItemProperties a =
    { a | gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector ) }



type Position
    = Before
    | After



type alias VisibleAttributes a =
    { a
        | box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias StringValue a =
    ValueAttribute String a



type alias IntValue a =
    ValueAttribute Int a



type alias ColorValue a =
    ValueAttribute Color a



type alias VisibleAttributesAndEvents msg a =
    { a
        | onMouseEvents : Maybe (OnMouseEventsInside msg)
        , onEvent : Maybe ( String, Decoder msg )
        , onBlurEvent : Maybe msg
        , onFocusEvent : Maybe msg
        , box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias InputPasswordAttributes msg =
    InputTextAttributes msg



type alias InputRangeAttributes msg =
    InputNumberAttributes msg



type alias SelectAttributes msg =
    { block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , value : Maybe String
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    }



type alias UniversalAttributes =
    { title : Maybe String
    , tabindex : Maybe Int
    , id : Maybe String
    , class : List String
    }



type alias FlowAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias NodeAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexContainerProperties (NodeAttributes msg)



type alias FlexContainerAttributes msg =
    { flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexItemProperties (NodeAttributes msg)



type alias FlexItemAttributes msg =
    { flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridContainerProperties (NodeAttributes msg)



type alias GridContainerAttributes msg =
    { gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridItemProperties (NodeAttributes msg)



type alias GridItemAttributes msg =
    { gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- BlockContainer (FlowAttributes msg)



type alias BlockAttributes msg =
    { block : List ( Modifiers BlockDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias HeadingAttributes msg =
    BlockAttributes msg



type alias ButtonAttributes msg =
    { disabled : Bool
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias AAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , href : Maybe String
    , target : Maybe String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias TextareaAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , value : Maybe String
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    , name : Maybe String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias ImgAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , alt : String
    , width : Maybe Int
    , 
```


- [HeadingAttributes](#headingattributes)
- [defaultHeadingAttributes](#defaultheadingattributes)
- [headingAttributesToHtmlAttributes](#headingattributestohtmlattributes)

### **type alias HeadingAttributes**
```elm
type alias HeadingAttributes msg =
    BlockAttributes msg



type alias ButtonAttributes msg =
    { disabled : Bool
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }
```



---

### **defaultHeadingAttributes**
```elm
defaultHeadingAttributes : HeadingAttributes msg

```



---

### **headingAttributesToHtmlAttributes**
```elm
headingAttributesToHtmlAttributes : HeadingAttributes msg -> List (Html.Attribute msg)

```


- [FlowAttributes](#flowattributes)
- [defaultFlowAttributes](#defaultflowattributes)
- [flowAttributesToHtmlAttributes](#flowattributestohtmlattributes)

### **type alias FlowAttributes**
```elm
type alias FlowAttributes msg =  
    { onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) , onEvent : Maybe ( String, Json.Decode.Decoder msg ) , onBlurEvent : Maybe msg , onFocusEvent : Maybe msg , box : List ( Modifiers Box, BodyBuilder.Attributes.StyleSelector ) , universal : BodyBuilder.Attributes.UniversalAttributes , rawStyle : Maybe Elegant.Style }
```



---

### **defaultFlowAttributes**
```elm
defaultFlowAttributes : FlowAttributes msg

```



---

### **flowAttributesToHtmlAttributes**
```elm
flowAttributesToHtmlAttributes : FlowAttributes msg -> List (Html.Attribute msg)

```


- [FlexContainerAttributes](#flexcontainerattributes)
- [defaultFlexContainerAttributes](#defaultflexcontainerattributes)
- [flexContainerAttributesToHtmlAttributes](#flexcontainerattributestohtmlattributes)

### **type alias FlexContainerAttributes**
```elm
type alias FlexContainerAttributes msg =
    { flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }
```



---

### **defaultFlexContainerAttributes**
```elm
defaultFlexContainerAttributes : FlexContainerAttributes msg

```



---

### **flexContainerAttributesToHtmlAttributes**
```elm
flexContainerAttributesToHtmlAttributes : FlexContainerAttributes msg -> List (Html.Attribute msg)

```


- [FlexItemAttributes](#flexitemattributes)
- [defaultFlexItemAttributes](#defaultflexitemattributes)
- [flexItemAttributesToHtmlAttributes](#flexitemattributestohtmlattributes)

### **type alias FlexItemAttributes**
```elm
type alias FlexItemAttributes msg =
    { flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }
```



---

### **defaultFlexItemAttributes**
```elm
defaultFlexItemAttributes : FlexItemAttributes msg

```



---

### **flexItemAttributesToHtmlAttributes**
```elm
flexItemAttributesToHtmlAttributes : FlexItemAttributes msg -> List (Html.Attribute msg)

```


- [GridContainerAttributes](#gridcontainerattributes)
- [defaultGridContainerAttributes](#defaultgridcontainerattributes)
- [gridContainerAttributesToHtmlAttributes](#gridcontainerattributestohtmlattributes)

### **type alias GridContainerAttributes**
```elm
type alias GridContainerAttributes msg =
    { gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }
```



---

### **defaultGridContainerAttributes**
```elm
defaultGridContainerAttributes : GridContainerAttributes msg

```



---

### **gridContainerAttributesToHtmlAttributes**
```elm
gridContainerAttributesToHtmlAttributes : GridContainerAttributes msg -> List (Html.Attribute msg)

```


- [GridItemAttributes](#griditemattributes)
- [defaultGridItemAttributes](#defaultgriditemattributes)
- [gridItemAttributesToHtmlAttributes](#griditemattributestohtmlattributes)

### **type alias GridItemAttributes**
```elm
type alias GridItemAttributes msg =
    { gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }
```



---

### **defaultGridItemAttributes**
```elm
defaultGridItemAttributes : GridItemAttributes msg

```



---

### **gridItemAttributesToHtmlAttributes**
```elm
gridItemAttributesToHtmlAttributes : GridItemAttributes msg -> List (Html.Attribute msg)

```


- [ButtonAttributes](#buttonattributes)
- [defaultButtonAttributes](#defaultbuttonattributes)
- [buttonAttributesToHtmlAttributes](#buttonattributestohtmlattributes)

### **type alias ButtonAttributes**
```elm
type alias ButtonAttributes msg =  
    { disabled : Bool , block : Maybe (List ( Modifiers Display.BlockDetails , BodyBuilder.Attributes.StyleSelector )) , onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) , onEvent : Maybe ( String, Json.Decode.Decoder msg ) , onBlurEvent : Maybe msg , onFocusEvent : Maybe msg , box : List ( Modifiers Box, BodyBuilder.Attributes.StyleSelector ) , universal : BodyBuilder.Attributes.UniversalAttributes , rawStyle : Maybe Elegant.Style }
```



---

### **defaultButtonAttributes**
```elm
defaultButtonAttributes : ButtonAttributes msg

```



---

### **buttonAttributesToHtmlAttributes**
```elm
buttonAttributesToHtmlAttributes : ButtonAttributes msg -> List (Html.Attribute msg)

```


- [AAttributes](#aattributes)
- [target](#target)
- [href](#href)
- [defaultAAttributes](#defaultaattributes)
- [aAttributesToHtmlAttributes](#aattributestohtmlattributes)

### **type alias AAttributes**
```elm
type alias AAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , href : Maybe String
    , target : Maybe String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }
```



---

### **target**
```elm
target : Maybe String }



type alias HrefAttribute a =
    { a | href : Maybe String }



type alias NameAttribute a =
    { a | name : Maybe String }



type alias WidthAttribute a =
    { a | width : Maybe Int }



type alias HeightAttribute a =
    { a | height : Maybe Int }



type alias DisabledAttribute a =
    { a | disabled : Bool }



type alias MaybeBlockContainer a =
    { a | block : Maybe (List ( Modifiers BlockDetails, StyleSelector )) }



type alias BlockContainer a =
    { a | block : List ( Modifiers BlockDetails, StyleSelector ) }



type alias AutocompleteAttribute a =
    { a | autocomplete : Bool }



type alias PlaceholderAttribute a =
    { a | placeholder : Maybe String }



type alias PositionAttribute a =
    { a | position : Position }



type alias DataAttribute a =
    { a | data : List ( String, String ) }



type alias TypeContainer a =
    { a | type_ : String }



type alias BoxContainer a =
    { a | box : List ( Modifiers Box, StyleSelector ) }



type alias CheckedContainer a =
    { a | checked : Bool }



type alias UniversalContainer a =
    { a | universal : UniversalAttributes }



type alias FlexContainerProperties a =
    { a | flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector ) }



type alias FlexItemProperties a =
    { a | flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector ) }



type alias GridContainerProperties a =
    { a | gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector ) }



type alias GridItemProperties a =
    { a | gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector ) }



type Position
    = Before
    | After



type alias VisibleAttributes a =
    { a
        | box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias StringValue a =
    ValueAttribute String a



type alias IntValue a =
    ValueAttribute Int a



type alias ColorValue a =
    ValueAttribute Color a



type alias VisibleAttributesAndEvents msg a =
    { a
        | onMouseEvents : Maybe (OnMouseEventsInside msg)
        , onEvent : Maybe ( String, Decoder msg )
        , onBlurEvent : Maybe msg
        , onFocusEvent : Maybe msg
        , box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias InputPasswordAttributes msg =
    InputTextAttributes msg



type alias InputRangeAttributes msg =
    InputNumberAttributes msg



type alias SelectAttributes msg =
    { block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , value : Maybe String
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    }



type alias UniversalAttributes =
    { title : Maybe String
    , tabindex : Maybe Int
    , id : Maybe String
    , class : List String
    }



type alias FlowAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias NodeAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexContainerProperties (NodeAttributes msg)



type alias FlexContainerAttributes msg =
    { flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexItemProperties (NodeAttributes msg)



type alias FlexItemAttributes msg =
    { flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridContainerProperties (NodeAttributes msg)



type alias GridContainerAttributes msg =
    { gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridItemProperties (NodeAttributes msg)



type alias GridItemAttributes msg =
    { gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- BlockContainer (FlowAttributes msg)



type alias BlockAttributes msg =
    { block : List ( Modifiers BlockDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias HeadingAttributes msg =
    BlockAttributes msg



type alias ButtonAttributes msg =
    { disabled : Bool
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias AAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , href : Maybe String
    , 
```



---

### **href**
```elm
href : Maybe String }



type alias NameAttribute a =
    { a | name : Maybe String }



type alias WidthAttribute a =
    { a | width : Maybe Int }



type alias HeightAttribute a =
    { a | height : Maybe Int }



type alias DisabledAttribute a =
    { a | disabled : Bool }



type alias MaybeBlockContainer a =
    { a | block : Maybe (List ( Modifiers BlockDetails, StyleSelector )) }



type alias BlockContainer a =
    { a | block : List ( Modifiers BlockDetails, StyleSelector ) }



type alias AutocompleteAttribute a =
    { a | autocomplete : Bool }



type alias PlaceholderAttribute a =
    { a | placeholder : Maybe String }



type alias PositionAttribute a =
    { a | position : Position }



type alias DataAttribute a =
    { a | data : List ( String, String ) }



type alias TypeContainer a =
    { a | type_ : String }



type alias BoxContainer a =
    { a | box : List ( Modifiers Box, StyleSelector ) }



type alias CheckedContainer a =
    { a | checked : Bool }



type alias UniversalContainer a =
    { a | universal : UniversalAttributes }



type alias FlexContainerProperties a =
    { a | flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector ) }



type alias FlexItemProperties a =
    { a | flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector ) }



type alias GridContainerProperties a =
    { a | gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector ) }



type alias GridItemProperties a =
    { a | gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector ) }



type Position
    = Before
    | After



type alias VisibleAttributes a =
    { a
        | box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias StringValue a =
    ValueAttribute String a



type alias IntValue a =
    ValueAttribute Int a



type alias ColorValue a =
    ValueAttribute Color a



type alias VisibleAttributesAndEvents msg a =
    { a
        | onMouseEvents : Maybe (OnMouseEventsInside msg)
        , onEvent : Maybe ( String, Decoder msg )
        , onBlurEvent : Maybe msg
        , onFocusEvent : Maybe msg
        , box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias InputPasswordAttributes msg =
    InputTextAttributes msg



type alias InputRangeAttributes msg =
    InputNumberAttributes msg



type alias SelectAttributes msg =
    { block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , value : Maybe String
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    }



type alias UniversalAttributes =
    { title : Maybe String
    , tabindex : Maybe Int
    , id : Maybe String
    , class : List String
    }



type alias FlowAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias NodeAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexContainerProperties (NodeAttributes msg)



type alias FlexContainerAttributes msg =
    { flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexItemProperties (NodeAttributes msg)



type alias FlexItemAttributes msg =
    { flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridContainerProperties (NodeAttributes msg)



type alias GridContainerAttributes msg =
    { gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridItemProperties (NodeAttributes msg)



type alias GridItemAttributes msg =
    { gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- BlockContainer (FlowAttributes msg)



type alias BlockAttributes msg =
    { block : List ( Modifiers BlockDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias HeadingAttributes msg =
    BlockAttributes msg



type alias ButtonAttributes msg =
    { disabled : Bool
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias AAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , 
```



---

### **defaultAAttributes**
```elm
defaultAAttributes : AAttributes msg

```



---

### **aAttributesToHtmlAttributes**
```elm
aAttributesToHtmlAttributes : AAttributes msg -> List (Html.Attribute msg)

```


- [ImgAttributes](#imgattributes)
- [defaultImgAttributes](#defaultimgattributes)
- [imgAttributesToHtmlAttributes](#imgattributestohtmlattributes)

### **type alias ImgAttributes**
```elm
type alias ImgAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , alt : String
    , width : Maybe Int
    , height : Maybe Int
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }
```



---

### **defaultImgAttributes**
```elm
defaultImgAttributes : String -> String -> ImgAttributes msg

```



---

### **imgAttributesToHtmlAttributes**
```elm
imgAttributesToHtmlAttributes : ImgAttributes msg -> List (Html.Attribute msg)

```


- [AudioAttributes](#audioattributes)
- [defaultAudioAttributes](#defaultaudioattributes)
- [audioAttributesToHtmlAttributes](#audioattributestohtmlattributes)

### **type alias AudioAttributes**
```elm
type alias AudioAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }
```



---

### **defaultAudioAttributes**
```elm
defaultAudioAttributes : AudioAttributes msg

```



---

### **audioAttributesToHtmlAttributes**
```elm
audioAttributesToHtmlAttributes : AudioAttributes msg -> List (Html.Attribute msg)

```


- [ScriptAttributes](#scriptattributes)
- [defaultScriptAttributes](#defaultscriptattributes)
- [scriptAttributesToHtmlAttributes](#scriptattributestohtmlattributes)

### **type alias ScriptAttributes**
```elm
type alias ScriptAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , data : List ( String, String )
    , rawStyle : Maybe Elegant.Style
    }
```



---

### **defaultScriptAttributes**
```elm
defaultScriptAttributes : ScriptAttributes msg

```



---

### **scriptAttributesToHtmlAttributes**
```elm
scriptAttributesToHtmlAttributes : ScriptAttributes msg -> List (Html.Attribute msg)

```


- [ProgressAttributes](#progressattributes)
- [defaultProgressAttributes](#defaultprogressattributes)
- [progressAttributesToHtmlAttributes](#progressattributestohtmlattributes)

### **type alias ProgressAttributes**
```elm
type alias ProgressAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }
```



---

### **defaultProgressAttributes**
```elm
defaultProgressAttributes : ProgressAttributes msg

```



---

### **progressAttributesToHtmlAttributes**
```elm
progressAttributesToHtmlAttributes : ProgressAttributes msg -> List (Html.Attribute msg)

```


- [SelectAttributes](#selectattributes)
- [defaultSelectAttributes](#defaultselectattributes)
- [selectAttributesToHtmlAttributes](#selectattributestohtmlattributes)

### **type alias SelectAttributes**
```elm
type alias SelectAttributes msg =  
    { block : Maybe (List ( Modifiers Display.BlockDetails , BodyBuilder.Attributes.StyleSelector )) , value : Maybe String , onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) , onEvent : Maybe ( String, Json.Decode.Decoder msg ) , onBlurEvent : Maybe msg , onFocusEvent : Maybe msg , box : List ( Modifiers Box, BodyBuilder.Attributes.StyleSelector ) , universal : BodyBuilder.Attributes.UniversalAttributes , rawStyle : Maybe Elegant.Style , onInputEvent : Maybe (String -> msg) , fromStringInput : String -> String }
```

Computed : -- MaybeBlockContainer (StringValue (FlowAttributes msg))

---

### **defaultSelectAttributes**
```elm
defaultSelectAttributes : SelectAttributes msg

```



---

### **selectAttributesToHtmlAttributes**
```elm
selectAttributesToHtmlAttributes : SelectAttributes msg -> List (Html.Attribute msg)

```


- [LabelAttributes](#labelattributes)
- [label](#label)
- [PositionAttribute](#positionattribute)
- [Position](#position)

### **type alias LabelAttributes**
```elm
type alias LabelAttributes msg =  
    { onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) , onEvent : Maybe ( String, Json.Decode.Decoder msg ) , onBlurEvent : Maybe msg , onFocusEvent : Maybe msg , box : List ( Modifiers Box, BodyBuilder.Attributes.StyleSelector ) , universal : BodyBuilder.Attributes.UniversalAttributes , position : BodyBuilder.Attributes.Position , block : Maybe (List ( Modifiers Display.BlockDetails , BodyBuilder.Attributes.StyleSelector )) , rawStyle : Maybe Elegant.Style }
```



---

### **label**
```elm
label : Maybe (Shared.Label msg)
    , rawStyle : Maybe Elegant.Style
    }



type alias InputCheckboxAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , value : Maybe String
    , 
```



---

### **type alias PositionAttribute**
```elm
type alias PositionAttribute a =
    { a | position : Position }
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
value : Maybe b }



type alias StepAttribute a =
    { a | step : Maybe Int }



type alias MaxAttribute a =
    { a | max : Maybe Int }



type alias MinAttribute a =
    { a | min : Maybe Int }



type alias TargetAttribute a =
    { a | target : Maybe String }



type alias HrefAttribute a =
    { a | href : Maybe String }



type alias NameAttribute a =
    { a | name : Maybe String }



type alias WidthAttribute a =
    { a | width : Maybe Int }



type alias HeightAttribute a =
    { a | height : Maybe Int }



type alias DisabledAttribute a =
    { a | disabled : Bool }



type alias MaybeBlockContainer a =
    { a | block : Maybe (List ( Modifiers BlockDetails, StyleSelector )) }



type alias BlockContainer a =
    { a | block : List ( Modifiers BlockDetails, StyleSelector ) }



type alias AutocompleteAttribute a =
    { a | autocomplete : Bool }



type alias PlaceholderAttribute a =
    { a | placeholder : Maybe String }



type alias PositionAttribute a =
    { a | position : Position }



type alias DataAttribute a =
    { a | data : List ( String, String ) }



type alias TypeContainer a =
    { a | type_ : String }



type alias BoxContainer a =
    { a | box : List ( Modifiers Box, StyleSelector ) }



type alias CheckedContainer a =
    { a | checked : Bool }



type alias UniversalContainer a =
    { a | universal : UniversalAttributes }



type alias FlexContainerProperties a =
    { a | flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector ) }



type alias FlexItemProperties a =
    { a | flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector ) }



type alias GridContainerProperties a =
    { a | gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector ) }



type alias GridItemProperties a =
    { a | gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector ) }



type Position
    = Before
    | After



type alias VisibleAttributes a =
    { a
        | box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias StringValue a =
    ValueAttribute String a



type alias IntValue a =
    ValueAttribute Int a



type alias ColorValue a =
    ValueAttribute Color a



type alias VisibleAttributesAndEvents msg a =
    { a
        | onMouseEvents : Maybe (OnMouseEventsInside msg)
        , onEvent : Maybe ( String, Decoder msg )
        , onBlurEvent : Maybe msg
        , onFocusEvent : Maybe msg
        , box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias InputPasswordAttributes msg =
    InputTextAttributes msg



type alias InputRangeAttributes msg =
    InputNumberAttributes msg



type alias SelectAttributes msg =
    { block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , 
```



---

### **disabled**
```elm
disabled : Bool }



type alias MaybeBlockContainer a =
    { a | block : Maybe (List ( Modifiers BlockDetails, StyleSelector )) }



type alias BlockContainer a =
    { a | block : List ( Modifiers BlockDetails, StyleSelector ) }



type alias AutocompleteAttribute a =
    { a | autocomplete : Bool }



type alias PlaceholderAttribute a =
    { a | placeholder : Maybe String }



type alias PositionAttribute a =
    { a | position : Position }



type alias DataAttribute a =
    { a | data : List ( String, String ) }



type alias TypeContainer a =
    { a | type_ : String }



type alias BoxContainer a =
    { a | box : List ( Modifiers Box, StyleSelector ) }



type alias CheckedContainer a =
    { a | checked : Bool }



type alias UniversalContainer a =
    { a | universal : UniversalAttributes }



type alias FlexContainerProperties a =
    { a | flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector ) }



type alias FlexItemProperties a =
    { a | flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector ) }



type alias GridContainerProperties a =
    { a | gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector ) }



type alias GridItemProperties a =
    { a | gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector ) }



type Position
    = Before
    | After



type alias VisibleAttributes a =
    { a
        | box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias StringValue a =
    ValueAttribute String a



type alias IntValue a =
    ValueAttribute Int a



type alias ColorValue a =
    ValueAttribute Color a



type alias VisibleAttributesAndEvents msg a =
    { a
        | onMouseEvents : Maybe (OnMouseEventsInside msg)
        , onEvent : Maybe ( String, Decoder msg )
        , onBlurEvent : Maybe msg
        , onFocusEvent : Maybe msg
        , box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias InputPasswordAttributes msg =
    InputTextAttributes msg



type alias InputRangeAttributes msg =
    InputNumberAttributes msg



type alias SelectAttributes msg =
    { block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , value : Maybe String
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    }



type alias UniversalAttributes =
    { title : Maybe String
    , tabindex : Maybe Int
    , id : Maybe String
    , class : List String
    }



type alias FlowAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias NodeAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexContainerProperties (NodeAttributes msg)



type alias FlexContainerAttributes msg =
    { flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexItemProperties (NodeAttributes msg)



type alias FlexItemAttributes msg =
    { flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridContainerProperties (NodeAttributes msg)



type alias GridContainerAttributes msg =
    { gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridItemProperties (NodeAttributes msg)



type alias GridItemAttributes msg =
    { gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- BlockContainer (FlowAttributes msg)



type alias BlockAttributes msg =
    { block : List ( Modifiers BlockDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias HeadingAttributes msg =
    BlockAttributes msg



type alias ButtonAttributes msg =
    { 
```



---

### **name**
```elm
name : Maybe String }



type alias WidthAttribute a =
    { a | width : Maybe Int }



type alias HeightAttribute a =
    { a | height : Maybe Int }



type alias DisabledAttribute a =
    { a | disabled : Bool }



type alias MaybeBlockContainer a =
    { a | block : Maybe (List ( Modifiers BlockDetails, StyleSelector )) }



type alias BlockContainer a =
    { a | block : List ( Modifiers BlockDetails, StyleSelector ) }



type alias AutocompleteAttribute a =
    { a | autocomplete : Bool }



type alias PlaceholderAttribute a =
    { a | placeholder : Maybe String }



type alias PositionAttribute a =
    { a | position : Position }



type alias DataAttribute a =
    { a | data : List ( String, String ) }



type alias TypeContainer a =
    { a | type_ : String }



type alias BoxContainer a =
    { a | box : List ( Modifiers Box, StyleSelector ) }



type alias CheckedContainer a =
    { a | checked : Bool }



type alias UniversalContainer a =
    { a | universal : UniversalAttributes }



type alias FlexContainerProperties a =
    { a | flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector ) }



type alias FlexItemProperties a =
    { a | flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector ) }



type alias GridContainerProperties a =
    { a | gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector ) }



type alias GridItemProperties a =
    { a | gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector ) }



type Position
    = Before
    | After



type alias VisibleAttributes a =
    { a
        | box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias StringValue a =
    ValueAttribute String a



type alias IntValue a =
    ValueAttribute Int a



type alias ColorValue a =
    ValueAttribute Color a



type alias VisibleAttributesAndEvents msg a =
    { a
        | onMouseEvents : Maybe (OnMouseEventsInside msg)
        , onEvent : Maybe ( String, Decoder msg )
        , onBlurEvent : Maybe msg
        , onFocusEvent : Maybe msg
        , box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias InputPasswordAttributes msg =
    InputTextAttributes msg



type alias InputRangeAttributes msg =
    InputNumberAttributes msg



type alias SelectAttributes msg =
    { block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , value : Maybe String
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    }



type alias UniversalAttributes =
    { title : Maybe String
    , tabindex : Maybe Int
    , id : Maybe String
    , class : List String
    }



type alias FlowAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias NodeAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexContainerProperties (NodeAttributes msg)



type alias FlexContainerAttributes msg =
    { flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexItemProperties (NodeAttributes msg)



type alias FlexItemAttributes msg =
    { flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridContainerProperties (NodeAttributes msg)



type alias GridContainerAttributes msg =
    { gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridItemProperties (NodeAttributes msg)



type alias GridItemAttributes msg =
    { gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- BlockContainer (FlowAttributes msg)



type alias BlockAttributes msg =
    { block : List ( Modifiers BlockDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias HeadingAttributes msg =
    BlockAttributes msg



type alias ButtonAttributes msg =
    { disabled : Bool
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias AAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , href : Maybe String
    , target : Maybe String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias TextareaAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , value : Maybe String
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    , 
```



---

### **disabledAttributeToHtmlAttributes**
```elm
disabledAttributeToHtmlAttributes : Bool -> List (Html.Attribute msg)

```



---

### **inputAttributesToHtmlAttributes**
```elm
inputAttributesToHtmlAttributes : InputAttributes a -> List (Html.Attribute msg)

```



---

### **inputVisibleToHtmlAttributes**
```elm
inputVisibleToHtmlAttributes : 
    VisibleAttributesAndEvents msg { a | name : Maybe String, type_ : String }
    -> List (Html.Attribute msg)

```


- [InputHiddenAttributes](#inputhiddenattributes)
- [name](#name-1)
- [defaultInputHiddenAttributes](#defaultinputhiddenattributes)
- [inputHiddenAttributesToHtmlAttributes](#inputhiddenattributestohtmlattributes)

### **type alias InputHiddenAttributes**
```elm
type alias InputHiddenAttributes  =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , position : Position
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }
```



---

### **name**
```elm
name : Maybe String }



type alias WidthAttribute a =
    { a | width : Maybe Int }



type alias HeightAttribute a =
    { a | height : Maybe Int }



type alias DisabledAttribute a =
    { a | disabled : Bool }



type alias MaybeBlockContainer a =
    { a | block : Maybe (List ( Modifiers BlockDetails, StyleSelector )) }



type alias BlockContainer a =
    { a | block : List ( Modifiers BlockDetails, StyleSelector ) }



type alias AutocompleteAttribute a =
    { a | autocomplete : Bool }



type alias PlaceholderAttribute a =
    { a | placeholder : Maybe String }



type alias PositionAttribute a =
    { a | position : Position }



type alias DataAttribute a =
    { a | data : List ( String, String ) }



type alias TypeContainer a =
    { a | type_ : String }



type alias BoxContainer a =
    { a | box : List ( Modifiers Box, StyleSelector ) }



type alias CheckedContainer a =
    { a | checked : Bool }



type alias UniversalContainer a =
    { a | universal : UniversalAttributes }



type alias FlexContainerProperties a =
    { a | flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector ) }



type alias FlexItemProperties a =
    { a | flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector ) }



type alias GridContainerProperties a =
    { a | gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector ) }



type alias GridItemProperties a =
    { a | gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector ) }



type Position
    = Before
    | After



type alias VisibleAttributes a =
    { a
        | box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias StringValue a =
    ValueAttribute String a



type alias IntValue a =
    ValueAttribute Int a



type alias ColorValue a =
    ValueAttribute Color a



type alias VisibleAttributesAndEvents msg a =
    { a
        | onMouseEvents : Maybe (OnMouseEventsInside msg)
        , onEvent : Maybe ( String, Decoder msg )
        , onBlurEvent : Maybe msg
        , onFocusEvent : Maybe msg
        , box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias InputPasswordAttributes msg =
    InputTextAttributes msg



type alias InputRangeAttributes msg =
    InputNumberAttributes msg



type alias SelectAttributes msg =
    { block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , value : Maybe String
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    }



type alias UniversalAttributes =
    { title : Maybe String
    , tabindex : Maybe Int
    , id : Maybe String
    , class : List String
    }



type alias FlowAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias NodeAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexContainerProperties (NodeAttributes msg)



type alias FlexContainerAttributes msg =
    { flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexItemProperties (NodeAttributes msg)



type alias FlexItemAttributes msg =
    { flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridContainerProperties (NodeAttributes msg)



type alias GridContainerAttributes msg =
    { gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridItemProperties (NodeAttributes msg)



type alias GridItemAttributes msg =
    { gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- BlockContainer (FlowAttributes msg)



type alias BlockAttributes msg =
    { block : List ( Modifiers BlockDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias HeadingAttributes msg =
    BlockAttributes msg



type alias ButtonAttributes msg =
    { disabled : Bool
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias AAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , href : Maybe String
    , target : Maybe String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias TextareaAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , value : Maybe String
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    , 
```



---

### **defaultInputHiddenAttributes**
```elm
defaultInputHiddenAttributes : InputHiddenAttributes

```



---

### **inputHiddenAttributesToHtmlAttributes**
```elm
inputHiddenAttributesToHtmlAttributes : InputHiddenAttributes -> List (Html.Attribute msg)

```


- [InputPasswordAttributes](#inputpasswordattributes)
- [name](#name-2)
- [defaultInputPasswordAttributes](#defaultinputpasswordattributes)
- [inputPasswordAttributesToHtmlAttributes](#inputpasswordattributestohtmlattributes)

### **type alias InputPasswordAttributes**
```elm
type alias InputPasswordAttributes msg =
    InputTextAttributes msg



type alias InputRangeAttributes msg =
    InputNumberAttributes msg



type alias SelectAttributes msg =
    { block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , value : Maybe String
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    }
```



---

### **name**
```elm
name : Maybe String }



type alias WidthAttribute a =
    { a | width : Maybe Int }



type alias HeightAttribute a =
    { a | height : Maybe Int }



type alias DisabledAttribute a =
    { a | disabled : Bool }



type alias MaybeBlockContainer a =
    { a | block : Maybe (List ( Modifiers BlockDetails, StyleSelector )) }



type alias BlockContainer a =
    { a | block : List ( Modifiers BlockDetails, StyleSelector ) }



type alias AutocompleteAttribute a =
    { a | autocomplete : Bool }



type alias PlaceholderAttribute a =
    { a | placeholder : Maybe String }



type alias PositionAttribute a =
    { a | position : Position }



type alias DataAttribute a =
    { a | data : List ( String, String ) }



type alias TypeContainer a =
    { a | type_ : String }



type alias BoxContainer a =
    { a | box : List ( Modifiers Box, StyleSelector ) }



type alias CheckedContainer a =
    { a | checked : Bool }



type alias UniversalContainer a =
    { a | universal : UniversalAttributes }



type alias FlexContainerProperties a =
    { a | flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector ) }



type alias FlexItemProperties a =
    { a | flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector ) }



type alias GridContainerProperties a =
    { a | gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector ) }



type alias GridItemProperties a =
    { a | gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector ) }



type Position
    = Before
    | After



type alias VisibleAttributes a =
    { a
        | box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias StringValue a =
    ValueAttribute String a



type alias IntValue a =
    ValueAttribute Int a



type alias ColorValue a =
    ValueAttribute Color a



type alias VisibleAttributesAndEvents msg a =
    { a
        | onMouseEvents : Maybe (OnMouseEventsInside msg)
        , onEvent : Maybe ( String, Decoder msg )
        , onBlurEvent : Maybe msg
        , onFocusEvent : Maybe msg
        , box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias InputPasswordAttributes msg =
    InputTextAttributes msg



type alias InputRangeAttributes msg =
    InputNumberAttributes msg



type alias SelectAttributes msg =
    { block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , value : Maybe String
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    }



type alias UniversalAttributes =
    { title : Maybe String
    , tabindex : Maybe Int
    , id : Maybe String
    , class : List String
    }



type alias FlowAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias NodeAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexContainerProperties (NodeAttributes msg)



type alias FlexContainerAttributes msg =
    { flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexItemProperties (NodeAttributes msg)



type alias FlexItemAttributes msg =
    { flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridContainerProperties (NodeAttributes msg)



type alias GridContainerAttributes msg =
    { gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridItemProperties (NodeAttributes msg)



type alias GridItemAttributes msg =
    { gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- BlockContainer (FlowAttributes msg)



type alias BlockAttributes msg =
    { block : List ( Modifiers BlockDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias HeadingAttributes msg =
    BlockAttributes msg



type alias ButtonAttributes msg =
    { disabled : Bool
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias AAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , href : Maybe String
    , target : Maybe String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias TextareaAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , value : Maybe String
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    , 
```



---

### **defaultInputPasswordAttributes**
```elm
defaultInputPasswordAttributes : InputPasswordAttributes msg

```



---

### **inputPasswordAttributesToHtmlAttributes**
```elm
inputPasswordAttributesToHtmlAttributes : InputPasswordAttributes msg -> List (Html.Attribute msg)

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
name : Maybe String }



type alias WidthAttribute a =
    { a | width : Maybe Int }



type alias HeightAttribute a =
    { a | height : Maybe Int }



type alias DisabledAttribute a =
    { a | disabled : Bool }



type alias MaybeBlockContainer a =
    { a | block : Maybe (List ( Modifiers BlockDetails, StyleSelector )) }



type alias BlockContainer a =
    { a | block : List ( Modifiers BlockDetails, StyleSelector ) }



type alias AutocompleteAttribute a =
    { a | autocomplete : Bool }



type alias PlaceholderAttribute a =
    { a | placeholder : Maybe String }



type alias PositionAttribute a =
    { a | position : Position }



type alias DataAttribute a =
    { a | data : List ( String, String ) }



type alias TypeContainer a =
    { a | type_ : String }



type alias BoxContainer a =
    { a | box : List ( Modifiers Box, StyleSelector ) }



type alias CheckedContainer a =
    { a | checked : Bool }



type alias UniversalContainer a =
    { a | universal : UniversalAttributes }



type alias FlexContainerProperties a =
    { a | flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector ) }



type alias FlexItemProperties a =
    { a | flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector ) }



type alias GridContainerProperties a =
    { a | gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector ) }



type alias GridItemProperties a =
    { a | gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector ) }



type Position
    = Before
    | After



type alias VisibleAttributes a =
    { a
        | box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias StringValue a =
    ValueAttribute String a



type alias IntValue a =
    ValueAttribute Int a



type alias ColorValue a =
    ValueAttribute Color a



type alias VisibleAttributesAndEvents msg a =
    { a
        | onMouseEvents : Maybe (OnMouseEventsInside msg)
        , onEvent : Maybe ( String, Decoder msg )
        , onBlurEvent : Maybe msg
        , onFocusEvent : Maybe msg
        , box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias InputPasswordAttributes msg =
    InputTextAttributes msg



type alias InputRangeAttributes msg =
    InputNumberAttributes msg



type alias SelectAttributes msg =
    { block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , value : Maybe String
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    }



type alias UniversalAttributes =
    { title : Maybe String
    , tabindex : Maybe Int
    , id : Maybe String
    , class : List String
    }



type alias FlowAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias NodeAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexContainerProperties (NodeAttributes msg)



type alias FlexContainerAttributes msg =
    { flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexItemProperties (NodeAttributes msg)



type alias FlexItemAttributes msg =
    { flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridContainerProperties (NodeAttributes msg)



type alias GridContainerAttributes msg =
    { gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridItemProperties (NodeAttributes msg)



type alias GridItemAttributes msg =
    { gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- BlockContainer (FlowAttributes msg)



type alias BlockAttributes msg =
    { block : List ( Modifiers BlockDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias HeadingAttributes msg =
    BlockAttributes msg



type alias ButtonAttributes msg =
    { disabled : Bool
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias AAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , href : Maybe String
    , target : Maybe String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias TextareaAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , value : Maybe String
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    , 
```



---

### **step**
```elm
step : Maybe Int }



type alias MaxAttribute a =
    { a | max : Maybe Int }



type alias MinAttribute a =
    { a | min : Maybe Int }



type alias TargetAttribute a =
    { a | target : Maybe String }



type alias HrefAttribute a =
    { a | href : Maybe String }



type alias NameAttribute a =
    { a | name : Maybe String }



type alias WidthAttribute a =
    { a | width : Maybe Int }



type alias HeightAttribute a =
    { a | height : Maybe Int }



type alias DisabledAttribute a =
    { a | disabled : Bool }



type alias MaybeBlockContainer a =
    { a | block : Maybe (List ( Modifiers BlockDetails, StyleSelector )) }



type alias BlockContainer a =
    { a | block : List ( Modifiers BlockDetails, StyleSelector ) }



type alias AutocompleteAttribute a =
    { a | autocomplete : Bool }



type alias PlaceholderAttribute a =
    { a | placeholder : Maybe String }



type alias PositionAttribute a =
    { a | position : Position }



type alias DataAttribute a =
    { a | data : List ( String, String ) }



type alias TypeContainer a =
    { a | type_ : String }



type alias BoxContainer a =
    { a | box : List ( Modifiers Box, StyleSelector ) }



type alias CheckedContainer a =
    { a | checked : Bool }



type alias UniversalContainer a =
    { a | universal : UniversalAttributes }



type alias FlexContainerProperties a =
    { a | flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector ) }



type alias FlexItemProperties a =
    { a | flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector ) }



type alias GridContainerProperties a =
    { a | gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector ) }



type alias GridItemProperties a =
    { a | gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector ) }



type Position
    = Before
    | After



type alias VisibleAttributes a =
    { a
        | box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias StringValue a =
    ValueAttribute String a



type alias IntValue a =
    ValueAttribute Int a



type alias ColorValue a =
    ValueAttribute Color a



type alias VisibleAttributesAndEvents msg a =
    { a
        | onMouseEvents : Maybe (OnMouseEventsInside msg)
        , onEvent : Maybe ( String, Decoder msg )
        , onBlurEvent : Maybe msg
        , onFocusEvent : Maybe msg
        , box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias InputPasswordAttributes msg =
    InputTextAttributes msg



type alias InputRangeAttributes msg =
    InputNumberAttributes msg



type alias SelectAttributes msg =
    { block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , value : Maybe String
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    }



type alias UniversalAttributes =
    { title : Maybe String
    , tabindex : Maybe Int
    , id : Maybe String
    , class : List String
    }



type alias FlowAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias NodeAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexContainerProperties (NodeAttributes msg)



type alias FlexContainerAttributes msg =
    { flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexItemProperties (NodeAttributes msg)



type alias FlexItemAttributes msg =
    { flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridContainerProperties (NodeAttributes msg)



type alias GridContainerAttributes msg =
    { gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridItemProperties (NodeAttributes msg)



type alias GridItemAttributes msg =
    { gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- BlockContainer (FlowAttributes msg)



type alias BlockAttributes msg =
    { block : List ( Modifiers BlockDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias HeadingAttributes msg =
    BlockAttributes msg



type alias ButtonAttributes msg =
    { disabled : Bool
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias AAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , href : Maybe String
    , target : Maybe String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias TextareaAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , value : Maybe String
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    , name : Maybe String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias ImgAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , alt : String
    , width : Maybe Int
    , height : Maybe Int
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias AudioAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias ProgressAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias ScriptAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , data : List ( String, String )
    , rawStyle : Maybe Elegant.Style
    }



type alias InputAttributes a =
    { a | type_ : String, name : Maybe String }



type alias InputHiddenAttributes =
    { name : Maybe String, type_ : String, value : Maybe String, universal : UniversalAttributes }



type alias LabelAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , position : Position
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias InputRadioAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , value : Maybe String
    , block : Maybe (List ( Modifiers Display.BlockDetails, StyleSelector ))
    , label : Maybe (Shared.Label msg)
    , rawStyle : Maybe Elegant.Style
    }



type alias InputCheckboxAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , value : Maybe String
    , label : Maybe (Shared.Label msg)
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , checked : Bool
    , onCheckEvent : Maybe (Bool -> msg)
    , rawStyle : Maybe Elegant.Style
    }



type alias InputTextAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , value : Maybe String
    , label : Maybe (Shared.Label msg)
    , placeholder : Maybe String
    , autocomplete : Bool
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias InputTelAttributes msg =
    InputTextAttributes msg



type alias InputSubmitAttributes msg =
    { label : Maybe (Shared.Label msg)
    , type_ : String
    , disabled : Bool
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , onSubmitEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias InputUrlAttributes msg =
    InputTextAttributes msg



type alias InputNumberAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , label : Maybe (Shared.Label msg)
    , rawStyle : Maybe Elegant.Style
    , value : Maybe Int
    , onInputEvent : Maybe (Int -> msg)
    , fromStringInput : String -> Int
    , 
```



---

### **max**
```elm
max : Maybe Int }



type alias MinAttribute a =
    { a | min : Maybe Int }



type alias TargetAttribute a =
    { a | target : Maybe String }



type alias HrefAttribute a =
    { a | href : Maybe String }



type alias NameAttribute a =
    { a | name : Maybe String }



type alias WidthAttribute a =
    { a | width : Maybe Int }



type alias HeightAttribute a =
    { a | height : Maybe Int }



type alias DisabledAttribute a =
    { a | disabled : Bool }



type alias MaybeBlockContainer a =
    { a | block : Maybe (List ( Modifiers BlockDetails, StyleSelector )) }



type alias BlockContainer a =
    { a | block : List ( Modifiers BlockDetails, StyleSelector ) }



type alias AutocompleteAttribute a =
    { a | autocomplete : Bool }



type alias PlaceholderAttribute a =
    { a | placeholder : Maybe String }



type alias PositionAttribute a =
    { a | position : Position }



type alias DataAttribute a =
    { a | data : List ( String, String ) }



type alias TypeContainer a =
    { a | type_ : String }



type alias BoxContainer a =
    { a | box : List ( Modifiers Box, StyleSelector ) }



type alias CheckedContainer a =
    { a | checked : Bool }



type alias UniversalContainer a =
    { a | universal : UniversalAttributes }



type alias FlexContainerProperties a =
    { a | flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector ) }



type alias FlexItemProperties a =
    { a | flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector ) }



type alias GridContainerProperties a =
    { a | gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector ) }



type alias GridItemProperties a =
    { a | gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector ) }



type Position
    = Before
    | After



type alias VisibleAttributes a =
    { a
        | box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias StringValue a =
    ValueAttribute String a



type alias IntValue a =
    ValueAttribute Int a



type alias ColorValue a =
    ValueAttribute Color a



type alias VisibleAttributesAndEvents msg a =
    { a
        | onMouseEvents : Maybe (OnMouseEventsInside msg)
        , onEvent : Maybe ( String, Decoder msg )
        , onBlurEvent : Maybe msg
        , onFocusEvent : Maybe msg
        , box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias InputPasswordAttributes msg =
    InputTextAttributes msg



type alias InputRangeAttributes msg =
    InputNumberAttributes msg



type alias SelectAttributes msg =
    { block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , value : Maybe String
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    }



type alias UniversalAttributes =
    { title : Maybe String
    , tabindex : Maybe Int
    , id : Maybe String
    , class : List String
    }



type alias FlowAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias NodeAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexContainerProperties (NodeAttributes msg)



type alias FlexContainerAttributes msg =
    { flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexItemProperties (NodeAttributes msg)



type alias FlexItemAttributes msg =
    { flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridContainerProperties (NodeAttributes msg)



type alias GridContainerAttributes msg =
    { gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridItemProperties (NodeAttributes msg)



type alias GridItemAttributes msg =
    { gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- BlockContainer (FlowAttributes msg)



type alias BlockAttributes msg =
    { block : List ( Modifiers BlockDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias HeadingAttributes msg =
    BlockAttributes msg



type alias ButtonAttributes msg =
    { disabled : Bool
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias AAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , href : Maybe String
    , target : Maybe String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias TextareaAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , value : Maybe String
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    , name : Maybe String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias ImgAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , alt : String
    , width : Maybe Int
    , height : Maybe Int
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias AudioAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias ProgressAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias ScriptAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , data : List ( String, String )
    , rawStyle : Maybe Elegant.Style
    }



type alias InputAttributes a =
    { a | type_ : String, name : Maybe String }



type alias InputHiddenAttributes =
    { name : Maybe String, type_ : String, value : Maybe String, universal : UniversalAttributes }



type alias LabelAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , position : Position
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias InputRadioAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , value : Maybe String
    , block : Maybe (List ( Modifiers Display.BlockDetails, StyleSelector ))
    , label : Maybe (Shared.Label msg)
    , rawStyle : Maybe Elegant.Style
    }



type alias InputCheckboxAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , value : Maybe String
    , label : Maybe (Shared.Label msg)
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , checked : Bool
    , onCheckEvent : Maybe (Bool -> msg)
    , rawStyle : Maybe Elegant.Style
    }



type alias InputTextAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , value : Maybe String
    , label : Maybe (Shared.Label msg)
    , placeholder : Maybe String
    , autocomplete : Bool
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias InputTelAttributes msg =
    InputTextAttributes msg



type alias InputSubmitAttributes msg =
    { label : Maybe (Shared.Label msg)
    , type_ : String
    , disabled : Bool
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , onSubmitEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias InputUrlAttributes msg =
    InputTextAttributes msg



type alias InputNumberAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , label : Maybe (Shared.Label msg)
    , rawStyle : Maybe Elegant.Style
    , value : Maybe Int
    , onInputEvent : Maybe (Int -> msg)
    , fromStringInput : String -> Int
    , step : Maybe Int
    , 
```



---

### **min**
```elm
min : Maybe Int }



type alias TargetAttribute a =
    { a | target : Maybe String }



type alias HrefAttribute a =
    { a | href : Maybe String }



type alias NameAttribute a =
    { a | name : Maybe String }



type alias WidthAttribute a =
    { a | width : Maybe Int }



type alias HeightAttribute a =
    { a | height : Maybe Int }



type alias DisabledAttribute a =
    { a | disabled : Bool }



type alias MaybeBlockContainer a =
    { a | block : Maybe (List ( Modifiers BlockDetails, StyleSelector )) }



type alias BlockContainer a =
    { a | block : List ( Modifiers BlockDetails, StyleSelector ) }



type alias AutocompleteAttribute a =
    { a | autocomplete : Bool }



type alias PlaceholderAttribute a =
    { a | placeholder : Maybe String }



type alias PositionAttribute a =
    { a | position : Position }



type alias DataAttribute a =
    { a | data : List ( String, String ) }



type alias TypeContainer a =
    { a | type_ : String }



type alias BoxContainer a =
    { a | box : List ( Modifiers Box, StyleSelector ) }



type alias CheckedContainer a =
    { a | checked : Bool }



type alias UniversalContainer a =
    { a | universal : UniversalAttributes }



type alias FlexContainerProperties a =
    { a | flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector ) }



type alias FlexItemProperties a =
    { a | flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector ) }



type alias GridContainerProperties a =
    { a | gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector ) }



type alias GridItemProperties a =
    { a | gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector ) }



type Position
    = Before
    | After



type alias VisibleAttributes a =
    { a
        | box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias StringValue a =
    ValueAttribute String a



type alias IntValue a =
    ValueAttribute Int a



type alias ColorValue a =
    ValueAttribute Color a



type alias VisibleAttributesAndEvents msg a =
    { a
        | onMouseEvents : Maybe (OnMouseEventsInside msg)
        , onEvent : Maybe ( String, Decoder msg )
        , onBlurEvent : Maybe msg
        , onFocusEvent : Maybe msg
        , box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias InputPasswordAttributes msg =
    InputTextAttributes msg



type alias InputRangeAttributes msg =
    InputNumberAttributes msg



type alias SelectAttributes msg =
    { block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , value : Maybe String
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    }



type alias UniversalAttributes =
    { title : Maybe String
    , tabindex : Maybe Int
    , id : Maybe String
    , class : List String
    }



type alias FlowAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias NodeAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexContainerProperties (NodeAttributes msg)



type alias FlexContainerAttributes msg =
    { flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexItemProperties (NodeAttributes msg)



type alias FlexItemAttributes msg =
    { flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridContainerProperties (NodeAttributes msg)



type alias GridContainerAttributes msg =
    { gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridItemProperties (NodeAttributes msg)



type alias GridItemAttributes msg =
    { gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- BlockContainer (FlowAttributes msg)



type alias BlockAttributes msg =
    { block : List ( Modifiers BlockDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias HeadingAttributes msg =
    BlockAttributes msg



type alias ButtonAttributes msg =
    { disabled : Bool
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias AAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , href : Maybe String
    , target : Maybe String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias TextareaAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , value : Maybe String
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    , name : Maybe String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias ImgAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , alt : String
    , width : Maybe Int
    , height : Maybe Int
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias AudioAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias ProgressAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias ScriptAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , data : List ( String, String )
    , rawStyle : Maybe Elegant.Style
    }



type alias InputAttributes a =
    { a | type_ : String, name : Maybe String }



type alias InputHiddenAttributes =
    { name : Maybe String, type_ : String, value : Maybe String, universal : UniversalAttributes }



type alias LabelAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , position : Position
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias InputRadioAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , value : Maybe String
    , block : Maybe (List ( Modifiers Display.BlockDetails, StyleSelector ))
    , label : Maybe (Shared.Label msg)
    , rawStyle : Maybe Elegant.Style
    }



type alias InputCheckboxAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , value : Maybe String
    , label : Maybe (Shared.Label msg)
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , checked : Bool
    , onCheckEvent : Maybe (Bool -> msg)
    , rawStyle : Maybe Elegant.Style
    }



type alias InputTextAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , value : Maybe String
    , label : Maybe (Shared.Label msg)
    , placeholder : Maybe String
    , autocomplete : Bool
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias InputTelAttributes msg =
    InputTextAttributes msg



type alias InputSubmitAttributes msg =
    { label : Maybe (Shared.Label msg)
    , type_ : String
    , disabled : Bool
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , onSubmitEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias InputUrlAttributes msg =
    InputTextAttributes msg



type alias InputNumberAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , label : Maybe (Shared.Label msg)
    , rawStyle : Maybe Elegant.Style
    , value : Maybe Int
    , onInputEvent : Maybe (Int -> msg)
    , fromStringInput : String -> Int
    , step : Maybe Int
    , max : Maybe Int
    , 
```



---

### **defaultInputRangeAttributes**
```elm
defaultInputRangeAttributes : InputRangeAttributes msg

```



---

### **inputRangeAttributesToHtmlAttributes**
```elm
inputRangeAttributesToHtmlAttributes : InputRangeAttributes msg -> List (Html.Attribute msg)

```


- [InputRadioAttributes](#inputradioattributes)
- [name](#name-4)
- [defaultInputRadioAttributes](#defaultinputradioattributes)
- [inputRadioAttributesToHtmlAttributes](#inputradioattributestohtmlattributes)

### **type alias InputRadioAttributes**
```elm
type alias InputRadioAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , value : Maybe String
    , block : Maybe (List ( Modifiers Display.BlockDetails, StyleSelector ))
    , label : Maybe (Shared.Label msg)
    , rawStyle : Maybe Elegant.Style
    }
```



---

### **name**
```elm
name : Maybe String }



type alias WidthAttribute a =
    { a | width : Maybe Int }



type alias HeightAttribute a =
    { a | height : Maybe Int }



type alias DisabledAttribute a =
    { a | disabled : Bool }



type alias MaybeBlockContainer a =
    { a | block : Maybe (List ( Modifiers BlockDetails, StyleSelector )) }



type alias BlockContainer a =
    { a | block : List ( Modifiers BlockDetails, StyleSelector ) }



type alias AutocompleteAttribute a =
    { a | autocomplete : Bool }



type alias PlaceholderAttribute a =
    { a | placeholder : Maybe String }



type alias PositionAttribute a =
    { a | position : Position }



type alias DataAttribute a =
    { a | data : List ( String, String ) }



type alias TypeContainer a =
    { a | type_ : String }



type alias BoxContainer a =
    { a | box : List ( Modifiers Box, StyleSelector ) }



type alias CheckedContainer a =
    { a | checked : Bool }



type alias UniversalContainer a =
    { a | universal : UniversalAttributes }



type alias FlexContainerProperties a =
    { a | flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector ) }



type alias FlexItemProperties a =
    { a | flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector ) }



type alias GridContainerProperties a =
    { a | gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector ) }



type alias GridItemProperties a =
    { a | gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector ) }



type Position
    = Before
    | After



type alias VisibleAttributes a =
    { a
        | box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias StringValue a =
    ValueAttribute String a



type alias IntValue a =
    ValueAttribute Int a



type alias ColorValue a =
    ValueAttribute Color a



type alias VisibleAttributesAndEvents msg a =
    { a
        | onMouseEvents : Maybe (OnMouseEventsInside msg)
        , onEvent : Maybe ( String, Decoder msg )
        , onBlurEvent : Maybe msg
        , onFocusEvent : Maybe msg
        , box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias InputPasswordAttributes msg =
    InputTextAttributes msg



type alias InputRangeAttributes msg =
    InputNumberAttributes msg



type alias SelectAttributes msg =
    { block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , value : Maybe String
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    }



type alias UniversalAttributes =
    { title : Maybe String
    , tabindex : Maybe Int
    , id : Maybe String
    , class : List String
    }



type alias FlowAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias NodeAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexContainerProperties (NodeAttributes msg)



type alias FlexContainerAttributes msg =
    { flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexItemProperties (NodeAttributes msg)



type alias FlexItemAttributes msg =
    { flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridContainerProperties (NodeAttributes msg)



type alias GridContainerAttributes msg =
    { gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridItemProperties (NodeAttributes msg)



type alias GridItemAttributes msg =
    { gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- BlockContainer (FlowAttributes msg)



type alias BlockAttributes msg =
    { block : List ( Modifiers BlockDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias HeadingAttributes msg =
    BlockAttributes msg



type alias ButtonAttributes msg =
    { disabled : Bool
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias AAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , href : Maybe String
    , target : Maybe String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias TextareaAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , value : Maybe String
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    , 
```



---

### **defaultInputRadioAttributes**
```elm
defaultInputRadioAttributes : InputRadioAttributes msg

```



---

### **inputRadioAttributesToHtmlAttributes**
```elm
inputRadioAttributesToHtmlAttributes : InputRadioAttributes msg -> List (Html.Attribute msg)

```


- [InputCheckboxAttributes](#inputcheckboxattributes)
- [name](#name-5)
- [checked](#checked)
- [defaultInputCheckboxAttributes](#defaultinputcheckboxattributes)
- [inputCheckboxAttributesToHtmlAttributes](#inputcheckboxattributestohtmlattributes)

### **type alias InputCheckboxAttributes**
```elm
type alias InputCheckboxAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , value : Maybe String
    , label : Maybe (Shared.Label msg)
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , checked : Bool
    , onCheckEvent : Maybe (Bool -> msg)
    , rawStyle : Maybe Elegant.Style
    }
```



---

### **name**
```elm
name : Maybe String }



type alias WidthAttribute a =
    { a | width : Maybe Int }



type alias HeightAttribute a =
    { a | height : Maybe Int }



type alias DisabledAttribute a =
    { a | disabled : Bool }



type alias MaybeBlockContainer a =
    { a | block : Maybe (List ( Modifiers BlockDetails, StyleSelector )) }



type alias BlockContainer a =
    { a | block : List ( Modifiers BlockDetails, StyleSelector ) }



type alias AutocompleteAttribute a =
    { a | autocomplete : Bool }



type alias PlaceholderAttribute a =
    { a | placeholder : Maybe String }



type alias PositionAttribute a =
    { a | position : Position }



type alias DataAttribute a =
    { a | data : List ( String, String ) }



type alias TypeContainer a =
    { a | type_ : String }



type alias BoxContainer a =
    { a | box : List ( Modifiers Box, StyleSelector ) }



type alias CheckedContainer a =
    { a | checked : Bool }



type alias UniversalContainer a =
    { a | universal : UniversalAttributes }



type alias FlexContainerProperties a =
    { a | flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector ) }



type alias FlexItemProperties a =
    { a | flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector ) }



type alias GridContainerProperties a =
    { a | gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector ) }



type alias GridItemProperties a =
    { a | gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector ) }



type Position
    = Before
    | After



type alias VisibleAttributes a =
    { a
        | box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias StringValue a =
    ValueAttribute String a



type alias IntValue a =
    ValueAttribute Int a



type alias ColorValue a =
    ValueAttribute Color a



type alias VisibleAttributesAndEvents msg a =
    { a
        | onMouseEvents : Maybe (OnMouseEventsInside msg)
        , onEvent : Maybe ( String, Decoder msg )
        , onBlurEvent : Maybe msg
        , onFocusEvent : Maybe msg
        , box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias InputPasswordAttributes msg =
    InputTextAttributes msg



type alias InputRangeAttributes msg =
    InputNumberAttributes msg



type alias SelectAttributes msg =
    { block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , value : Maybe String
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    }



type alias UniversalAttributes =
    { title : Maybe String
    , tabindex : Maybe Int
    , id : Maybe String
    , class : List String
    }



type alias FlowAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias NodeAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexContainerProperties (NodeAttributes msg)



type alias FlexContainerAttributes msg =
    { flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexItemProperties (NodeAttributes msg)



type alias FlexItemAttributes msg =
    { flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridContainerProperties (NodeAttributes msg)



type alias GridContainerAttributes msg =
    { gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridItemProperties (NodeAttributes msg)



type alias GridItemAttributes msg =
    { gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- BlockContainer (FlowAttributes msg)



type alias BlockAttributes msg =
    { block : List ( Modifiers BlockDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias HeadingAttributes msg =
    BlockAttributes msg



type alias ButtonAttributes msg =
    { disabled : Bool
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias AAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , href : Maybe String
    , target : Maybe String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias TextareaAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , value : Maybe String
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    , 
```



---

### **checked**
```elm
checked : Bool }



type alias UniversalContainer a =
    { a | universal : UniversalAttributes }



type alias FlexContainerProperties a =
    { a | flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector ) }



type alias FlexItemProperties a =
    { a | flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector ) }



type alias GridContainerProperties a =
    { a | gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector ) }



type alias GridItemProperties a =
    { a | gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector ) }



type Position
    = Before
    | After



type alias VisibleAttributes a =
    { a
        | box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias StringValue a =
    ValueAttribute String a



type alias IntValue a =
    ValueAttribute Int a



type alias ColorValue a =
    ValueAttribute Color a



type alias VisibleAttributesAndEvents msg a =
    { a
        | onMouseEvents : Maybe (OnMouseEventsInside msg)
        , onEvent : Maybe ( String, Decoder msg )
        , onBlurEvent : Maybe msg
        , onFocusEvent : Maybe msg
        , box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias InputPasswordAttributes msg =
    InputTextAttributes msg



type alias InputRangeAttributes msg =
    InputNumberAttributes msg



type alias SelectAttributes msg =
    { block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , value : Maybe String
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    }



type alias UniversalAttributes =
    { title : Maybe String
    , tabindex : Maybe Int
    , id : Maybe String
    , class : List String
    }



type alias FlowAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias NodeAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexContainerProperties (NodeAttributes msg)



type alias FlexContainerAttributes msg =
    { flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexItemProperties (NodeAttributes msg)



type alias FlexItemAttributes msg =
    { flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridContainerProperties (NodeAttributes msg)



type alias GridContainerAttributes msg =
    { gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridItemProperties (NodeAttributes msg)



type alias GridItemAttributes msg =
    { gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- BlockContainer (FlowAttributes msg)



type alias BlockAttributes msg =
    { block : List ( Modifiers BlockDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias HeadingAttributes msg =
    BlockAttributes msg



type alias ButtonAttributes msg =
    { disabled : Bool
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias AAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , href : Maybe String
    , target : Maybe String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias TextareaAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , value : Maybe String
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    , name : Maybe String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias ImgAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , alt : String
    , width : Maybe Int
    , height : Maybe Int
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias AudioAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias ProgressAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias ScriptAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , data : List ( String, String )
    , rawStyle : Maybe Elegant.Style
    }



type alias InputAttributes a =
    { a | type_ : String, name : Maybe String }



type alias InputHiddenAttributes =
    { name : Maybe String, type_ : String, value : Maybe String, universal : UniversalAttributes }



type alias LabelAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , position : Position
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias InputRadioAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , value : Maybe String
    , block : Maybe (List ( Modifiers Display.BlockDetails, StyleSelector ))
    , label : Maybe (Shared.Label msg)
    , rawStyle : Maybe Elegant.Style
    }



type alias InputCheckboxAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , value : Maybe String
    , label : Maybe (Shared.Label msg)
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , 
```



---

### **defaultInputCheckboxAttributes**
```elm
defaultInputCheckboxAttributes : InputCheckboxAttributes msg

```



---

### **inputCheckboxAttributesToHtmlAttributes**
```elm
inputCheckboxAttributesToHtmlAttributes : InputCheckboxAttributes msg -> List (Html.Attribute msg)

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
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , value : Maybe String
    , label : Maybe (Shared.Label msg)
    , placeholder : Maybe String
    , autocomplete : Bool
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }
```



---

### **name**
```elm
name : Maybe String }



type alias WidthAttribute a =
    { a | width : Maybe Int }



type alias HeightAttribute a =
    { a | height : Maybe Int }



type alias DisabledAttribute a =
    { a | disabled : Bool }



type alias MaybeBlockContainer a =
    { a | block : Maybe (List ( Modifiers BlockDetails, StyleSelector )) }



type alias BlockContainer a =
    { a | block : List ( Modifiers BlockDetails, StyleSelector ) }



type alias AutocompleteAttribute a =
    { a | autocomplete : Bool }



type alias PlaceholderAttribute a =
    { a | placeholder : Maybe String }



type alias PositionAttribute a =
    { a | position : Position }



type alias DataAttribute a =
    { a | data : List ( String, String ) }



type alias TypeContainer a =
    { a | type_ : String }



type alias BoxContainer a =
    { a | box : List ( Modifiers Box, StyleSelector ) }



type alias CheckedContainer a =
    { a | checked : Bool }



type alias UniversalContainer a =
    { a | universal : UniversalAttributes }



type alias FlexContainerProperties a =
    { a | flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector ) }



type alias FlexItemProperties a =
    { a | flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector ) }



type alias GridContainerProperties a =
    { a | gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector ) }



type alias GridItemProperties a =
    { a | gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector ) }



type Position
    = Before
    | After



type alias VisibleAttributes a =
    { a
        | box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias StringValue a =
    ValueAttribute String a



type alias IntValue a =
    ValueAttribute Int a



type alias ColorValue a =
    ValueAttribute Color a



type alias VisibleAttributesAndEvents msg a =
    { a
        | onMouseEvents : Maybe (OnMouseEventsInside msg)
        , onEvent : Maybe ( String, Decoder msg )
        , onBlurEvent : Maybe msg
        , onFocusEvent : Maybe msg
        , box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias InputPasswordAttributes msg =
    InputTextAttributes msg



type alias InputRangeAttributes msg =
    InputNumberAttributes msg



type alias SelectAttributes msg =
    { block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , value : Maybe String
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    }



type alias UniversalAttributes =
    { title : Maybe String
    , tabindex : Maybe Int
    , id : Maybe String
    , class : List String
    }



type alias FlowAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias NodeAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexContainerProperties (NodeAttributes msg)



type alias FlexContainerAttributes msg =
    { flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexItemProperties (NodeAttributes msg)



type alias FlexItemAttributes msg =
    { flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridContainerProperties (NodeAttributes msg)



type alias GridContainerAttributes msg =
    { gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridItemProperties (NodeAttributes msg)



type alias GridItemAttributes msg =
    { gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- BlockContainer (FlowAttributes msg)



type alias BlockAttributes msg =
    { block : List ( Modifiers BlockDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias HeadingAttributes msg =
    BlockAttributes msg



type alias ButtonAttributes msg =
    { disabled : Bool
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias AAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , href : Maybe String
    , target : Maybe String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias TextareaAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , value : Maybe String
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    , 
```



---

### **autocomplete**
```elm
autocomplete : Bool }



type alias PlaceholderAttribute a =
    { a | placeholder : Maybe String }



type alias PositionAttribute a =
    { a | position : Position }



type alias DataAttribute a =
    { a | data : List ( String, String ) }



type alias TypeContainer a =
    { a | type_ : String }



type alias BoxContainer a =
    { a | box : List ( Modifiers Box, StyleSelector ) }



type alias CheckedContainer a =
    { a | checked : Bool }



type alias UniversalContainer a =
    { a | universal : UniversalAttributes }



type alias FlexContainerProperties a =
    { a | flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector ) }



type alias FlexItemProperties a =
    { a | flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector ) }



type alias GridContainerProperties a =
    { a | gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector ) }



type alias GridItemProperties a =
    { a | gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector ) }



type Position
    = Before
    | After



type alias VisibleAttributes a =
    { a
        | box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias StringValue a =
    ValueAttribute String a



type alias IntValue a =
    ValueAttribute Int a



type alias ColorValue a =
    ValueAttribute Color a



type alias VisibleAttributesAndEvents msg a =
    { a
        | onMouseEvents : Maybe (OnMouseEventsInside msg)
        , onEvent : Maybe ( String, Decoder msg )
        , onBlurEvent : Maybe msg
        , onFocusEvent : Maybe msg
        , box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias InputPasswordAttributes msg =
    InputTextAttributes msg



type alias InputRangeAttributes msg =
    InputNumberAttributes msg



type alias SelectAttributes msg =
    { block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , value : Maybe String
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    }



type alias UniversalAttributes =
    { title : Maybe String
    , tabindex : Maybe Int
    , id : Maybe String
    , class : List String
    }



type alias FlowAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias NodeAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexContainerProperties (NodeAttributes msg)



type alias FlexContainerAttributes msg =
    { flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexItemProperties (NodeAttributes msg)



type alias FlexItemAttributes msg =
    { flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridContainerProperties (NodeAttributes msg)



type alias GridContainerAttributes msg =
    { gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridItemProperties (NodeAttributes msg)



type alias GridItemAttributes msg =
    { gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- BlockContainer (FlowAttributes msg)



type alias BlockAttributes msg =
    { block : List ( Modifiers BlockDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias HeadingAttributes msg =
    BlockAttributes msg



type alias ButtonAttributes msg =
    { disabled : Bool
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias AAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , href : Maybe String
    , target : Maybe String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias TextareaAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , value : Maybe String
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    , name : Maybe String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias ImgAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , alt : String
    , width : Maybe Int
    , height : Maybe Int
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias AudioAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias ProgressAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias ScriptAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , data : List ( String, String )
    , rawStyle : Maybe Elegant.Style
    }



type alias InputAttributes a =
    { a | type_ : String, name : Maybe String }



type alias InputHiddenAttributes =
    { name : Maybe String, type_ : String, value : Maybe String, universal : UniversalAttributes }



type alias LabelAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , position : Position
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias InputRadioAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , value : Maybe String
    , block : Maybe (List ( Modifiers Display.BlockDetails, StyleSelector ))
    , label : Maybe (Shared.Label msg)
    , rawStyle : Maybe Elegant.Style
    }



type alias InputCheckboxAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , value : Maybe String
    , label : Maybe (Shared.Label msg)
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , checked : Bool
    , onCheckEvent : Maybe (Bool -> msg)
    , rawStyle : Maybe Elegant.Style
    }



type alias InputTextAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , value : Maybe String
    , label : Maybe (Shared.Label msg)
    , placeholder : Maybe String
    , 
```



---

### **placeholder**
```elm
placeholder : Maybe String }



type alias PositionAttribute a =
    { a | position : Position }



type alias DataAttribute a =
    { a | data : List ( String, String ) }



type alias TypeContainer a =
    { a | type_ : String }



type alias BoxContainer a =
    { a | box : List ( Modifiers Box, StyleSelector ) }



type alias CheckedContainer a =
    { a | checked : Bool }



type alias UniversalContainer a =
    { a | universal : UniversalAttributes }



type alias FlexContainerProperties a =
    { a | flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector ) }



type alias FlexItemProperties a =
    { a | flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector ) }



type alias GridContainerProperties a =
    { a | gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector ) }



type alias GridItemProperties a =
    { a | gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector ) }



type Position
    = Before
    | After



type alias VisibleAttributes a =
    { a
        | box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias StringValue a =
    ValueAttribute String a



type alias IntValue a =
    ValueAttribute Int a



type alias ColorValue a =
    ValueAttribute Color a



type alias VisibleAttributesAndEvents msg a =
    { a
        | onMouseEvents : Maybe (OnMouseEventsInside msg)
        , onEvent : Maybe ( String, Decoder msg )
        , onBlurEvent : Maybe msg
        , onFocusEvent : Maybe msg
        , box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias InputPasswordAttributes msg =
    InputTextAttributes msg



type alias InputRangeAttributes msg =
    InputNumberAttributes msg



type alias SelectAttributes msg =
    { block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , value : Maybe String
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    }



type alias UniversalAttributes =
    { title : Maybe String
    , tabindex : Maybe Int
    , id : Maybe String
    , class : List String
    }



type alias FlowAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias NodeAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexContainerProperties (NodeAttributes msg)



type alias FlexContainerAttributes msg =
    { flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexItemProperties (NodeAttributes msg)



type alias FlexItemAttributes msg =
    { flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridContainerProperties (NodeAttributes msg)



type alias GridContainerAttributes msg =
    { gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridItemProperties (NodeAttributes msg)



type alias GridItemAttributes msg =
    { gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- BlockContainer (FlowAttributes msg)



type alias BlockAttributes msg =
    { block : List ( Modifiers BlockDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias HeadingAttributes msg =
    BlockAttributes msg



type alias ButtonAttributes msg =
    { disabled : Bool
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias AAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , href : Maybe String
    , target : Maybe String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias TextareaAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , value : Maybe String
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    , name : Maybe String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias ImgAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , alt : String
    , width : Maybe Int
    , height : Maybe Int
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias AudioAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias ProgressAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias ScriptAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , data : List ( String, String )
    , rawStyle : Maybe Elegant.Style
    }



type alias InputAttributes a =
    { a | type_ : String, name : Maybe String }



type alias InputHiddenAttributes =
    { name : Maybe String, type_ : String, value : Maybe String, universal : UniversalAttributes }



type alias LabelAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , position : Position
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias InputRadioAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , value : Maybe String
    , block : Maybe (List ( Modifiers Display.BlockDetails, StyleSelector ))
    , label : Maybe (Shared.Label msg)
    , rawStyle : Maybe Elegant.Style
    }



type alias InputCheckboxAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , value : Maybe String
    , label : Maybe (Shared.Label msg)
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , checked : Bool
    , onCheckEvent : Maybe (Bool -> msg)
    , rawStyle : Maybe Elegant.Style
    }



type alias InputTextAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , value : Maybe String
    , label : Maybe (Shared.Label msg)
    , 
```



---

### **defaultInputTextAttributes**
```elm
defaultInputTextAttributes : InputTextAttributes msg

```



---

### **inputTextAttributesToHtmlAttributes**
```elm
inputTextAttributesToHtmlAttributes : InputTextAttributes msg -> List (Html.Attribute msg)

```


- [InputTelAttributes](#inputtelattributes)
- [defaultInputTelAttributes](#defaultinputtelattributes)

### **type alias InputTelAttributes**
```elm
type alias InputTelAttributes msg =
    InputTextAttributes msg



type alias InputSubmitAttributes msg =
    { label : Maybe (Shared.Label msg)
    , type_ : String
    , disabled : Bool
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , onSubmitEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }
```



---

### **defaultInputTelAttributes**
```elm
defaultInputTelAttributes : InputTelAttributes msg

```


- [InputSubmitAttributes](#inputsubmitattributes)
- [name](#name-7)
- [defaultInputSubmitAttributes](#defaultinputsubmitattributes)
- [inputSubmitAttributesToHtmlAttributes](#inputsubmitattributestohtmlattributes)

### **type alias InputSubmitAttributes**
```elm
type alias InputSubmitAttributes msg =  
    { label : Maybe (BodyBuilder.Shared.Label msg) , type_ : String , disabled : Bool , block : Maybe (List ( Modifiers Display.BlockDetails , BodyBuilder.Attributes.StyleSelector )) , onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) , onEvent : Maybe ( String, Json.Decode.Decoder msg ) , onBlurEvent : Maybe msg , onFocusEvent : Maybe msg , onSubmitEvent : Maybe msg , box : List ( Modifiers Box, BodyBuilder.Attributes.StyleSelector ) , universal : BodyBuilder.Attributes.UniversalAttributes , rawStyle : Maybe Elegant.Style }
```



---

### **name**
```elm
name : Maybe String }



type alias WidthAttribute a =
    { a | width : Maybe Int }



type alias HeightAttribute a =
    { a | height : Maybe Int }



type alias DisabledAttribute a =
    { a | disabled : Bool }



type alias MaybeBlockContainer a =
    { a | block : Maybe (List ( Modifiers BlockDetails, StyleSelector )) }



type alias BlockContainer a =
    { a | block : List ( Modifiers BlockDetails, StyleSelector ) }



type alias AutocompleteAttribute a =
    { a | autocomplete : Bool }



type alias PlaceholderAttribute a =
    { a | placeholder : Maybe String }



type alias PositionAttribute a =
    { a | position : Position }



type alias DataAttribute a =
    { a | data : List ( String, String ) }



type alias TypeContainer a =
    { a | type_ : String }



type alias BoxContainer a =
    { a | box : List ( Modifiers Box, StyleSelector ) }



type alias CheckedContainer a =
    { a | checked : Bool }



type alias UniversalContainer a =
    { a | universal : UniversalAttributes }



type alias FlexContainerProperties a =
    { a | flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector ) }



type alias FlexItemProperties a =
    { a | flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector ) }



type alias GridContainerProperties a =
    { a | gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector ) }



type alias GridItemProperties a =
    { a | gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector ) }



type Position
    = Before
    | After



type alias VisibleAttributes a =
    { a
        | box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias StringValue a =
    ValueAttribute String a



type alias IntValue a =
    ValueAttribute Int a



type alias ColorValue a =
    ValueAttribute Color a



type alias VisibleAttributesAndEvents msg a =
    { a
        | onMouseEvents : Maybe (OnMouseEventsInside msg)
        , onEvent : Maybe ( String, Decoder msg )
        , onBlurEvent : Maybe msg
        , onFocusEvent : Maybe msg
        , box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias InputPasswordAttributes msg =
    InputTextAttributes msg



type alias InputRangeAttributes msg =
    InputNumberAttributes msg



type alias SelectAttributes msg =
    { block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , value : Maybe String
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    }



type alias UniversalAttributes =
    { title : Maybe String
    , tabindex : Maybe Int
    , id : Maybe String
    , class : List String
    }



type alias FlowAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias NodeAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexContainerProperties (NodeAttributes msg)



type alias FlexContainerAttributes msg =
    { flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexItemProperties (NodeAttributes msg)



type alias FlexItemAttributes msg =
    { flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridContainerProperties (NodeAttributes msg)



type alias GridContainerAttributes msg =
    { gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridItemProperties (NodeAttributes msg)



type alias GridItemAttributes msg =
    { gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- BlockContainer (FlowAttributes msg)



type alias BlockAttributes msg =
    { block : List ( Modifiers BlockDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias HeadingAttributes msg =
    BlockAttributes msg



type alias ButtonAttributes msg =
    { disabled : Bool
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias AAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , href : Maybe String
    , target : Maybe String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias TextareaAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , value : Maybe String
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    , 
```



---

### **defaultInputSubmitAttributes**
```elm
defaultInputSubmitAttributes : InputSubmitAttributes msg

```



---

### **inputSubmitAttributesToHtmlAttributes**
```elm
inputSubmitAttributesToHtmlAttributes : InputSubmitAttributes msg -> List (Html.Attribute msg)

```


- [InputUrlAttributes](#inputurlattributes)
- [name](#name-8)
- [placeholder](#placeholder-1)
- [defaultInputUrlAttributes](#defaultinputurlattributes)
- [inputUrlAttributesToHtmlAttributes](#inputurlattributestohtmlattributes)

### **type alias InputUrlAttributes**
```elm
type alias InputUrlAttributes msg =
    InputTextAttributes msg



type alias InputNumberAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , label : Maybe (Shared.Label msg)
    , rawStyle : Maybe Elegant.Style
    , value : Maybe Int
    , onInputEvent : Maybe (Int -> msg)
    , fromStringInput : String -> Int
    , step : Maybe Int
    , max : Maybe Int
    , min : Maybe Int
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , disabled : Bool
    }
```



---

### **name**
```elm
name : Maybe String }



type alias WidthAttribute a =
    { a | width : Maybe Int }



type alias HeightAttribute a =
    { a | height : Maybe Int }



type alias DisabledAttribute a =
    { a | disabled : Bool }



type alias MaybeBlockContainer a =
    { a | block : Maybe (List ( Modifiers BlockDetails, StyleSelector )) }



type alias BlockContainer a =
    { a | block : List ( Modifiers BlockDetails, StyleSelector ) }



type alias AutocompleteAttribute a =
    { a | autocomplete : Bool }



type alias PlaceholderAttribute a =
    { a | placeholder : Maybe String }



type alias PositionAttribute a =
    { a | position : Position }



type alias DataAttribute a =
    { a | data : List ( String, String ) }



type alias TypeContainer a =
    { a | type_ : String }



type alias BoxContainer a =
    { a | box : List ( Modifiers Box, StyleSelector ) }



type alias CheckedContainer a =
    { a | checked : Bool }



type alias UniversalContainer a =
    { a | universal : UniversalAttributes }



type alias FlexContainerProperties a =
    { a | flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector ) }



type alias FlexItemProperties a =
    { a | flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector ) }



type alias GridContainerProperties a =
    { a | gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector ) }



type alias GridItemProperties a =
    { a | gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector ) }



type Position
    = Before
    | After



type alias VisibleAttributes a =
    { a
        | box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias StringValue a =
    ValueAttribute String a



type alias IntValue a =
    ValueAttribute Int a



type alias ColorValue a =
    ValueAttribute Color a



type alias VisibleAttributesAndEvents msg a =
    { a
        | onMouseEvents : Maybe (OnMouseEventsInside msg)
        , onEvent : Maybe ( String, Decoder msg )
        , onBlurEvent : Maybe msg
        , onFocusEvent : Maybe msg
        , box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias InputPasswordAttributes msg =
    InputTextAttributes msg



type alias InputRangeAttributes msg =
    InputNumberAttributes msg



type alias SelectAttributes msg =
    { block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , value : Maybe String
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    }



type alias UniversalAttributes =
    { title : Maybe String
    , tabindex : Maybe Int
    , id : Maybe String
    , class : List String
    }



type alias FlowAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias NodeAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexContainerProperties (NodeAttributes msg)



type alias FlexContainerAttributes msg =
    { flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexItemProperties (NodeAttributes msg)



type alias FlexItemAttributes msg =
    { flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridContainerProperties (NodeAttributes msg)



type alias GridContainerAttributes msg =
    { gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridItemProperties (NodeAttributes msg)



type alias GridItemAttributes msg =
    { gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- BlockContainer (FlowAttributes msg)



type alias BlockAttributes msg =
    { block : List ( Modifiers BlockDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias HeadingAttributes msg =
    BlockAttributes msg



type alias ButtonAttributes msg =
    { disabled : Bool
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias AAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , href : Maybe String
    , target : Maybe String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias TextareaAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , value : Maybe String
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    , 
```



---

### **placeholder**
```elm
placeholder : Maybe String }



type alias PositionAttribute a =
    { a | position : Position }



type alias DataAttribute a =
    { a | data : List ( String, String ) }



type alias TypeContainer a =
    { a | type_ : String }



type alias BoxContainer a =
    { a | box : List ( Modifiers Box, StyleSelector ) }



type alias CheckedContainer a =
    { a | checked : Bool }



type alias UniversalContainer a =
    { a | universal : UniversalAttributes }



type alias FlexContainerProperties a =
    { a | flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector ) }



type alias FlexItemProperties a =
    { a | flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector ) }



type alias GridContainerProperties a =
    { a | gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector ) }



type alias GridItemProperties a =
    { a | gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector ) }



type Position
    = Before
    | After



type alias VisibleAttributes a =
    { a
        | box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias StringValue a =
    ValueAttribute String a



type alias IntValue a =
    ValueAttribute Int a



type alias ColorValue a =
    ValueAttribute Color a



type alias VisibleAttributesAndEvents msg a =
    { a
        | onMouseEvents : Maybe (OnMouseEventsInside msg)
        , onEvent : Maybe ( String, Decoder msg )
        , onBlurEvent : Maybe msg
        , onFocusEvent : Maybe msg
        , box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias InputPasswordAttributes msg =
    InputTextAttributes msg



type alias InputRangeAttributes msg =
    InputNumberAttributes msg



type alias SelectAttributes msg =
    { block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , value : Maybe String
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    }



type alias UniversalAttributes =
    { title : Maybe String
    , tabindex : Maybe Int
    , id : Maybe String
    , class : List String
    }



type alias FlowAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias NodeAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexContainerProperties (NodeAttributes msg)



type alias FlexContainerAttributes msg =
    { flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexItemProperties (NodeAttributes msg)



type alias FlexItemAttributes msg =
    { flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridContainerProperties (NodeAttributes msg)



type alias GridContainerAttributes msg =
    { gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridItemProperties (NodeAttributes msg)



type alias GridItemAttributes msg =
    { gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- BlockContainer (FlowAttributes msg)



type alias BlockAttributes msg =
    { block : List ( Modifiers BlockDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias HeadingAttributes msg =
    BlockAttributes msg



type alias ButtonAttributes msg =
    { disabled : Bool
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias AAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , href : Maybe String
    , target : Maybe String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias TextareaAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , value : Maybe String
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    , name : Maybe String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias ImgAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , alt : String
    , width : Maybe Int
    , height : Maybe Int
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias AudioAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias ProgressAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias ScriptAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , data : List ( String, String )
    , rawStyle : Maybe Elegant.Style
    }



type alias InputAttributes a =
    { a | type_ : String, name : Maybe String }



type alias InputHiddenAttributes =
    { name : Maybe String, type_ : String, value : Maybe String, universal : UniversalAttributes }



type alias LabelAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , position : Position
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias InputRadioAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , value : Maybe String
    , block : Maybe (List ( Modifiers Display.BlockDetails, StyleSelector ))
    , label : Maybe (Shared.Label msg)
    , rawStyle : Maybe Elegant.Style
    }



type alias InputCheckboxAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , value : Maybe String
    , label : Maybe (Shared.Label msg)
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , checked : Bool
    , onCheckEvent : Maybe (Bool -> msg)
    , rawStyle : Maybe Elegant.Style
    }



type alias InputTextAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , value : Maybe String
    , label : Maybe (Shared.Label msg)
    , 
```



---

### **defaultInputUrlAttributes**
```elm
defaultInputUrlAttributes : InputUrlAttributes msg

```



---

### **inputUrlAttributesToHtmlAttributes**
```elm
inputUrlAttributesToHtmlAttributes : InputUrlAttributes msg -> List (Html.Attribute msg)

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
    { name : Maybe String , type_ : String , universal : BodyBuilder.Attributes.UniversalAttributes , box : List ( Modifiers Box, BodyBuilder.Attributes.StyleSelector ) , onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) , onEvent : Maybe ( String, Json.Decode.Decoder msg ) , onBlurEvent : Maybe msg , onFocusEvent : Maybe msg , label : Maybe (BodyBuilder.Shared.Label msg) , rawStyle : Maybe Elegant.Style , value : Maybe Int , onInputEvent : Maybe (Int -> msg) , fromStringInput : String -> Int , step : Maybe Int , max : Maybe Int , min : Maybe Int , block : Maybe (List ( Modifiers Display.BlockDetails , BodyBuilder.Attributes.StyleSelector )) , disabled : Bool }
```



---

### **name**
```elm
name : Maybe String }



type alias WidthAttribute a =
    { a | width : Maybe Int }



type alias HeightAttribute a =
    { a | height : Maybe Int }



type alias DisabledAttribute a =
    { a | disabled : Bool }



type alias MaybeBlockContainer a =
    { a | block : Maybe (List ( Modifiers BlockDetails, StyleSelector )) }



type alias BlockContainer a =
    { a | block : List ( Modifiers BlockDetails, StyleSelector ) }



type alias AutocompleteAttribute a =
    { a | autocomplete : Bool }



type alias PlaceholderAttribute a =
    { a | placeholder : Maybe String }



type alias PositionAttribute a =
    { a | position : Position }



type alias DataAttribute a =
    { a | data : List ( String, String ) }



type alias TypeContainer a =
    { a | type_ : String }



type alias BoxContainer a =
    { a | box : List ( Modifiers Box, StyleSelector ) }



type alias CheckedContainer a =
    { a | checked : Bool }



type alias UniversalContainer a =
    { a | universal : UniversalAttributes }



type alias FlexContainerProperties a =
    { a | flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector ) }



type alias FlexItemProperties a =
    { a | flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector ) }



type alias GridContainerProperties a =
    { a | gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector ) }



type alias GridItemProperties a =
    { a | gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector ) }



type Position
    = Before
    | After



type alias VisibleAttributes a =
    { a
        | box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias StringValue a =
    ValueAttribute String a



type alias IntValue a =
    ValueAttribute Int a



type alias ColorValue a =
    ValueAttribute Color a



type alias VisibleAttributesAndEvents msg a =
    { a
        | onMouseEvents : Maybe (OnMouseEventsInside msg)
        , onEvent : Maybe ( String, Decoder msg )
        , onBlurEvent : Maybe msg
        , onFocusEvent : Maybe msg
        , box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias InputPasswordAttributes msg =
    InputTextAttributes msg



type alias InputRangeAttributes msg =
    InputNumberAttributes msg



type alias SelectAttributes msg =
    { block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , value : Maybe String
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    }



type alias UniversalAttributes =
    { title : Maybe String
    , tabindex : Maybe Int
    , id : Maybe String
    , class : List String
    }



type alias FlowAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias NodeAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexContainerProperties (NodeAttributes msg)



type alias FlexContainerAttributes msg =
    { flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexItemProperties (NodeAttributes msg)



type alias FlexItemAttributes msg =
    { flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridContainerProperties (NodeAttributes msg)



type alias GridContainerAttributes msg =
    { gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridItemProperties (NodeAttributes msg)



type alias GridItemAttributes msg =
    { gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- BlockContainer (FlowAttributes msg)



type alias BlockAttributes msg =
    { block : List ( Modifiers BlockDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias HeadingAttributes msg =
    BlockAttributes msg



type alias ButtonAttributes msg =
    { disabled : Bool
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias AAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , href : Maybe String
    , target : Maybe String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias TextareaAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , value : Maybe String
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    , 
```



---

### **step**
```elm
step : Maybe Int }



type alias MaxAttribute a =
    { a | max : Maybe Int }



type alias MinAttribute a =
    { a | min : Maybe Int }



type alias TargetAttribute a =
    { a | target : Maybe String }



type alias HrefAttribute a =
    { a | href : Maybe String }



type alias NameAttribute a =
    { a | name : Maybe String }



type alias WidthAttribute a =
    { a | width : Maybe Int }



type alias HeightAttribute a =
    { a | height : Maybe Int }



type alias DisabledAttribute a =
    { a | disabled : Bool }



type alias MaybeBlockContainer a =
    { a | block : Maybe (List ( Modifiers BlockDetails, StyleSelector )) }



type alias BlockContainer a =
    { a | block : List ( Modifiers BlockDetails, StyleSelector ) }



type alias AutocompleteAttribute a =
    { a | autocomplete : Bool }



type alias PlaceholderAttribute a =
    { a | placeholder : Maybe String }



type alias PositionAttribute a =
    { a | position : Position }



type alias DataAttribute a =
    { a | data : List ( String, String ) }



type alias TypeContainer a =
    { a | type_ : String }



type alias BoxContainer a =
    { a | box : List ( Modifiers Box, StyleSelector ) }



type alias CheckedContainer a =
    { a | checked : Bool }



type alias UniversalContainer a =
    { a | universal : UniversalAttributes }



type alias FlexContainerProperties a =
    { a | flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector ) }



type alias FlexItemProperties a =
    { a | flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector ) }



type alias GridContainerProperties a =
    { a | gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector ) }



type alias GridItemProperties a =
    { a | gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector ) }



type Position
    = Before
    | After



type alias VisibleAttributes a =
    { a
        | box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias StringValue a =
    ValueAttribute String a



type alias IntValue a =
    ValueAttribute Int a



type alias ColorValue a =
    ValueAttribute Color a



type alias VisibleAttributesAndEvents msg a =
    { a
        | onMouseEvents : Maybe (OnMouseEventsInside msg)
        , onEvent : Maybe ( String, Decoder msg )
        , onBlurEvent : Maybe msg
        , onFocusEvent : Maybe msg
        , box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias InputPasswordAttributes msg =
    InputTextAttributes msg



type alias InputRangeAttributes msg =
    InputNumberAttributes msg



type alias SelectAttributes msg =
    { block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , value : Maybe String
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    }



type alias UniversalAttributes =
    { title : Maybe String
    , tabindex : Maybe Int
    , id : Maybe String
    , class : List String
    }



type alias FlowAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias NodeAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexContainerProperties (NodeAttributes msg)



type alias FlexContainerAttributes msg =
    { flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexItemProperties (NodeAttributes msg)



type alias FlexItemAttributes msg =
    { flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridContainerProperties (NodeAttributes msg)



type alias GridContainerAttributes msg =
    { gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridItemProperties (NodeAttributes msg)



type alias GridItemAttributes msg =
    { gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- BlockContainer (FlowAttributes msg)



type alias BlockAttributes msg =
    { block : List ( Modifiers BlockDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias HeadingAttributes msg =
    BlockAttributes msg



type alias ButtonAttributes msg =
    { disabled : Bool
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias AAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , href : Maybe String
    , target : Maybe String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias TextareaAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , value : Maybe String
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    , name : Maybe String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias ImgAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , alt : String
    , width : Maybe Int
    , height : Maybe Int
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias AudioAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias ProgressAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias ScriptAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , data : List ( String, String )
    , rawStyle : Maybe Elegant.Style
    }



type alias InputAttributes a =
    { a | type_ : String, name : Maybe String }



type alias InputHiddenAttributes =
    { name : Maybe String, type_ : String, value : Maybe String, universal : UniversalAttributes }



type alias LabelAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , position : Position
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias InputRadioAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , value : Maybe String
    , block : Maybe (List ( Modifiers Display.BlockDetails, StyleSelector ))
    , label : Maybe (Shared.Label msg)
    , rawStyle : Maybe Elegant.Style
    }



type alias InputCheckboxAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , value : Maybe String
    , label : Maybe (Shared.Label msg)
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , checked : Bool
    , onCheckEvent : Maybe (Bool -> msg)
    , rawStyle : Maybe Elegant.Style
    }



type alias InputTextAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , value : Maybe String
    , label : Maybe (Shared.Label msg)
    , placeholder : Maybe String
    , autocomplete : Bool
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias InputTelAttributes msg =
    InputTextAttributes msg



type alias InputSubmitAttributes msg =
    { label : Maybe (Shared.Label msg)
    , type_ : String
    , disabled : Bool
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , onSubmitEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias InputUrlAttributes msg =
    InputTextAttributes msg



type alias InputNumberAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , label : Maybe (Shared.Label msg)
    , rawStyle : Maybe Elegant.Style
    , value : Maybe Int
    , onInputEvent : Maybe (Int -> msg)
    , fromStringInput : String -> Int
    , 
```



---

### **max**
```elm
max : Maybe Int }



type alias MinAttribute a =
    { a | min : Maybe Int }



type alias TargetAttribute a =
    { a | target : Maybe String }



type alias HrefAttribute a =
    { a | href : Maybe String }



type alias NameAttribute a =
    { a | name : Maybe String }



type alias WidthAttribute a =
    { a | width : Maybe Int }



type alias HeightAttribute a =
    { a | height : Maybe Int }



type alias DisabledAttribute a =
    { a | disabled : Bool }



type alias MaybeBlockContainer a =
    { a | block : Maybe (List ( Modifiers BlockDetails, StyleSelector )) }



type alias BlockContainer a =
    { a | block : List ( Modifiers BlockDetails, StyleSelector ) }



type alias AutocompleteAttribute a =
    { a | autocomplete : Bool }



type alias PlaceholderAttribute a =
    { a | placeholder : Maybe String }



type alias PositionAttribute a =
    { a | position : Position }



type alias DataAttribute a =
    { a | data : List ( String, String ) }



type alias TypeContainer a =
    { a | type_ : String }



type alias BoxContainer a =
    { a | box : List ( Modifiers Box, StyleSelector ) }



type alias CheckedContainer a =
    { a | checked : Bool }



type alias UniversalContainer a =
    { a | universal : UniversalAttributes }



type alias FlexContainerProperties a =
    { a | flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector ) }



type alias FlexItemProperties a =
    { a | flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector ) }



type alias GridContainerProperties a =
    { a | gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector ) }



type alias GridItemProperties a =
    { a | gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector ) }



type Position
    = Before
    | After



type alias VisibleAttributes a =
    { a
        | box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias StringValue a =
    ValueAttribute String a



type alias IntValue a =
    ValueAttribute Int a



type alias ColorValue a =
    ValueAttribute Color a



type alias VisibleAttributesAndEvents msg a =
    { a
        | onMouseEvents : Maybe (OnMouseEventsInside msg)
        , onEvent : Maybe ( String, Decoder msg )
        , onBlurEvent : Maybe msg
        , onFocusEvent : Maybe msg
        , box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias InputPasswordAttributes msg =
    InputTextAttributes msg



type alias InputRangeAttributes msg =
    InputNumberAttributes msg



type alias SelectAttributes msg =
    { block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , value : Maybe String
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    }



type alias UniversalAttributes =
    { title : Maybe String
    , tabindex : Maybe Int
    , id : Maybe String
    , class : List String
    }



type alias FlowAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias NodeAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexContainerProperties (NodeAttributes msg)



type alias FlexContainerAttributes msg =
    { flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexItemProperties (NodeAttributes msg)



type alias FlexItemAttributes msg =
    { flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridContainerProperties (NodeAttributes msg)



type alias GridContainerAttributes msg =
    { gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridItemProperties (NodeAttributes msg)



type alias GridItemAttributes msg =
    { gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- BlockContainer (FlowAttributes msg)



type alias BlockAttributes msg =
    { block : List ( Modifiers BlockDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias HeadingAttributes msg =
    BlockAttributes msg



type alias ButtonAttributes msg =
    { disabled : Bool
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias AAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , href : Maybe String
    , target : Maybe String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias TextareaAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , value : Maybe String
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    , name : Maybe String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias ImgAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , alt : String
    , width : Maybe Int
    , height : Maybe Int
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias AudioAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias ProgressAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias ScriptAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , data : List ( String, String )
    , rawStyle : Maybe Elegant.Style
    }



type alias InputAttributes a =
    { a | type_ : String, name : Maybe String }



type alias InputHiddenAttributes =
    { name : Maybe String, type_ : String, value : Maybe String, universal : UniversalAttributes }



type alias LabelAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , position : Position
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias InputRadioAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , value : Maybe String
    , block : Maybe (List ( Modifiers Display.BlockDetails, StyleSelector ))
    , label : Maybe (Shared.Label msg)
    , rawStyle : Maybe Elegant.Style
    }



type alias InputCheckboxAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , value : Maybe String
    , label : Maybe (Shared.Label msg)
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , checked : Bool
    , onCheckEvent : Maybe (Bool -> msg)
    , rawStyle : Maybe Elegant.Style
    }



type alias InputTextAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , value : Maybe String
    , label : Maybe (Shared.Label msg)
    , placeholder : Maybe String
    , autocomplete : Bool
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias InputTelAttributes msg =
    InputTextAttributes msg



type alias InputSubmitAttributes msg =
    { label : Maybe (Shared.Label msg)
    , type_ : String
    , disabled : Bool
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , onSubmitEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias InputUrlAttributes msg =
    InputTextAttributes msg



type alias InputNumberAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , label : Maybe (Shared.Label msg)
    , rawStyle : Maybe Elegant.Style
    , value : Maybe Int
    , onInputEvent : Maybe (Int -> msg)
    , fromStringInput : String -> Int
    , step : Maybe Int
    , 
```



---

### **min**
```elm
min : Maybe Int }



type alias TargetAttribute a =
    { a | target : Maybe String }



type alias HrefAttribute a =
    { a | href : Maybe String }



type alias NameAttribute a =
    { a | name : Maybe String }



type alias WidthAttribute a =
    { a | width : Maybe Int }



type alias HeightAttribute a =
    { a | height : Maybe Int }



type alias DisabledAttribute a =
    { a | disabled : Bool }



type alias MaybeBlockContainer a =
    { a | block : Maybe (List ( Modifiers BlockDetails, StyleSelector )) }



type alias BlockContainer a =
    { a | block : List ( Modifiers BlockDetails, StyleSelector ) }



type alias AutocompleteAttribute a =
    { a | autocomplete : Bool }



type alias PlaceholderAttribute a =
    { a | placeholder : Maybe String }



type alias PositionAttribute a =
    { a | position : Position }



type alias DataAttribute a =
    { a | data : List ( String, String ) }



type alias TypeContainer a =
    { a | type_ : String }



type alias BoxContainer a =
    { a | box : List ( Modifiers Box, StyleSelector ) }



type alias CheckedContainer a =
    { a | checked : Bool }



type alias UniversalContainer a =
    { a | universal : UniversalAttributes }



type alias FlexContainerProperties a =
    { a | flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector ) }



type alias FlexItemProperties a =
    { a | flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector ) }



type alias GridContainerProperties a =
    { a | gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector ) }



type alias GridItemProperties a =
    { a | gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector ) }



type Position
    = Before
    | After



type alias VisibleAttributes a =
    { a
        | box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias StringValue a =
    ValueAttribute String a



type alias IntValue a =
    ValueAttribute Int a



type alias ColorValue a =
    ValueAttribute Color a



type alias VisibleAttributesAndEvents msg a =
    { a
        | onMouseEvents : Maybe (OnMouseEventsInside msg)
        , onEvent : Maybe ( String, Decoder msg )
        , onBlurEvent : Maybe msg
        , onFocusEvent : Maybe msg
        , box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias InputPasswordAttributes msg =
    InputTextAttributes msg



type alias InputRangeAttributes msg =
    InputNumberAttributes msg



type alias SelectAttributes msg =
    { block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , value : Maybe String
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    }



type alias UniversalAttributes =
    { title : Maybe String
    , tabindex : Maybe Int
    , id : Maybe String
    , class : List String
    }



type alias FlowAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias NodeAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexContainerProperties (NodeAttributes msg)



type alias FlexContainerAttributes msg =
    { flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexItemProperties (NodeAttributes msg)



type alias FlexItemAttributes msg =
    { flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridContainerProperties (NodeAttributes msg)



type alias GridContainerAttributes msg =
    { gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridItemProperties (NodeAttributes msg)



type alias GridItemAttributes msg =
    { gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- BlockContainer (FlowAttributes msg)



type alias BlockAttributes msg =
    { block : List ( Modifiers BlockDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias HeadingAttributes msg =
    BlockAttributes msg



type alias ButtonAttributes msg =
    { disabled : Bool
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias AAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , href : Maybe String
    , target : Maybe String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias TextareaAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , value : Maybe String
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    , name : Maybe String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias ImgAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , alt : String
    , width : Maybe Int
    , height : Maybe Int
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias AudioAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias ProgressAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias ScriptAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , data : List ( String, String )
    , rawStyle : Maybe Elegant.Style
    }



type alias InputAttributes a =
    { a | type_ : String, name : Maybe String }



type alias InputHiddenAttributes =
    { name : Maybe String, type_ : String, value : Maybe String, universal : UniversalAttributes }



type alias LabelAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , position : Position
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias InputRadioAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , value : Maybe String
    , block : Maybe (List ( Modifiers Display.BlockDetails, StyleSelector ))
    , label : Maybe (Shared.Label msg)
    , rawStyle : Maybe Elegant.Style
    }



type alias InputCheckboxAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , value : Maybe String
    , label : Maybe (Shared.Label msg)
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , checked : Bool
    , onCheckEvent : Maybe (Bool -> msg)
    , rawStyle : Maybe Elegant.Style
    }



type alias InputTextAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , value : Maybe String
    , label : Maybe (Shared.Label msg)
    , placeholder : Maybe String
    , autocomplete : Bool
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias InputTelAttributes msg =
    InputTextAttributes msg



type alias InputSubmitAttributes msg =
    { label : Maybe (Shared.Label msg)
    , type_ : String
    , disabled : Bool
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , onSubmitEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias InputUrlAttributes msg =
    InputTextAttributes msg



type alias InputNumberAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , label : Maybe (Shared.Label msg)
    , rawStyle : Maybe Elegant.Style
    , value : Maybe Int
    , onInputEvent : Maybe (Int -> msg)
    , fromStringInput : String -> Int
    , step : Maybe Int
    , max : Maybe Int
    , 
```



---

### **defaultInputNumberAttributes**
```elm
defaultInputNumberAttributes : InputNumberAttributes msg

```



---

### **inputNumberAttributesToHtmlAttributes**
```elm
inputNumberAttributesToHtmlAttributes : InputNumberAttributes msg -> List (Html.Attribute msg)

```


- [InputColorAttributes](#inputcolorattributes)
- [name](#name-10)
- [defaultInputColorAttributes](#defaultinputcolorattributes)
- [inputColorAttributesToHtmlAttributes](#inputcolorattributestohtmlattributes)

### **type alias InputColorAttributes**
```elm
type alias InputColorAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , label : Maybe (Shared.Label msg)
    , rawStyle : Maybe Elegant.Style
    , value : Maybe Color
    , onInputEvent : Maybe (Color -> msg)
    , fromStringInput : String -> Color
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    }
```



---

### **name**
```elm
name : Maybe String }



type alias WidthAttribute a =
    { a | width : Maybe Int }



type alias HeightAttribute a =
    { a | height : Maybe Int }



type alias DisabledAttribute a =
    { a | disabled : Bool }



type alias MaybeBlockContainer a =
    { a | block : Maybe (List ( Modifiers BlockDetails, StyleSelector )) }



type alias BlockContainer a =
    { a | block : List ( Modifiers BlockDetails, StyleSelector ) }



type alias AutocompleteAttribute a =
    { a | autocomplete : Bool }



type alias PlaceholderAttribute a =
    { a | placeholder : Maybe String }



type alias PositionAttribute a =
    { a | position : Position }



type alias DataAttribute a =
    { a | data : List ( String, String ) }



type alias TypeContainer a =
    { a | type_ : String }



type alias BoxContainer a =
    { a | box : List ( Modifiers Box, StyleSelector ) }



type alias CheckedContainer a =
    { a | checked : Bool }



type alias UniversalContainer a =
    { a | universal : UniversalAttributes }



type alias FlexContainerProperties a =
    { a | flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector ) }



type alias FlexItemProperties a =
    { a | flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector ) }



type alias GridContainerProperties a =
    { a | gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector ) }



type alias GridItemProperties a =
    { a | gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector ) }



type Position
    = Before
    | After



type alias VisibleAttributes a =
    { a
        | box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias StringValue a =
    ValueAttribute String a



type alias IntValue a =
    ValueAttribute Int a



type alias ColorValue a =
    ValueAttribute Color a



type alias VisibleAttributesAndEvents msg a =
    { a
        | onMouseEvents : Maybe (OnMouseEventsInside msg)
        , onEvent : Maybe ( String, Decoder msg )
        , onBlurEvent : Maybe msg
        , onFocusEvent : Maybe msg
        , box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias InputPasswordAttributes msg =
    InputTextAttributes msg



type alias InputRangeAttributes msg =
    InputNumberAttributes msg



type alias SelectAttributes msg =
    { block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , value : Maybe String
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    }



type alias UniversalAttributes =
    { title : Maybe String
    , tabindex : Maybe Int
    , id : Maybe String
    , class : List String
    }



type alias FlowAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias NodeAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexContainerProperties (NodeAttributes msg)



type alias FlexContainerAttributes msg =
    { flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexItemProperties (NodeAttributes msg)



type alias FlexItemAttributes msg =
    { flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridContainerProperties (NodeAttributes msg)



type alias GridContainerAttributes msg =
    { gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridItemProperties (NodeAttributes msg)



type alias GridItemAttributes msg =
    { gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- BlockContainer (FlowAttributes msg)



type alias BlockAttributes msg =
    { block : List ( Modifiers BlockDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias HeadingAttributes msg =
    BlockAttributes msg



type alias ButtonAttributes msg =
    { disabled : Bool
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias AAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , href : Maybe String
    , target : Maybe String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias TextareaAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , value : Maybe String
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    , 
```



---

### **defaultInputColorAttributes**
```elm
defaultInputColorAttributes : InputColorAttributes msg

```



---

### **inputColorAttributesToHtmlAttributes**
```elm
inputColorAttributesToHtmlAttributes : InputColorAttributes msg -> List (Html.Attribute msg)

```


- [InputFileAttributes](#inputfileattributes)
- [name](#name-11)
- [defaultInputFileAttributes](#defaultinputfileattributes)
- [inputFileAttributesToHtmlAttributes](#inputfileattributestohtmlattributes)

### **type alias InputFileAttributes**
```elm
type alias InputFileAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , label : Maybe (Shared.Label msg)
    , rawStyle : Maybe Elegant.Style
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    }
```



---

### **name**
```elm
name : Maybe String }



type alias WidthAttribute a =
    { a | width : Maybe Int }



type alias HeightAttribute a =
    { a | height : Maybe Int }



type alias DisabledAttribute a =
    { a | disabled : Bool }



type alias MaybeBlockContainer a =
    { a | block : Maybe (List ( Modifiers BlockDetails, StyleSelector )) }



type alias BlockContainer a =
    { a | block : List ( Modifiers BlockDetails, StyleSelector ) }



type alias AutocompleteAttribute a =
    { a | autocomplete : Bool }



type alias PlaceholderAttribute a =
    { a | placeholder : Maybe String }



type alias PositionAttribute a =
    { a | position : Position }



type alias DataAttribute a =
    { a | data : List ( String, String ) }



type alias TypeContainer a =
    { a | type_ : String }



type alias BoxContainer a =
    { a | box : List ( Modifiers Box, StyleSelector ) }



type alias CheckedContainer a =
    { a | checked : Bool }



type alias UniversalContainer a =
    { a | universal : UniversalAttributes }



type alias FlexContainerProperties a =
    { a | flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector ) }



type alias FlexItemProperties a =
    { a | flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector ) }



type alias GridContainerProperties a =
    { a | gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector ) }



type alias GridItemProperties a =
    { a | gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector ) }



type Position
    = Before
    | After



type alias VisibleAttributes a =
    { a
        | box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias StringValue a =
    ValueAttribute String a



type alias IntValue a =
    ValueAttribute Int a



type alias ColorValue a =
    ValueAttribute Color a



type alias VisibleAttributesAndEvents msg a =
    { a
        | onMouseEvents : Maybe (OnMouseEventsInside msg)
        , onEvent : Maybe ( String, Decoder msg )
        , onBlurEvent : Maybe msg
        , onFocusEvent : Maybe msg
        , box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias InputPasswordAttributes msg =
    InputTextAttributes msg



type alias InputRangeAttributes msg =
    InputNumberAttributes msg



type alias SelectAttributes msg =
    { block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , value : Maybe String
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    }



type alias UniversalAttributes =
    { title : Maybe String
    , tabindex : Maybe Int
    , id : Maybe String
    , class : List String
    }



type alias FlowAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias NodeAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexContainerProperties (NodeAttributes msg)



type alias FlexContainerAttributes msg =
    { flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexItemProperties (NodeAttributes msg)



type alias FlexItemAttributes msg =
    { flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridContainerProperties (NodeAttributes msg)



type alias GridContainerAttributes msg =
    { gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridItemProperties (NodeAttributes msg)



type alias GridItemAttributes msg =
    { gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- BlockContainer (FlowAttributes msg)



type alias BlockAttributes msg =
    { block : List ( Modifiers BlockDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias HeadingAttributes msg =
    BlockAttributes msg



type alias ButtonAttributes msg =
    { disabled : Bool
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias AAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , href : Maybe String
    , target : Maybe String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias TextareaAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , value : Maybe String
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    , 
```



---

### **defaultInputFileAttributes**
```elm
defaultInputFileAttributes : InputFileAttributes msg

```



---

### **inputFileAttributesToHtmlAttributes**
```elm
inputFileAttributesToHtmlAttributes : InputFileAttributes msg -> List (Html.Attribute msg)

```


- [TextareaAttributes](#textareaattributes)
- [autocomplete](#autocomplete-1)
- [placeholder](#placeholder-2)
- [defaultTextareaAttributes](#defaulttextareaattributes)
- [textareaAttributesToHtmlAttributes](#textareaattributestohtmlattributes)

### **type alias TextareaAttributes**
```elm
type alias TextareaAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , value : Maybe String
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    , name : Maybe String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }
```



---

### **autocomplete**
```elm
autocomplete : Bool }



type alias PlaceholderAttribute a =
    { a | placeholder : Maybe String }



type alias PositionAttribute a =
    { a | position : Position }



type alias DataAttribute a =
    { a | data : List ( String, String ) }



type alias TypeContainer a =
    { a | type_ : String }



type alias BoxContainer a =
    { a | box : List ( Modifiers Box, StyleSelector ) }



type alias CheckedContainer a =
    { a | checked : Bool }



type alias UniversalContainer a =
    { a | universal : UniversalAttributes }



type alias FlexContainerProperties a =
    { a | flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector ) }



type alias FlexItemProperties a =
    { a | flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector ) }



type alias GridContainerProperties a =
    { a | gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector ) }



type alias GridItemProperties a =
    { a | gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector ) }



type Position
    = Before
    | After



type alias VisibleAttributes a =
    { a
        | box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias StringValue a =
    ValueAttribute String a



type alias IntValue a =
    ValueAttribute Int a



type alias ColorValue a =
    ValueAttribute Color a



type alias VisibleAttributesAndEvents msg a =
    { a
        | onMouseEvents : Maybe (OnMouseEventsInside msg)
        , onEvent : Maybe ( String, Decoder msg )
        , onBlurEvent : Maybe msg
        , onFocusEvent : Maybe msg
        , box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias InputPasswordAttributes msg =
    InputTextAttributes msg



type alias InputRangeAttributes msg =
    InputNumberAttributes msg



type alias SelectAttributes msg =
    { block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , value : Maybe String
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    }



type alias UniversalAttributes =
    { title : Maybe String
    , tabindex : Maybe Int
    , id : Maybe String
    , class : List String
    }



type alias FlowAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias NodeAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexContainerProperties (NodeAttributes msg)



type alias FlexContainerAttributes msg =
    { flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexItemProperties (NodeAttributes msg)



type alias FlexItemAttributes msg =
    { flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridContainerProperties (NodeAttributes msg)



type alias GridContainerAttributes msg =
    { gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridItemProperties (NodeAttributes msg)



type alias GridItemAttributes msg =
    { gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- BlockContainer (FlowAttributes msg)



type alias BlockAttributes msg =
    { block : List ( Modifiers BlockDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias HeadingAttributes msg =
    BlockAttributes msg



type alias ButtonAttributes msg =
    { disabled : Bool
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias AAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , href : Maybe String
    , target : Maybe String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias TextareaAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , value : Maybe String
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    , name : Maybe String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias ImgAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , alt : String
    , width : Maybe Int
    , height : Maybe Int
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias AudioAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias ProgressAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias ScriptAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , data : List ( String, String )
    , rawStyle : Maybe Elegant.Style
    }



type alias InputAttributes a =
    { a | type_ : String, name : Maybe String }



type alias InputHiddenAttributes =
    { name : Maybe String, type_ : String, value : Maybe String, universal : UniversalAttributes }



type alias LabelAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , position : Position
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias InputRadioAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , value : Maybe String
    , block : Maybe (List ( Modifiers Display.BlockDetails, StyleSelector ))
    , label : Maybe (Shared.Label msg)
    , rawStyle : Maybe Elegant.Style
    }



type alias InputCheckboxAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , value : Maybe String
    , label : Maybe (Shared.Label msg)
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , checked : Bool
    , onCheckEvent : Maybe (Bool -> msg)
    , rawStyle : Maybe Elegant.Style
    }



type alias InputTextAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , value : Maybe String
    , label : Maybe (Shared.Label msg)
    , placeholder : Maybe String
    , 
```



---

### **placeholder**
```elm
placeholder : Maybe String }



type alias PositionAttribute a =
    { a | position : Position }



type alias DataAttribute a =
    { a | data : List ( String, String ) }



type alias TypeContainer a =
    { a | type_ : String }



type alias BoxContainer a =
    { a | box : List ( Modifiers Box, StyleSelector ) }



type alias CheckedContainer a =
    { a | checked : Bool }



type alias UniversalContainer a =
    { a | universal : UniversalAttributes }



type alias FlexContainerProperties a =
    { a | flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector ) }



type alias FlexItemProperties a =
    { a | flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector ) }



type alias GridContainerProperties a =
    { a | gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector ) }



type alias GridItemProperties a =
    { a | gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector ) }



type Position
    = Before
    | After



type alias VisibleAttributes a =
    { a
        | box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias StringValue a =
    ValueAttribute String a



type alias IntValue a =
    ValueAttribute Int a



type alias ColorValue a =
    ValueAttribute Color a



type alias VisibleAttributesAndEvents msg a =
    { a
        | onMouseEvents : Maybe (OnMouseEventsInside msg)
        , onEvent : Maybe ( String, Decoder msg )
        , onBlurEvent : Maybe msg
        , onFocusEvent : Maybe msg
        , box : List ( Modifiers Box, StyleSelector )
        , universal : UniversalAttributes
        , rawStyle : Maybe Elegant.Style
    }



type alias InputPasswordAttributes msg =
    InputTextAttributes msg



type alias InputRangeAttributes msg =
    InputNumberAttributes msg



type alias SelectAttributes msg =
    { block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , value : Maybe String
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    }



type alias UniversalAttributes =
    { title : Maybe String
    , tabindex : Maybe Int
    , id : Maybe String
    , class : List String
    }



type alias FlowAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias NodeAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexContainerProperties (NodeAttributes msg)



type alias FlexContainerAttributes msg =
    { flexContainerProperties : List ( Modifiers Flex.FlexContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- FlexItemProperties (NodeAttributes msg)



type alias FlexItemAttributes msg =
    { flexItemProperties : List ( Modifiers Flex.FlexItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridContainerProperties (NodeAttributes msg)



type alias GridContainerAttributes msg =
    { gridContainerProperties : List ( Modifiers Grid.GridContainerDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- GridItemProperties (NodeAttributes msg)



type alias GridItemAttributes msg =
    { gridItemProperties : List ( Modifiers Grid.GridItemDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



-- BlockContainer (FlowAttributes msg)



type alias BlockAttributes msg =
    { block : List ( Modifiers BlockDetails, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias HeadingAttributes msg =
    BlockAttributes msg



type alias ButtonAttributes msg =
    { disabled : Bool
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , rawStyle : Maybe Elegant.Style
    }



type alias AAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , href : Maybe String
    , target : Maybe String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias TextareaAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , value : Maybe String
    , onInputEvent : Maybe (String -> msg)
    , fromStringInput : String -> String
    , name : Maybe String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias ImgAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , alt : String
    , width : Maybe Int
    , height : Maybe Int
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias AudioAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias ProgressAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias ScriptAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , src : String
    , data : List ( String, String )
    , rawStyle : Maybe Elegant.Style
    }



type alias InputAttributes a =
    { a | type_ : String, name : Maybe String }



type alias InputHiddenAttributes =
    { name : Maybe String, type_ : String, value : Maybe String, universal : UniversalAttributes }



type alias LabelAttributes msg =
    { onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , box : List ( Modifiers Box, StyleSelector )
    , universal : UniversalAttributes
    , position : Position
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , rawStyle : Maybe Elegant.Style
    }



type alias InputRadioAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , value : Maybe String
    , block : Maybe (List ( Modifiers Display.BlockDetails, StyleSelector ))
    , label : Maybe (Shared.Label msg)
    , rawStyle : Maybe Elegant.Style
    }



type alias InputCheckboxAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , value : Maybe String
    , label : Maybe (Shared.Label msg)
    , block : Maybe (List ( Modifiers BlockDetails, StyleSelector ))
    , checked : Bool
    , onCheckEvent : Maybe (Bool -> msg)
    , rawStyle : Maybe Elegant.Style
    }



type alias InputTextAttributes msg =
    { name : Maybe String
    , type_ : String
    , universal : UniversalAttributes
    , box : List ( Modifiers Box, StyleSelector )
    , onMouseEvents : Maybe (OnMouseEventsInside msg)
    , onEvent : Maybe ( String, Decoder msg )
    , onBlurEvent : Maybe msg
    , onFocusEvent : Maybe msg
    , value : Maybe String
    , label : Maybe (Shared.Label msg)
    , 
```



---

### **defaultTextareaAttributes**
```elm
defaultTextareaAttributes : TextareaAttributes msg

```



---

### **textareaAttributesToHtmlAttributes**
```elm
textareaAttributesToHtmlAttributes : TextareaAttributes msg -> List (Html.Attribute msg)

```



