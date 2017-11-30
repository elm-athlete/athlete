# Flex

Flex handles everything related to the flex element.

- [FlexContainerDetails](#flexcontainerdetails)

### **type alias FlexContainerDetails**
```elm
type alias FlexContainerDetails  =
    FlexContainerDetails Nothing Nothing Nothing Nothing



type FlexDirection
    = FlexDirectionColumn
    | FlexDirectionRow



direction : FlexDirection -> Modifier FlexContainerDetails
direction =
    setDirection << Just



column : FlexDirection
column =
    FlexDirectionColumn



row : FlexDirection
row =
    FlexDirectionRow



type FlexWrap
    = FlexWrapWrap
    | FlexWrapNoWrap



wrap : Modifier FlexContainerDetails
wrap =
    setWrap <| Just FlexWrapWrap



noWrap : Modifier FlexContainerDetails
noWrap =
    setWrap <| Just FlexWrapNoWrap



type Align
    = AlignBaseline
    | AlignCenter
    | AlignFlexStart
    | AlignFlexEnd
    | AlignInherit
    | AlignInitial
    | AlignStretch



align : Align -> Modifier FlexContainerDetails
align =
    setAlign << Just



baseline : Align
baseline =
    AlignBaseline



alignCenter : Align
alignCenter =
    AlignCenter



flexStart : Align
flexStart =
    AlignFlexStart



flexEnd : Align
flexEnd =
    AlignFlexEnd



inherit : Align
inherit =
    AlignInherit



initial : Align
initial =
    AlignInitial



stretch : Align
stretch =
    AlignStretch



type JustifyContent
    = JustifyContentSpaceBetween
    | JustifyContentSpaceAround
    | JustifyContentCenter
    | JustifyContentFlexStart
    | JustifyContentFlexEnd



justifyContent : JustifyContent -> Modifier FlexContainerDetails
justifyContent =
    setJustifyContent << Just



spaceBetween : JustifyContent
spaceBetween =
    JustifyContentSpaceBetween



spaceAround : JustifyContent
spaceAround =
    JustifyContentSpaceAround



justifyContentCenter : JustifyContent
justifyContentCenter =
    JustifyContentCenter



justifyContentFlexStart : JustifyContent
justifyContentFlexStart =
    JustifyContentFlexStart



justifyContentFlexEnd : JustifyContent
justifyContentFlexEnd =
    JustifyContentFlexEnd



type alias FlexItemDetails =
    { grow : Maybe Int
    , shrink : Maybe Int
    , basis : Maybe (Either SizeUnit Auto)
    , alignSelf : Maybe Align
    }
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
direction : Maybe FlexDirection
    , wrap : Maybe FlexWrap
    , align : Maybe Align
    , justifyContent : Maybe JustifyContent
    }



defaultFlexContainerDetails : FlexContainerDetails
defaultFlexContainerDetails =
    FlexContainerDetails Nothing Nothing Nothing Nothing



type FlexDirection
    = FlexDirectionColumn
    | FlexDirectionRow




```

Accepts a flex-direction and modifies the flex container accordingly.
- [column](#column)

### **column**
```elm
column : FlexDirection

```

Defines the flex direction column.
- [row](#row)

### **row**
```elm
row : FlexDirection

```

Defines the flex direction row.


## FlexWrap

- [wrap](#wrap)

### **wrap**
```elm
wrap : Maybe FlexWrap
    , align : Maybe Align
    , justifyContent : Maybe JustifyContent
    }



defaultFlexContainerDetails : FlexContainerDetails
defaultFlexContainerDetails =
    FlexContainerDetails Nothing Nothing Nothing Nothing



type FlexDirection
    = FlexDirectionColumn
    | FlexDirectionRow



direction : FlexDirection -> Modifier FlexContainerDetails
direction =
    setDirection << Just



column : FlexDirection
column =
    FlexDirectionColumn



row : FlexDirection
row =
    FlexDirectionRow



type FlexWrap
    = FlexWrapWrap
    | FlexWrapNoWrap




```

Modifies the flex-wrap to wrap.
- [noWrap](#nowrap)

### **noWrap**
```elm
noWrap : Modifier FlexContainerDetails

```

Modifies the flex-wrap to no-wrap.


## AlignItems / AlignSelf

- [align](#align-1)

### **align**
```elm
align : Maybe Align
    , justifyContent : Maybe JustifyContent
    }



defaultFlexContainerDetails : FlexContainerDetails
defaultFlexContainerDetails =
    FlexContainerDetails Nothing Nothing Nothing Nothing



type FlexDirection
    = FlexDirectionColumn
    | FlexDirectionRow



direction : FlexDirection -> Modifier FlexContainerDetails
direction =
    setDirection << Just



column : FlexDirection
column =
    FlexDirectionColumn



row : FlexDirection
row =
    FlexDirectionRow



type FlexWrap
    = FlexWrapWrap
    | FlexWrapNoWrap



wrap : Modifier FlexContainerDetails
wrap =
    setWrap <| Just FlexWrapWrap



noWrap : Modifier FlexContainerDetails
noWrap =
    setWrap <| Just FlexWrapNoWrap



type Align
    = AlignBaseline
    | AlignCenter
    | AlignFlexStart
    | AlignFlexEnd
    | AlignInherit
    | AlignInitial
    | AlignStretch




```

Accepts an Align, and modifies the flex container accordingly.
- [alignXY](#alignxy)

### **alignXY**
```elm
alignXY : ( Align, JustifyContent ) -> FlexContainerDetails -> FlexContainerDetails

```


- [baseline](#baseline)

### **baseline**
```elm
baseline : Align

```

Generates a baseline alignment.
- [alignCenter](#aligncenter)

### **alignCenter**
```elm
alignCenter : Align

```

Generates a center alignment.
- [flexStart](#flexstart)

### **flexStart**
```elm
flexStart : Align

```

Generates a flex-start alignment.
- [flexEnd](#flexend)

### **flexEnd**
```elm
flexEnd : Align

```

Generates a flex-end alignment.
- [inherit](#inherit)

### **inherit**
```elm
inherit : Align

```

Generates a inherit alignment.
- [initial](#initial)

### **initial**
```elm
initial : Align

```

Generates a initial alignment.
- [stretch](#stretch)

### **stretch**
```elm
stretch : Align

```

Generates a stretch alignment.


## JustifyContent

- [justifyContent](#justifycontent-1)

### **justifyContent**
```elm
justifyContent : Maybe JustifyContent
    }



defaultFlexContainerDetails : FlexContainerDetails
defaultFlexContainerDetails =
    FlexContainerDetails Nothing Nothing Nothing Nothing



type FlexDirection
    = FlexDirectionColumn
    | FlexDirectionRow



direction : FlexDirection -> Modifier FlexContainerDetails
direction =
    setDirection << Just



column : FlexDirection
column =
    FlexDirectionColumn



row : FlexDirection
row =
    FlexDirectionRow



type FlexWrap
    = FlexWrapWrap
    | FlexWrapNoWrap



wrap : Modifier FlexContainerDetails
wrap =
    setWrap <| Just FlexWrapWrap



noWrap : Modifier FlexContainerDetails
noWrap =
    setWrap <| Just FlexWrapNoWrap



type Align
    = AlignBaseline
    | AlignCenter
    | AlignFlexStart
    | AlignFlexEnd
    | AlignInherit
    | AlignInitial
    | AlignStretch



align : Align -> Modifier FlexContainerDetails
align =
    setAlign << Just



baseline : Align
baseline =
    AlignBaseline



alignCenter : Align
alignCenter =
    AlignCenter



flexStart : Align
flexStart =
    AlignFlexStart



flexEnd : Align
flexEnd =
    AlignFlexEnd



inherit : Align
inherit =
    AlignInherit



initial : Align
initial =
    AlignInitial



stretch : Align
stretch =
    AlignStretch



type JustifyContent
    = JustifyContentSpaceBetween
    | JustifyContentSpaceAround
    | JustifyContentCenter
    | JustifyContentFlexStart
    | JustifyContentFlexEnd




```

Accepts a justify-content and modifies the flex container accordingly.
- [spaceBetween](#spacebetween)

### **spaceBetween**
```elm
spaceBetween : JustifyContent

```

Defines the justify-content space-between.
- [spaceAround](#spacearound)

### **spaceAround**
```elm
spaceAround : JustifyContent

```

Defines the justify-content space-around.
- [justifyContentCenter](#justifycontentcenter)

### **justifyContentCenter**
```elm
justifyContentCenter : JustifyContent

```

Defines the justify-content center.
- [justifyContentFlexStart](#justifycontentflexstart)

### **justifyContentFlexStart**
```elm
justifyContentFlexStart : JustifyContent

```

Defines the justify-content flex-start.
- [justifyContentFlexEnd](#justifycontentflexend)

### **justifyContentFlexEnd**
```elm
justifyContentFlexEnd : JustifyContent

```

Defines the justify-content flex-end.


## Positionning

- [topLeft](#topleft)

### **topLeft**
```elm
topLeft : FlexContainerDetails -> FlexContainerDetails

```


- [topCenter](#topcenter)

### **topCenter**
```elm
topCenter : FlexContainerDetails -> FlexContainerDetails

```


- [topRight](#topright)

### **topRight**
```elm
topRight : FlexContainerDetails -> FlexContainerDetails

```


- [centerLeft](#centerleft)

### **centerLeft**
```elm
centerLeft : FlexContainerDetails -> FlexContainerDetails

```


- [center](#center)

### **center**
```elm
center : FlexContainerDetails -> FlexContainerDetails

```


- [centerRight](#centerright)

### **centerRight**
```elm
centerRight : FlexContainerDetails -> FlexContainerDetails

```


- [bottomLeft](#bottomleft)

### **bottomLeft**
```elm
bottomLeft : FlexContainerDetails -> FlexContainerDetails

```


- [bottomCenter](#bottomcenter)

### **bottomCenter**
```elm
bottomCenter : FlexContainerDetails -> FlexContainerDetails

```


- [bottomRight](#bottomright)

### **bottomRight**
```elm
bottomRight : FlexContainerDetails -> FlexContainerDetails

```




## Flex

- [grow](#grow)

### **grow**
```elm
grow : Maybe Int
    , shrink : Maybe Int
    , basis : Maybe (Either SizeUnit Auto)
    , alignSelf : Maybe Align
    }



defaultFlexItemDetails : FlexItemDetails
defaultFlexItemDetails =
    FlexItemDetails Nothing Nothing Nothing Nothing




```

Accepts an int and sets the flex-grow accordingly.
- [shrink](#shrink)

### **shrink**
```elm
shrink : Maybe Int
    , basis : Maybe (Either SizeUnit Auto)
    , alignSelf : Maybe Align
    }



defaultFlexItemDetails : FlexItemDetails
defaultFlexItemDetails =
    FlexItemDetails Nothing Nothing Nothing Nothing



grow : Int -> Modifier FlexItemDetails
grow =
    setGrow << Just




```

Accepts an int and sets the flex-shrink accordingly.
- [basisAuto](#basisauto)

### **basisAuto**
```elm
basisAuto : Modifier FlexItemDetails

```

Sets the flex-basis as auto.
- [basis](#basis)

### **basis**
```elm
basis : Maybe (Either SizeUnit Auto)
    , alignSelf : Maybe Align
    }



defaultFlexItemDetails : FlexItemDetails
defaultFlexItemDetails =
    FlexItemDetails Nothing Nothing Nothing Nothing



grow : Int -> Modifier FlexItemDetails
grow =
    setGrow << Just



shrink : Int -> Modifier FlexItemDetails
shrink =
    setShrink << Just




```

Accepts a size and sets the flex-basis accordingly.
- [alignSelf](#alignself)

### **alignSelf**
```elm
alignSelf : Maybe Align
    }



defaultFlexItemDetails : FlexItemDetails
defaultFlexItemDetails =
    FlexItemDetails Nothing Nothing Nothing Nothing



grow : Int -> Modifier FlexItemDetails
grow =
    setGrow << Just



shrink : Int -> Modifier FlexItemDetails
shrink =
    setShrink << Just



basisAuto : Modifier FlexItemDetails
basisAuto =
    setBasis <| Just <| Right Auto



basis : SizeUnit -> Modifier FlexItemDetails
basis =
    setBasis << Just << Left




```

Accepts an align and modifies the flex item accordingly.

- [defaultFlexContainerDetails](#defaultflexcontainerdetails)

### **defaultFlexContainerDetails**
```elm
defaultFlexContainerDetails : FlexContainerDetails

```


- [defaultFlexItemDetails](#defaultflexitemdetails)

### **defaultFlexItemDetails**
```elm
defaultFlexItemDetails : FlexItemDetails

```


- [flexContainerDetailsToCouples](#flexcontainerdetailstocouples)

### **flexContainerDetailsToCouples**
```elm
flexContainerDetailsToCouples : FlexContainerDetails -> List ( String, String )

```


- [flexItemDetailsToCouples](#flexitemdetailstocouples)

### **flexItemDetailsToCouples**
```elm
flexItemDetailsToCouples : FlexItemDetails -> List ( String, String )

```



