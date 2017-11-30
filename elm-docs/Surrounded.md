# Surrounded

Generic module for surrounded values.

- [Surrounded](#surrounded)

### **type alias Surrounded**
```elm
type alias Surrounded surroundType =
    { top : Maybe surroundType
    , right : Maybe surroundType
    , bottom : Maybe surroundType
    , left : Maybe surroundType
    }
```


- [all](#all)

### **all**
```elm
all : a -> Modifiers a -> Modifier (Surrounded a)

```


- [bottom](#bottom)

### **bottom**
```elm
bottom : Maybe surroundType
    , left : Maybe surroundType
    }



default : Surrounded a
default =
    Surrounded Nothing Nothing Nothing Nothing



top : a -> Modifiers a -> Modifier (Surrounded a)
top default =
    getModifyAndSet .top setTopIn default




```


- [default](#default)

### **default**
```elm
default : Surrounded a

```


- [horizontal](#horizontal)

### **horizontal**
```elm
horizontal : a -> Modifiers a -> Modifier (Surrounded a)

```


- [left](#left)

### **left**
```elm
left : Maybe surroundType
    }



default : Surrounded a
default =
    Surrounded Nothing Nothing Nothing Nothing



top : a -> Modifiers a -> Modifier (Surrounded a)
top default =
    getModifyAndSet .top setTopIn default



bottom : a -> Modifiers a -> Modifier (Surrounded a)
bottom default =
    getModifyAndSet .bottom setBottomIn default



right : a -> Modifiers a -> Modifier (Surrounded a)
right default =
    getModifyAndSet .right setRightIn default




```


- [right](#right)

### **right**
```elm
right : Maybe surroundType
    , bottom : Maybe surroundType
    , left : Maybe surroundType
    }



default : Surrounded a
default =
    Surrounded Nothing Nothing Nothing Nothing



top : a -> Modifiers a -> Modifier (Surrounded a)
top default =
    getModifyAndSet .top setTopIn default



bottom : a -> Modifiers a -> Modifier (Surrounded a)
bottom default =
    getModifyAndSet .bottom setBottomIn default




```


- [surroundedToCouples](#surroundedtocouples)

### **surroundedToCouples**
```elm
surroundedToCouples : 
    Maybe String
    -> (a -> List ( String, String ))
    -> Surrounded a
    -> List ( String, String )

```


- [top](#top)

### **top**
```elm
top : Maybe surroundType
    , right : Maybe surroundType
    , bottom : Maybe surroundType
    , left : Maybe surroundType
    }



default : Surrounded a
default =
    Surrounded Nothing Nothing Nothing Nothing




```


- [vertical](#vertical)

### **vertical**
```elm
vertical : a -> Modifiers a -> Modifier (Surrounded a)

```


- [applyModifiersOnDefault](#applymodifiersondefault)

### **applyModifiersOnDefault**
```elm
applyModifiersOnDefault : Modifiers (Surrounded a) -> Surrounded a

```



