module BodyBuilder.Setters exposing (..)


setBoxIn : { a | box : b } -> b -> { a | box : b }
setBoxIn record boxAttribute =
    { record | box = boxAttribute }


setClick : b -> { a | click : Maybe b } -> { a | click : Maybe b }
setClick click record =
    { record | click = Just click }


setDoubleClick : b -> { a | doubleClick : Maybe b } -> { a | doubleClick : Maybe b }
setDoubleClick click record =
    { record | doubleClick = Just click }


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
