# Box

Handles all modifications for the box. You don't need to instanciate one,
as it's automatically done by Elegant and the different display elements.
It contains only modifiers, and they can be found in the respective modules.


# Types

- [Box](#box)

### **type alias Box**
```elm
type alias Box  =  
    { appearance : Maybe String , background : Maybe Background , border : Maybe (Surrounded Border) , boxShadow : Maybe Shadow , corner : Maybe Corner , cursor : Maybe Cursor , margin : Maybe (Surrounded Margin) , opacity : Maybe Float , outline : Maybe Outline , padding : Maybe (Surrounded Padding) , position : Maybe Position , typography : Maybe Typography , visibility : Maybe Box.Visibility , zIndex : Maybe Int }
```

Represents a box, handling the properties of blocks. They are automatically
instanciated to avoid to deal with it directly. The focus is on the modifiers, available
in respective modules.

```elm
Elegant.displayBlock []
    [ Box.cursor Cursor.default
    -- You can use any Box functions here to add custom style...
    ]
```
- [Visibility](#visibility)

### **type Visibility**
```elm
type Visibility   
    = 
```

Defines the visibility of an element. It can be either visible or hidden.


# Modifiers

- [appearanceNone](#appearancenone)

### **appearanceNone**
```elm
appearanceNone : Helpers.Shared.Modifier Box
```

Accepts an Int for the `zIndex` and modifies the Box accordingly.
- [background](#background)

### **background**
```elm
background : Helpers.Shared.Modifiers Background -> Helpers.Shared.Modifier Box
```

Accepts a list of modifiers for the `Background` and modifies the Box accordingly.
- [border](#border)

### **border**
```elm
border : Helpers.Shared.Modifiers (Surrounded Border) -> Helpers.Shared.Modifier Box
```

Accepts a list of modifiers for the `Border` and modifies the Box accordingly.
- [boxShadow](#boxshadow)

### **boxShadow**
```elm
boxShadow : Helpers.Shared.Modifiers Shadow -> Helpers.Shared.Modifier Box
```

Accepts a list of modifiers for the `Shadow` and modifies the Box accordingly.
- [shadow](#shadow)

### **shadow**
```elm
shadow : Helpers.Shared.Modifiers Shadow -> Helpers.Shared.Modifier Box
```

Alias of boxShadow
- [corner](#corner)

### **corner**
```elm
corner : Helpers.Shared.Modifiers Corner -> Helpers.Shared.Modifier Box
```

Accepts a list of modifiers for the `Corner` and modifies the Box accordingly.
- [cursor](#cursor)

### **cursor**
```elm
cursor : Cursor -> Helpers.Shared.Modifier Box
```

Accepts a `Cursor` and modifies the Box accordingly.
- [margin](#margin)

### **margin**
```elm
margin : Helpers.Shared.Modifiers (Surrounded Margin) -> Helpers.Shared.Modifier Box
```

Accepts a list of modifiers for the `Margin` and modifies the Box accordingly.
- [opacity](#opacity)

### **opacity**
```elm
opacity : Float -> Helpers.Shared.Modifier Box
```

Accepts a size for the `opacity` and modifies the Box accordingly.
- [outline](#outline)

### **outline**
```elm
outline : Helpers.Shared.Modifiers Outline -> Helpers.Shared.Modifier Box
```

Accepts a list of modifiers for the `Outline` and modifies the Box accordingly.
- [padding](#padding)

### **padding**
```elm
padding : Helpers.Shared.Modifiers (Surrounded Padding) -> Helpers.Shared.Modifier Box
```

Accepts a list of modifiers for the `Padding` and modifies the Box accordingly.
- [position](#position)

### **position**
```elm
position : Position -> Helpers.Shared.Modifier Box
```

Accepts a `Position` and modifies the Box accordingly.
- [typography](#typography)

### **typography**
```elm
typography : Helpers.Shared.Modifiers Typography -> Helpers.Shared.Modifier Box
```

Accepts a list of modifiers for the `Typography` and modifies the Box accordingly.
- [visibility](#visibility-1)

### **visibility**
```elm
visibility : Box.Visibility -> Helpers.Shared.Modifier Box
```

Accepts a `Visibility` and modifies the Box accordingly.
- [zIndex](#zindex)

### **zIndex**
```elm
zIndex : Int -> Helpers.Shared.Modifier Box
```

Accepts an Int for the `zIndex` and modifies the Box accordingly.


# Shortcuts

- [outlineNone](#outlinenone)

### **outlineNone**
```elm
outlineNone : Helpers.Shared.Modifier Box
```


- [backgroundColor](#backgroundcolor)

### **backgroundColor**
```elm
backgroundColor : Color -> Helpers.Shared.Modifier Box
```


- [cornerRound](#cornerround)

### **cornerRound**
```elm
cornerRound : Helpers.Shared.Modifier Box
```


- [cornerRadius](#cornerradius)

### **cornerRadius**
```elm
cornerRadius : Int -> Helpers.Shared.Modifier Box
```


- [borderNone](#bordernone)

### **borderNone**
```elm
borderNone : Helpers.Shared.Modifier Box
```


- [borderColor](#bordercolor)

### **borderColor**
```elm
borderColor : Color -> Helpers.Shared.Modifier Box
```


- [borderWidth](#borderwidth)

### **borderWidth**
```elm
borderWidth : Int -> Helpers.Shared.Modifier Box
```


- [borderSolid](#bordersolid)

### **borderSolid**
```elm
borderSolid : Helpers.Shared.Modifier Box
```


- [paddingAll](#paddingall)

### **paddingAll**
```elm
paddingAll : Helpers.Shared.SizeUnit -> Helpers.Shared.Modifier Box
```


- [paddingHorizontal](#paddinghorizontal)

### **paddingHorizontal**
```elm
paddingHorizontal : Helpers.Shared.SizeUnit -> Helpers.Shared.Modifier Box
```


- [paddingVertical](#paddingvertical)

### **paddingVertical**
```elm
paddingVertical : Helpers.Shared.SizeUnit -> Helpers.Shared.Modifier Box
```


- [paddingTop](#paddingtop)

### **paddingTop**
```elm
paddingTop : Helpers.Shared.SizeUnit -> Helpers.Shared.Modifier Box
```


- [paddingRight](#paddingright)

### **paddingRight**
```elm
paddingRight : Helpers.Shared.SizeUnit -> Helpers.Shared.Modifier Box
```


- [paddingBottom](#paddingbottom)

### **paddingBottom**
```elm
paddingBottom : Helpers.Shared.SizeUnit -> Helpers.Shared.Modifier Box
```


- [paddingLeft](#paddingleft)

### **paddingLeft**
```elm
paddingLeft : Helpers.Shared.SizeUnit -> Helpers.Shared.Modifier Box
```


- [shadowCenteredBlurry](#shadowcenteredblurry)

### **shadowCenteredBlurry**
```elm
shadowCenteredBlurry : Helpers.Shared.SizeUnit -> Color -> Helpers.Shared.Modifier Box
```


- [marginAuto](#marginauto)

### **marginAuto**
```elm
marginAuto : Helpers.Shared.Modifier Box
```


- [fontFamilySansSerif](#fontfamilysansserif)

### **fontFamilySansSerif**
```elm
fontFamilySansSerif : Helpers.Shared.Modifier Box
```


- [systemFont](#systemfont)

### **systemFont**
```elm
systemFont : String -> Helpers.Shared.Modifier Box
```


- [textColor](#textcolor)

### **textColor**
```elm
textColor : Color -> Helpers.Shared.Modifier Box
```




# Values

- [default](#default)

### **default**
```elm
default : Box
```

Generates a default empty Box.
- [visible](#visible)

### **visible**
```elm
visible : Box.Visibility
```


- [hidden](#hidden)

### **hidden**
```elm
hidden : Box.Visibility
```




# Compilation

- [boxToCouples](#boxtocouples)

### **boxToCouples**
```elm
boxToCouples : Box -> List ( String, String )
```

Compiles a `Box` to the corresponding CSS list of tuples.
Compiles only the defined styles, ignoring the `Nothing` fields.

