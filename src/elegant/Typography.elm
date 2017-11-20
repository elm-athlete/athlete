module Typography
    exposing
        ( Typography
        , Capitalization
        , Decoration
        , WhiteSpaceWrap
        , UserSelect
        , Normal
        , FontTilt
        , FontFamily
        , CustomFontFamily
        , default
        , capitalize
        , lowercase
        , uppercase
        , underline
        , lineThrough
        , noDecoration
        , whiteSpaceNoWrap
        , userSelect
        , weight
        , tiltNormal
        , italic
        , oblique
        , size
        , systemFont
        , customFont
        , fontFamily
        , fontFamilyInherit
        , fontFamilySansSerif
        , lineHeightNormal
        , lineHeight
        , letterSpacing
        , typographyToCouples
        , bold
        )

{-| Typography contains everything about fonts and characters rendering.


# Types

@docs Typography
@docs Capitalization
@docs Decoration
@docs WhiteSpaceWrap
@docs UserSelect
@docs Normal
@docs FontTilt
@docs FontFamily
@docs CustomFontFamily


# Default typography

@docs default


# Typography modifiers


## Text Transformations

@docs capitalize
@docs lowercase
@docs uppercase


## Text Decorations

@docs underline
@docs lineThrough
@docs noDecoration


## Whitespace Management

@docs whiteSpaceNoWrap


## User Interactions

@docs userSelect


## Line Height

@docs lineHeightNormal
@docs lineHeight


## Weight

@docs weight


## Tilting

@docs tiltNormal
@docs italic
@docs oblique


## Size

@docs size


## Font Family

@docs systemFont
@docs customFont
@docs fontFamily
@docs fontFamilyInherit
@docs fontFamilySansSerif


## Letter Spacing

@docs letterSpacing


# Shortcuts

@docs bold


# Compilation

@docs typographyToCouples

-}

import Color exposing (Color)
import Either exposing (Either(..))
import Helpers.Shared exposing (..)
import Helpers.Css
import Elegant.Setters exposing (..)


{-| The `Typography` record contains everything about fonts rendering,
including character rendering. You probably won't use it as is, but instead using
`Box.typography` which automatically generate an empty `Typography` record. You
can then use modifiers. I.E.

    Box.typography
        [ Typography.color Color.white
        , Typography.italic
        ]

-}
type alias Typography =
    { capitalization : Maybe Capitalization
    , decoration : Maybe Decoration
    , color : Maybe Color
    , whiteSpaceWrap : Maybe WhiteSpaceWrap
    , userSelect : Maybe UserSelect
    , lineHeight : Maybe (Either SizeUnit Normal)
    , weight : Maybe Int
    , tilt : Maybe FontTilt
    , size : Maybe SizeUnit
    , family : Maybe FontFamily
    , letterSpacing : Maybe SizeUnit
    }


{-| Generate an empty `Typography` record, with every field equal to Nothing.
You are free to use it as you wish, but it is instanciated automatically by `Box.typography`.
-}
default : Typography
default =
    Typography Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing


{-| Represents the possible transformations of the text.
It can be Uppercase, Lowercase, or Capitalize. They are created by `uppercase`,
`lowercase` and `capitalize`.
-}
type Capitalization
    = CapitalizationUppercase
    | CapitalizationLowercase
    | CapitalizationCapitalize


{-| Represents the possible decorations of the text.
It can be None, Underline or LineThrough. They are created by `noDecoration`,
`underline` and `lineThrough`.
-}
type Decoration
    = DecorationNone
    | DecorationUnderline
    | DecorationLineThrough


{-| Represents the whitespaces management in the text.
It can be NoWrap, and created by `whiteSpaceNoWrap`.
-}
type WhiteSpaceWrap
    = WhiteSpaceWrapNoWrap


{-| Represents the interaction with the user. If set to `True`, the user
can interact with the text, i.e. can select it, copy and paste. If set to
`False`, nothing can be done.
-}
type alias UserSelect =
    Bool


{-| Value representing the 'normal' value in `line-height`.
-}
type Normal
    = Normal


{-| Capitalize the first letter in the text.
'just an example' is transformed in 'Just an example'.
-}
capitalize : Modifier Typography
capitalize =
    setCapitalization <| Just CapitalizationCapitalize


