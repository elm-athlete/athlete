# Margin

Margin contains everything about margins rendering.


# Types

- [Margin](#margin)

### **type alias Margin**
```elm
type alias Margin  =  
    Either Helpers.Shared.SizeUnit Helpers.Shared.Auto
```

The `Margin` record contains everything about one margin side.
You probably won't use it as is, but instead using `Elegant.margin`
which automatically generate an empty `Margin` record. You
can then use modifiers. I.E.

```elm
Elegant.margin
    [ Margin.top <| Margin.width (px 30)
    , Margin.vertical Margin.auto
    ]
```


# Default margin

- [default](#default)

### **default**
```elm
default : Margin
```

Generate an empty `Margin` record, equal to auto.
You are free to use it as you wish, but it is instanciated automatically by `Elegant.margin`.


# Margin setters

- [auto](#auto)

### **auto**
```elm
auto : Helpers.Shared.Modifier Margin
```

Set the margin value to auto.
- [width](#width)

### **width**
```elm
width : Helpers.Shared.SizeUnit -> Helpers.Shared.Modifier Margin
```

Set the margin value to the desired value.


# Margin selectors

- [top](#top)

### **top**
```elm
top : Helpers.Shared.Modifier Margin -> Helpers.Shared.Modifier (Surrounded Margin)
```

Accepts a margin modifier, and modify the top side of the margin.
- [right](#right)

### **right**
```elm
right : Helpers.Shared.Modifier Margin -> Helpers.Shared.Modifier (Surrounded Margin)
```

Accepts a margin modifier, and modify the right side of the margin.
- [bottom](#bottom)

### **bottom**
```elm
bottom : Helpers.Shared.Modifier Margin -> Helpers.Shared.Modifier (Surrounded Margin)
```

Accepts a margin modifier, and modify the bottom side of the margin.
- [left](#left)

### **left**
```elm
left : Helpers.Shared.Modifier Margin -> Helpers.Shared.Modifier (Surrounded Margin)
```

Accepts a margin modifier, and modify the left side of the margin.
- [horizontal](#horizontal)

### **horizontal**
```elm
horizontal : Helpers.Shared.Modifier Margin -> Helpers.Shared.Modifier (Surrounded Margin)
```

Accepts a margin modifier, and modify both the top and the bottom side of the margin.
- [vertical](#vertical)

### **vertical**
```elm
vertical : Helpers.Shared.Modifier Margin -> Helpers.Shared.Modifier (Surrounded Margin)
```

Accepts a margin modifier, and modify both the right and left side of the margin.
- [all](#all)

### **all**
```elm
all : Helpers.Shared.Modifier Margin -> Helpers.Shared.Modifier (Surrounded Margin)
```

Accepts a margin modifier, and modify the four sides of the margin.


# Compilation

- [marginToCouples](#margintocouples)

### **marginToCouples**
```elm
marginToCouples : Surrounded Margin -> List ( String, String )
```

Compiles a `Surrounded Margin` record to the corresponding CSS list of tuples.
Compiles only styles which are defined, ignoring `Nothing` fields.

