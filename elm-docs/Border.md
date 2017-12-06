# Border

Border contains everything about borders rendering.


# Types

- [Border](#border)

### **type alias Border**
```elm
type alias Border  =  
    { color : Maybe Color , thickness : Maybe Helpers.Shared.SizeUnit , style : Maybe Border.BorderStyle }
```

The `Border` record contains everything about one border side.
You probably won't use it as is, but instead using `Elegant.border`
which automatically generate an empty `Border` record. You
can then use modifiers. I.E.

```elm
Elegant.border
```

        [ Border.solid
        , Border.color Color.blue
        ]
- [BorderStyle](#borderstyle)

### **type BorderStyle**
```elm
type BorderStyle   
    = 
```

Represents the possible styles of the border.
It can be Solid or Dashed. They are created by `solid` and `dashed`.


# Default border

- [default](#default)

### **default**
```elm
default : Border

```

Generate an empty `Border` record, with every field equal to Nothing.
You are free to use it as you wish, but it is instanciated automatically by `Elegant.border`.


# Border modifiers


## Appearance

- [thickness](#thickness)

### **thickness**
```elm
thickness : Maybe SizeUnit
    , style : Maybe BorderStyle
    }



default : Border
default =
    Border Nothing Nothing Nothing



type BorderStyle
    = Solid
    | Dashed
    | None



none : Modifier Border
none =
    setStyle <| Just None



solid : Modifier Border
solid =
    setStyle <| Just Solid



dashed : Modifier Border
dashed =
    setStyle <| Just Dashed




```

Set the thickness of the border.
- [none](#none)

### **none**
```elm
none : Modifier Border

```

Set the border to none.
- [solid](#solid)

### **solid**
```elm
solid : Modifier Border

```

Set the border as solid.
- [dashed](#dashed)

### **dashed**
```elm
dashed : Modifier Border

```

Set the border as dashed.


## Sides

- [top](#top)

### **top**
```elm
top : Modifiers Border -> Modifier (Surrounded Border)

```

Accepts a list of border modifiers, and modify the top side of the border.
- [bottom](#bottom)

### **bottom**
```elm
bottom : Modifiers Border -> Modifier (Surrounded Border)

```

Accepts a list of border modifiers, and modify the bottom side of the border.
- [left](#left)

### **left**
```elm
left : Modifiers Border -> Modifier (Surrounded Border)

```

Accepts a list of border modifiers, and modify the left side of the border.
- [right](#right)

### **right**
```elm
right : Modifiers Border -> Modifier (Surrounded Border)

```

Accepts a list of border modifiers, and modify the right side of the border.
- [horizontal](#horizontal)

### **horizontal**
```elm
horizontal : Modifiers Border -> Modifier (Surrounded Border)

```

Accepts a list of border modifiers, and modify both the top and the bottom side of the border.
- [vertical](#vertical)

### **vertical**
```elm
vertical : Modifiers Border -> Modifier (Surrounded Border)

```

Accepts a list of border modifiers, and modify both the right and left side of the border.
- [all](#all)

### **all**
```elm
all : Modifiers Border -> Modifier (Surrounded Border)

```

Accepts a list of border modifiers, and modify the four sides of the border.


# Compilation

- [borderToCouples](#bordertocouples)

### **borderToCouples**
```elm
borderToCouples : Surrounded Border -> List ( String, String )

```

Compiles a `Surrounded Border` record to the corresponding CSS list of tuples.
Compiles only styles which are defined, ignoring `Nothing` fields.


# Sugar

- [full](#full)

### **full**
```elm
full : Color -> Modifier (Surrounded Border)

```

Accepts a color modifier

