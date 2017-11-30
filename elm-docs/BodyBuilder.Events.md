# BodyBuilder.Events

This module entirely replaces Html.Events, providing a type-safer alternative.
This is designed to work with BodyBuilder.
It is not compatible with Html, though.

- [checkEventToHtmlEvent](#checkeventtohtmlevent)

### **checkEventToHtmlEvent**
```elm
checkEventToHtmlEvent : OnCheckEvent msg a -> List (Html.Attribute msg)

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
mouseEventsToHtmlAttributes : OnMouseEventsInside msg -> List (Html.Attribute msg)

```


- [on](#on)

### **on**
```elm
on : String -> Decoder msg -> Modifier (OnEvent msg a)

```


- [onBlur](#onblur)

### **onBlur**
```elm
onBlur : msg -> Modifier (OnBlurEvent msg a)

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
onCheck : (Bool -> msg) -> Modifier (OnCheckEvent msg a)

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
onClick : msg -> Modifier (OnMouseEvents msg a)

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
onDoubleClick : msg -> Modifier (OnMouseEvents msg a)

```


- [OnEvent](#onevent)

### **type alias OnEvent**
```elm
type alias OnEvent msg a =
    { a | onEvent : Maybe ( String, Decoder msg ) }
```


- [onEventToHtmlAttributes](#oneventtohtmlattributes)

### **onEventToHtmlAttributes**
```elm
onEventToHtmlAttributes : ( String, Decoder msg ) -> List (Html.Attribute msg)

```


- [onFocus](#onfocus)

### **onFocus**
```elm
onFocus : msg -> Modifier (OnFocusEvent msg a)

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
onInput : (a -> msg) -> Modifier (OnInputEvent a msg b)

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
onMouseDown : msg -> Modifier (OnMouseEvents msg a)

```


- [onMouseEnter](#onmouseenter)

### **onMouseEnter**
```elm
onMouseEnter : msg -> Modifier (OnMouseEvents msg a)

```


- [OnMouseEvents](#onmouseevents)

### **type alias OnMouseEvents**
```elm
type alias OnMouseEvents msg a =
    { a | onMouseEvents : Maybe (OnMouseEventsInside msg) }
```


- [OnMouseEventsInside](#onmouseeventsinside)

### **type alias OnMouseEventsInside**
```elm
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
```


- [onMouseLeave](#onmouseleave)

### **onMouseLeave**
```elm
onMouseLeave : msg -> Modifier (OnMouseEvents msg a)

```


- [onMouseOut](#onmouseout)

### **onMouseOut**
```elm
onMouseOut : msg -> Modifier (OnMouseEvents msg a)

```


- [onMouseOver](#onmouseover)

### **onMouseOver**
```elm
onMouseOver : msg -> Modifier (OnMouseEvents msg a)

```


- [onMouseUp](#onmouseup)

### **onMouseUp**
```elm
onMouseUp : msg -> Modifier (OnMouseEvents msg a)

```


- [OnStringInputEvent](#onstringinputevent)

### **type alias OnStringInputEvent**
```elm
type alias OnStringInputEvent msg a =
    OnInputEvent String msg a



type alias OnIntInputEvent msg a =
    OnInputEvent Int msg a



type alias OnColorInputEvent msg a =
    OnInputEvent Color msg a



type alias OnCheckEvent msg a =
    { a | onCheckEvent : Maybe (Bool -> msg) }
```


- [onSubmit](#onsubmit)

### **onSubmit**
```elm
onSubmit : msg -> Modifier (OnSubmitEvent msg a)

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
submitEventToHtmlEvent : OnSubmitEvent msg a -> List (Html.Attribute msg)

```



