# Typography

Typography contains everything about fonts and characters rendering.


# Types

- [Typography](#typography)

### **type alias Typography**
```elm
type alias Typography  =  
    { capitalization : Maybe Typography.Capitalization , decoration : Maybe Typography.Decoration , color : Maybe Color , whiteSpaceWrap : Maybe Typography.WhiteSpaceWrap , userSelect : Maybe Typography.UserSelect , lineHeight : Maybe (Either Helpers.Shared.SizeUnit Typography.Normal) , weight : Maybe Int , tilt : Maybe Typography.FontTilt , size : Maybe Helpers.Shared.SizeUnit , family : Maybe Typography.FontFamily , letterSpacing : Maybe Helpers.Shared.SizeUnit }
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


# Default typography

- [default](#default)

### **default**
```elm
default : Typography

```

Generate an empty `Typography` record, with every field equal to Nothing.
You are free to use it as you wish, but it is instanciated automatically by `Box.typography`.


# Typography modifiers

## Color
- [color](#color)

### **color**
```elm
color : Maybe Color
    , whiteSpaceWrap : Maybe WhiteSpaceWrap
    , userSelect : Maybe UserSelect
    , lineHeight : Maybe (Either SizeUnit Normal)
    , weight : Maybe Int
    , tilt : Maybe FontTilt
    , size : Maybe SizeUnit
    , family : Maybe FontFamily
    , letterSpacing : Maybe SizeUnit
    }



default : Typography
default =
    Typography Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing



type Capitalization
    = CapitalizationUppercase
    | CapitalizationLowercase
    | CapitalizationCapitalize



type Decoration
    = DecorationNone
    | DecorationUnderline
    | DecorationLineThrough



type WhiteSpaceWrap
    = WhiteSpaceWrapNoWrap



type alias UserSelect =
    Bool



type Normal
    = Normal



capitalize : Modifier Typography
capitalize =
    setCapitalization <| Just CapitalizationCapitalize



lowercase : Modifier Typography
lowercase =
    setCapitalization <| Just CapitalizationLowercase



uppercase : Modifier Typography
uppercase =
    setCapitalization <| Just CapitalizationUppercase



underline : Modifier Typography
underline =
    setDecoration <| Just DecorationUnderline



lineThrough : Modifier Typography
lineThrough =
    setDecoration <| Just DecorationLineThrough



noDecoration : Modifier Typography
noDecoration =
    setDecoration <| Just DecorationNone



whiteSpaceNoWrap : Modifier Typography
whiteSpaceNoWrap =
    setWhiteSpaceWrap <| Just WhiteSpaceWrapNoWrap



userSelect : Bool -> Modifier Typography
userSelect =
    setUserSelect << Just



lineHeightNormal : Modifier Typography
lineHeightNormal =
    setLineHeight <| Just <| Right Normal



lineHeight : SizeUnit -> Modifier Typography
lineHeight =
    setLineHeight << Just << Left




```

Set the color of the typography

## Text Transformations

- [capitalize](#capitalize)

### **capitalize**
```elm
capitalize : Modifier Typography

```

Capitalize the first letter in the text.
'just an example' is transformed in 'Just an example'.
- [lowercase](#lowercase)

### **lowercase**
```elm
lowercase : Modifier Typography

```

Turn the entire text in lowercase.
'JuST an ExAMPle' is transformed in 'just an example'.
- [uppercase](#uppercase)

### **uppercase**
```elm
uppercase : Modifier Typography

```

Turn the entire text in uppercase.
'JuST an ExAMPle' is transformed in 'JUST AN EXAMPLE'.


## Text Decorations

- [underline](#underline)

### **underline**
```elm
underline : Modifier Typography

```

Underline the text.
- [lineThrough](#linethrough)

### **lineThrough**
```elm
lineThrough : Modifier Typography

```

Print a line through the text.
- [noDecoration](#nodecoration)

### **noDecoration**
```elm
noDecoration : Modifier Typography

```

Remove every decoration (underline or lineThrough) on the text.


## Whitespace Management

- [whiteSpaceNoWrap](#whitespacenowrap)

### **whiteSpaceNoWrap**
```elm
whiteSpaceNoWrap : Modifier Typography

```

Cancel the wrapping of the text on whitespaces. It forces text to stay on one line.


## User Interactions

- [userSelect](#userselect-1)

### **userSelect**
```elm
userSelect : Maybe UserSelect
    , lineHeight : Maybe (Either SizeUnit Normal)
    , weight : Maybe Int
    , tilt : Maybe FontTilt
    , size : Maybe SizeUnit
    , family : Maybe FontFamily
    , letterSpacing : Maybe SizeUnit
    }



