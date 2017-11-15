# BodyBuilder.Events

This module entirely replaces Html.Events, providing a type-safer alternative.
This is designed to work with BodyBuilder.
It is not compatible with Html, though.

- [checkEventToHtmlEvent](#checkeventtohtmlevent)

### **checkEventToHtmlEvent**
```elm
checkEventToHtmlEvent : BodyBuilder.Events.OnCheckEvent msg a -> List (Html.Attribute msg)
```


- [focusEventToHtmlAttributes](#focuseventtohtmlattributes)

### **focusEventToHtmlAttributes**
```elm
focusEventToHtmlAttributes : msg -> List (Html.Attribute msg)
```


- [inputEventToHtmlEvent](#inputeventtohtmlevent)

### **inputEventToHtmlEvent**
```elm
inputEventToHtmlEvent : ( Maybe (a -> msg), String -> a ) -> List (Html.Attribute msg)
```


- [mouseEventsToHtmlAttributes](#mouseeventstohtmlattributes)

### **mouseEventsToHtmlAttributes**
```elm
mouseEventsToHtmlAttributes : BodyBuilder.Events.OnMouseEventsInside msg -> List (Html.Attribute msg)
```


- [on](#on)

### **on**
```elm
on : String -> Json.Decode.Decoder msg -> Helpers.Shared.Modifier (BodyBuilder.Events.OnEvent msg a)
```


- [onBlur](#onblur)

### **onBlur**
```elm
onBlur : msg -> Helpers.Shared.Modifier (BodyBuilder.Events.OnBlurEvent msg a)
```


- [OnBlurEvent](#onblurevent)

### **type alias OnBlurEvent**
```elm
type alias OnBlurEvent msg a =  
    { a | onBlurEvent : Maybe msg }
```


- [onBlurEventToHtmlAttributes](#onblureventtohtmlattributes)

### **onBlurEventToHtmlAttributes**
```elm
onBlurEventToHtmlAttributes : msg -> List (Html.Attribute msg)
```


- [onCheck](#oncheck)

### **onCheck**
```elm
onCheck : (Bool -> msg) -> Helpers.Shared.Modifier (BodyBuilder.Events.OnCheckEvent msg a)
```


- [OnCheckEvent](#oncheckevent)

### **type alias OnCheckEvent**
```elm
type alias OnCheckEvent msg a =  
    { a | onCheckEvent : Maybe (Bool -> msg) }
```


- [onClick](#onclick)

### **onClick**
```elm
onClick : msg -> Helpers.Shared.Modifier (BodyBuilder.Events.OnMouseEvents msg a)
```


- [OnColorInputEvent](#oncolorinputevent)

### **type alias OnColorInputEvent**
```elm
type alias OnColorInputEvent msg a =  
    BodyBuilder.Events.OnInputEvent Color msg a
```


- [onDoubleClick](#ondoubleclick)

### **onDoubleClick**
```elm
onDoubleClick : msg -> Helpers.Shared.Modifier (BodyBuilder.Events.OnMouseEvents msg a)
```


- [OnEvent](#onevent)

### **type alias OnEvent**
```elm
type alias OnEvent msg a =  
    { a | onEvent : Maybe ( String, Json.Decode.Decoder msg ) }
```


- [onEventToHtmlAttributes](#oneventtohtmlattributes)

### **onEventToHtmlAttributes**
```elm
onEventToHtmlAttributes : ( String, Json.Decode.Decoder msg ) -> List (Html.Attribute msg)
```


- [onFocus](#onfocus)

### **onFocus**
```elm
onFocus : msg -> Helpers.Shared.Modifier (BodyBuilder.Events.OnFocusEvent msg a)
```


- [OnFocusEvent](#onfocusevent)

### **type alias OnFocusEvent**
```elm
type alias OnFocusEvent msg a =  
    { a | onFocusEvent : Maybe msg }
```


- [onInput](#oninput)

### **onInput**
```elm
onInput : (a -> msg) -> Helpers.Shared.Modifier (BodyBuilder.Events.OnInputEvent a msg b)
```


- [OnIntInputEvent](#onintinputevent)

### **type alias OnIntInputEvent**
```elm
type alias OnIntInputEvent msg a =  
    BodyBuilder.Events.OnInputEvent Int msg a
```


- [onMouseDown](#onmousedown)

### **onMouseDown**
```elm
onMouseDown : msg -> Helpers.Shared.Modifier (BodyBuilder.Events.OnMouseEvents msg a)
```


- [onMouseEnter](#onmouseenter)

### **onMouseEnter**
```elm
onMouseEnter : msg -> Helpers.Shared.Modifier (BodyBuilder.Events.OnMouseEvents msg a)
```


- [OnMouseEvents](#onmouseevents)

### **type alias OnMouseEvents**
```elm
type alias OnMouseEvents msg a =  
    { a | onMouseEvents : Maybe (BodyBuilder.Events.OnMouseEventsInside msg) }
```


- [OnMouseEventsInside](#onmouseeventsinside)

### **type alias OnMouseEventsInside**
```elm
type alias OnMouseEventsInside msg =  
    { click : Maybe msg , doubleClick : Maybe msg , mouseDown : Maybe msg , mouseUp : Maybe msg , mouseEnter : Maybe msg , mouseLeave : Maybe msg , mouseOver : Maybe msg , mouseOut : Maybe msg }
```


- [onMouseLeave](#onmouseleave)

### **onMouseLeave**
```elm
onMouseLeave : msg -> Helpers.Shared.Modifier (BodyBuilder.Events.OnMouseEvents msg a)
```


- [onMouseOut](#onmouseout)

### **onMouseOut**
```elm
onMouseOut : msg -> Helpers.Shared.Modifier (BodyBuilder.Events.OnMouseEvents msg a)
```


- [onMouseOver](#onmouseover)

### **onMouseOver**
```elm
onMouseOver : msg -> Helpers.Shared.Modifier (BodyBuilder.Events.OnMouseEvents msg a)
```


- [onMouseUp](#onmouseup)

### **onMouseUp**
```elm
onMouseUp : msg -> Helpers.Shared.Modifier (BodyBuilder.Events.OnMouseEvents msg a)
```


- [OnStringInputEvent](#onstringinputevent)

### **type alias OnStringInputEvent**
```elm
type alias OnStringInputEvent msg a =  
    BodyBuilder.Events.OnInputEvent String msg a
```


- [onSubmit](#onsubmit)

### **onSubmit**
```elm
onSubmit : msg -> Helpers.Shared.Modifier (BodyBuilder.Events.OnSubmitEvent msg a)
```


- [OnSubmitEvent](#onsubmitevent)

### **type alias OnSubmitEvent**
```elm
type alias OnSubmitEvent msg a =  
    { a | onSubmitEvent : Maybe msg }
```


- [submitEventToHtmlEvent](#submiteventtohtmlevent)

### **submitEventToHtmlEvent**
```elm
submitEventToHtmlEvent : BodyBuilder.Events.OnSubmitEvent msg a -> List (Html.Attribute msg)
```



