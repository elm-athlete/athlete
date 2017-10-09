module Elegant exposing (..)

{-|


# New

@docs color
@docs typography
@docs toInlineStyles
@docs style
@docs padding
@docs styleContents


# Types

@docs Vector
@docs Style
@docs SizeUnit
@docs BoxShadow
@docs Offset

# Styling
@docs defaultStyle
@docs inlineStyle
@docs convertStyles
@docs classes
@docs classesHover
@docs classesFocus
@docs stylesToCss
@docs screenWidthBetween
@docs screenWidthGE
@docs screenWidthLE
-- @docs userSelectNone
-- @docs userSelectAll

# Styles
## Positions
-- @docs positionStatic
-- @docs positionAbsolute
-- @docs positionRelative
-- @docs positionFixed
-- @docs positionSticky
-- @docs left
-- @docs right
-- @docs top
-- @docs bottom
-- @docs absolutelyPositionned
-- @docs verticalAlignMiddle

## Align Items
-- @docs alignItemsBaseline
-- @docs alignItemsCenter
-- @docs alignItemsFlexStart
-- @docs alignItemsFlexEnd
-- @docs alignItemsInherit
-- @docs alignItemsInitial
-- @docs alignItemsStretch
-- @docs alignSelfCenter


## SizeUnit operations

@docs opposite

## Text Alignements
-- @docs textCenter
-- @docs textLeft
-- @docs textRight
-- @docs textJustify
-- @docs backgroundColor
-- @docs backgroundImage
@docs withUrl
-- @docs backgroundImages

## Display
@docs displayBlock
@docs displayBlockFlexContainer
@docs displayInlineFlexContainer
@docs displayInline
@docs displayNone

## Flex Attributes
-- @docs flex
-- @docs flexWrapWrap
-- @docs flexWrapNoWrap
-- @docs flexBasis
-- @docs flexGrow
-- @docs flexShrink
-- @docs flexDirectionColumn
-- @docs flexDirectionRow

## Overflow
-- @docs overflowAuto
-- @docs overflowHidden
-- @docs overflowScroll
-- @docs overflowVisible
-- @docs overflowXAuto
-- @docs overflowXVisible
-- @docs overflowXHidden
-- @docs overflowXScroll
-- @docs overflowYAuto
-- @docs overflowYVisible
-- @docs overflowYHidden
-- @docs overflowYScroll
-- @docs textOverflowEllipsis

## List Style Type
-- @docs listStyleNone
-- @docs listStyleDisc
-- @docs listStyleCircle
-- @docs listStyleSquare
-- @docs listStyleDecimal
-- @docs listStyleGeorgian


## Justify Content

-- @docs justifyContentSpaceBetween
-- @docs justifyContentSpaceAround


## -- @docs justifyContentCenter

-- ## Spacings
-- @docs spaceBetween
-- @docs spaceAround

## Width and Height
-- @docs width
-- @docs widthPercent
-- @docs maxWidth
-- @docs minWidth
-- @docs height
-- @docs heightPercent
-- @docs maxHeight
-- @docs minHeight
-- @docs fullWidth
-- @docs fullHeight


## -- @docs fullViewportHeight


# Constants

## Sizes
@docs huge
@docs large
@docs medium
@docs small
@docs tiny
@docs zero

## Color


## -- @docs transparent

--


## -- ## Headings Helper functions

@docs h1S
@docs h2S
@docs h3S
@docs h4S
@docs h5S
@docs h6S
@docs heading

## Font Sizes
@docs alpha
@docs beta
@docs gamma
@docs delta
@docs epsilon
@docs zeta
@docs eta
@docs theta
@docs iota
@docs kappa

-}

import Html exposing (Html)
import Html.Attributes
import Function exposing (compose)
import List.Extra
import Maybe.Extra as Maybe exposing ((?))
import Function
import Helpers.Setters exposing (..)
import Helpers.Shared exposing (..)
import Either exposing (Either(..))
import Helpers.Css
import Display exposing (DisplayBox)


