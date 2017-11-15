# Grid

- [align](#align)

### **align**
```elm
align : Grid.Align -> Helpers.Shared.Modifier { a | align : Maybe Grid.Align }
```


- [alignItems](#alignitems)

### **alignItems**
```elm
alignItems : Grid.AlignItems -> Helpers.Shared.Modifier Grid.GridContainerCoordinate
```


- [alignItemsToCouple](#alignitemstocouple)

### **alignItemsToCouple**
```elm
alignItemsToCouple : String -> Grid.AlignItems -> ( String, String )
```


- [alignSelfToCouple](#alignselftocouple)

### **alignSelfToCouple**
```elm
alignSelfToCouple : String -> Grid.Align -> ( String, String )
```


- [alignToCouple](#aligntocouple)

### **alignToCouple**
```elm
alignToCouple : String -> Grid.Align -> ( String, String )
```


- [alignToString](#aligntostring)

### **alignToString**
```elm
alignToString : Grid.Align -> String
```


- [alignWrapper](#alignwrapper)

### **alignWrapper**
```elm
alignWrapper : Grid.Align -> Grid.AlignItems
```


- [auto](#auto)

### **auto**
```elm
auto : Grid.ValType
```


- [autofill](#autofill)

### **autofill**
```elm
autofill : Grid.RepeatOption
```


- [autofit](#autofit)

### **autofit**
```elm
autofit : Grid.RepeatOption
```


- [center](#center)

### **center**
```elm
center : Grid.Align
```


- [columns](#columns)

### **columns**
```elm
columns : Helpers.Shared.Modifiers Grid.GridContainerCoordinate -> Helpers.Shared.Modifier Grid.GridContainerDetails
```


- [end](#end)

### **end**
```elm
end : Grid.Align
```


- [fitContent](#fitcontent)

### **fitContent**
```elm
fitContent : Grid.ValType -> Grid.Repeatable
```


- [fractionOfAvailableSpace](#fractionofavailablespace)

### **fractionOfAvailableSpace**
```elm
fractionOfAvailableSpace : Int -> Grid.ValType
```


- [gap](#gap)

### **gap**
```elm
gap : Helpers.Shared.SizeUnit -> Helpers.Shared.Modifier Grid.GridContainerCoordinate
```


- [gridContainerCoordinateToCouples](#gridcontainercoordinatetocouples)

### **gridContainerCoordinateToCouples**
```elm
gridContainerCoordinateToCouples : String -> String -> Grid.GridContainerCoordinate -> List ( String, String )
```


- [gridContainerDetailsToCouples](#gridcontainerdetailstocouples)

### **gridContainerDetailsToCouples**
```elm
gridContainerDetailsToCouples : Grid.GridContainerDetails -> List ( String, String )
```


- [gridItemCoordinateToCouples](#griditemcoordinatetocouples)

### **gridItemCoordinateToCouples**
```elm
gridItemCoordinateToCouples : String -> String -> Grid.GridItemCoordinate -> List ( String, String )
```


- [gridItemDetailsToCouples](#griditemdetailstocouples)

### **gridItemDetailsToCouples**
```elm
gridItemDetailsToCouples : Grid.GridItemDetails -> List ( String, String )
```


- [gutterToCouple](#guttertocouple)

### **gutterToCouple**
```elm
gutterToCouple : String -> Helpers.Shared.SizeUnit -> ( String, String )
```


- [horizontal](#horizontal)

### **horizontal**
```elm
horizontal : Helpers.Shared.Modifiers Grid.GridItemCoordinate -> Helpers.Shared.Modifier Grid.GridItemDetails
```


- [maxContent](#maxcontent)

### **maxContent**
```elm
maxContent : Grid.ValType
```


- [minContent](#mincontent)

### **minContent**
```elm
minContent : Grid.ValType
```


- [minmax](#minmax)

### **minmax**
```elm
minmax : Grid.ValType -> Grid.ValType -> Grid.Repeatable
```


- [placement](#placement)

### **placement**
```elm
placement : Int -> Helpers.Shared.Modifier Grid.GridItemCoordinate
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
size : Grid.GridItemSize -> Helpers.Shared.Modifier Grid.GridItemCoordinate
```


- [sizeToCouple](#sizetocouple)

### **sizeToCouple**
```elm
sizeToCouple : String -> Grid.GridItemSize -> ( String, String )
```


- [sizeToString](#sizetostring)

### **sizeToString**
```elm
sizeToString : Grid.GridItemSize -> String
```


- [repeat](#repeat)

### **repeat**
```elm
repeat : Grid.RepeatOption -> List Helpers.Shared.SizeUnit -> Grid.Repeatable
```


- [repeatOptionToString](#repeatoptiontostring)

### **repeatOptionToString**
```elm
repeatOptionToString : Grid.RepeatOption -> String
```


- [repeatableToString](#repeatabletostring)

### **repeatableToString**
```elm
repeatableToString : Grid.Repeatable -> String
```


- [rows](#rows)

### **rows**
```elm
rows : Helpers.Shared.Modifiers Grid.GridContainerCoordinate -> Helpers.Shared.Modifier Grid.GridContainerDetails
```


- [simple](#simple)

### **simple**
```elm
simple : Grid.ValType -> Grid.Repeatable
```


- [sizeUnitVal](#sizeunitval)

### **sizeUnitVal**
```elm
sizeUnitVal : Helpers.Shared.SizeUnit -> Grid.ValType
```


- [spaceAround](#spacearound)

### **spaceAround**
```elm
spaceAround : Grid.AlignItems
```


- [spaceBetween](#spacebetween)

### **spaceBetween**
```elm
spaceBetween : Grid.AlignItems
```


- [spaceEvenly](#spaceevenly)

### **spaceEvenly**
```elm
spaceEvenly : Grid.AlignItems
```


- [spacingToString](#spacingtostring)

### **spacingToString**
```elm
spacingToString : Grid.Spacing -> String
```


- [span](#span)

### **span**
```elm
span : Int -> Grid.GridItemSize
```


- [start](#start)

### **start**
```elm
start : Grid.Align
```


- [stretch](#stretch)

### **stretch**
```elm
stretch : Grid.Align
```


- [template](#template)

### **template**
```elm
template : List Grid.Repeatable -> Helpers.Shared.Modifier Grid.GridContainerCoordinate
```


- [templateToCouple](#templatetocouple)

### **templateToCouple**
```elm
templateToCouple : String -> Grid.GridTemplate -> ( String, String )
```


- [untilEndOfCoordinate](#untilendofcoordinate)

### **untilEndOfCoordinate**
```elm
untilEndOfCoordinate : Grid.GridItemSize
```


- [valTypeToString](#valtypetostring)

### **valTypeToString**
```elm
valTypeToString : Grid.ValType -> String
```


- [vertical](#vertical)

### **vertical**
```elm
vertical : Helpers.Shared.Modifiers Grid.GridItemCoordinate -> Helpers.Shared.Modifier Grid.GridItemDetails
```


- [viewWidth](#viewwidth)

### **viewWidth**
```elm
viewWidth : Int -> Grid.ValType
```


- [GridItemDetails](#griditemdetails)

### **type alias GridItemDetails**
```elm
type alias GridItemDetails  =  
    { x : Maybe Grid.GridItemCoordinate , y : Maybe Grid.GridItemCoordinate }
```


- [GridItemCoordinate](#griditemcoordinate)

### **type alias GridItemCoordinate**
```elm
type alias GridItemCoordinate  =  
    { placement : Maybe Int , size : Maybe Grid.GridItemSize , align : Maybe Grid.Align }
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
    List Grid.Repeatable
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



