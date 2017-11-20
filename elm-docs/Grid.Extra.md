# Grid.Extra

- [alignedCell](#alignedcell)

### **alignedCell**
```elm
alignedCell : List (BodyBuilder.Attributes.StyleModifier (BodyBuilder.Attributes.GridItemAttributes msg)) -> ( Int, Int ) -> ( Int, Int ) -> ( Flex.Align, Flex.JustifyContent ) -> List (BodyBuilder.Node msg) -> BodyBuilder.GridItem msg
```

a cell inside a grid with alignement of it's content
- [cell](#cell)

### **cell**
```elm
cell : List (BodyBuilder.Attributes.StyleModifier (BodyBuilder.Attributes.GridItemAttributes msg)) -> ( Int, Int ) -> ( Int, Int ) -> List (BodyBuilder.Node msg) -> BodyBuilder.GridItem msg
```

a cell inside a grid with beginning coordinates and size

