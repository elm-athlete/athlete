# Overflow

Handles Overflow

- [FullOverflow](#fulloverflow)

### **type alias FullOverflow**
```elm
type alias FullOverflow  =  
    Helpers.Vector.Vector (Maybe Overflow)
```


- [overflowX](#overflowx)

### **overflowX**
```elm
overflowX : Overflow -> Modifier FullOverflow

```

OverflowX to handle overflow X of an element
- [overflowY](#overflowy)

### **overflowY**
```elm
overflowY : Overflow -> Modifier FullOverflow

```

OverflowY to handle overflow Y of an element
- [overflowXY](#overflowxy)

### **overflowXY**
```elm
overflowXY : Overflow -> Modifier FullOverflow

```

OverflowY to handle overflow XY of an element
- [visible](#visible)

### **visible**
```elm
visible : Overflow

```

always visible overflow)
- [hidden](#hidden)

### **hidden**
```elm
hidden : Overflow

```

hidden overflow
- [auto](#auto)

### **auto**
```elm
auto : Overflow

```

auto overflow
- [default](#default)

### **default**
```elm
default : Vector (Maybe Overflow)

```


- [scroll](#scroll)

### **scroll**
```elm
scroll : Overflow

```

scroll overflow
- [Overflow](#overflow)

### **type Overflow**
```elm
type Overflow   
    = OverflowVisible   
    | OverflowHidden   
    | OverflowAuto   
    | OverflowScroll 
```



