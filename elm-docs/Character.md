# Character

Character contains everything about characters rendering.


# Types

- [Character](#character)

### **type alias Character**
```elm
type alias Character  =  
    { weight : Maybe Int , tilt : Maybe Character.FontTilt , size : Maybe Helpers.Shared.SizeUnit , family : Maybe Character.FontFamily }
```

The Character record contains everything about characters rendering.
You probably won't use it as is, but instead using `Typography.character`
which automatically generate an empty `Character` record. You can then use
modifiers. I.E.

```elm
Typography.characters
    [ Typography.Character.weight 700
    , Typography.Character.size (px 30)
    ]
```
- [FontTilt](#fonttilt)

### **type FontTilt**
```elm
type FontTilt   
    = 
```

Represents the possible tilting of the characters.
It can be Normal, Italic, or Oblique. They are created by `uppercase`,
`lowercase` and `capitalize`.
- [FontFamily](#fontfamily)

### **type FontFamily**
```elm
type FontFamily   
    = 
```

Represents the possible fontFamily of the characters.
It can be Inherited from the parent, or customized.
- [CustomFontFamily](#customfontfamily)

### **type CustomFontFamily**
```elm
type CustomFontFamily   
    = 
```

Represents the font family used to render characters.
It can be a system or a custom type. They are created by `systemFont` and `customFont`.


# Default Character

- [default](#default)

### **default**
```elm
default : Character
```

Generate an empty `Character` record, with every field equal to Nothing.
You are free to use it as you wish, but it is instanciated automatically by `Typography.character`.


# Modifiers


## Weight

- [weight](#weight)

### **weight**
```elm
weight : Int -> Helpers.Shared.Modifier Character
```

Changes the weight of the characters.
Value is defined between 100 and 900 and default weight is equal to 400.


## Tilting

- [tiltNormal](#tiltnormal)

### **tiltNormal**
```elm
tiltNormal : Helpers.Shared.Modifier Character
```

Cancels any tilting of the characters.
- [italic](#italic)

### **italic**
```elm
italic : Helpers.Shared.Modifier Character
```

Renders the characters as italic.
- [oblique](#oblique)

### **oblique**
```elm
oblique : Helpers.Shared.Modifier Character
```

Renders the characters as oblique.


## Size

- [size](#size)

### **size**
```elm
size : Helpers.Shared.SizeUnit -> Helpers.Shared.Modifier Character
```

Set the size of the characters to the desired value.
Can be px, pt, vh, em or rem.


## Font Family

- [systemFont](#systemfont)

### **systemFont**
```elm
systemFont : String -> Character.CustomFontFamily
```

Gives a system font.
- [customFont](#customfont)

### **customFont**
```elm
customFont : String -> Character.CustomFontFamily
```

Gives a custom font.
- [fontFamily](#fontfamily-1)

### **fontFamily**
```elm
fontFamily : List Character.CustomFontFamily -> Helpers.Shared.Modifier Character
```

Set the font family to the desired fonts. All fonts will be tried one by one
until one is found either on the browser or user's OS. It is possible to use both
system and custom fonts.
- [fontFamilyInherit](#fontfamilyinherit)

### **fontFamilyInherit**
```elm
fontFamilyInherit : Helpers.Shared.Modifier Character
```

Inherits the font from the parents. It is the default behavior of fontFamily.
- [fontFamilySansSerif](#fontfamilysansserif)

### **fontFamilySansSerif**
```elm
fontFamilySansSerif : Helpers.Shared.Modifier Character
```

Standard Sans Serif font family.
Inspired from <https://www.smashingmagazine.com/2015/11/using-system-ui-fonts-practical-guide/>


# Compilation

- [characterToCouples](#charactertocouples)

### **characterToCouples**
```elm
characterToCouples : Character -> List ( String, String )
```

Compiles a `Character` record to the corresponding CSS list of tuples.
Compiles only styles which are defined, ignoring `Nothing` fields.

