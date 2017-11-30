# Elegant

- [CommonStyle](#commonstyle)

### **type alias CommonStyle**
```elm
type alias CommonStyle  =
    CommonStyle.Style



commonStyleToStyle : CommonStyle -> Style
commonStyleToStyle =
    Style



style : DisplayBox -> Style
style display =
    Style
        { display 
```


- [commonStyle](#commonstyle-1)

### **commonStyle**
```elm
commonStyle : 
    Maybe DisplayBox
    -> List CommonStyle.ScreenWidth
    -> Maybe String
    -> CommonStyle.Style

```


- [commonStyleToCss](#commonstyletocss)

### **commonStyleToCss**
```elm
commonStyleToCss : CommonStyle -> String

```


- [commonStyleToStyle](#commonstyletostyle)

### **commonStyleToStyle**
```elm
commonStyleToStyle : CommonStyle -> Style

```


- [SizeUnit](#sizeunit)

### **type alias SizeUnit**
```elm
type alias SizeUnit  =
    Px



pt : Int -> SizeUnit
pt =
    Pt



percent : Float -> SizeUnit
percent =
    Percent



vh : Float -> SizeUnit
vh =
    Vh



vw : Float -> SizeUnit
vw =
    Vw



em : Float -> SizeUnit
em =
    Em



rem : Float -> SizeUnit
rem =
    Rem



opposite : SizeUnit -> SizeUnit
opposite unit =
    case unit of
        Px a ->
            Px -a

        Pt a ->
            Pt -a

        Percent a ->
            Percent -a

        Vh a ->
            Vh -a

        Vw a ->
            Vw -a

        Em a ->
            Em -a

        Rem a ->
            Rem -a



color : a -> { b | color : Maybe a }
```


- [Style](#style)

### **type Style**
```elm
type Style   
    = 
```

Contains all style for an element used with Elegant.
- [classes](#classes)

### **classes**
```elm
classes : Style -> String

```

Generate all the classes of a list of Styles
- [color](#color)

### **color**
```elm
color : a -> { b | 
```


- [em](#em)

### **em**
```elm
em : Float -> SizeUnit

```


- [emptyStyle](#emptystyle)

### **emptyStyle**
```elm
emptyStyle : Style

```


- [inlineStyle](#inlinestyle)

### **inlineStyle**
```elm
inlineStyle : DisplayBox -> Html.Attribute msg

```


- [opposite](#opposite)

### **opposite**
```elm
opposite : SizeUnit -> SizeUnit

```

Calculate the opposite of a size unit value.
Ex : opposite (Px 2) == Px -2
- [percent](#percent)

### **percent**
```elm
percent : Float -> SizeUnit

```


- [pt](#pt)

### **pt**
```elm
pt : Int -> SizeUnit

```


- [px](#px)

### **px**
```elm
px : Int -> SizeUnit

```


- [rem](#rem)

### **rem**
```elm
rem : Float -> SizeUnit

```


- [screenWidthBetween](#screenwidthbetween)

### **screenWidthBetween**
```elm
screenWidthBetween : Int -> Int -> DisplayBox -> Modifier Style

```


- [screenWidthGE](#screenwidthge)

### **screenWidthGE**
```elm
screenWidthGE : Int -> DisplayBox -> Modifier Style

```


- [screenWidthLE](#screenwidthle)

### **screenWidthLE**
```elm
screenWidthLE : Int -> DisplayBox -> Modifier Style

```


- [setSuffix](#setsuffix)

### **setSuffix**
```elm
setSuffix : String -> Style -> Style

```


- [style](#style-1)

### **style**
```elm
style : DisplayBox -> Style

```


- [styleToCss](#styletocss)

### **styleToCss**
```elm
styleToCss : Style -> String

```


- [toCommonStyle](#tocommonstyle)

### **toCommonStyle**
```elm
toCommonStyle : Style -> CommonStyle.Style

```


- [toInlineStyles](#toinlinestyles)

### **toInlineStyles**
```elm
toInlineStyles : Style -> List ( String, String )

```


- [vh](#vh)

### **vh**
```elm
vh : Float -> SizeUnit

```


- [vw](#vw)

### **vw**
```elm
vw : Float -> SizeUnit

```


- [withScreenWidth](#withscreenwidth)

### **withScreenWidth**
```elm
withScreenWidth : List CommonStyle.ScreenWidth -> Modifier Style

```



