# Padding

Padding contains everything about paddings rendering.


# Types

- [Padding](#padding)

### **type alias Padding**
```elm
type alias Padding  =  
    Helpers.Shared.SizeUnit
```

The `Padding` record contains everything about one padding side.
You probably won't use it as is, but instead using `Elegant.padding`
which automatically generate an empty `Padding` record. You
can then use modifiers. I.E.

```elm
Elegant.padding
    [ Padding.top <| Padding.width (px 30)
    , Padding.vertical <| Padding.width (px 40)
    ]
```


# Default padding

- [default](#default)

### **default**
```elm
default : Padding

```

Generate an empty `Padding` record, equal to 0 px.
You are free to use it as you wish, but it is instanciated automatically by `Elegant.padding`.


# Padding selectors

- [top](#top)

### **top**
```elm
top : SizeUnit -> Modifier (Surrounded Padding)

```

Accepts a padding modifier, and modify the top side of the padding.
- [right](#right)

### **right**
```elm
right : SizeUnit -> Modifier (Surrounded Padding)

```

Accepts a padding modifier, and modify the right side of the padding.
- [bottom](#bottom)

### **bottom**
```elm
bottom : SizeUnit -> Modifier (Surrounded Padding)

```

Accepts a padding modifier, and modify the bottom side of the padding.
- [left](#left)

### **left**
```elm
left : SizeUnit -> Modifier (Surrounded Padding)

```

Accepts a padding modifier, and modify the left side of the padding.
- [horizontal](#horizontal)

### **horizontal**
```elm
horizontal : SizeUnit -> Modifier (Surrounded Padding)

```

Accepts a padding modifier, and modify both the top and the bottom side of the padding.
- [vertical](#vertical)

### **vertical**
```elm
vertical : SizeUnit -> Modifier (Surrounded Padding)

```

Accepts a padding modifier, and modify both the right and left side of the padding.
- [all](#all)

### **all**
```elm
all : SizeUnit -> Modifier (Surrounded Padding)

```

Accepts a padding modifier, and modify the four sides of the padding.


# Compilation

- [paddingToCouples](#paddingtocouples)

### **paddingToCouples**
```elm
paddingToCouples : Surrounded Padding -> List ( String, String )

```

Compiles a `Surrounded Padding` record to the corresponding CSS list of tuples.
Compiles only styles which are defined, ignoring `Nothing` fields.