default : Typography
default =
    Typography Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing



type Capitalization
    = CapitalizationUppercase
    | CapitalizationLowercase
    | CapitalizationCapitalize



type Decoration
    = DecorationNone
    | DecorationUnderline
    | DecorationLineThrough



type WhiteSpaceWrap
    = WhiteSpaceWrapNoWrap



type alias UserSelect =
    Bool



type Normal
    = Normal



capitalize : Modifier Typography
capitalize =
    setCapitalization <| Just CapitalizationCapitalize



lowercase : Modifier Typography
lowercase =
    setCapitalization <| Just CapitalizationLowercase



uppercase : Modifier Typography
uppercase =
    setCapitalization <| Just CapitalizationUppercase



underline : Modifier Typography
underline =
    setDecoration <| Just DecorationUnderline



lineThrough : Modifier Typography
lineThrough =
    setDecoration <| Just DecorationLineThrough



noDecoration : Modifier Typography
noDecoration =
    setDecoration <| Just DecorationNone



whiteSpaceNoWrap : Modifier Typography
whiteSpaceNoWrap =
    setWhiteSpaceWrap <| Just WhiteSpaceWrapNoWrap




```

Allow or disallow user to interact with the text, i.e. select, copy, etc.


## Line Height

- [lineHeightNormal](#lineheightnormal)

### **lineHeightNormal**
```elm
lineHeightNormal : Modifier Typography

```

Set the lineHeight property to respect the space defined by the User Agent of
the user's browser. It usually is 1.2em, but can vary.
- [lineHeight](#lineheight)

### **lineHeight**
```elm
lineHeight : Maybe (Either SizeUnit Normal)
    , weight : Maybe Int
    , tilt : Maybe FontTilt
    , size : Maybe SizeUnit
    , family : Maybe FontFamily
    , letterSpacing : Maybe SizeUnit
    }



default : Typography
default =
    Typography Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing



type Capitalization
    = CapitalizationUppercase
    | CapitalizationLowercase
    | CapitalizationCapitalize



type Decoration
    = DecorationNone
    | DecorationUnderline
    | DecorationLineThrough



type WhiteSpaceWrap
    = WhiteSpaceWrapNoWrap



type alias UserSelect =
    Bool



type Normal
    = Normal



capitalize : Modifier Typography
capitalize =
    setCapitalization <| Just CapitalizationCapitalize



lowercase : Modifier Typography
lowercase =
    setCapitalization <| Just CapitalizationLowercase



uppercase : Modifier Typography
uppercase =
    setCapitalization <| Just CapitalizationUppercase



underline : Modifier Typography
underline =
    setDecoration <| Just DecorationUnderline



lineThrough : Modifier Typography
lineThrough =
    setDecoration <| Just DecorationLineThrough



noDecoration : Modifier Typography
noDecoration =
    setDecoration <| Just DecorationNone



whiteSpaceNoWrap : Modifier Typography
whiteSpaceNoWrap =
    setWhiteSpaceWrap <| Just WhiteSpaceWrapNoWrap



userSelect : Bool -> Modifier Typography
userSelect =
    setUserSelect << Just




```

Set the lineHeight to the desired value. Can be px, pt, vh, em or rem.


## Weight

- [weight](#weight)

### **weight**
```elm
weight : Maybe Int
    , tilt : Maybe FontTilt
    , size : Maybe SizeUnit
    , family : Maybe FontFamily
    , letterSpacing : Maybe SizeUnit
    }



default : Typography
default =
    Typography Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing



type Capitalization
    = CapitalizationUppercase
    | CapitalizationLowercase
    | CapitalizationCapitalize



type Decoration
    = DecorationNone
    | DecorationUnderline
    | DecorationLineThrough



type WhiteSpaceWrap
    = WhiteSpaceWrapNoWrap



type alias UserSelect =
    Bool



type Normal
    = Normal



capitalize : Modifier Typography
capitalize =
    setCapitalization <| Just CapitalizationCapitalize



lowercase : Modifier Typography
lowercase =
    setCapitalization <| Just CapitalizationLowercase



uppercase : Modifier Typography
uppercase =
    setCapitalization <| Just CapitalizationUppercase



underline : Modifier Typography
underline =
    setDecoration <| Just DecorationUnderline



lineThrough : Modifier Typography
lineThrough =
    setDecoration <| Just DecorationLineThrough



