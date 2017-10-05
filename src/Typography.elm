module Typography
    exposing
        ( Typography
        , Capitalization
        , Decoration
        , WhiteSpaceWrap
        , UserSelect
        , Normal
        , default
        , character
        , capitalize
        , lowercase
        , uppercase
        , underline
        , lineThrough
        , noDecoration
        , whiteSpaceNoWrap
        , userSelect
        , lineHeightNormal
        , lineHeight
        , typographyToCouples
        )

{-| Typography contains everything about fonts and characters rendering.


# Types

@docs Typography
@docs Capitalization
@docs Decoration
@docs WhiteSpaceWrap
@docs UserSelect
@docs Normal


# Default typography

@docs default


# Typography modifiers


## Characters rendering

@docs character


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


# Compilation

@docs typographyToCouples

-}

import Color exposing (Color)
import Either exposing (Either(..))
import Typography.Character as Character exposing (Character)
import Shared exposing (..)
import Function
import Setters exposing (..)


{-| The Typography record contains everything about fonts rendering,
including character rendering. You probably won't use it as is, but instead using
`Elegant.typography` which automatically generate an empty `Typography` record. You
can then use modifiers. I.E.

    Elegant.typography
        [ Typography.color Color.white
        , Typography.italic
        ]

-}
type alias Typography =
    { character : Maybe Character
    , capitalization : Maybe Capitalization
    , decoration : Maybe Decoration
    , color : Maybe Color
    , whiteSpaceWrap : Maybe WhiteSpaceWrap
    , userSelect : Maybe UserSelect
    , lineHeight : Maybe (Either SizeUnit Normal)
    }


{-| Generate an empty `Typography` record, with every field equal to Nothing.
You are free to use it as you wish, but it is instanciated automatically by `Elegant.typography`.
-}
default : Typography
default =
    Typography Nothing Nothing Nothing Nothing Nothing Nothing Nothing


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


{-| Modify the character rendering of the text. The characters options are in
`Typography.Character`.
It creates a default empty `Character` record, modifies it according to the
modifiers, then set the resulting `Character` in Typography.

    Typography.character
        [ Typography.Character.weight 700
        , Typography.Character.italic
        ]

-}
character : Modifiers Character -> Modifier Typography
character modifiers typo =
    typo.character
        |> Maybe.withDefault Character.default
        |> Function.compose modifiers
        |> Just
        |> setCharacterIn typo


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
    ]
        |> List.concatMap (callOn typography)
        |> List.append
            (typography
                |> unwrapToCouples
                    .character
                    Character.characterToCouples
            )



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
