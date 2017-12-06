# Transform

Transform contains everything about css transformations : translate, rotate and scale.


# Types

- [Transform](#transform)

### **type alias Transform**
```elm
type alias Transform  =  
    { translate : Transform.Triplet (Maybe Helpers.Shared.SizeUnit) }
```

The Transform record contains everything about transformations.
You probably won't use it as is, but instead using `Box.transform`
which automatically generate an empty `Transform` record. You
can then use modifiers. I.E.

```elm
Box.transform
```

        [ Transform.translateX (px 30)
        , Transform.translateY (vw 30)
        ]

# Default transform

- [default](#default)

### **default**
```elm
default : Transform

```

Generate an empty `Translate` record, with every field equal to Nothing.
You are free to use it as you wish, but it is instanciated automatically by `Box.translate`.


# Shadow modifiers

- [translateX](#translatex)

### **translateX**
```elm
translateX : SizeUnit -> Modifier Transform

```

Set the translateX of the Transform.
- [translateY](#translatey)

### **translateY**
```elm
translateY : SizeUnit -> Modifier Transform

```

Set the translateY of the Transform.
- [translateZ](#translatez)

### **translateZ**
```elm
translateZ : SizeUnit -> Modifier Transform

```

Set the translateZ of the Transform.

# Compilation

- [transformToCouples](#transformtocouples)

### **transformToCouples**
```elm
transformToCouples : Transform -> List ( String, String )

```

Compiles a `Translate` record to the corresponding CSS tuple.
Compiles only parts which are defined, ignoring `Nothing` fields.