{-| Contains all style for an element used with Elegant.
-}
type Style
    = Style
        { display : Maybe DisplayBox
        , screenWidths : List ScreenWidth
        }


{-| -}
style : DisplayBox -> Style
style display =
    Style
        { display = Just display
        , screenWidths = []
        }



-- Alias


type alias SizeUnit =
    Helpers.Shared.SizeUnit


px : Int -> SizeUnit
px =
    Px


pt : Int -> SizeUnit
pt =
    Pt


percent : Float -> SizeUnit
percent =
    Percent


vh : Float -> SizeUnit
vh =
    Vh


em : Float -> SizeUnit
em =
    Em


rem : Float -> SizeUnit
rem =
    Rem


{-| Calculate the opposite of a size unit value.
Ex : opposite (Px 2) == Px -2
-}
opposite : SizeUnit -> SizeUnit
opposite unit =
    case unit of
        Px a ->
            Px -a

        Pt a ->
            Pt -a

        Percent a ->
            Percent -a

        Vh a ->
            Vh -a

        Em a ->
            Em -a

        Rem a ->
            Rem -a


{-| -}
color : a -> { b | color : Maybe a } -> { b | color : Maybe a }
color =
    setColor << Just


type alias ScreenWidth =
    { min : Maybe Int
    , max : Maybe Int
    , style : Style
    }


{-| -}
screenWidthBetween : Int -> Int -> List (Style -> Style) -> Style -> Style
screenWidthBetween min max insideStyle (Style style) =
    Style
        { style
            | screenWidths =
                { min = Just min
                , max = Just max
                , style = (compose insideStyle) defaultStyle
                }
                    :: style.screenWidths
        }


{-| -}
screenWidthGE : Int -> List (Style -> Style) -> Style -> Style
screenWidthGE min insideStyle (Style style) =
    Style
        { style
            | screenWidths =
                { min = Just min
                , max = Nothing
                , style = (compose insideStyle) defaultStyle
                }
                    :: style.screenWidths
        }


{-| -}
screenWidthLE : Int -> List (Style -> Style) -> Style -> Style
screenWidthLE max insideStyle (Style style) =
    Style
        { style
            | screenWidths =
                { min = Nothing
                , max = Just max
                , style = (compose insideStyle) defaultStyle
                }
                    :: style.screenWidths
        }


{-| -}
huge : SizeUnit
huge =
    Px 48


{-| -}
large : SizeUnit
large =
    Px 24


{-| -}
medium : SizeUnit
medium =
    Px 12


{-| -}
small : SizeUnit
small =
    Px 6


{-| -}
tiny : SizeUnit
tiny =
    Px 3


{-| -}
zero : SizeUnit
zero =
    Px 0


{-| -}
defaultStyle : Style
defaultStyle =
    Style
        { display = Nothing
        , screenWidths = []
        }


nothingOrJust : (a -> b) -> Maybe a -> Maybe b
nothingOrJust fun =
    Maybe.andThen (Just << fun)


autoOrSizeUnitToString : Maybe (Either SizeUnit Auto) -> Maybe String
autoOrSizeUnitToString =
    nothingOrJust
        (\val ->
            case val of
                Left su ->
                    sizeUnitToString su

                Right _ ->
                    "auto"
        )


maybeToString : Maybe a -> Maybe String
maybeToString =
    nothingOrJust
        (\val ->
            toString val
        )


compileStyle : Style -> List ( String, String )
compileStyle (Style style) =
    Display.displayBoxToString style.display


removeEmptyStyles : List ( String, Maybe String ) -> List ( String, String )
removeEmptyStyles =
    List.concatMap <|
        \( attr, maybe_ ) ->
            case maybe_ of
                Nothing ->
                    []

                Just val ->
                    [ ( attr, val ) ]


{-| -}
toInlineStyles : Style -> List ( String, String )
toInlineStyles =
    compileStyle


