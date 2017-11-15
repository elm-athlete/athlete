# Elegant

- [Modifier](#modifier)

### **type alias Modifier**
```elm
type alias Modifier a =  
    Helpers.Shared.Modifier a
```


- [CommonStyle](#commonstyle)

### **type alias CommonStyle**
```elm
type alias CommonStyle  =  
    Helpers.Style.Style
```


- [commonStyle](#commonstyle-1)

### **commonStyle**
```elm
commonStyle : Maybe Display.DisplayBox -> List Helpers.Style.ScreenWidth -> Maybe String -> Helpers.Style.Style
```


- [commonStyleToCss](#commonstyletocss)

### **commonStyleToCss**
```elm
commonStyleToCss : Elegant.CommonStyle -> String
```


- [commonStyleToStyle](#commonstyletostyle)

### **commonStyleToStyle**
```elm
commonStyleToStyle : Elegant.CommonStyle -> Elegant.Style
```


- [Modifiers](#modifiers)

### **type alias Modifiers**
```elm
type alias Modifiers a =  
    Helpers.Shared.Modifiers a
```


- [SizeUnit](#sizeunit)

### **type alias SizeUnit**
```elm
type alias SizeUnit  =  
    Helpers.Shared.SizeUnit
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
classes : Elegant.Style -> String
```

Generate all the classes of a list of Styles
- [color](#color)

### **color**
```elm
color : a -> { b | color : Maybe a } -> { b | color : Maybe a }
```


- [em](#em)

### **em**
```elm
em : Float -> Elegant.SizeUnit
```


- [emptyStyle](#emptystyle)

### **emptyStyle**
```elm
emptyStyle : Elegant.Style
```


- [inlineStyle](#inlinestyle)

### **inlineStyle**
```elm
inlineStyle : Display.DisplayBox -> Html.Attribute msg
```


- [opposite](#opposite)

### **opposite**
```elm
opposite : Elegant.SizeUnit -> Elegant.SizeUnit
```

Calculate the opposite of a size unit value.
Ex : opposite (Px 2) == Px -2
- [percent](#percent)

### **percent**
```elm
percent : Float -> Elegant.SizeUnit
```


- [pt](#pt)

### **pt**
```elm
pt : Int -> Elegant.SizeUnit
```


- [px](#px)

### **px**
```elm
px : Int -> Elegant.SizeUnit
```


- [rem](#rem)

### **rem**
```elm
rem : Float -> Elegant.SizeUnit
```


- [screenWidthBetween](#screenwidthbetween)

### **screenWidthBetween**
```elm
screenWidthBetween : Int -> Int -> Display.DisplayBox -> Elegant.Modifier Elegant.Style
```


- [screenWidthGE](#screenwidthge)

### **screenWidthGE**
```elm
screenWidthGE : Int -> Display.DisplayBox -> Elegant.Modifier Elegant.Style
```


- [screenWidthLE](#screenwidthle)

### **screenWidthLE**
```elm
screenWidthLE : Int -> Display.DisplayBox -> Elegant.Modifier Elegant.Style
```


- [setSuffix](#setsuffix)

### **setSuffix**
```elm
setSuffix : String -> Elegant.Style -> Elegant.Style
```


- [style](#style-1)

### **style**
```elm
style : Display.DisplayBox -> Elegant.Style
```


- [styleToCss](#styletocss)

### **styleToCss**
```elm
styleToCss : Elegant.Style -> String
```


- [toCommonStyle](#tocommonstyle)

### **toCommonStyle**
```elm
toCommonStyle : Elegant.Style -> Helpers.Style.Style
```


- [toInlineStyles](#toinlinestyles)

### **toInlineStyles**
```elm
toInlineStyles : Elegant.Style -> List ( String, String )
```


- [vh](#vh)

### **vh**
```elm
vh : Float -> Elegant.SizeUnit
```


- [withScreenWidth](#withscreenwidth)

### **withScreenWidth**
```elm
withScreenWidth : List Helpers.Style.ScreenWidth -> Elegant.Modifier Elegant.Style
```



