module BodyBuilder.Setters exposing (..)


setBox : b -> { a | box : List b } -> { a | box : List b }
setBox =
    flip setBoxIn


setBoxIn : { a | box : List b } -> b -> { a | box : List b }
setBoxIn ({ box } as record) boxAttribute =
    { record | box = boxAttribute :: box }


setBlock : b -> { a | block : List b } -> { a | block : List b }
setBlock =
    flip setBlockIn


setBlockIn : { a | block : List b } -> b -> { a | block : List b }
setBlockIn ({ block } as record) blockAttribute =
    { record | block = blockAttribute :: block }


setMaybeBlock : b -> { a | block : Maybe (List b) } -> { a | block : Maybe (List b) }
setMaybeBlock =
    flip setMaybeBlockIn


setMaybeBlockIn : { a | block : Maybe (List b) } -> b -> { a | block : Maybe (List b) }
setMaybeBlockIn ({ block } as record) blockAttribute =
    { record
        | block =
            case block of
                Nothing ->
                    Just [ blockAttribute ]

                Just modifiers ->
                    Just (blockAttribute :: modifiers)
    }


setFlexContainerProperties : c -> { b | flexContainerProperties : List c } -> { b | flexContainerProperties : List c }
setFlexContainerProperties =
    flip setFlexContainerPropertiesIn


setFlexContainerPropertiesIn : { b | flexContainerProperties : List c } -> c -> { b | flexContainerProperties : List c }
setFlexContainerPropertiesIn ({ flexContainerProperties } as record) flexContainerAttribute =
    { record | flexContainerProperties = flexContainerAttribute :: flexContainerProperties }


setFlexItemProperties : c -> { b | flexItemProperties : List c } -> { b | flexItemProperties : List c }
setFlexItemProperties =
    flip setFlexItemPropertiesIn


setFlexItemPropertiesIn : { b | flexItemProperties : List c } -> c -> { b | flexItemProperties : List c }
setFlexItemPropertiesIn ({ flexItemProperties } as record) flexItemAttribute =
    { record | flexItemProperties = flexItemAttribute :: flexItemProperties }


setGridContainerProperties : c -> { b | gridContainerProperties : List c } -> { b | gridContainerProperties : List c }
setGridContainerProperties =
    flip setGridContainerPropertiesIn


setGridContainerPropertiesIn : { b | gridContainerProperties : List c } -> c -> { b | gridContainerProperties : List c }
setGridContainerPropertiesIn ({ gridContainerProperties } as record) gridContainerAttribute =
    { record | gridContainerProperties = gridContainerAttribute :: gridContainerProperties }


setGridItemProperties : c -> { b | gridItemProperties : List c } -> { b | gridItemProperties : List c }
setGridItemProperties =
    flip setGridItemPropertiesIn


setGridItemPropertiesIn : { b | gridItemProperties : List c } -> c -> { b | gridItemProperties : List c }
setGridItemPropertiesIn ({ gridItemProperties } as record) gridItemAttribute =
    { record | gridItemProperties = gridItemAttribute :: gridItemProperties }


setStyleIn : { a | style : b } -> b -> { a | style : b }
setStyleIn record styleAttribute =
    { record | style = styleAttribute }


setClick : b -> { a | click : Maybe b } -> { a | click : Maybe b }
setClick click record =
    { record | click = Just click }


setDoubleClick : b -> { a | doubleClick : Maybe b } -> { a | doubleClick : Maybe b }
setDoubleClick click record =
    { record | doubleClick = Just click }


setContextMenu : b -> { a | contextMenu : Maybe b } -> { a | contextMenu : Maybe b }
setContextMenu contextMenu record =
    { record | contextMenu = Just contextMenu }


setOnMouseUp : b -> { a | mouseUp : Maybe b } -> { a | mouseUp : Maybe b }
setOnMouseUp mouseUp record =
    { record | mouseUp = Just mouseUp }


setOnMouseOut : b -> { a | mouseOut : Maybe b } -> { a | mouseOut : Maybe b }
setOnMouseOut mouseOut record =
    { record | mouseOut = Just mouseOut }


setOnMouseOver : b -> { a | mouseOver : Maybe b } -> { a | mouseOver : Maybe b }
setOnMouseOver mouseOver record =
    { record | mouseOver = Just mouseOver }


