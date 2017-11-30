# Router

Router based on BodyBuilder and Elegant implementing transitions between
pages and history (backward and forward)

- [History](#history)

### **type alias History**
```elm
type alias History route msg =
    { before : List (Page route msg)
    , current : Page route msg
    , after : List (Page route msg)
    , transition : Maybe (Transition route msg)
    , currentPageHasFocusElement : Bool
    , standardHistoryWrapper : StandardHistoryMsg -> msg
    }
```

Generic History type handling current page, before pages, after pages
and current transition
- [StandardHistoryMsg](#standardhistorymsg)

### **type StandardHistoryMsg**
```elm
type StandardHistoryMsg   
    = Back 
```

Standard History Messages type :
Tick to handle transitions with RequestAnimationFrame
Back to handle back buttons
- [Page](#page)

### **type alias Page**
```elm
type alias Page route msg =
    { maybeFocusedId : Maybe String
    , maybeTransition : Maybe (Transition route msg)
    , route : route
    }
```

Page type handling transition
- [Transition](#transition)

### **type alias Transition**
```elm
type alias Transition route msg =
    { timer : Float
    , length : Float
    , kind : Kind route msg
    , direction : Direction
    , easing : Easing
    }
```

Transition between 2 pages
- [PageView](#pageview)

### **type alias PageView**
```elm
type alias PageView route msg =
    Page route msg
    -> Maybe (Transition route msg)
    -> Node msg


type Direction
    = Forward
    | Backward



forward : Direction
forward =
    Forward



easeInOut : Easing
easeInOut =
    EaseInOut



type StandardHistoryMsg
    = Tick Time
    | Back
    | FocusMsg (Result Dom.Error ())


easingFun : Easing -> Float -> Float
easingFun easing =
    case easing of
        EaseInOut ->
            easeInOutFun

        Linear ->
            identity


easeInOutFun : Float -> Float
easeInOutFun t =
    if t < 0.5 then
        2 * t * t
    else
        -1 + (4 - 2 * t) * t



getMaybeTransitionValue : Maybe (Transition route msg) -> Float
getMaybeTransitionValue maybeTransition =
    case maybeTransition of
        Nothing ->
            0

        Just transition ->
            transition |> getTransitionValue


getTransitionValue : Transition route msg -> Float
getTransitionValue { direction, timer, length, easing }
```



- [handleStandardHistory](#handlestandardhistory)

### **handleStandardHistory**
```elm
handleStandardHistory : StandardHistoryMsg -> { a | history : History route msg } -> ( { a | history : History route msg }, Cmd msg )

```

handle model's history update using historyMsg
- [maybeTransitionSubscription](#maybetransitionsubscription)

### **maybeTransitionSubscription**
```elm
maybeTransitionSubscription : History route msg -> Sub msg

```

maybe transition subscription
- [initHistoryAndData](#inithistoryanddata)

### **initHistoryAndData**
```elm
initHistoryAndData : route -> data -> (StandardHistoryMsg -> msg) -> { history : History route msg, data : data }

```

initialize history and data based on the routing system
- [push](#push)

### **push**
```elm
push : Page route msg -> History route msg -> History route msg

```

push a page into history
- [slideUp](#slideup)

### **slideUp**
```elm
slideUp : Transition route msg

```

slideUp transition
- [forward](#forward)

### **forward**
```elm
forward : Direction

```


- [pageWithDefaultTransition](#pagewithdefaulttransition)

### **pageWithDefaultTransition**
```elm
pageWithDefaultTransition : route -> Page route msg

```

creates a page with the defaultTransition
- [pageWithTransition](#pagewithtransition)

### **pageWithTransition**
```elm
pageWithTransition : Transition route msg -> route -> Page route msg

```

creates a page with a custom transition
- [pageWithoutTransition](#pagewithouttransition)

### **pageWithoutTransition**
```elm
pageWithoutTransition : route -> Page route msg

```

creates a page without any transition
- [customTransition](#customtransition)

### **customTransition**
```elm
customTransition : Float -> Kind route msg -> Direction -> Easing -> Transition route msg

```


- [easeInOut](#easeinout)

### **easeInOut**
```elm
easeInOut : Easing

```


- [customKind](#customkind)

### **customKind**
```elm
customKind : (History route msg -> (Page route msg -> Maybe (Transition route msg) -> Node msg) -> Node msg) -> Kind route msg

```


- [overflowHiddenContainer](#overflowhiddencontainer)

### **overflowHiddenContainer**
```elm
overflowHiddenContainer : 
    Modifiers (Attributes.FlexContainerAttributes msg)
    -> List (FlexItem msg)
    -> Node msg

```


- [pageView](#pageview-1)

### **pageView**
```elm
pageView : 
    (a -> Maybe (Transition route msg) -> Node msg)
    -> Maybe (Transition route msg)
    -> a
    -> Node msg

```


- [beforeTransition](#beforetransition)

### **beforeTransition**
```elm
beforeTransition : History route msg -> List (Page route msg)

```


- [percentage](#percentage)

### **percentage**
```elm
percentage : Float -> Float

```


- [getMaybeTransitionValue](#getmaybetransitionvalue)

### **getMaybeTransitionValue**
```elm
getMaybeTransitionValue : Maybe (Transition route msg) -> Float

```


- [afterTransition](#aftertransition)

### **afterTransition**
```elm
afterTransition : History route msg -> List (Page route msg)

```


- [visiblePages](#visiblepages)

### **visiblePages**
```elm
visiblePages : History route msg -> List (Page route msg)

```


- [focusedElement](#focusedelement)

### **focusedElement**
```elm
focusedElement : String -> Page route msg -> Page route msg

```



- [headerElement](#headerelement)

### **headerElement**
```elm
headerElement : 
    { a | center : Node msg, left : Node msg, right : Node msg }
    -> Node msg

```

display header
- [pageWithHeader](#pagewithheader)

### **pageWithHeader**
```elm
pageWithHeader : Node msg -> Node msg -> Node msg

```


- [headerButton](#headerbutton)

### **headerButton**
```elm
headerButton : msg -> String -> Node msg

```

display button
- [historyView](#historyview)

### **historyView**
```elm
historyView : 
    (Page route msg -> Maybe (Transition route msg) -> Node msg)
    -> History route msg
    -> Node msg

```

display the current possible transition from one page to the other using
the history and its own routing system