noDecoration : Modifier Typography
noDecoration =
    setDecoration <| Just DecorationNone



whiteSpaceNoWrap : Modifier Typography
whiteSpaceNoWrap =
    setWhiteSpaceWrap <| Just WhiteSpaceWrapNoWrap



userSelect : Bool -> Modifier Typography
userSelect =
    setUserSelect << Just



lineHeightNormal : Modifier Typography
lineHeightNormal =
    setLineHeight <| Just <| Right Normal



lineHeight : SizeUnit -> Modifier Typography
lineHeight =
    setLineHeight << Just << Left



color : Color -> Modifier Typography
color =
    setColor << Just



type FontTilt
    = FontTiltNormal
    | FontTiltItalic
    | FontTiltOblique



type CustomFontFamily
    = SystemFont String
    | CustomFont String



systemFont : String -> CustomFontFamily
systemFont =
    SystemFont



customFont : String -> CustomFontFamily
customFont =
    CustomFont



type FontFamily
    = FontFamilyInherit
    | FontFamilyCustom (List CustomFontFamily)




```

Changes the weight of the characters.
Value is defined between 100 and 900 and default weight is equal to 400.


## Tilting

- [tiltNormal](#tiltnormal)

### **tiltNormal**
```elm
tiltNormal : Modifier Typography

```

Cancels any tilting of the characters.
- [italic](#italic)

### **italic**
```elm
italic : Modifier Typography

```

Renders the characters as italic.
- [oblique](#oblique)

### **oblique**
```elm
oblique : Modifier Typography

```

Renders the characters as oblique.


## Size

- [size](#size)

### **size**
```elm
size : Maybe SizeUnit
    , family : Maybe FontFamily
    , letterSpacing : Maybe SizeUnit
    }



default : Typography
default =
    Typography Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing



type Capitalization
    = CapitalizationUppercase
    | CapitalizationLowercase
    | CapitalizationCapitalize



type Decoration
    = DecorationNone
    | DecorationUnderline
    | DecorationLineThrough



type WhiteSpaceWrap
    = WhiteSpaceWrapNoWrap



type alias UserSelect =
    Bool



type Normal
    = Normal



capitalize : Modifier Typography
capitalize =
    setCapitalization <| Just CapitalizationCapitalize



lowercase : Modifier Typography
lowercase =
    setCapitalization <| Just CapitalizationLowercase



uppercase : Modifier Typography
uppercase =
    setCapitalization <| Just CapitalizationUppercase



underline : Modifier Typography
underline =
    setDecoration <| Just DecorationUnderline



lineThrough : Modifier Typography
lineThrough =
    setDecoration <| Just DecorationLineThrough



noDecoration : Modifier Typography
noDecoration =
    setDecoration <| Just DecorationNone



whiteSpaceNoWrap : Modifier Typography
whiteSpaceNoWrap =
    setWhiteSpaceWrap <| Just WhiteSpaceWrapNoWrap



userSelect : Bool -> Modifier Typography
userSelect =
    setUserSelect << Just



lineHeightNormal : Modifier Typography
lineHeightNormal =
    setLineHeight <| Just <| Right Normal



lineHeight : SizeUnit -> Modifier Typography
lineHeight =
    setLineHeight << Just << Left



color : Color -> Modifier Typography
color =
    setColor << Just



type FontTilt
    = FontTiltNormal
    | FontTiltItalic
    | FontTiltOblique



type CustomFontFamily
    = SystemFont String
    | CustomFont String



systemFont : String -> CustomFontFamily
systemFont =
    SystemFont



customFont : String -> CustomFontFamily
customFont =
    CustomFont



type FontFamily
    = FontFamilyInherit
    | FontFamilyCustom (List CustomFontFamily)



weight : Int -> Modifier Typography
weight =
    setWeight << Just



tiltNormal : Modifier Typography
tiltNormal =
    setTilt <| Just FontTiltNormal



italic : Modifier Typography
italic =
    setTilt <| Just FontTiltItalic



oblique : Modifier Typography
oblique =
    setTilt <| Just FontTiltOblique




```

Set the size of the characters to the desired value.
Can be px, pt, vh, em or rem.


## Font Family

- [systemFont](#systemfont)

### **systemFont**
```elm
systemFont : String -> CustomFontFamily

```

Gives a system font.
- [customFont](#customfont)

### **customFont**
```elm
customFont : String -> CustomFontFamily