setOnMouseDown : b -> { a | mouseDown : Maybe b } -> { a | mouseDown : Maybe b }
setOnMouseDown mouseDown record =
    { record | mouseDown = Just mouseDown }


setOnMouseLeave : b -> { a | mouseLeave : Maybe b } -> { a | mouseLeave : Maybe b }
setOnMouseLeave mouseLeave record =
    { record | mouseLeave = Just mouseLeave }


setOnMouseEnter : b -> { a | mouseEnter : Maybe b } -> { a | mouseEnter : Maybe b }
setOnMouseEnter mouseEnter record =
    { record | mouseEnter = Just mouseEnter }


setOnMouseEventsIn : { a | onMouseEvents : Maybe b } -> b -> { a | onMouseEvents : Maybe b }
setOnMouseEventsIn record onMouseEvents =
    { record | onMouseEvents = Just onMouseEvents }


setFlexContainer : a -> { b | flexContainer : Maybe a } -> { b | flexContainer : Maybe a }
setFlexContainer modifiers ({ flexContainer } as record) =
    { record | flexContainer = Just modifiers }


setFlexItem : a -> { b | flexItem : Maybe a } -> { b | flexItem : Maybe a }
setFlexItem modifiers ({ flexItem } as record) =
    { record | flexItem = Just modifiers }


setGridContainer : a -> { b | gridContainer : Maybe a } -> { b | gridContainer : Maybe a }
setGridContainer modifiers ({ gridContainer } as record) =
    { record | gridContainer = Just modifiers }


setGridItem : a -> { b | gridItem : Maybe a } -> { b | gridItem : Maybe a }
setGridItem modifiers ({ gridItem } as record) =
    { record | gridItem = Just modifiers }


setMediaBlock : a -> { b | block : Maybe a } -> { b | block : Maybe a }
setMediaBlock modifiers ({ block } as record) =
    { record | block = Just modifiers }


setMediaBox : a -> { b | box : Maybe a } -> { b | box : Maybe a }
setMediaBox modifiers ({ box } as record) =
    { record | box = Just modifiers }


setTitle : b -> { a | title : Maybe b } -> { a | title : Maybe b }
setTitle val attrs =
    { attrs | title = Just val }


setTabIndex : b -> { a | tabindex : Maybe b } -> { a | tabindex : Maybe b }
setTabIndex val attrs =
    { attrs | tabindex = Just val }


setId : b -> { a | id : Maybe b } -> { a | id : Maybe b }
setId val attrs =
    { attrs | id = Just val }


setClass : List b -> { a | class : List b } -> { a | class : List b }
setClass val attrs =
    { attrs | class = val }


setValue : a -> { c | value : Maybe a } -> { c | value : Maybe a }
setValue val attrs =
    { attrs | value = Just val }


setDisabled : a -> { c | disabled : a } -> { c | disabled : a }
setDisabled val attrs =
    { attrs | disabled = val }


setTarget : a -> { c | target : Maybe a } -> { c | target : Maybe a }
setTarget val attrs =
    { attrs | target = Just val }


setHref : a -> { c | href : Maybe a } -> { c | href : Maybe a }
setHref val attrs =
    { attrs | href = Just val }


setName : a -> { c | name : Maybe a } -> { c | name : Maybe a }
setName val attrs =
    { attrs | name = Just val }


setWidth : a -> { c | width : Maybe a } -> { c | width : Maybe a }
setWidth val attrs =
    { attrs | width = Just val }


setHeight : a -> { c | height : Maybe a } -> { c | height : Maybe a }
setHeight val attrs =
    { attrs | height = Just val }


setAutocomplete : a -> { c | autocomplete : a } -> { c | autocomplete : a }
setAutocomplete val attrs =
    { attrs | autocomplete = val }


setPlaceholder : a -> { c | placeholder : Maybe a } -> { c | placeholder : Maybe a }
setPlaceholder val attrs =
    { attrs | placeholder = Just val }


setStep : a -> { c | step : Maybe a } -> { c | step : Maybe a }
setStep val attrs =
    { attrs | step = Just val }


setMax : a -> { c | max : Maybe a } -> { c | max : Maybe a }
setMax val attrs =
    { attrs | max = Just val }


setMin : a -> { c | min : Maybe a } -> { c | min : Maybe a }
setMin val attrs =
    { attrs | min = Just val }


setChecked : a -> { c | checked : a } -> { c | checked : a }
setChecked val attrs =
    { attrs | checked = val }
