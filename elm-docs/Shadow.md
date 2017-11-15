# Shadow

Shadow contains everything about boxShadow.


# Types

- [Shadow](#shadow)

### **type alias Shadow**
```elm
type alias Shadow  =  
    { inset : Bool , spreadRadius : Helpers.Shared.SizeUnit , blurRadius : Helpers.Shared.SizeUnit , color : Color , offset : ( Helpers.Shared.SizeUnit, Helpers.Shared.SizeUnit ) }
```

The Shadow record contains everything about box shadow.
You probably won't use it as is, but instead using `Elegant.boxShadow`
which automatically generate an empty `Shadow` record. You
can then use modifiers. I.E.

```elm
Elegant.boxShadow
    [ Shadow.inset True
    , Shadow.spreadRadius (px 30)
    ]
```


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
inset : Bool -> Helpers.Shared.Modifier Shadow
```

Set the inset of the Shadow.
- [blurRadius](#blurradius)

### **blurRadius**
```elm
blurRadius : Helpers.Shared.SizeUnit -> Helpers.Shared.Modifier Shadow
```

Set the blurRadius of the Shadow.
- [spreadRadius](#spreadradius)

### **spreadRadius**
```elm
spreadRadius : Helpers.Shared.SizeUnit -> Helpers.Shared.Modifier Shadow
```

Set the spreadRadius of the Shadow.
- [offset](#offset)

### **offset**
```elm
offset : ( Helpers.Shared.SizeUnit, Helpers.Shared.SizeUnit ) -> Helpers.Shared.Modifier Shadow
```

Set the offset of the Shadow.
- [standard](#standard)

### **standard**
```elm
standard : Helpers.Shared.SizeUnit -> Color -> ( Helpers.Shared.SizeUnit, Helpers.Shared.SizeUnit ) -> Helpers.Shared.Modifier Shadow
```

Defines a standard boxShadow.
- [plain](#plain)

### **plain**
```elm
plain : ( Helpers.Shared.SizeUnit, Helpers.Shared.SizeUnit ) -> Color -> Helpers.Shared.Modifier Shadow
```

Creates a plain boxShadow.
- [blurry](#blurry)

### **blurry**
```elm
blurry : Helpers.Shared.SizeUnit -> Helpers.Shared.SizeUnit -> Color -> Helpers.Shared.Modifier Shadow
```

Creates a plain boxShadow.


# Compilation

- [boxShadowToCouple](#boxshadowtocouple)

### **boxShadowToCouple**
```elm
boxShadowToCouple : Shadow -> ( String, String )
```

Compiles a `Shadow` record to the corresponding CSS tuple.
Compiles only parts which are defined, ignoring `Nothing` fields.