```

Gives a custom font.
- [fontFamily](#fontfamily-1)

### **fontFamily**
```elm
fontFamily : List CustomFontFamily -> Modifier Typography

```

Set the font family to the desired fonts. All fonts will be tried one by one
until one is found either on the browser or user's OS. It is possible to use both
system and custom fonts.
- [fontFamilyInherit](#fontfamilyinherit)

### **fontFamilyInherit**
```elm
fontFamilyInherit : Modifier Typography

```

Inherits the font from the parents. It is the default behavior of fontFamily.
- [fontFamilySansSerif](#fontfamilysansserif)

### **fontFamilySansSerif**
```elm
fontFamilySansSerif : Modifier Typography

```

Standard Sans Serif font family.
Inspired from <https://www.smashingmagazine.com/2015/11/using-system-ui-fonts-practical-guide/>

## Letter Spacing

- [letterSpacing](#letterspacing)

### **letterSpacing**
```elm
letterSpacing : Maybe SizeUnit
    }



default : Typography
default =
    Typography Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing



type Capitalization
    = CapitalizationUppercase
    | CapitalizationLowercase
    | CapitalizationCapitalize



type Decoration
    = DecorationNone
    | DecorationUnderline
    | DecorationLineThrough



type WhiteSpaceWrap
    = WhiteSpaceWrapNoWrap



type alias UserSelect =
    Bool



type Normal
    = Normal



capitalize : Modifier Typography
capitalize =
    setCapitalization <| Just CapitalizationCapitalize



lowercase : Modifier Typography
lowercase =
    setCapitalization <| Just CapitalizationLowercase



uppercase : Modifier Typography
uppercase =
    setCapitalization <| Just CapitalizationUppercase



underline : Modifier Typography
underline =
    setDecoration <| Just DecorationUnderline



lineThrough : Modifier Typography
lineThrough =
    setDecoration <| Just DecorationLineThrough



noDecoration : Modifier Typography
noDecoration =
    setDecoration <| Just DecorationNone



whiteSpaceNoWrap : Modifier Typography
whiteSpaceNoWrap =
    setWhiteSpaceWrap <| Just WhiteSpaceWrapNoWrap



userSelect : Bool -> Modifier Typography
userSelect =
    setUserSelect << Just



lineHeightNormal : Modifier Typography
lineHeightNormal =
    setLineHeight <| Just <| Right Normal



lineHeight : SizeUnit -> Modifier Typography
lineHeight =
    setLineHeight << Just << Left



color : Color -> Modifier Typography
color =
    setColor << Just



type FontTilt
    = FontTiltNormal
    | FontTiltItalic
    | FontTiltOblique



type CustomFontFamily
    = SystemFont String
    | CustomFont String



systemFont : String -> CustomFontFamily
systemFont =
    SystemFont



customFont : String -> CustomFontFamily
customFont =
    CustomFont



type FontFamily
    = FontFamilyInherit
    | FontFamilyCustom (List CustomFontFamily)



weight : Int -> Modifier Typography
weight =
    setWeight << Just



tiltNormal : Modifier Typography
tiltNormal =
    setTilt <| Just FontTiltNormal



italic : Modifier Typography
italic =
    setTilt <| Just FontTiltItalic



oblique : Modifier Typography
oblique =
    setTilt <| Just FontTiltOblique



size : SizeUnit -> Modifier Typography
size =
    setSize << Just



fontFamily : List CustomFontFamily -> Modifier Typography
fontFamily =
    setFamily << Just << FontFamilyCustom



fontFamilyInherit : Modifier Typography
fontFamilyInherit =
    setFamily <| Just FontFamilyInherit



fontFamilySansSerif : Modifier Typography
fontFamilySansSerif =
    setFamily <|
        Just <|
            FontFamilyCustom
                [ SystemFont "-apple-system"
                , SystemFont "system-ui"
                , SystemFont "BlinkMacSystemFont"
                , CustomFont "Segoe UI"
                , CustomFont "Roboto"
                , CustomFont "Helvetica Neue"
                , CustomFont "Arial"
                , SystemFont "sans-serif"
                ]




```

Set the letter spacing of the typography.


# Shortcuts

- [bold](#bold)

### **bold**
```elm
bold : Modifier Typography

```




# Compilation

- [typographyToCouples](#typographytocouples)

### **typographyToCouples**
```elm
typographyToCouples : Typography -> List ( String, String )

```

Compiles a `Typography` record to the corresponding CSS list of tuples.
Compiles only styles which are defined, ignoring `Nothing` fields.

