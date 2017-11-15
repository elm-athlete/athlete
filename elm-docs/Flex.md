# Flex

Flex handles everything related to the flex element.

- [FlexContainerDetails](#flexcontainerdetails)

### **type alias FlexContainerDetails**
```elm
type alias FlexContainerDetails  =  
    { direction : Maybe Flex.FlexDirection , wrap : Maybe Flex.FlexWrap , align : Maybe Flex.Align , justifyContent : Maybe Flex.JustifyContent }
```

Contains all style which can be applied on a flex container.
This contains flex-direction, flex-wrap, align-items and justify-content.
- [FlexItemDetails](#flexitemdetails)

### **type alias FlexItemDetails**
```elm
type alias FlexItemDetails  =  
    { grow : Maybe Int , shrink : Maybe Int , basis : Maybe (Either Helpers.Shared.SizeUnit Helpers.Shared.Auto) , alignSelf : Maybe Flex.Align }
```

Contains all style which can be used on a flex item.
This contains flex-grow, flex-shrink, flex-basis and align-self.
- [FlexDirection](#flexdirection)

### **type FlexDirection**
```elm
type FlexDirection   
    = 
```

Represents a flex direction.
Can be column or row.
- [FlexWrap](#flexwrap)

### **type FlexWrap**
```elm
type FlexWrap   
    = 
```

Represents a flex wrap.
Can be wrap or no-wrap.
- [Align](#align)

### **type Align**
```elm
type Align   
    = 
```

Represents the alignment in flex.
Can be baseline, center, flex-start, flex-end, inherit, initial or stretch.
- [JustifyContent](#justifycontent)

### **type JustifyContent**
```elm
type JustifyContent   
    = 
```

Represents the value of justify-content.
Can be space-between, space-around or center.


## FlexDirection

- [direction](#direction)

### **direction**
```elm
direction : Flex.FlexDirection -> Helpers.Shared.Modifier Flex.FlexContainerDetails
```

Accepts a flex-direction and modifies the flex container accordingly.
- [column](#column)

### **column**
```elm
column : Flex.FlexDirection
```

Defines the flex direction column.
- [row](#row)

### **row**
```elm
row : Flex.FlexDirection
```

Defines the flex direction row.


## FlexWrap

- [wrap](#wrap)

### **wrap**
```elm
wrap : Helpers.Shared.Modifier Flex.FlexContainerDetails
```

Modifies the flex-wrap to wrap.
- [noWrap](#nowrap)

### **noWrap**
```elm
noWrap : Helpers.Shared.Modifier Flex.FlexContainerDetails
```

Modifies the flex-wrap to no-wrap.


## AlignItems / AlignSelf

- [align](#align-1)

### **align**
```elm
align : Flex.Align -> Helpers.Shared.Modifier Flex.FlexContainerDetails
```

Accepts an Align, and modifies the flex container accordingly.
- [alignXY](#alignxy)

### **alignXY**
```elm
alignXY : ( Flex.Align, Flex.JustifyContent ) -> Flex.FlexContainerDetails -> Flex.FlexContainerDetails
```


- [baseline](#baseline)

### **baseline**
```elm
baseline : Flex.Align
```

Generates a baseline alignment.
- [alignCenter](#aligncenter)

### **alignCenter**
```elm
alignCenter : Flex.Align
```

Generates a center alignment.
- [flexStart](#flexstart)

### **flexStart**
```elm
flexStart : Flex.Align
```

Generates a flex-start alignment.
- [flexEnd](#flexend)

### **flexEnd**
```elm
flexEnd : Flex.Align
```

Generates a flex-end alignment.
- [inherit](#inherit)

### **inherit**
```elm
inherit : Flex.Align
```

Generates a inherit alignment.
- [initial](#initial)

### **initial**
```elm
initial : Flex.Align
```

Generates a initial alignment.
- [stretch](#stretch)

### **stretch**
```elm
stretch : Flex.Align
```

Generates a stretch alignment.


## JustifyContent

- [justifyContent](#justifycontent-1)

### **justifyContent**
```elm
justifyContent : Flex.JustifyContent -> Helpers.Shared.Modifier Flex.FlexContainerDetails
```

Accepts a justify-content and modifies the flex container accordingly.
- [spaceBetween](#spacebetween)

### **spaceBetween**
```elm
spaceBetween : Flex.JustifyContent
```

Defines the justify-content space-between.
- [spaceAround](#spacearound)

### **spaceAround**
```elm
spaceAround : Flex.JustifyContent
```

Defines the justify-content space-around.
- [justifyContentCenter](#justifycontentcenter)

### **justifyContentCenter**
```elm
justifyContentCenter : Flex.JustifyContent
```

Defines the justify-content center.
- [justifyContentFlexStart](#justifycontentflexstart)

### **justifyContentFlexStart**
```elm
justifyContentFlexStart : Flex.JustifyContent
```

Defines the justify-content flex-start.
- [justifyContentFlexEnd](#justifycontentflexend)

### **justifyContentFlexEnd**
```elm
justifyContentFlexEnd : Flex.JustifyContent
```

Defines the justify-content flex-end.


## Positionning

- [topLeft](#topleft)

### **topLeft**
```elm
topLeft : Flex.FlexContainerDetails -> Flex.FlexContainerDetails
```


- [topCenter](#topcenter)

### **topCenter**
```elm
topCenter : Flex.FlexContainerDetails -> Flex.FlexContainerDetails
```


- [topRight](#topright)

### **topRight**
```elm
topRight : Flex.FlexContainerDetails -> Flex.FlexContainerDetails
```


- [centerLeft](#centerleft)

### **centerLeft**
```elm
centerLeft : Flex.FlexContainerDetails -> Flex.FlexContainerDetails
```


- [center](#center)

### **center**
```elm
center : Flex.FlexContainerDetails -> Flex.FlexContainerDetails
```


- [centerRight](#centerright)

### **centerRight**
```elm
centerRight : Flex.FlexContainerDetails -> Flex.FlexContainerDetails
```


- [bottomLeft](#bottomleft)

### **bottomLeft**
```elm
bottomLeft : Flex.FlexContainerDetails -> Flex.FlexContainerDetails
```


- [bottomCenter](#bottomcenter)

### **bottomCenter**
```elm
bottomCenter : Flex.FlexContainerDetails -> Flex.FlexContainerDetails
```


- [bottomRight](#bottomright)

### **bottomRight**
```elm
bottomRight : Flex.FlexContainerDetails -> Flex.FlexContainerDetails
```




## Flex

- [grow](#grow)

### **grow**
```elm
grow : Int -> Helpers.Shared.Modifier Flex.FlexItemDetails
```

Accepts an int and sets the flex-grow accordingly.
- [shrink](#shrink)

### **shrink**
```elm
shrink : Int -> Helpers.Shared.Modifier Flex.FlexItemDetails
```

Accepts an int and sets the flex-shrink accordingly.
- [basisAuto](#basisauto)

### **basisAuto**
```elm
basisAuto : Helpers.Shared.Modifier Flex.FlexItemDetails
```

Sets the flex-basis as auto.
- [basis](#basis)

### **basis**
```elm
basis : Helpers.Shared.SizeUnit -> Helpers.Shared.Modifier Flex.FlexItemDetails
```

Accepts a size and sets the flex-basis accordingly.
- [alignSelf](#alignself)

### **alignSelf**
```elm
alignSelf : Flex.Align -> Helpers.Shared.Modifier Flex.FlexItemDetails
```

Accepts an align and modifies the flex item accordingly.

- [defaultFlexContainerDetails](#defaultflexcontainerdetails)

### **defaultFlexContainerDetails**
```elm
defaultFlexContainerDetails : Flex.FlexContainerDetails
```


- [defaultFlexItemDetails](#defaultflexitemdetails)

### **defaultFlexItemDetails**
```elm
defaultFlexItemDetails : Flex.FlexItemDetails
```


- [flexContainerDetailsToCouples](#flexcontainerdetailstocouples)

### **flexContainerDetailsToCouples**
```elm
flexContainerDetailsToCouples : Flex.FlexContainerDetails -> List ( String, String )
```


- [flexItemDetailsToCouples](#flexitemdetailstocouples)

### **flexItemDetailsToCouples**
```elm
flexItemDetailsToCouples : Flex.FlexItemDetails -> List ( String, String )
```



