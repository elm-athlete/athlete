# Box

Handles all modifications for the box. You don't need to instanciate one,
as it's automatically done by Elegant and the different display elements.
It contains only modifiers, and they can be found in the respective modules.


# Types

- [Box](#box)

### **type alias Box**
```elm
type alias Box  =
    Box
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing



position : Position -> Modifier Box
position =
    setMaybeValue setPosition



background : Modifiers Background -> Modifier Box
background =
    getModifyAndSet .background setBackgroundIn Background.default



border : Modifiers (Surrounded Border) -> Modifier Box
border =
    getModifyAndSet .border setBorderIn Surrounded.default



transform : Modifiers Transform -> Modifier Box
transform =
    getModifyAndSet .transform setTransformIn Transform.default



boxShadow : Modifiers Shadow -> Modifier Box
boxShadow =
    getModifyAndSet .boxShadow setShadowIn Shadow.default



shadow : Modifiers Shadow -> Modifier Box
shadow =
    boxShadow



corner : Modifiers Corner -> Modifier Box
corner =
    getModifyAndSet .corner setCornerIn Corner.default



cursor : Cursor -> Modifier Box
cursor =
    setMaybeValue setCursor



margin : Modifiers (Surrounded Margin) -> Modifier Box
margin =
    getModifyAndSet .margin setMarginIn Surrounded.default



opacity : Float -> Modifier Box
opacity =
    setMaybeValue setOpacity



outline : Modifiers Outline -> Modifier Box
outline =
    getModifyAndSet .outline setOutlineIn Outline.default



padding : Modifiers (Surrounded Padding) -> Modifier Box
padding =
    getModifyAndSet .padding setPaddingIn Surrounded.default



typography : Modifiers Typography -> Modifier Box
typography =
    getModifyAndSet .typography setTypographyIn Typography.default



visibility : Visibility -> Modifier Box
visibility =
    setMaybeValue setVisibility



zIndex : Int -> Modifier Box
zIndex =
    setMaybeValue setZIndex



appearanceNone : Modifier Box
appearanceNone box =
    { box | appearance 
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
appearanceNone : Modifier Box

```

Accepts an Int for the `zIndex` and modifies the Box accordingly.
- [background](#background)

### **background**
```elm
background : Maybe Background
    , border : Maybe (Surrounded Border)
    , boxShadow : Maybe Shadow
    , corner : Maybe Corner
    , cursor : Maybe Cursor
    , margin : Maybe (Surrounded Margin)
    , opacity : Maybe Float
    , outline : Maybe Outline
    , padding : Maybe (Surrounded Padding)
    , position : Maybe Position
    , typography : Maybe Typography
    , visibility : Maybe Visibility
    , transform : Maybe Transform
    , zIndex : Maybe Int
    }



default : Box
default =
    Box
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing



position : Position -> Modifier Box
position =
    setMaybeValue setPosition




```

Accepts a list of modifiers for the `Background` and modifies the Box accordingly.
- [border](#border)

### **border**
```elm
border : Maybe (Surrounded Border)
    , boxShadow : Maybe Shadow
    , corner : Maybe Corner
    , cursor : Maybe Cursor
    , margin : Maybe (Surrounded Margin)
    , opacity : Maybe Float
    , outline : Maybe Outline
    , padding : Maybe (Surrounded Padding)
    , position : Maybe Position
    , typography : Maybe Typography
    , visibility : Maybe Visibility
    , transform : Maybe Transform
    , zIndex : Maybe Int
    }



default : Box
default =
    Box
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing



position : Position -> Modifier Box
position =
    setMaybeValue setPosition



background : Modifiers Background -> Modifier Box
background =
    getModifyAndSet .background setBackgroundIn Background.default




```

Accepts a list of modifiers for the `Border` and modifies the Box accordingly.
- [boxShadow](#boxshadow)

### **boxShadow**
```elm
boxShadow : Maybe Shadow
    , corner : Maybe Corner
    , cursor : Maybe Cursor
    , margin : Maybe (Surrounded Margin)
    , opacity : Maybe Float
    , outline : Maybe Outline
    , padding : Maybe (Surrounded Padding)
    , position : Maybe Position
    , typography : Maybe Typography
    , visibility : Maybe Visibility
    , transform : Maybe Transform
    , zIndex : Maybe Int
    }



default : Box
default =
    Box
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing



position : Position -> Modifier Box
position =
    setMaybeValue setPosition



background : Modifiers Background -> Modifier Box
background =
    getModifyAndSet .background setBackgroundIn Background.default



border : Modifiers (Surrounded Border) -> Modifier Box
border =
    getModifyAndSet .border setBorderIn Surrounded.default



transform : Modifiers Transform -> Modifier Box
transform =
    getModifyAndSet .transform setTransformIn Transform.default




```

Accepts a list of modifiers for the `Shadow` and modifies the Box accordingly.
- [shadow](#shadow)

### **shadow**
```elm
shadow : Modifiers Shadow -> Modifier Box

```

Alias of boxShadow
- [corner](#corner)

### **corner**
```elm
corner : Maybe Corner
    , cursor : Maybe Cursor
    , margin : Maybe (Surrounded Margin)
    , opacity : Maybe Float
    , outline : Maybe Outline
    , padding : Maybe (Surrounded Padding)
    , position : Maybe Position
    , typography : Maybe Typography
    , visibility : Maybe Visibility
    , transform : Maybe Transform
    , zIndex : Maybe Int
    }



default : Box
default =
    Box
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing



position : Position -> Modifier Box
position =
    setMaybeValue setPosition



background : Modifiers Background -> Modifier Box
background =
    getModifyAndSet .background setBackgroundIn Background.default



border : Modifiers (Surrounded Border) -> Modifier Box
border =
    getModifyAndSet .border setBorderIn Surrounded.default



transform : Modifiers Transform -> Modifier Box
transform =
    getModifyAndSet .transform setTransformIn Transform.default



boxShadow : Modifiers Shadow -> Modifier Box
boxShadow =
    getModifyAndSet .boxShadow setShadowIn Shadow.default



shadow : Modifiers Shadow -> Modifier Box
shadow =
    boxShadow




```

Accepts a list of modifiers for the `Corner` and modifies the Box accordingly.
- [cursor](#cursor)

### **cursor**
```elm
cursor : Maybe Cursor
    , margin : Maybe (Surrounded Margin)
    , opacity : Maybe Float
    , outline : Maybe Outline
    , padding : Maybe (Surrounded Padding)
    , position : Maybe Position
    , typography : Maybe Typography
    , visibility : Maybe Visibility
    , transform : Maybe Transform
    , zIndex : Maybe Int
    }



default : Box
default =
    Box
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing



position : Position -> Modifier Box
position =
    setMaybeValue setPosition



background : Modifiers Background -> Modifier Box
background =
    getModifyAndSet .background setBackgroundIn Background.default



border : Modifiers (Surrounded Border) -> Modifier Box
border =
    getModifyAndSet .border setBorderIn Surrounded.default



transform : Modifiers Transform -> Modifier Box
transform =
    getModifyAndSet .transform setTransformIn Transform.default



boxShadow : Modifiers Shadow -> Modifier Box
boxShadow =
    getModifyAndSet .boxShadow setShadowIn Shadow.default



shadow : Modifiers Shadow -> Modifier Box
shadow =
    boxShadow



corner : Modifiers Corner -> Modifier Box
corner =
    getModifyAndSet .corner setCornerIn Corner.default




```

Accepts a `Cursor` and modifies the Box accordingly.
- [margin](#margin)

### **margin**
```elm
margin : Maybe (Surrounded Margin)
    , opacity : Maybe Float
    , outline : Maybe Outline
    , padding : Maybe (Surrounded Padding)
    , position : Maybe Position
    , typography : Maybe Typography
    , visibility : Maybe Visibility
    , transform : Maybe Transform
    , zIndex : Maybe Int
    }



default : Box
default =
    Box
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing



position : Position -> Modifier Box
position =
    setMaybeValue setPosition



background : Modifiers Background -> Modifier Box
background =
    getModifyAndSet .background setBackgroundIn Background.default



border : Modifiers (Surrounded Border) -> Modifier Box
border =
    getModifyAndSet .border setBorderIn Surrounded.default



transform : Modifiers Transform -> Modifier Box
transform =
    getModifyAndSet .transform setTransformIn Transform.default



boxShadow : Modifiers Shadow -> Modifier Box
boxShadow =
    getModifyAndSet .boxShadow setShadowIn Shadow.default



shadow : Modifiers Shadow -> Modifier Box
shadow =
    boxShadow



corner : Modifiers Corner -> Modifier Box
corner =
    getModifyAndSet .corner setCornerIn Corner.default



cursor : Cursor -> Modifier Box
cursor =
    setMaybeValue setCursor




```

Accepts a list of modifiers for the `Margin` and modifies the Box accordingly.
- [opacity](#opacity)

### **opacity**
```elm
opacity : Maybe Float
    , outline : Maybe Outline
    , padding : Maybe (Surrounded Padding)
    , position : Maybe Position
    , typography : Maybe Typography
    , visibility : Maybe Visibility
    , transform : Maybe Transform
    , zIndex : Maybe Int
    }



default : Box
default =
    Box
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing



position : Position -> Modifier Box
position =
    setMaybeValue setPosition



background : Modifiers Background -> Modifier Box
background =
    getModifyAndSet .background setBackgroundIn Background.default



border : Modifiers (Surrounded Border) -> Modifier Box
border =
    getModifyAndSet .border setBorderIn Surrounded.default



transform : Modifiers Transform -> Modifier Box
transform =
    getModifyAndSet .transform setTransformIn Transform.default



boxShadow : Modifiers Shadow -> Modifier Box
boxShadow =
    getModifyAndSet .boxShadow setShadowIn Shadow.default



shadow : Modifiers Shadow -> Modifier Box
shadow =
    boxShadow



corner : Modifiers Corner -> Modifier Box
corner =
    getModifyAndSet .corner setCornerIn Corner.default



cursor : Cursor -> Modifier Box
cursor =
    setMaybeValue setCursor



margin : Modifiers (Surrounded Margin) -> Modifier Box
margin =
    getModifyAndSet .margin setMarginIn Surrounded.default




```

Accepts a size for the `opacity` and modifies the Box accordingly.
- [outline](#outline)

### **outline**
```elm
outline : Maybe Outline
    , padding : Maybe (Surrounded Padding)
    , position : Maybe Position
    , typography : Maybe Typography
    , visibility : Maybe Visibility
    , transform : Maybe Transform
    , zIndex : Maybe Int
    }



default : Box
default =
    Box
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing



position : Position -> Modifier Box
position =
    setMaybeValue setPosition



background : Modifiers Background -> Modifier Box
background =
    getModifyAndSet .background setBackgroundIn Background.default



border : Modifiers (Surrounded Border) -> Modifier Box
border =
    getModifyAndSet .border setBorderIn Surrounded.default



transform : Modifiers Transform -> Modifier Box
transform =
    getModifyAndSet .transform setTransformIn Transform.default



boxShadow : Modifiers Shadow -> Modifier Box
boxShadow =
    getModifyAndSet .boxShadow setShadowIn Shadow.default



shadow : Modifiers Shadow -> Modifier Box
shadow =
    boxShadow



corner : Modifiers Corner -> Modifier Box
corner =
    getModifyAndSet .corner setCornerIn Corner.default



cursor : Cursor -> Modifier Box
cursor =
    setMaybeValue setCursor



margin : Modifiers (Surrounded Margin) -> Modifier Box
margin =
    getModifyAndSet .margin setMarginIn Surrounded.default



opacity : Float -> Modifier Box
opacity =
    setMaybeValue setOpacity




```

Accepts a list of modifiers for the `Outline` and modifies the Box accordingly.
- [padding](#padding)

### **padding**
```elm
padding : Maybe (Surrounded Padding)
    , position : Maybe Position
    , typography : Maybe Typography
    , visibility : Maybe Visibility
    , transform : Maybe Transform
    , zIndex : Maybe Int
    }



default : Box
default =
    Box
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing



position : Position -> Modifier Box
position =
    setMaybeValue setPosition



background : Modifiers Background -> Modifier Box
background =
    getModifyAndSet .background setBackgroundIn Background.default



border : Modifiers (Surrounded Border) -> Modifier Box
border =
    getModifyAndSet .border setBorderIn Surrounded.default



transform : Modifiers Transform -> Modifier Box
transform =
    getModifyAndSet .transform setTransformIn Transform.default



boxShadow : Modifiers Shadow -> Modifier Box
boxShadow =
    getModifyAndSet .boxShadow setShadowIn Shadow.default



shadow : Modifiers Shadow -> Modifier Box
shadow =
    boxShadow



corner : Modifiers Corner -> Modifier Box
corner =
    getModifyAndSet .corner setCornerIn Corner.default



cursor : Cursor -> Modifier Box
cursor =
    setMaybeValue setCursor



margin : Modifiers (Surrounded Margin) -> Modifier Box
margin =
    getModifyAndSet .margin setMarginIn Surrounded.default



opacity : Float -> Modifier Box
opacity =
    setMaybeValue setOpacity



outline : Modifiers Outline -> Modifier Box
outline =
    getModifyAndSet .outline setOutlineIn Outline.default




```

Accepts a list of modifiers for the `Padding` and modifies the Box accordingly.
- [position](#position)

### **position**
```elm
position : Maybe Position
    , typography : Maybe Typography
    , visibility : Maybe Visibility
    , transform : Maybe Transform
    , zIndex : Maybe Int
    }



default : Box
default =
    Box
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing




```

Accepts a `Position` and modifies the Box accordingly.
- [typography](#typography)

### **typography**
```elm
typography : Maybe Typography
    , visibility : Maybe Visibility
    , transform : Maybe Transform
    , zIndex : Maybe Int
    }



default : Box
default =
    Box
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing



position : Position -> Modifier Box
position =
    setMaybeValue setPosition



background : Modifiers Background -> Modifier Box
background =
    getModifyAndSet .background setBackgroundIn Background.default



border : Modifiers (Surrounded Border) -> Modifier Box
border =
    getModifyAndSet .border setBorderIn Surrounded.default



transform : Modifiers Transform -> Modifier Box
transform =
    getModifyAndSet .transform setTransformIn Transform.default



boxShadow : Modifiers Shadow -> Modifier Box
boxShadow =
    getModifyAndSet .boxShadow setShadowIn Shadow.default



shadow : Modifiers Shadow -> Modifier Box
shadow =
    boxShadow



corner : Modifiers Corner -> Modifier Box
corner =
    getModifyAndSet .corner setCornerIn Corner.default



cursor : Cursor -> Modifier Box
cursor =
    setMaybeValue setCursor



margin : Modifiers (Surrounded Margin) -> Modifier Box
margin =
    getModifyAndSet .margin setMarginIn Surrounded.default



opacity : Float -> Modifier Box
opacity =
    setMaybeValue setOpacity



outline : Modifiers Outline -> Modifier Box
outline =
    getModifyAndSet .outline setOutlineIn Outline.default



padding : Modifiers (Surrounded Padding) -> Modifier Box
padding =
    getModifyAndSet .padding setPaddingIn Surrounded.default




```

Accepts a list of modifiers for the `Typography` and modifies the Box accordingly.
- [visibility](#visibility-1)

### **visibility**
```elm
visibility : Maybe Visibility
    , transform : Maybe Transform
    , zIndex : Maybe Int
    }



default : Box
default =
    Box
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing



position : Position -> Modifier Box
position =
    setMaybeValue setPosition



background : Modifiers Background -> Modifier Box
background =
    getModifyAndSet .background setBackgroundIn Background.default



border : Modifiers (Surrounded Border) -> Modifier Box
border =
    getModifyAndSet .border setBorderIn Surrounded.default



transform : Modifiers Transform -> Modifier Box
transform =
    getModifyAndSet .transform setTransformIn Transform.default



boxShadow : Modifiers Shadow -> Modifier Box
boxShadow =
    getModifyAndSet .boxShadow setShadowIn Shadow.default



shadow : Modifiers Shadow -> Modifier Box
shadow =
    boxShadow



corner : Modifiers Corner -> Modifier Box
corner =
    getModifyAndSet .corner setCornerIn Corner.default



cursor : Cursor -> Modifier Box
cursor =
    setMaybeValue setCursor



margin : Modifiers (Surrounded Margin) -> Modifier Box
margin =
    getModifyAndSet .margin setMarginIn Surrounded.default



opacity : Float -> Modifier Box
opacity =
    setMaybeValue setOpacity



outline : Modifiers Outline -> Modifier Box
outline =
    getModifyAndSet .outline setOutlineIn Outline.default



padding : Modifiers (Surrounded Padding) -> Modifier Box
padding =
    getModifyAndSet .padding setPaddingIn Surrounded.default



typography : Modifiers Typography -> Modifier Box
typography =
    getModifyAndSet .typography setTypographyIn Typography.default




```

Accepts a `Visibility` and modifies the Box accordingly.
- [transform](#transform)

### **transform**
```elm
transform : Maybe Transform
    , zIndex : Maybe Int
    }



default : Box
default =
    Box
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing



position : Position -> Modifier Box
position =
    setMaybeValue setPosition



background : Modifiers Background -> Modifier Box
background =
    getModifyAndSet .background setBackgroundIn Background.default



border : Modifiers (Surrounded Border) -> Modifier Box
border =
    getModifyAndSet .border setBorderIn Surrounded.default




```

Accepts a list of modifiers for the `transform` and modifies the Box accordingly.
- [zIndex](#zindex)

### **zIndex**
```elm
zIndex : Maybe Int
    }



default : Box
default =
    Box
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing



position : Position -> Modifier Box
position =
    setMaybeValue setPosition



background : Modifiers Background -> Modifier Box
background =
    getModifyAndSet .background setBackgroundIn Background.default



border : Modifiers (Surrounded Border) -> Modifier Box
border =
    getModifyAndSet .border setBorderIn Surrounded.default



transform : Modifiers Transform -> Modifier Box
transform =
    getModifyAndSet .transform setTransformIn Transform.default



boxShadow : Modifiers Shadow -> Modifier Box
boxShadow =
    getModifyAndSet .boxShadow setShadowIn Shadow.default



shadow : Modifiers Shadow -> Modifier Box
shadow =
    boxShadow



corner : Modifiers Corner -> Modifier Box
corner =
    getModifyAndSet .corner setCornerIn Corner.default



cursor : Cursor -> Modifier Box
cursor =
    setMaybeValue setCursor



margin : Modifiers (Surrounded Margin) -> Modifier Box
margin =
    getModifyAndSet .margin setMarginIn Surrounded.default



opacity : Float -> Modifier Box
opacity =
    setMaybeValue setOpacity



outline : Modifiers Outline -> Modifier Box
outline =
    getModifyAndSet .outline setOutlineIn Outline.default



padding : Modifiers (Surrounded Padding) -> Modifier Box
padding =
    getModifyAndSet .padding setPaddingIn Surrounded.default



typography : Modifiers Typography -> Modifier Box
typography =
    getModifyAndSet .typography setTypographyIn Typography.default



visibility : Visibility -> Modifier Box
visibility =
    setMaybeValue setVisibility




```

Accepts an Int for the `zIndex` and modifies the Box accordingly.


# Shortcuts

- [outlineNone](#outlinenone)

### **outlineNone**
```elm
outlineNone : Modifier Box

```


- [backgroundColor](#backgroundcolor)

### **backgroundColor**
```elm
backgroundColor : Color -> Modifier Box

```


- [cornerRound](#cornerround)

### **cornerRound**
```elm
cornerRound : Modifier Box

```


- [cornerRadius](#cornerradius)

### **cornerRadius**
```elm
cornerRadius : Int -> Modifier Box

```


- [borderNone](#bordernone)

### **borderNone**
```elm
borderNone : Modifier Box

```


- [borderColor](#bordercolor)

### **borderColor**
```elm
borderColor : Color -> Modifier Box

```


- [borderWidth](#borderwidth)

### **borderWidth**
```elm
borderWidth : Int -> Modifier Box

```


- [borderSolid](#bordersolid)

### **borderSolid**
```elm
borderSolid : Modifier Box

```


- [paddingAll](#paddingall)

### **paddingAll**
```elm
paddingAll : SizeUnit -> Modifier Box

```


- [paddingHorizontal](#paddinghorizontal)

### **paddingHorizontal**
```elm
paddingHorizontal : SizeUnit -> Modifier Box

```


- [paddingVertical](#paddingvertical)

### **paddingVertical**
```elm
paddingVertical : SizeUnit -> Modifier Box

```


- [paddingTop](#paddingtop)

### **paddingTop**
```elm
paddingTop : SizeUnit -> Modifier Box

```


- [paddingRight](#paddingright)

### **paddingRight**
```elm
paddingRight : SizeUnit -> Modifier Box

```


- [paddingBottom](#paddingbottom)

### **paddingBottom**
```elm
paddingBottom : SizeUnit -> Modifier Box

```


- [paddingLeft](#paddingleft)

### **paddingLeft**
```elm
paddingLeft : SizeUnit -> Modifier Box

```


- [shadowCenteredBlurry](#shadowcenteredblurry)

### **shadowCenteredBlurry**
```elm
shadowCenteredBlurry : SizeUnit -> Color -> Modifier Box

```


- [marginAuto](#marginauto)

### **marginAuto**
```elm
marginAuto : Modifier Box

```


- [fontFamilySansSerif](#fontfamilysansserif)

### **fontFamilySansSerif**
```elm
fontFamilySansSerif : Modifier Box

```


- [systemFont](#systemfont)

### **systemFont**
```elm
systemFont : String -> Modifier Box

```


- [textColor](#textcolor)

### **textColor**
```elm
textColor : Color -> Modifier Box

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
visible : Visibility

```


- [hidden](#hidden)

### **hidden**
```elm
hidden : Visibility

```




# Compilation

- [boxToCouples](#boxtocouples)

### **boxToCouples**
```elm
boxToCouples : Box -> List ( String, String )

```

Compiles a `Box` to the corresponding CSS list of tuples.
Compiles only the defined styles, ignoring the `Nothing` fields.

