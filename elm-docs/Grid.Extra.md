# Grid.Extra

- [alignedCell](#alignedcell)

### **alignedCell**
```elm
alignedCell : 
    List (Attributes.StyleModifier (Attributes.GridItemAttributes msg))
    -> ( Int, Int )
    -> ( Int, Int )
    -> ( Flex.Align, Flex.JustifyContent )
    -> List (Node msg)
    -> Builder.GridItem msg

```

a cell inside a grid with alignement of it's content
- [cell](#cell)

### **cell**
```elm
cell : 
    List (Attributes.StyleModifier (Attributes.GridItemAttributes msg))
    -> ( Int, Int )
    -> ( Int, Int )
    -> List (Node msg)
    -> Builder.GridItem msg

```

a cell inside a grid with beginning coordinates and size

