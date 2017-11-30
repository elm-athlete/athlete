# Grid

- [align](#align)

### **align**
```elm
align : Maybe Align
    , 
```


- [alignItems](#alignitems)

### **alignItems**
```elm
alignItems : Maybe AlignItems
    , template : Maybe GridTemplate
    }



type GridItemSize
    = UntilEndOfCoordinate
    | Span Int



untilEndOfCoordinate : GridItemSize
untilEndOfCoordinate =
    UntilEndOfCoordinate



span : Int -> GridItemSize
span =
    Span



type alias GridItemCoordinate =
    { placement : Maybe Int
    , size : Maybe GridItemSize
    , align : Maybe Align
    }



type alias GridContainerDetails =
    { x : Maybe GridContainerCoordinate
    , y : Maybe GridContainerCoordinate
    }



type alias GridItemDetails =
    { x : Maybe GridItemCoordinate
    , y : Maybe GridItemCoordinate
    }



columns : Modifiers GridContainerCoordinate -> Modifier GridContainerDetails
columns modifiers gridContainerDetails =
    { gridContainerDetails | x = modifiedElementOrNothing (GridContainerCoordinate Nothing Nothing Nothing Nothing) modifiers }



rows : Modifiers GridContainerCoordinate -> Modifier GridContainerDetails
rows modifiers gridContainerDetails =
    { gridContainerDetails | y = modifiedElementOrNothing (GridContainerCoordinate Nothing Nothing Nothing Nothing) modifiers }



horizontal : Modifiers GridItemCoordinate -> Modifier GridItemDetails
horizontal modifiers gridItemDetails =
    { gridItemDetails | x = modifiedElementOrNothing (GridItemCoordinate Nothing Nothing Nothing) modifiers }



vertical : Modifiers GridItemCoordinate -> Modifier GridItemDetails
vertical modifiers gridItemDetails =
    { gridItemDetails | y = modifiedElementOrNothing (GridItemCoordinate Nothing Nothing Nothing) modifiers }



template : List Repeatable -> Modifier GridContainerCoordinate
template repeatable gridContainerCoordinate =
    { gridContainerCoordinate | template = Just repeatable }



gap : SizeUnit -> Modifier GridContainerCoordinate
gap value gridContainerCoordinate =
    { gridContainerCoordinate | gutter = Just value }



align : Align -> Modifier { a | align : Maybe Align }
align value gridContainerCoordinate =
    { gridContainerCoordinate | align = Just value }




```


- [alignItemsToCouple](#alignitemstocouple)

### **alignItemsToCouple**
```elm
alignItemsToCouple : String -> AlignItems -> ( String, String )

```


- [alignSelfToCouple](#alignselftocouple)

### **alignSelfToCouple**
```elm
alignSelfToCouple : String -> Align -> ( String, String )

```


- [alignToCouple](#aligntocouple)

### **alignToCouple**
```elm
alignToCouple : String -> Align -> ( String, String )

```


- [alignToString](#aligntostring)

### **alignToString**
```elm
alignToString : Align -> String

```


- [alignWrapper](#alignwrapper)

### **alignWrapper**
```elm
alignWrapper : Align -> AlignItems

```


- [auto](#auto)

### **auto**
```elm
auto : ValType

```


- [autofill](#autofill)

### **autofill**
```elm
autofill : RepeatOption

```


- [autofit](#autofit)

### **autofit**
```elm
autofit : RepeatOption

```


- [center](#center)

### **center**
```elm
center : Align

```


- [columns](#columns)

### **columns**
```elm
columns : Modifiers GridContainerCoordinate -> Modifier GridContainerDetails

```


- [end](#end)

### **end**
```elm
end : Align

```


- [fitContent](#fitcontent)

### **fitContent**
```elm
fitContent : ValType -> Repeatable

```


- [fractionOfAvailableSpace](#fractionofavailablespace)

### **fractionOfAvailableSpace**
```elm
fractionOfAvailableSpace : Int -> ValType

```


- [gap](#gap)

### **gap**
```elm
gap : SizeUnit -> Modifier GridContainerCoordinate

```


- [gridContainerCoordinateToCouples](#gridcontainercoordinatetocouples)

### **gridContainerCoordinateToCouples**
```elm
gridContainerCoordinateToCouples : String -> String -> GridContainerCoordinate -> List ( String, String )

```


- [gridContainerDetailsToCouples](#gridcontainerdetailstocouples)

### **gridContainerDetailsToCouples**
```elm
gridContainerDetailsToCouples : GridContainerDetails -> List ( String, String )

```


- [gridItemCoordinateToCouples](#griditemcoordinatetocouples)

### **gridItemCoordinateToCouples**
```elm
gridItemCoordinateToCouples : String -> String -> GridItemCoordinate -> List ( String, String )

```


- [gridItemDetailsToCouples](#griditemdetailstocouples)

### **gridItemDetailsToCouples**
```elm
gridItemDetailsToCouples : GridItemDetails -> List ( String, String )

```


- [gutterToCouple](#guttertocouple)

### **gutterToCouple**
```elm
gutterToCouple : String -> SizeUnit -> ( String, String )

```


- [horizontal](#horizontal)

### **horizontal**
```elm
horizontal : Modifiers GridItemCoordinate -> Modifier GridItemDetails

```


- [maxContent](#maxcontent)

### **maxContent**
```elm
maxContent : ValType

```


- [minContent](#mincontent)

### **minContent**
```elm
minContent : ValType

```


- [minmax](#minmax)

### **minmax**
```elm
minmax : ValType -> ValType -> Repeatable

```


- [placement](#placement)

### **placement**
```elm
placement : Maybe Int
    , size : Maybe GridItemSize
    , align : Maybe Align
    }



type alias GridContainerDetails =
    { x : Maybe GridContainerCoordinate
    , y : Maybe GridContainerCoordinate
    }



type alias GridItemDetails =
    { x : Maybe GridItemCoordinate
    , y : Maybe GridItemCoordinate
    }



columns : Modifiers GridContainerCoordinate -> Modifier GridContainerDetails
columns modifiers gridContainerDetails =
    { gridContainerDetails | x = modifiedElementOrNothing (GridContainerCoordinate Nothing Nothing Nothing Nothing) modifiers }



rows : Modifiers GridContainerCoordinate -> Modifier GridContainerDetails
rows modifiers gridContainerDetails =
    { gridContainerDetails | y = modifiedElementOrNothing (GridContainerCoordinate Nothing Nothing Nothing Nothing) modifiers }



horizontal : Modifiers GridItemCoordinate -> Modifier GridItemDetails
horizontal modifiers gridItemDetails =
    { gridItemDetails | x = modifiedElementOrNothing (GridItemCoordinate Nothing Nothing Nothing) modifiers }



vertical : Modifiers GridItemCoordinate -> Modifier GridItemDetails
vertical modifiers gridItemDetails =
    { gridItemDetails | y = modifiedElementOrNothing (GridItemCoordinate Nothing Nothing Nothing) modifiers }



template : List Repeatable -> Modifier GridContainerCoordinate
template repeatable gridContainerCoordinate =
    { gridContainerCoordinate | template = Just repeatable }



gap : SizeUnit -> Modifier GridContainerCoordinate
gap value gridContainerCoordinate =
    { gridContainerCoordinate | gutter = Just value }



align : Align -> Modifier { a | align : Maybe Align }
align value gridContainerCoordinate =
    { gridContainerCoordinate | align = Just value }



alignItems : AlignItems -> Modifier GridContainerCoordinate
alignItems value gridContainerCoordinate =
    { gridContainerCoordinate | alignItems = Just value }



alignWrapper : Align -> AlignItems
alignWrapper =
    AlignWrapper



spaceAround : AlignItems
spaceAround =
    Space Around



spaceBetween : AlignItems
spaceBetween =
    Space Between



spaceEvenly : AlignItems
spaceEvenly =
    Space Evenly




```


- [placementToCouple](#placementtocouple)

### **placementToCouple**
```elm
placementToCouple : String -> Int -> ( String, String )

```


- [placementToString](#placementtostring)

### **placementToString**
```elm
placementToString : Int -> String

```


- [size](#size)

### **size**
```elm
size : Maybe GridItemSize
    , align : Maybe Align
    }



type alias GridContainerDetails =
    { x : Maybe GridContainerCoordinate
    , y : Maybe GridContainerCoordinate
    }



type alias GridItemDetails =
    { x : Maybe GridItemCoordinate
    , y : Maybe GridItemCoordinate
    }



columns : Modifiers GridContainerCoordinate -> Modifier GridContainerDetails
columns modifiers gridContainerDetails =
    { gridContainerDetails | x = modifiedElementOrNothing (GridContainerCoordinate Nothing Nothing Nothing Nothing) modifiers }



rows : Modifiers GridContainerCoordinate -> Modifier GridContainerDetails
rows modifiers gridContainerDetails =
    { gridContainerDetails | y = modifiedElementOrNothing (GridContainerCoordinate Nothing Nothing Nothing Nothing) modifiers }



horizontal : Modifiers GridItemCoordinate -> Modifier GridItemDetails
horizontal modifiers gridItemDetails =
    { gridItemDetails | x = modifiedElementOrNothing (GridItemCoordinate Nothing Nothing Nothing) modifiers }



vertical : Modifiers GridItemCoordinate -> Modifier GridItemDetails
vertical modifiers gridItemDetails =
    { gridItemDetails | y = modifiedElementOrNothing (GridItemCoordinate Nothing Nothing Nothing) modifiers }



template : List Repeatable -> Modifier GridContainerCoordinate
template repeatable gridContainerCoordinate =
    { gridContainerCoordinate | template = Just repeatable }



gap : SizeUnit -> Modifier GridContainerCoordinate
gap value gridContainerCoordinate =
    { gridContainerCoordinate | gutter = Just value }



align : Align -> Modifier { a | align : Maybe Align }
align value gridContainerCoordinate =
    { gridContainerCoordinate | align = Just value }



alignItems : AlignItems -> Modifier GridContainerCoordinate
alignItems value gridContainerCoordinate =
    { gridContainerCoordinate | alignItems = Just value }



alignWrapper : Align -> AlignItems
alignWrapper =
    AlignWrapper



spaceAround : AlignItems
spaceAround =
    Space Around



spaceBetween : AlignItems
spaceBetween =
    Space Between



spaceEvenly : AlignItems
spaceEvenly =
    Space Evenly



placement : Int -> Modifier GridItemCoordinate
placement value gridItemCoordinate =
    { gridItemCoordinate | placement = Just (value + 1) }




```


- [sizeToCouple](#sizetocouple)

### **sizeToCouple**
```elm
sizeToCouple : String -> GridItemSize -> ( String, String )

```


- [sizeToString](#sizetostring)

### **sizeToString**
```elm
sizeToString : GridItemSize -> String

```


- [repeat](#repeat)

### **repeat**
```elm
repeat : RepeatOption -> List SizeUnit -> Repeatable

```


- [repeatOptionToString](#repeatoptiontostring)

### **repeatOptionToString**
```elm
repeatOptionToString : RepeatOption -> String

```


- [repeatableToString](#repeatabletostring)

### **repeatableToString**
```elm
repeatableToString : Repeatable -> String

```


- [rows](#rows)

### **rows**
```elm
rows : Modifiers GridContainerCoordinate -> Modifier GridContainerDetails

```


- [simple](#simple)

### **simple**
```elm
simple : ValType -> Repeatable

```


- [sizeUnitVal](#sizeunitval)

### **sizeUnitVal**
```elm
sizeUnitVal : SizeUnit -> ValType

```


- [spaceAround](#spacearound)

### **spaceAround**
```elm
spaceAround : AlignItems

```


- [spaceBetween](#spacebetween)

### **spaceBetween**
```elm
spaceBetween : AlignItems

```


- [spaceEvenly](#spaceevenly)

### **spaceEvenly**
```elm
spaceEvenly : AlignItems

```


- [spacingToString](#spacingtostring)

### **spacingToString**
```elm
spacingToString : Spacing -> String

```


- [span](#span)

### **span**
```elm
span : Int -> GridItemSize

```


- [start](#start)

### **start**
```elm
start : Align

```


- [stretch](#stretch)

### **stretch**
```elm
stretch : Align

```


- [template](#template)

### **template**
```elm
template : Maybe GridTemplate
    }



type GridItemSize
    = UntilEndOfCoordinate
    | Span Int



untilEndOfCoordinate : GridItemSize
untilEndOfCoordinate =
    UntilEndOfCoordinate



span : Int -> GridItemSize
span =
    Span



type alias GridItemCoordinate =
    { placement : Maybe Int
    , size : Maybe GridItemSize
    , align : Maybe Align
    }



type alias GridContainerDetails =
    { x : Maybe GridContainerCoordinate
    , y : Maybe GridContainerCoordinate
    }



type alias GridItemDetails =
    { x : Maybe GridItemCoordinate
    , y : Maybe GridItemCoordinate
    }



columns : Modifiers GridContainerCoordinate -> Modifier GridContainerDetails
columns modifiers gridContainerDetails =
    { gridContainerDetails | x = modifiedElementOrNothing (GridContainerCoordinate Nothing Nothing Nothing Nothing) modifiers }



rows : Modifiers GridContainerCoordinate -> Modifier GridContainerDetails
rows modifiers gridContainerDetails =
    { gridContainerDetails | y = modifiedElementOrNothing (GridContainerCoordinate Nothing Nothing Nothing Nothing) modifiers }



horizontal : Modifiers GridItemCoordinate -> Modifier GridItemDetails
horizontal modifiers gridItemDetails =
    { gridItemDetails | x = modifiedElementOrNothing (GridItemCoordinate Nothing Nothing Nothing) modifiers }



vertical : Modifiers GridItemCoordinate -> Modifier GridItemDetails
vertical modifiers gridItemDetails =
    { gridItemDetails | y = modifiedElementOrNothing (GridItemCoordinate Nothing Nothing Nothing) modifiers }




```


- [templateToCouple](#templatetocouple)

### **templateToCouple**
```elm
templateToCouple : String -> GridTemplate -> ( String, String )

```


- [untilEndOfCoordinate](#untilendofcoordinate)

### **untilEndOfCoordinate**
```elm
untilEndOfCoordinate : GridItemSize

```


- [valTypeToString](#valtypetostring)

### **valTypeToString**
```elm
valTypeToString : ValType -> String

```


- [vertical](#vertical)

### **vertical**
```elm
vertical : Modifiers GridItemCoordinate -> Modifier GridItemDetails

```


- [viewWidth](#viewwidth)

### **viewWidth**
```elm
viewWidth : Int -> ValType

```


- [GridItemDetails](#griditemdetails)

### **type alias GridItemDetails**
```elm
type alias GridItemDetails  =
    { gridContainerDetails | x 
```


- [GridItemCoordinate](#griditemcoordinate)

### **type alias GridItemCoordinate**
```elm
type alias GridItemCoordinate  =
    { x : Maybe GridContainerCoordinate
    , y : Maybe GridContainerCoordinate
    }
```


- [GridContainerDetails](#gridcontainerdetails)

### **type alias GridContainerDetails**
```elm
type alias GridContainerDetails  =  
    { x : Maybe Grid.GridContainerCoordinate , y : Maybe Grid.GridContainerCoordinate }
```


- [GridContainerCoordinate](#gridcontainercoordinate)

### **type alias GridContainerCoordinate**
```elm
type alias GridContainerCoordinate  =  
    { gutter : Maybe Helpers.Shared.SizeUnit , align : Maybe Grid.Align , alignItems : Maybe Grid.AlignItems , template : Maybe Grid.GridTemplate }
```


- [GridItemSize](#griditemsize)

### **type GridItemSize**
```elm
type GridItemSize   
    = UntilEndOfCoordinate   
    | Span Int
```


- [GridTemplate](#gridtemplate)

### **type alias GridTemplate**
```elm
type alias GridTemplate  =
    { gutter : Maybe SizeUnit
    , align : Maybe Align
    , alignItems : Maybe AlignItems
    , template : Maybe GridTemplate
    }
```


- [Repeatable](#repeatable)

### **type Repeatable**
```elm
type Repeatable   
    = Simple Grid.ValType  
    | Minmax Grid.ValType Grid.ValType  
    | FitContent Grid.ValType  
    | Repeat Grid.RepeatOption List Helpers.Shared.SizeUnit
```


- [ValType](#valtype)

### **type ValType**
```elm
type ValType   
    = SizeUnitVal Helpers.Shared.SizeUnit  
    | Fr Int  
    | Vw Int  
    | MinContent   
    | MaxContent   
    | Auto 
```



