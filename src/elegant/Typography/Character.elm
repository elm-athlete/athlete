module Typography.Character
    exposing
        ( Character
        , FontTilt
        , FontFamily
        , CustomFontFamily
        , systemFont
        , customFont
        , weight
        , tiltNormal
        , italic
        , oblique
        , size
        , fontFamily
        , fontFamilyInherit
        , fontFamilySansSerif
        , default
        , characterToCouples
        )

{-| Character contains everything about characters rendering.


# Types

@docs Character
@docs FontTilt
@docs FontFamily
@docs CustomFontFamily


# Default Character

@docs default


# Modifiers


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


# Compilation

@docs characterToCouples

-}

import Helpers.Shared exposing (..)
import Elegant.Setters exposing (..)
import Helpers.Css


{-| The Character record contains everything about characters rendering.
You probably won't use it as is, but instead using `Typography.character`
which automatically generate an empty `Character` record. You can then use
modifiers. I.E.

    Typography.characters
        [ Typography.Character.weight 700
        , Typography.Character.size (px 30)
        ]

-}
type alias Character =
    { weight : Maybe Int
    , tilt : Maybe FontTilt
    , size : Maybe SizeUnit
    , family : Maybe FontFamily
    }


{-| Generate an empty `Character` record, with every field equal to Nothing.
You are free to use it as you wish, but it is instanciated automatically by `Typography.character`.
-}
default : Character
default =
    Character Nothing Nothing Nothing Nothing


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
weight : Int -> Modifier Character
weight =
    setWeight << Just


{-| Cancels any tilting of the characters.
-}
tiltNormal : Modifier Character
tiltNormal =
    setTilt <| Just FontTiltNormal


{-| Renders the characters as italic.
-}
italic : Modifier Character
italic =
    setTilt <| Just FontTiltItalic


{-| Renders the characters as oblique.
-}
oblique : Modifier Character
oblique =
    setTilt <| Just FontTiltOblique


{-| Set the size of the characters to the desired value.
Can be px, pt, vh, em or rem.
-}
size : SizeUnit -> Modifier Character
size =
    setSize << Just


{-| Set the font family to the desired fonts. All fonts will be tried one by one
until one is found either on the browser or user's OS. It is possible to use both
system and custom fonts.
-}
fontFamily : List CustomFontFamily -> Modifier Character
fontFamily =
    setFamily << Just << FontFamilyCustom


{-| Inherits the font from the parents. It is the default behavior of fontFamily.
-}
fontFamilyInherit : Modifier Character
fontFamilyInherit =
    setFamily <| Just FontFamilyInherit


{-| Standard Sans Serif font family.
Inspired from <https://www.smashingmagazine.com/2015/11/using-system-ui-fonts-practical-guide/>
-}
fontFamilySansSerif : Modifier Character
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


{-| Compiles a `Character` record to the corresponding CSS list of tuples.
Compiles only styles which are defined, ignoring `Nothing` fields.
-}
characterToCouples : Character -> List ( String, String )
characterToCouples character =
    [ unwrapToCouple .weight weightToCouple
    , unwrapToCouple .tilt tiltToCouple
    , unwrapToCouple .size sizeToCouple
    , unwrapToCouple .family familyToCouple
    ]
        |> List.concatMap (\fun -> fun character)


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
