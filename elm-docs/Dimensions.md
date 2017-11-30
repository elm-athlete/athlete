# Dimensions

- [width](#width)

### **width**
```elm
width : SizeUnit -> Modifier Dimensions

```


- [height](#height)

### **height**
```elm
height : SizeUnit -> Modifier Dimensions

```


- [square](#square)

### **square**
```elm
square : SizeUnit -> Modifier Dimensions

```


- [minWidth](#minwidth)

### **minWidth**
```elm
minWidth : SizeUnit -> Modifier Dimensions

```


- [maxWidth](#maxwidth)

### **maxWidth**
```elm
maxWidth : SizeUnit -> Modifier Dimensions

```


- [minHeight](#minheight)

### **minHeight**
```elm
minHeight : SizeUnit -> Modifier Dimensions

```


- [maxHeight](#maxheight)

### **maxHeight**
```elm
maxHeight : SizeUnit -> Modifier Dimensions

```


- [Dimensions](#dimensions)

### **type alias Dimensions**
```elm
type alias Dimensions  =
    { min : Maybe SizeUnit
    , dimension : Maybe SizeUnit
    , max : Maybe SizeUnit
    }
```

The type behind the handling of (max-|min-|)width and (max-|min-|)height
- [defaultDimensions](#defaultdimensions)

### **defaultDimensions**
```elm
defaultDimensions : ( DimensionAxis, DimensionAxis )

```


- [dimensionsToCouples](#dimensionstocouples)

### **dimensionsToCouples**
```elm
dimensionsToCouples : Dimensions -> List ( String, String )

```



