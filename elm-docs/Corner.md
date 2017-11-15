# Corner

Corner contains everything about corner radius (also called border radius in CSS).


# Types

- [Corner](#corner)

### **type alias Corner**
```elm
type alias Corner  =  
    { topLeft : Maybe ( Helpers.Shared.SizeUnit, Helpers.Shared.SizeUnit ) , topRight : Maybe ( Helpers.Shared.SizeUnit, Helpers.Shared.SizeUnit ) , bottomRight : Maybe ( Helpers.Shared.SizeUnit, Helpers.Shared.SizeUnit ) , bottomLeft : Maybe ( Helpers.Shared.SizeUnit, Helpers.Shared.SizeUnit ) }
```

The `Corner` record contains everything about corner radius (also called border radius in CSS).
You probably won't use it as is, but instead using `Elegant.corner`
which automatically generate an empty `Corner` record. You
can then use modifiers. I.E.

```elm
Elegant.corner
    [ Corner.circular Corner.all (px 30) ]
```
- [CornerSet](#cornerset)

### **type CornerSet**
```elm
type CornerSet   
    = 
```

Represents the possible selected corner(s).
It can be Top, TopRight, Right, BottomRight, Bottom, BottomLeft, Left, TopLeft or All.
They are created by `top`, `topRight`, `right`, `bottomRight`, `bottom`, `bottomLeft`,
`left`, `topLeft` or `all`.


# Default corner radius

- [default](#default)

### **default**
```elm
default : Corner
```

Generate an empty `Corner` record, with every field equal to Nothing.
You are free to use it as you wish, but it is instanciated automatically by `Elegant.corner`.


# Corner radius style

- [circular](#circular)

### **circular**
```elm
circular : Corner.CornerSet -> Helpers.Shared.SizeUnit -> Helpers.Shared.Modifier Corner
```

Set the corner(s) to be round (the two angles are the same).
- [elliptic](#elliptic)

### **elliptic**
```elm
elliptic : Corner.CornerSet -> Helpers.Shared.SizeUnit -> Helpers.Shared.SizeUnit -> Helpers.Shared.Modifier Corner
```

Set the corner(s) to be elliptic, i.e. you can specify two different values
for the corner(s).


# Corner radius selector

- [top](#top)

### **top**
```elm
top : Corner.CornerSet
```

Select the two top corners.
- [topRight](#topright)

### **topRight**
```elm
topRight : Corner.CornerSet
```

Select the top-right corner.
- [right](#right)

### **right**
```elm
right : Corner.CornerSet
```

Select the two right corners.
- [bottomRight](#bottomright)

### **bottomRight**
```elm
bottomRight : Corner.CornerSet
```

Select the bottom-right corner.
- [bottom](#bottom)

### **bottom**
```elm
bottom : Corner.CornerSet
```

Select the two bottom corners.
- [bottomLeft](#bottomleft)

### **bottomLeft**
```elm
bottomLeft : Corner.CornerSet
```

Select the bottom-left corner.
- [left](#left)

### **left**
```elm
left : Corner.CornerSet
```

Select the two left corners.
- [topLeft](#topleft)

### **topLeft**
```elm
topLeft : Corner.CornerSet
```

Select the top-left corner.
- [all](#all)

### **all**
```elm
all : Corner.CornerSet
```

Select the four corners.


# Compilation

- [cornerToCouples](#cornertocouples)

### **cornerToCouples**
```elm
cornerToCouples : Corner -> List ( String, String )
```

Compiles a `Corner` record to the corresponding CSS tuples.
Compiles only parts which are defined, ignoring `Nothing` fields.