{-| Turn the entire text in lowercase.
'JuST an ExAMPle' is transformed in 'just an example'.
-}
lowercase : Modifier Typography
lowercase =
    setCapitalization <| Just CapitalizationLowercase


{-| Turn the entire text in uppercase.
'JuST an ExAMPle' is transformed in 'JUST AN EXAMPLE'.
-}
uppercase : Modifier Typography
uppercase =
    setCapitalization <| Just CapitalizationUppercase


{-| Underline the text.
-}
underline : Modifier Typography
underline =
    setDecoration <| Just DecorationUnderline


{-| Print a line through the text.
-}
lineThrough : Modifier Typography
lineThrough =
    setDecoration <| Just DecorationLineThrough


{-| Remove every decoration (underline or lineThrough) on the text.
-}
noDecoration : Modifier Typography
noDecoration =
    setDecoration <| Just DecorationNone


{-| Cancel the wrapping of the text on whitespaces. It forces text to stay on one line.
-}
whiteSpaceNoWrap : Modifier Typography
whiteSpaceNoWrap =
    setWhiteSpaceWrap <| Just WhiteSpaceWrapNoWrap


{-| Allow or disallow user to interact with the text, i.e. select, copy, etc.
-}
userSelect : Bool -> Modifier Typography
userSelect =
    setUserSelect << Just


{-| Set the lineHeight property to respect the space defined by the User Agent of
the user's browser. It usually is 1.2em, but can vary.
-}
lineHeightNormal : Modifier Typography
lineHeightNormal =
    setLineHeight <| Just <| Right Normal


{-| Set the lineHeight to the desired value. Can be px, pt, vh, em or rem.
-}
lineHeight : SizeUnit -> Modifier Typography
lineHeight =
    setLineHeight << Just << Left


{-| Represents the possible tilting of the characters.
It can be Normal, Italic, or Oblique. They are created by `uppercase`,
`lowercase` and `capitalize`.
-}
type FontTilt
    = FontTiltNormal
    | FontTiltItalic
    | FontTiltOblique


{-| Represents the font family used to render characters.
It can be a system or a custom type. They are created by `systemFont` and `customFont`.
-}
type CustomFontFamily
    = SystemFont String
    | CustomFont String


{-| Gives a system font.
-}
systemFont : String -> CustomFontFamily
systemFont =
    SystemFont


{-| Gives a custom font.
-}
customFont : String -> CustomFontFamily
customFont =
    CustomFont


{-| Represents the possible fontFamily of the characters.
It can be Inherited from the parent, or customized.
-}
type FontFamily
    = FontFamilyInherit
    | FontFamilyCustom (List CustomFontFamily)


{-| Changes the weight of the characters.
Value is defined between 100 and 900 and default weight is equal to 400.
-}
weight : Int -> Modifier Typography
weight =
    setWeight << Just


{-| Cancels any tilting of the characters.
-}
tiltNormal : Modifier Typography
tiltNormal =
    setTilt <| Just FontTiltNormal


{-| Renders the characters as italic.
-}
italic : Modifier Typography
italic =
    setTilt <| Just FontTiltItalic


{-| Renders the characters as oblique.
-}
oblique : Modifier Typography
oblique =
    setTilt <| Just FontTiltOblique


{-| Set the size of the characters to the desired value.
Can be px, pt, vh, em or rem.
-}
size : SizeUnit -> Modifier Typography
size =
    setSize << Just


{-| Set the font family to the desired fonts. All fonts will be tried one by one
until one is found either on the browser or user's OS. It is possible to use both
system and custom fonts.
-}
fontFamily : List CustomFontFamily -> Modifier Typography
fontFamily =
    setFamily << Just << FontFamilyCustom


{-| Inherits the font from the parents. It is the default behavior of fontFamily.
-}
fontFamilyInherit : Modifier Typography
fontFamilyInherit =
    setFamily <| Just FontFamilyInherit


{-| Standard Sans Serif font family.
Inspired from <https://www.smashingmagazine.com/2015/11/using-system-ui-fonts-practical-guide/>
-}
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


{-| Set the letter spacing of the typography.
-}
letterSpacing : SizeUnit -> Modifier Typography
letterSpacing value =
    setLetterSpacing <| Just value


