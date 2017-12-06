# Outline

Outline contains everything about outline rendering.


# Types

- [Outline](#outline)

### **type alias Outline**
```elm
type alias Outline  =  
    { color : Maybe Color , thickness : Maybe Helpers.Shared.SizeUnit , style : Maybe Outline.OutlineStyle }
```

The `Outline` record contains everything about one outline side.
You probably won't use it as is, but instead using `Elegant.outline`
which automatically generate an empty `Outline` record. You
can then use modifiers. I.E.

```elm
Elegant.outline
```

        [ Outline.solid
        , Elegant.color Color.blue
        ]
- [OutlineStyle](#outlinestyle)

### **type OutlineStyle**
```elm
type OutlineStyle   
    = 
```

Represents the possible styles of the outline.
It can be Solid or Dashed. They are created by `solid` and `dashed`.


# Default border

- [default](#default)

### **default**
```elm
default : Outline

```

Generate an empty `Outline` record, with every field equal to Nothing.
You are free to use it as you wish, but it is instanciated automatically by `Elegant.outline`.


# Border modifiers


## Appearance

- [thickness](#thickness)

### **thickness**
```elm
thickness : Maybe SizeUnit
    , style : Maybe OutlineStyle
    }



default : Outline
default =
    Outline Nothing Nothing Nothing



type OutlineStyle
    = Solid
    | Dashed
    | None



none : Modifier Outline
none =
    setStyle <| Just None



solid : Modifier Outline
solid =
    setStyle <| Just Solid



dashed : Modifier Outline
dashed =
    setStyle <| Just Dashed




```

Set the thickness of the outline.
- [none](#none)

### **none**
```elm
none : Modifier Outline

```

Set the outline to none.
- [solid](#solid)

### **solid**
```elm
solid : Modifier Outline

```

Set the outline as solid.
- [dashed](#dashed)

### **dashed**
```elm
dashed : Modifier Outline

```

Set the outline as dashed.


# Compilation

- [outlineToCouples](#outlinetocouples)

### **outlineToCouples**
```elm
outlineToCouples : Outline -> List ( String, String )

```

Compiles an `Outline` record to the corresponding CSS list of tuples.
Compiles only styles which are defined, ignoring `Nothing` fields.

