# Cursor

Cursor contains everything about cursors rendering.


# Types

- [Cursor](#cursor)

### **type Cursor**
```elm
type Cursor   
    = Auto   
    | Default   
    | None   
    | Pointer   
    | ContextMenu   
    | Help   
    | Progress   
    | Wait   
    | Cell   
    | Crosshair   
    | Text   
    | VerticalText   
    | Move   
    | NoDrop   
    | NotAllowed   
    | ZoomIn   
    | ZoomOut   
    | Grab   
    | Grabbing 
```

The `Cursor` record contains everything about cursor.
You probably won't use it as is, but instead using `Elegant.cursor`.
You can provide one cursor type. They can be found [here](https://developer.mozilla.org/en/docs/Web/CSS/cursor).

```elm
Elegant.cursor Cursor.default
```


# Cursor types

- [default](#default)

### **default**
```elm
default : Cursor

```


- [auto](#auto)

### **auto**
```elm
auto : Cursor

```


- [cell](#cell)

### **cell**
```elm
cell : Cursor

```


- [contextMenu](#contextmenu)

### **contextMenu**
```elm
contextMenu : Cursor

```


- [crosshair](#crosshair)

### **crosshair**
```elm
crosshair : Cursor

```


- [grab](#grab)

### **grab**
```elm
grab : Cursor

```


- [grabbing](#grabbing)

### **grabbing**
```elm
grabbing : Cursor

```


- [help](#help)

### **help**
```elm
help : Cursor

```


- [move](#move)

### **move**
```elm
move : Cursor

```


- [noDrop](#nodrop)

### **noDrop**
```elm
noDrop : Cursor

```


- [none](#none)

### **none**
```elm
none : Cursor

```


- [notAllowed](#notallowed)

### **notAllowed**
```elm
notAllowed : Cursor

```


- [pointer](#pointer)

### **pointer**
```elm
pointer : Cursor

```


- [progress](#progress)

### **progress**
```elm
progress : Cursor

```


- [text](#text)

### **text**
```elm
text : Cursor

```


- [verticalText](#verticaltext)

### **verticalText**
```elm
verticalText : Cursor

```


- [wait](#wait)

### **wait**
```elm
wait : Cursor

```


- [zoomIn](#zoomin)

### **zoomIn**
```elm
zoomIn : Cursor

```


- [zoomOut](#zoomout)

### **zoomOut**
```elm
zoomOut : Cursor

```




# Compilation

- [cursorToCouple](#cursortocouple)

### **cursorToCouple**
```elm
cursorToCouple : Cursor -> ( String, String )

```

Compiles a `Cursor` to the corresponding CSS tuple.