{-| -}
convertStyles : Style -> List ( String, String )
convertStyles =
    toInlineStyles


{-| -}
inlineStyle : Style -> Html.Attribute msg
inlineStyle =
    Html.Attributes.style
        << convertStyles


{-| helper function to create a heading
-}
heading : SizeUnit -> Style -> Style
heading val =
    identity


{-| helper function to create a h1 style
-}
h1S : Style -> Style
h1S =
    heading alpha


{-| helper function to create a h2 style
-}
h2S : Style -> Style
h2S =
    heading beta


{-| helper function to create a h3 style
-}
h3S : Style -> Style
h3S =
    heading gamma


{-| helper function to create a h4 style
-}
h4S : Style -> Style
h4S =
    heading delta


{-| helper function to create a h5 style
-}
h5S : Style -> Style
h5S =
    heading epsilon


{-| helper function to create a h6 style
-}
h6S : Style -> Style
h6S =
    heading zeta


{-| -}
alpha : SizeUnit
alpha =
    Rem 2.5


{-| -}
beta : SizeUnit
beta =
    Rem 2


{-| -}
gamma : SizeUnit
gamma =
    Rem 1.75


{-| -}
delta : SizeUnit
delta =
    Rem 1.5


{-| -}
epsilon : SizeUnit
epsilon =
    Rem 1.25


{-| -}
zeta : SizeUnit
zeta =
    Rem 1


{-| -}
eta : SizeUnit
eta =
    Em 0.75


{-| -}
theta : SizeUnit
theta =
    Em 0.5


{-| -}
iota : SizeUnit
iota =
    Em 0.25


{-| -}
kappa : SizeUnit
kappa =
    Em 0.125



{-
    ███████    ███████    ███████
   ████████   ████████   ████████
   ████       █████      █████
   ███        ████       ████
   ███        ███████    ███████
   ███         ███████    ███████
   ███            ████       ████
   ████          █████      █████
   ████████   ████████   ████████
    ███████   ███████    ███████
-}


{-| Generate all the classes of a list of Styles
-}
classes : Style -> String
classes =
    classesAndScreenWidths Nothing


conditionalClasses : String -> Style -> String
conditionalClasses condition =
    classesAndScreenWidths (Just condition)


{-| Generate all the classes of a list of Hover Styles
-}
classesHover : Style -> String
classesHover =
    conditionalClasses "hover"


{-| Generate all the classes of a list of Focus Styles
-}
classesFocus : Style -> String
classesFocus =
    conditionalClasses "focus"


classesNameGeneration : Maybe String -> Style -> List String
classesNameGeneration suffix =
    compileStyle
        >> List.map (generateClassName suffix)


classesAndScreenWidths : Maybe String -> Style -> String
classesAndScreenWidths suffix (Style style) =
    let
        standardClassesNames =
            classesNameGeneration suffix (Style style)

        mediaQueriesClassesNames =
            style.screenWidths
                |> List.map (screenWidthToClassNames suffix)
                |> List.concat
    in
        List.append standardClassesNames mediaQueriesClassesNames
            |> String.join " "


screenWidthToClassNames : Maybe String -> ScreenWidth -> List String
screenWidthToClassNames suffix { min, max, style } =
    List.map
        (addMediaQueryId min max)
        (classesNameGeneration suffix style)


addMediaQueryId : Maybe Int -> Maybe Int -> String -> String
addMediaQueryId min max =
    flip (++) (String.filter Helpers.Css.isValidInCssName (toString min ++ toString max))


generateClassName : Maybe String -> ( String, String ) -> String
generateClassName maybeSuffix ( attribute, value ) =
    attribute ++ "-" ++ (String.filter Helpers.Css.isValidInCssName (value ++ generateSuffix maybeSuffix))


generateSuffix : Maybe String -> String
generateSuffix =
    Maybe.map (\suffix -> "_" ++ suffix)
        >> Maybe.withDefault ""


