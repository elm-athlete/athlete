# Typography

Typography contains everything about fonts and characters rendering.


# Types

- [Typography](#typography)

### **type alias Typography**
```elm
type alias Typography  =  
    { character : Maybe Character , capitalization : Maybe Typography.Capitalization , decoration : Maybe Typography.Decoration , color : Maybe Color , whiteSpaceWrap : Maybe Typography.WhiteSpaceWrap , userSelect : Maybe Typography.UserSelect , lineHeight : Maybe (Either Helpers.Shared.SizeUnit Typography.Normal) }
```

The `Typography` record contains everything about fonts rendering,
including character rendering. You probably won't use it as is, but instead using
`Box.typography` which automatically generate an empty `Typography` record. You
can then use modifiers. I.E.

```elm
Box.typography
    [ Typography.color Color.white
    , Typography.italic
    ]
```
- [Capitalization](#capitalization)

### **type Capitalization**
```elm
type Capitalization   
    = 
```

Represents the possible transformations of the text.
It can be Uppercase, Lowercase, or Capitalize. They are created by `uppercase`,
`lowercase` and `capitalize`.
- [Decoration](#decoration)

### **type Decoration**
```elm
type Decoration   
    = 
```

Represents the possible decorations of the text.
It can be None, Underline or LineThrough. They are created by `noDecoration`,
`underline` and `lineThrough`.
- [WhiteSpaceWrap](#whitespacewrap)

### **type WhiteSpaceWrap**
```elm
type WhiteSpaceWrap   
    = 
```

Represents the whitespaces management in the text.
It can be NoWrap, and created by `whiteSpaceNoWrap`.
- [UserSelect](#userselect)

### **type alias UserSelect**
```elm
type alias UserSelect  =  
    Bool
```

Represents the interaction with the user. If set to `True`, the user
can interact with the text, i.e. can select it, copy and paste. If set to
`False`, nothing can be done.
- [Normal](#normal)

### **type Normal**
```elm
type Normal   
    = 
```

Value representing the 'normal' value in `line-height`.


# Default typography

- [default](#default)

### **default**
```elm
default : Typography
```

Generate an empty `Typography` record, with every field equal to Nothing.
You are free to use it as you wish, but it is instanciated automatically by `Box.typography`.


# Typography modifiers


## Characters rendering

- [character](#character)

### **character**
```elm
character : Helpers.Shared.Modifiers Character -> Helpers.Shared.Modifier Typography
```

Modify the character rendering of the text. The characters options are in
`Typography.Character`.
It creates a default empty `Character` record, modifies it according to the
modifiers, then set the resulting `Character` in Typography.

```elm
Typography.character
    [ Typography.Character.weight 700
    , Typography.Character.italic
    ]
```


## Text Transformations

- [capitalize](#capitalize)

### **capitalize**
```elm
capitalize : Helpers.Shared.Modifier Typography
```

Capitalize the first letter in the text.
'just an example' is transformed in 'Just an example'.
- [lowercase](#lowercase)

### **lowercase**
```elm
lowercase : Helpers.Shared.Modifier Typography
```

Turn the entire text in lowercase.
'JuST an ExAMPle' is transformed in 'just an example'.
- [uppercase](#uppercase)

### **uppercase**
```elm
uppercase : Helpers.Shared.Modifier Typography
```

Turn the entire text in uppercase.
'JuST an ExAMPle' is transformed in 'JUST AN EXAMPLE'.


## Text Decorations

- [underline](#underline)

### **underline**
```elm
underline : Helpers.Shared.Modifier Typography
```

Underline the text.
- [lineThrough](#linethrough)

### **lineThrough**
```elm
lineThrough : Helpers.Shared.Modifier Typography
```

Print a line through the text.
- [noDecoration](#nodecoration)

### **noDecoration**
```elm
noDecoration : Helpers.Shared.Modifier Typography
```

Remove every decoration (underline or lineThrough) on the text.


## Whitespace Management

- [whiteSpaceNoWrap](#whitespacenowrap)

### **whiteSpaceNoWrap**
```elm
whiteSpaceNoWrap : Helpers.Shared.Modifier Typography
```

Cancel the wrapping of the text on whitespaces. It forces text to stay on one line.


## User Interactions

- [userSelect](#userselect-1)

### **userSelect**
```elm
userSelect : Bool -> Helpers.Shared.Modifier Typography
```

Allow or disallow user to interact with the text, i.e. select, copy, etc.


## Line Height

- [lineHeightNormal](#lineheightnormal)

### **lineHeightNormal**
```elm
lineHeightNormal : Helpers.Shared.Modifier Typography
```

Set the lineHeight property to respect the space defined by the User Agent of
the user's browser. It usually is 1.2em, but can vary.
- [lineHeight](#lineheight)

### **lineHeight**
```elm
lineHeight : Helpers.Shared.SizeUnit -> Helpers.Shared.Modifier Typography
```

Set the lineHeight to the desired value. Can be px, pt, vh, em or rem.


# Shortcuts

- [fontSize](#fontsize)

### **fontSize**
```elm
fontSize : Helpers.Shared.SizeUnit -> Helpers.Shared.Modifier Typography
```


- [bold](#bold)

### **bold**
```elm
bold : Helpers.Shared.Modifier Typography
```




# Compilation

- [typographyToCouples](#typographytocouples)

### **typographyToCouples**
```elm
typographyToCouples : Typography -> List ( String, String )
```

Compiles a `Typography` record to the corresponding CSS list of tuples.
Compiles only styles which are defined, ignoring `Nothing` fields.

