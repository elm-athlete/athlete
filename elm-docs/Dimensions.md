# Dimensions

- [width](#width)

### **width**
```elm
width : Helpers.Shared.SizeUnit -> Helpers.Shared.Modifier Dimensions
```


- [height](#height)

### **height**
```elm
height : Helpers.Shared.SizeUnit -> Helpers.Shared.Modifier Dimensions
```


- [square](#square)

### **square**
```elm
square : Helpers.Shared.SizeUnit -> Helpers.Shared.Modifier Dimensions
```


- [minWidth](#minwidth)

### **minWidth**
```elm
minWidth : Helpers.Shared.SizeUnit -> Helpers.Shared.Modifier Dimensions
```


- [maxWidth](#maxwidth)

### **maxWidth**
```elm
maxWidth : Helpers.Shared.SizeUnit -> Helpers.Shared.Modifier Dimensions
```


- [minHeight](#minheight)

### **minHeight**
```elm
minHeight : Helpers.Shared.SizeUnit -> Helpers.Shared.Modifier Dimensions
```


- [maxHeight](#maxheight)

### **maxHeight**
```elm
maxHeight : Helpers.Shared.SizeUnit -> Helpers.Shared.Modifier Dimensions
```


- [Dimensions](#dimensions)

### **type alias Dimensions**
```elm
type alias Dimensions  =  
    ( Dimensions.DimensionAxis, Dimensions.DimensionAxis )
```

The type behind the handling of (max-|min-|)width and (max-|min-|)height
- [defaultDimensions](#defaultdimensions)

### **defaultDimensions**
```elm
defaultDimensions : ( Dimensions.DimensionAxis, Dimensions.DimensionAxis )
```


- [dimensionsToCouples](#dimensionstocouples)

### **dimensionsToCouples**
```elm
dimensionsToCouples : Dimensions -> List ( String, String )
```



