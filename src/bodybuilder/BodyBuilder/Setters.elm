module BodyBuilder.Setters exposing (..)


setStyleIn : { a | style : Maybe b } -> b -> { a | style : Maybe b }
setStyleIn record styleAttribute =
    { record | style = Just styleAttribute }


setStandard : b -> { a | standard : Maybe b } -> { a | standard : Maybe b }
setStandard styleElegant record =
    { record | standard = Just styleElegant }


setStandardIn : { a | standard : Maybe b } -> b -> { a | standard : Maybe b }
setStandardIn record styleElegant =
    setStandard styleElegant record


setFocus : b -> { a | focus : Maybe b } -> { a | focus : Maybe b }
setFocus styleElegant record =
    { record | focus = Just styleElegant }


setHover : b -> { a | hover : Maybe b } -> { a | hover : Maybe b }
setHover styleElegant record =
    { record | hover = Just styleElegant }


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