generateSelector : Maybe String -> Maybe String
generateSelector =
    Maybe.map ((++) ":")


addSuffix : String -> String -> String
addSuffix =
    flip (++)


type alias ConditionalStyle =
    { style : Style
    , suffix : Maybe String
    , mediaQuery : Maybe ( Maybe Int, Maybe Int )
    }


type alias AtomicClass =
    { mediaQuery : Maybe String
    , className : String
    , mediaQueryId : Maybe String
    , selector : Maybe String
    , property : String
    }


generateMediaQueryId : ( Maybe Int, Maybe Int ) -> String
generateMediaQueryId ( min, max ) =
    String.filter Helpers.Css.isValidInCssName (toString min ++ toString max)


coupleToAtomicClass : Maybe String -> Maybe ( Maybe Int, Maybe Int ) -> ( String, String ) -> AtomicClass
coupleToAtomicClass suffix mediaQuery property =
    { mediaQuery = Maybe.map generateMediaQuery mediaQuery
    , className = generateClassName suffix property
    , mediaQueryId = Maybe.map generateMediaQueryId mediaQuery
    , selector = generateSelector suffix
    , property = generateProperty property
    }


compileConditionalStyle : ConditionalStyle -> List AtomicClass
compileConditionalStyle { style, suffix, mediaQuery } =
    List.map (coupleToAtomicClass suffix mediaQuery) (compileStyle style)


compileAtomicClass : AtomicClass -> String
compileAtomicClass { mediaQuery, className, mediaQueryId, selector, property } =
    inMediaQuery mediaQuery
        (compileStyleToCss className mediaQueryId selector property)


{-| Generate all the css from a list of tuple : styles and hover
-}
stylesToCss : List ConditionalStyle -> List String
stylesToCss styles =
    styles
        |> List.concatMap compileScreenWidths
        |> List.concatMap compileConditionalStyle
        |> List.map compileAtomicClass
        |> List.append [ boxSizingCss ]
        |> List.Extra.unique


boxSizingCss : String
boxSizingCss =
    "*{box-sizing: border-box;}"


screenWidthToCompiledStyle :
    Maybe String
    -> ScreenWidth
    -> ConditionalStyle
screenWidthToCompiledStyle suffix { min, max, style } =
    ConditionalStyle style suffix (Just ( min, max ))


compileScreenWidths : ConditionalStyle -> List ConditionalStyle
compileScreenWidths ({ suffix, style } as style_) =
    let
        (Style { screenWidths }) =
            style
    in
        style_ :: List.map (screenWidthToCompiledStyle suffix) screenWidths


generateMediaQuery : ( Maybe Int, Maybe Int ) -> String
generateMediaQuery ( min, max ) =
    "@media " ++ mediaQuerySelector min max


inMediaQuery : Maybe String -> String -> String
inMediaQuery mediaQuery content =
    case mediaQuery of
        Nothing ->
            content

        Just queries ->
            queries ++ Helpers.Css.surroundWithBraces content


mediaQuerySelector : Maybe Int -> Maybe Int -> String
mediaQuerySelector min max =
    case min of
        Nothing ->
            case max of
                Nothing ->
                    ""

                Just max_ ->
                    "(max-width: " ++ toString max_ ++ "px)"

        Just min_ ->
            case max of
                Nothing ->
                    "(min-width: " ++ toString min_ ++ "px)"

                Just max_ ->
                    "(min-width: " ++ toString min_ ++ "px) and (max-width: " ++ toString max_ ++ "px)"


generateProperty : ( String, String ) -> String
generateProperty ( attribute, value ) =
    attribute ++ ":" ++ value


compileStyleToCss : String -> Maybe String -> Maybe String -> String -> String
compileStyleToCss className mediaQueryId selector property =
    "."
        ++ className
        ++ (mediaQueryId ? "")
        ++ (selector ? "")
        ++ Helpers.Css.surroundWithBraces property
