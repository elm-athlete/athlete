# Router

Router based on BodyBuilder and Elegant implementing transitions between
pages and history (backward and forward)

- [History](#history)

### **type alias History**
```elm
type alias History route =  
    { before : List (Router.Page route) , current : Router.Page route , after : List (Router.Page route) , transition : Maybe Router.Transition }
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
type alias Page customRoute =  
    { maybeTransition : Maybe Router.Transition , route : customRoute }
```

Page type handling transition
- [Transition](#transition)

### **type alias Transition**
```elm
type alias Transition  =  
    { timer : Float , length : Float , kind : Router.Kind , direction : Router.Direction , easing : Router.Easing }
```

Transition between 2 pages

- [handleStandardHistory](#handlestandardhistory)

### **handleStandardHistory**
```elm
handleStandardHistory : Router.StandardHistoryMsg -> { a | history : Router.History route } -> ( { a | history : Router.History route }, Platform.Cmd.Cmd msg )
```

handle model's history update using historyMsg
- [maybeTransitionSubscription](#maybetransitionsubscription)

### **maybeTransitionSubscription**
```elm
maybeTransitionSubscription : (Router.StandardHistoryMsg -> msg) -> Maybe a -> Platform.Sub.Sub msg
```

maybe transition subscription
- [initHistoryAndData](#inithistoryanddata)

### **initHistoryAndData**
```elm
initHistoryAndData : route -> data -> { history : Router.History route, data : data }
```

initialize history and data based on the routing system
- [push](#push)

### **push**
```elm
push : Router.Page route -> Router.History route -> Router.History route
```

push a page into history
- [slideUp](#slideup)

### **slideUp**
```elm
slideUp : Router.Transition
```

slideUp transition
- [pageWithDefaultTransition](#pagewithdefaulttransition)

### **pageWithDefaultTransition**
```elm
pageWithDefaultTransition : route -> Router.Page route
```

creates a page with the defaultTransition
- [pageWithTransition](#pagewithtransition)

### **pageWithTransition**
```elm
pageWithTransition : Router.Transition -> route -> Router.Page route
```

creates a page with a custom transition
- [pageWithoutTransition](#pagewithouttransition)

### **pageWithoutTransition**
```elm
pageWithoutTransition : route -> Router.Page route
```

creates a page without any transition

- [headerElement](#headerelement)

### **headerElement**
```elm
headerElement : { a | center : BodyBuilder.Node msg, left : BodyBuilder.Node msg, right : BodyBuilder.Node msg } -> BodyBuilder.Node msg
```

display header
- [pageWithHeader](#pagewithheader)

### **pageWithHeader**
```elm
pageWithHeader : BodyBuilder.Node msg -> BodyBuilder.Node msg -> BodyBuilder.Node msg
```


- [headerButton](#headerbutton)

### **headerButton**
```elm
headerButton : msg -> String -> BodyBuilder.Node msg
```

display button
- [historyView](#historyview)

### **historyView**
```elm
historyView : (Router.Page route -> data -> Maybe Router.Transition -> BodyBuilder.Node msg) -> Router.History route -> data -> BodyBuilder.Node msg
```

display the current possible transition from one page to the other using
the history and its own routing system