{-| Compiles a `Typography` record to the corresponding CSS list of tuples.
Compiles only styles which are defined, ignoring `Nothing` fields.
-}
typographyToCouples : Typography -> List ( String, String )
typographyToCouples typography =
    [ unwrapToCouple .color colorToCouple
    , unwrapToCouple .capitalization capitalizationToCouples
    , unwrapToCouple .decoration decorationToCouples
    , unwrapToCouple .whiteSpaceWrap whiteSpaceToCouples
    , unwrapToCouple .userSelect userSelectToCouples
    , unwrapToCouple .lineHeight lineHeightToCouples
    , unwrapToCouple .weight weightToCouple
    , unwrapToCouple .tilt tiltToCouple
    , unwrapToCouple .size sizeToCouple
    , unwrapToCouple .family familyToCouple
    , unwrapToCouple .letterSpacing letterSpacingToCouple
    ]
        |> List.concatMap (callOn typography)



-- Shortcuts


{-| -}
bold : Modifier Typography
bold =
    weight 900



-- Internals


capitalizationToCouples : Capitalization -> ( String, String )
capitalizationToCouples capitalization =
    ( "text-transform", capitalizationToString capitalization )


capitalizationToString : Capitalization -> String
capitalizationToString capitalization =
    case capitalization of
        CapitalizationUppercase ->
            "uppercase"

        CapitalizationLowercase ->
            "lowercase"

        CapitalizationCapitalize ->
            "capitalize"


decorationToCouples : Decoration -> ( String, String )
decorationToCouples decoration =
    ( "text-decoration", textDecorationToString decoration )


textDecorationToString : Decoration -> String
textDecorationToString val =
    case val of
        DecorationNone ->
            "none"

        DecorationUnderline ->
            "underline"

        DecorationLineThrough ->
            "line-through"


whiteSpaceToCouples : WhiteSpaceWrap -> ( String, String )
whiteSpaceToCouples whiteSpace =
    ( "white-space", whiteSpaceWrapToString whiteSpace )


whiteSpaceWrapToString : WhiteSpaceWrap -> String
whiteSpaceWrapToString val =
    case val of
        WhiteSpaceWrapNoWrap ->
            "nowrap"


userSelectToCouples : UserSelect -> ( String, String )
userSelectToCouples userSelect =
    ( "user-select", userSelectToString userSelect )


userSelectToString : UserSelect -> String
userSelectToString val =
    case val of
        False ->
            "none"

        True ->
            "all"


lineHeightToCouples : Either SizeUnit Normal -> ( String, String )
lineHeightToCouples lineHeight =
    ( "line-height", lineHeightToString lineHeight )


lineHeightToString : Either SizeUnit Normal -> String
lineHeightToString normalSizeUnitEither =
    case normalSizeUnitEither of
        Left sizeUnit ->
            sizeUnitToString sizeUnit

        Right _ ->
            "normal"


weightToCouple : Int -> ( String, String )
weightToCouple int =
    ( "font-weight", toString int )


tiltToCouple : FontTilt -> ( String, String )
tiltToCouple fontTilt =
    ( "font-style", fontStyleToString fontTilt )


fontStyleToString : FontTilt -> String
fontStyleToString val =
    case val of
        FontTiltNormal ->
            "normal"

        FontTiltItalic ->
            "italic"

        FontTiltOblique ->
            "oblique"


sizeToCouple : SizeUnit -> ( String, String )
sizeToCouple val =
    ( "font-size", sizeUnitToString val )


familyToCouple : FontFamily -> ( String, String )
familyToCouple fontFamily =
    ( "font-family", fontFamilyToString fontFamily )


letterSpacingToCouple : SizeUnit -> ( String, String )
letterSpacingToCouple value =
    ( "letter-spacing", sizeUnitToString value )


fontFamilyToString : FontFamily -> String
fontFamilyToString val =
    case val of
        FontFamilyInherit ->
            "inherit"

        FontFamilyCustom fontList ->
            fontList
                |> List.map extractFontName
                |> String.join ", "


extractFontName : CustomFontFamily -> String
extractFontName customFont =
    case customFont of
        CustomFont fontName ->
            Helpers.Css.surroundWithQuotes fontName

        SystemFont fontName ->
            fontName
