# Style

- [box](#box)

### **box**
```elm
box : Helpers.Shared.Modifiers Box -> BodyBuilder.Attributes.StyleModifier (BodyBuilder.Attributes.BoxContainer a)
```


- [block](#block)

### **block**
```elm
block : Helpers.Shared.Modifiers Display.BlockDetails -> BodyBuilder.Attributes.StyleModifier (BodyBuilder.Attributes.MaybeBlockContainer a)
```


- [blockProperties](#blockproperties)

### **blockProperties**
```elm
blockProperties : Helpers.Shared.Modifiers Display.BlockDetails -> BodyBuilder.Attributes.StyleModifier (BodyBuilder.Attributes.BlockContainer a)
```


- [flexContainerProperties](#flexcontainerproperties)

### **flexContainerProperties**
```elm
flexContainerProperties : Helpers.Shared.Modifiers Flex.FlexContainerDetails -> BodyBuilder.Attributes.StyleModifier (BodyBuilder.Attributes.FlexContainerAttributes msg)
```


- [flexItemProperties](#flexitemproperties)

### **flexItemProperties**
```elm
flexItemProperties : Helpers.Shared.Modifiers Flex.FlexItemDetails -> BodyBuilder.Attributes.StyleModifier (BodyBuilder.Attributes.FlexItemAttributes msg)
```


- [gridContainerProperties](#gridcontainerproperties)

### **gridContainerProperties**
```elm
gridContainerProperties : Helpers.Shared.Modifiers Grid.GridContainerDetails -> BodyBuilder.Attributes.StyleModifier (BodyBuilder.Attributes.GridContainerAttributes msg)
```


- [gridItemProperties](#griditemproperties)

### **gridItemProperties**
```elm
gridItemProperties : Helpers.Shared.Modifiers Grid.GridItemDetails -> BodyBuilder.Attributes.StyleModifier (BodyBuilder.Attributes.GridItemAttributes msg)
```


- [waitForStyleSelector](#waitforstyleselector)

### **waitForStyleSelector**
```elm
waitForStyleSelector : (( a, BodyBuilder.Attributes.StyleSelector ) -> b -> b) -> a -> BodyBuilder.Attributes.StyleModifier b
```


- [media](#media)

### **media**
```elm
media : BodyBuilder.Attributes.MediaQuery -> BodyBuilder.Attributes.StyleModifier a -> BodyBuilder.Attributes.StyleModifier a
```


- [setMedia](#setmedia)

### **setMedia**
```elm
setMedia : BodyBuilder.Attributes.MediaQuery -> Helpers.Shared.Modifier BodyBuilder.Attributes.StyleSelector
```


- [greater](#greater)

### **greater**
```elm
greater : Int -> BodyBuilder.Attributes.MediaQuery
```


- [lesser](#lesser)

### **lesser**
```elm
lesser : Int -> BodyBuilder.Attributes.MediaQuery
```


- [between](#between)

### **between**
```elm
between : Int -> Int -> BodyBuilder.Attributes.MediaQuery
```


- [pseudoClass](#pseudoclass)

### **pseudoClass**
```elm
pseudoClass : String -> BodyBuilder.Attributes.StyleModifier a -> BodyBuilder.Attributes.StyleModifier a
```


- [setPseudoClass](#setpseudoclass)

### **setPseudoClass**
```elm
setPseudoClass : String -> Helpers.Shared.Modifier BodyBuilder.Attributes.StyleSelector
```


- [hover](#hover)

### **hover**
```elm
hover : BodyBuilder.Attributes.StyleModifier a -> BodyBuilder.Attributes.StyleModifier a
```


- [focus](#focus)

### **focus**
```elm
focus : BodyBuilder.Attributes.StyleModifier a -> BodyBuilder.Attributes.StyleModifier a
```



