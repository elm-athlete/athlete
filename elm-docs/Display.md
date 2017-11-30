# Display

Display contains everything about an element rendering. It is the basis of
every style, for every element. Each element can be block, inline, flow or flex.


# Types

- [DisplayBox](#displaybox)

### **type DisplayBox**
```elm
type DisplayBox   
    = None   
    | ContentsWrapper Display.Contents
```

Represents a box and contains all the style inside.
If the display is none, no style is included. Otherwise, the display
type requires the corresponding styles. I.e. if using a flex container,
then only styles applying to flex container can be used. If using a block
container, only styles applying to block can be used, and so on.

You don't use it directly, but rather generating one with the corresponding
functions, then giving it to a function which needs one. If you want to bypass
it, you can use `Display.displayBoxToCouples`, which generates the equivalent
CSS.
- [Contents](#contents)

### **type alias Contents**
```elm
type alias Contents  = Inline
    | Block (Maybe BlockDetails)
    | FlexItem (Maybe Flex.FlexItemDetails) (Maybe BlockDetails)
    | GridItem (Maybe Grid.GridItemDetails) (Maybe BlockDetails)



type InsideDisplay
    = Flow
    | FlexContainer (Maybe Flex.FlexContainerDetails)
    | GridContainer (Maybe Grid.GridContainerDetails)



type alias BlockDetails =
    { listStyleType : Maybe ListStyleType
    , alignment : Maybe Alignment
    , overflow : Maybe Overflow.FullOverflow
    , textOverflow : Maybe TextOverflow
    , dimensions : Maybe Dimensions
    }
```


- [OutsideDisplay](#outsidedisplay)

### **type OutsideDisplay**
```elm
type OutsideDisplay   
    = Inline   
    | Block Maybe Display.BlockDetails  
    | FlexItem Maybe Flex.FlexItemDetails Maybe Display.BlockDetails  
    | GridItem Maybe Grid.GridItemDetails Maybe Display.BlockDetails
```

Represents the style from outside the display.
Can be inline, block, or flex-item.
- [InsideDisplay](#insidedisplay)

### **type InsideDisplay**
```elm
type InsideDisplay   
    = Flow   
    | FlexContainer Maybe Flex.FlexContainerDetails  
    | GridContainer Maybe Grid.GridContainerDetails
```

Represents the style from inside a display.
Can be flow, or flex (and containing flex details).
- [BlockDetails](#blockdetails)

### **type alias BlockDetails**
```elm
type alias BlockDetails  =  
    { listStyleType : Maybe Display.ListStyleType , alignment : Maybe Display.Alignment , overflow : Maybe Overflow.FullOverflow , textOverflow : Maybe Display.TextOverflow , dimensions : Maybe Dimensions }
```

Contains all styles which can be applied to a block.
It is automatically instanciated by `Display.block`.
- [ListStyleType](#liststyletype)

### **type ListStyleType**
```elm
type ListStyleType   
    = 
```

Represents the type of the list style.
Can be none, disc, circle, square, decimal or georgian.
- [Alignment](#alignment)

### **type Alignment**
```elm
type Alignment   
    = 
```

Represents the alignment inside a block. Can be center, right, left or justify.
- [TextOverflow](#textoverflow)

### **type TextOverflow**
```elm
type TextOverflow   
    = 
```

Represents the text-overflow.
Can be ellipsis.
- [defaultBlockDetails](#defaultblockdetails)

### **defaultBlockDetails**
```elm
defaultBlockDetails : BlockDetails

```




# Modifiers


## List

- [listStyleNone](#liststylenone)

### **listStyleNone**
```elm
listStyleNone : Modifier BlockDetails

```

Set the list style to none.
- [listStyleDisc](#liststyledisc)

### **listStyleDisc**
```elm
listStyleDisc : Modifier BlockDetails

```

Set the list style to disc.
- [listStyleCircle](#liststylecircle)

### **listStyleCircle**
```elm
listStyleCircle : Modifier BlockDetails

```

Set the list style to circle.
- [listStyleSquare](#liststylesquare)

### **listStyleSquare**
```elm
listStyleSquare : Modifier BlockDetails

```

Set the list style to square.
- [listStyleDecimal](#liststyledecimal)

### **listStyleDecimal**
```elm
listStyleDecimal : Modifier BlockDetails

```

Set the list style to decimal.
- [listStyleGeorgian](#liststylegeorgian)

### **listStyleGeorgian**
```elm
listStyleGeorgian : Modifier BlockDetails

```

Set the list style to georgian.


## Alignment

- [alignment](#alignment-1)

### **alignment**
```elm
alignment : Maybe Alignment
    , overflow : Maybe Overflow.FullOverflow
    , textOverflow : Maybe TextOverflow
    , dimensions : Maybe Dimensions
    }



defaultBlockDetails : BlockDetails
defaultBlockDetails =
    BlockDetails Nothing Nothing Nothing Nothing Nothing



type ListStyleType
    = ListStyleTypeNone
    | ListStyleTypeDisc
    | ListStyleTypeCircle
    | ListStyleTypeSquare
    | ListStyleTypeDecimal
    | ListStyleTypeGeorgian


listStyleType : ListStyleType -> Modifier BlockDetails
listStyleType =
    setListStyleType << Just



listStyleNone : Modifier BlockDetails
listStyleNone =
    listStyleType ListStyleTypeNone



listStyleDisc : Modifier BlockDetails
listStyleDisc =
    listStyleType ListStyleTypeDisc



listStyleCircle : Modifier BlockDetails
listStyleCircle =
    listStyleType ListStyleTypeCircle



listStyleSquare : Modifier BlockDetails
listStyleSquare =
    listStyleType ListStyleTypeSquare



listStyleDecimal : Modifier BlockDetails
listStyleDecimal =
    listStyleType ListStyleTypeDecimal



listStyleGeorgian : Modifier BlockDetails
listStyleGeorgian =
    listStyleType ListStyleTypeGeorgian



type Alignment
    = AlignmentCenter
    | AlignmentRight
    | AlignmentLeft
    | AlignmentJustify




```

Accepts the alignment and modifies the block accordingly.
- [right](#right)

### **right**
```elm
right : Alignment

```

Defines the alignment as right.
- [center](#center)

### **center**
```elm
center : Alignment

```

Defines the alignment as center.
- [left](#left)

### **left**
```elm
left : Alignment

```

Defines the alignment as left.
- [justify](#justify)

### **justify**
```elm
justify : Alignment

```

Defines the alignment as justify.


## Overflow

- [overflow](#overflow)

### **overflow**
```elm
overflow : Maybe Overflow.FullOverflow
    , textOverflow : Maybe TextOverflow
    , dimensions : Maybe Dimensions
    }



defaultBlockDetails : BlockDetails
defaultBlockDetails =
    BlockDetails Nothing Nothing Nothing Nothing Nothing



type ListStyleType
    = ListStyleTypeNone
    | ListStyleTypeDisc
    | ListStyleTypeCircle
    | ListStyleTypeSquare
    | ListStyleTypeDecimal
    | ListStyleTypeGeorgian


listStyleType : ListStyleType -> Modifier BlockDetails
listStyleType =
    setListStyleType << Just



listStyleNone : Modifier BlockDetails
listStyleNone =
    listStyleType ListStyleTypeNone



listStyleDisc : Modifier BlockDetails
listStyleDisc =
    listStyleType ListStyleTypeDisc



listStyleCircle : Modifier BlockDetails
listStyleCircle =
    listStyleType ListStyleTypeCircle



listStyleSquare : Modifier BlockDetails
listStyleSquare =
    listStyleType ListStyleTypeSquare



listStyleDecimal : Modifier BlockDetails
listStyleDecimal =
    listStyleType ListStyleTypeDecimal



listStyleGeorgian : Modifier BlockDetails
listStyleGeorgian =
    listStyleType ListStyleTypeGeorgian



type Alignment
    = AlignmentCenter
    | AlignmentRight
    | AlignmentLeft
    | AlignmentJustify



alignment : Alignment -> Modifier BlockDetails
alignment =
    setAlignment << Just



dimensions : Modifiers Dimensions -> Modifier BlockDetails
dimensions =
    getModifyAndSet .dimensions setDimensionsIn Dimensions.defaultDimensions



right : Alignment
right =
    AlignmentRight



center : Alignment
center =
    AlignmentCenter



left : Alignment
left =
    AlignmentLeft



justify : Alignment
justify =
    AlignmentJustify




```

Accepts a list of Overflow modifiers and modifies the block accordingly.
- [textOverflowEllipsis](#textoverflowellipsis)

### **textOverflowEllipsis**
```elm
textOverflowEllipsis : Modifier BlockDetails

```

Modifies the block to give an text-overflow ellipsis.

## Dimensions
- [dimensions](#dimensions)

### **dimensions**
```elm
dimensions : Maybe Dimensions
    }



defaultBlockDetails : BlockDetails
defaultBlockDetails =
    BlockDetails Nothing Nothing Nothing Nothing Nothing



type ListStyleType
    = ListStyleTypeNone
    | ListStyleTypeDisc
    | ListStyleTypeCircle
    | ListStyleTypeSquare
    | ListStyleTypeDecimal
    | ListStyleTypeGeorgian


listStyleType : ListStyleType -> Modifier BlockDetails
listStyleType =
    setListStyleType << Just



listStyleNone : Modifier BlockDetails
listStyleNone =
    listStyleType ListStyleTypeNone



listStyleDisc : Modifier BlockDetails
listStyleDisc =
    listStyleType ListStyleTypeDisc



listStyleCircle : Modifier BlockDetails
listStyleCircle =
    listStyleType ListStyleTypeCircle



listStyleSquare : Modifier BlockDetails
listStyleSquare =
    listStyleType ListStyleTypeSquare



listStyleDecimal : Modifier BlockDetails
listStyleDecimal =
    listStyleType ListStyleTypeDecimal



listStyleGeorgian : Modifier BlockDetails
listStyleGeorgian =
    listStyleType ListStyleTypeGeorgian



type Alignment
    = AlignmentCenter
    | AlignmentRight
    | AlignmentLeft
    | AlignmentJustify



alignment : Alignment -> Modifier BlockDetails
alignment =
    setAlignment << Just




```

Accepts dimensions modifiers and modifies the block accordingly.
- [fullWidth](#fullwidth)

### **fullWidth**
```elm
fullWidth : Modifier BlockDetails

```




# Compilation

- [displayBoxToCouples](#displayboxtocouples)

### **displayBoxToCouples**
```elm
displayBoxToCouples : DisplayBox -> List ( String, String )

```

Compiles a DisplayBox to the corresponding CSS list of tuples.
Handles only defined styles, ignoring `Nothing` fields.

