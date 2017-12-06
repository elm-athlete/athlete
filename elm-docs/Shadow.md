# Shadow

Shadow contains everything about boxShadow.


# Types

- [Shadow](#shadow)

### **type alias Shadow**
```elm
type alias Shadow  =
    Shadow False (Px 0) (Px 0) Color.black ( Px 0, Px 0 )



inset : Bool -> Modifier Shadow
inset =
    setInset



color : Color -> Modifier Shadow
color =
    setColor



spreadRadius : SizeUnit -> Modifier Shadow
spreadRadius =
    setSpreadRadius



blurRadius : SizeUnit -> Modifier Shadow
blurRadius =
    setBlurRadius



offset : ( SizeUnit, SizeUnit ) -> Modifier Shadow
offset =
    setOffset



standard : SizeUnit -> Color -> ( SizeUnit, SizeUnit ) -> Modifier Shadow
standard size color offset =
    blurRadius size
        >> setColor color
        >> setOffset offset



plain : ( SizeUnit, SizeUnit ) -> Color -> Modifier Shadow
plain offset color =
    setOffset offset
        >> setColor color



blurry : SizeUnit -> SizeUnit -> Color -> Modifier Shadow
blurry spread blur color =
    spreadRadius spread << blurRadius blur << plain ( Px 0, Px 0 ) color



boxShadowToCouple : Shadow -> ( String, String )
boxShadowToCouple boxShadow =
    ( "box-shadow", boxShadowToString boxShadow )



-- Internals


offsetToStringList : ( SizeUnit, SizeUnit ) -> List String
offsetToStringList ( x, y ) =
    [ x, y ]
        |> List.map sizeUnitToString


blurAndSpreadRadiusToStringList : SizeUnit -> SizeUnit -> List String
blurAndSpreadRadiusToStringList blurRadius spreadRadius =
    [ blurRadius
    , spreadRadius
    ]
        |> List.map sizeUnitToString


colorToStringList : Color -> List String
colorToStringList =
    Color.Convert.colorToCssRgba >> List.singleton


insetToStringList : Bool -> List String
insetToStringList inset =
    if inset then
        [ "inset" ]
    else
        []


boxShadowToString : Shadow -> String
boxShadowToString { inset, offset, spreadRadius, color, blurRadius }
```

The Shadow record contains everything about box shadow.
You probably won't use it as is, but instead using `Elegant.boxShadow`
which automatically generate an empty `Shadow` record. You
can then use modifiers. I.E.

```elm
Elegant.boxShadow
```

        [ Shadow.inset True
        , Shadow.spreadRadius (px 30)
        ]


# Default box shadow

- [default](#default)

### **default**
```elm
default : Shadow

```

Generate an empty `Shadow` record, with every field equal to Nothing except inset (to `False`) and offset (to `( 0, 0 )`).
You are free to use it as you wish, but it is instanciated automatically by `Elegant.boxShadow`.


# Shadow modifiers

- [inset](#inset)

### **inset**
```elm
inset : Bool
    , spreadRadius : SizeUnit
    , blurRadius : SizeUnit
    , color : Color
    , offset : ( SizeUnit, SizeUnit )
    }



default : Shadow
default =
    Shadow False (Px 0) (Px 0) Color.black ( Px 0, Px 0 )




```

Set the inset of the Shadow.
- [blurRadius](#blurradius)

### **blurRadius**
```elm
blurRadius : SizeUnit
    , color : Color
    , offset : ( SizeUnit, SizeUnit )
    }



default : Shadow
default =
    Shadow False (Px 0) (Px 0) Color.black ( Px 0, Px 0 )



inset : Bool -> Modifier Shadow
inset =
    setInset



color : Color -> Modifier Shadow
color =
    setColor



spreadRadius : SizeUnit -> Modifier Shadow
spreadRadius =
    setSpreadRadius




```

Set the blurRadius of the Shadow.
- [spreadRadius](#spreadradius)

### **spreadRadius**
```elm
spreadRadius : SizeUnit
    , blurRadius : SizeUnit
    , color : Color
    , offset : ( SizeUnit, SizeUnit )
    }



default : Shadow
default =
    Shadow False (Px 0) (Px 0) Color.black ( Px 0, Px 0 )



inset : Bool -> Modifier Shadow
inset =
    setInset



color : Color -> Modifier Shadow
color =
    setColor




```

Set the spreadRadius of the Shadow.
- [offset](#offset)

### **offset**
```elm
offset : ( SizeUnit, SizeUnit )
    }



default : Shadow
default =
    Shadow False (Px 0) (Px 0) Color.black ( Px 0, Px 0 )



inset : Bool -> Modifier Shadow
inset =
    setInset



color : Color -> Modifier Shadow
color =
    setColor



spreadRadius : SizeUnit -> Modifier Shadow
spreadRadius =
    setSpreadRadius



blurRadius : SizeUnit -> Modifier Shadow
blurRadius =
    setBlurRadius




```

Set the offset of the Shadow.
- [standard](#standard)

### **standard**
```elm
standard : SizeUnit -> Color -> ( SizeUnit, SizeUnit ) -> Modifier Shadow

```

Defines a standard boxShadow.
- [plain](#plain)

### **plain**
```elm
plain : ( SizeUnit, SizeUnit ) -> Color -> Modifier Shadow

```

Creates a plain boxShadow.
- [blurry](#blurry)

### **blurry**
```elm
blurry : SizeUnit -> SizeUnit -> Color -> Modifier Shadow

```

Creates a plain boxShadow.
- [color](#color)

### **color**
```elm
color : Color
    , offset : ( SizeUnit, SizeUnit )
    }



default : Shadow
default =
    Shadow False (Px 0) (Px 0) Color.black ( Px 0, Px 0 )



inset : Bool -> Modifier Shadow
inset =
    setInset




```

Set the inset of the Shadow.

# Compilation

- [boxShadowToCouple](#boxshadowtocouple)

### **boxShadowToCouple**
```elm
boxShadowToCouple : Shadow -> ( String, String )

```

Compiles a `Shadow` record to the corresponding CSS tuple.
Compiles only parts which are defined, ignoring `Nothing` fields.

