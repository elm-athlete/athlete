# Style

- [box](#box)

### **box**
```elm
box : Modifiers Box -> StyleModifier (BoxContainer a)

```


- [block](#block)

### **block**
```elm
block : Modifiers Display.BlockDetails -> StyleModifier (MaybeBlockContainer a)

```


- [blockProperties](#blockproperties)

### **blockProperties**
```elm
blockProperties : Modifiers Display.BlockDetails -> StyleModifier (BlockContainer a)

```


- [flexContainerProperties](#flexcontainerproperties)

### **flexContainerProperties**
```elm
flexContainerProperties : Modifiers Flex.FlexContainerDetails -> StyleModifier (FlexContainerAttributes msg)

```


- [flexItemProperties](#flexitemproperties)

### **flexItemProperties**
```elm
flexItemProperties : Modifiers Flex.FlexItemDetails -> StyleModifier (FlexItemAttributes msg)

```


- [gridContainerProperties](#gridcontainerproperties)

### **gridContainerProperties**
```elm
gridContainerProperties : Modifiers Grid.GridContainerDetails -> StyleModifier (GridContainerAttributes msg)

```


- [gridItemProperties](#griditemproperties)

### **gridItemProperties**
```elm
gridItemProperties : Modifiers Grid.GridItemDetails -> StyleModifier (GridItemAttributes msg)

```


- [waitForStyleSelector](#waitforstyleselector)

### **waitForStyleSelector**
```elm
waitForStyleSelector : (( a, StyleSelector ) -> b -> b) -> a -> StyleModifier b

```


- [media](#media)

### **media**
```elm
media : MediaQuery -> StyleModifier a -> StyleModifier a

```


- [setMedia](#setmedia)

### **setMedia**
```elm
setMedia : MediaQuery -> Modifier StyleSelector

```


- [greater](#greater)

### **greater**
```elm
greater : Int -> MediaQuery

```


- [lesser](#lesser)

### **lesser**
```elm
lesser : Int -> MediaQuery

```


- [between](#between)

### **between**
```elm
between : Int -> Int -> MediaQuery

```


- [pseudoClass](#pseudoclass)

### **pseudoClass**
```elm
pseudoClass : String -> StyleModifier a -> StyleModifier a

```


- [setPseudoClass](#setpseudoclass)

### **setPseudoClass**
```elm
setPseudoClass : String -> Modifier StyleSelector

```


- [hover](#hover)

### **hover**
```elm
hover : StyleModifier a -> StyleModifier a

```


- [focus](#focus)

### **focus**
```elm
focus : StyleModifier a -> StyleModifier a

```



