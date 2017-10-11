module Elegant exposing (..)

import Html exposing (Html)
import Html.Attributes
import List.Extra
import Maybe.Extra as Maybe exposing ((?))
import Helpers.Setters exposing (..)
import Helpers.Shared exposing (..)
import Helpers.Css
import Helpers.Style exposing (..)
import Display exposing (DisplayBox)
import Elegant.Convert


{-| Contains all style for an element used with Elegant.
-}
type Style
    = Style StyleAndScreenWidths


{-| -}
style : DisplayBox -> Style
style display =
    Style
        { display = Just display
        , screenWidths = []
        }


withScreenWidth : List ScreenWidth -> Modifier Style
withScreenWidth screenWidth (Style style) =
    style
        |> setScreenWidths screenWidth
        |> Style


{-| -}
screenWidthBetween : Int -> Int -> DisplayBox -> Modifier Style
screenWidthBetween min max betweenStyle (Style style) =
    style
        |> addScreenWidth
            { min = Just min
            , max = Just max
            , style = betweenStyle
            }
        |> Style


{-| -}
screenWidthGE : Int -> DisplayBox -> Modifier Style
screenWidthGE min greaterStyle (Style style) =
    style
        |> addScreenWidth
            { min = Just min
            , max = Nothing
            , style = greaterStyle
            }
        |> Style


{-| -}
screenWidthLE : Int -> DisplayBox -> Modifier Style
screenWidthLE max lessStyle (Style style) =
    style
        |> addScreenWidth
            { min = Nothing
            , max = Just max
            , style = lessStyle
            }
        |> Style



-- Inline styling


{-| -}
toInlineStyles : Style -> List ( String, String )
toInlineStyles (Style style) =
    style.display
        |> Maybe.map Elegant.Convert.compileStyle
        |> Maybe.withDefault []


{-| -}
inlineStyle : DisplayBox -> Html.Attribute msg
inlineStyle =
    style
        >> toInlineStyles
        >> Html.Attributes.style



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
classes (Style style) =
    style
        |> Elegant.Convert.classesNamesFromStyleAndScreenWidths Nothing
        |> String.join " "


classesWithSuffix : String -> Style -> String
classesWithSuffix suffix (Style style) =
    style
        |> Elegant.Convert.classesNamesFromStyleAndScreenWidths (Just suffix)
        |> String.join " "


{-| Generate all the classes of a list of Hover Styles
-}
classesHover : Style -> String
classesHover =
    classesWithSuffix "hover"


{-| Generate all the classes of a list of Focus Styles
-}
classesFocus : Style -> String
classesFocus =
    classesWithSuffix "focus"



--
--
-- generateSelector : Maybe String -> Maybe String
-- generateSelector =
--     Maybe.map ((++) ":")
--
--
-- type alias ConditionalStyle =
--     { style : Style
--     , suffix : Maybe String
--     , mediaQuery : Maybe ( Maybe Int, Maybe Int )
--     }
--
--
-- type alias AtomicClass =
--     { mediaQuery : Maybe String
--     , className : String
--     , mediaQueryId : Maybe String
--     , selector : Maybe String
--     , property : String
--     }
--
--
-- generateMediaQueryId : ( Maybe Int, Maybe Int ) -> String
-- generateMediaQueryId ( min, max ) =
--     String.filter Helpers.Css.isValidInCssName (toString min ++ toString max)
--
--
-- coupleToAtomicClass : Maybe String -> Maybe ( Maybe Int, Maybe Int ) -> ( String, String ) -> AtomicClass
-- coupleToAtomicClass suffix mediaQuery property =
--     { mediaQuery = Maybe.map generateMediaQuery mediaQuery
--     , className = Elegant.Convert.generateClassName suffix property
--     , mediaQueryId = Maybe.map generateMediaQueryId mediaQuery
--     , selector = generateSelector suffix
--     , property = generateProperty property
--     }
--
--
-- compileConditionalStyle : ConditionalStyle -> List AtomicClass
-- compileConditionalStyle { style, suffix, mediaQuery } =
--     List.map (coupleToAtomicClass suffix mediaQuery) (compileStyle style)
--
--
-- compileAtomicClass : AtomicClass -> String
-- compileAtomicClass { mediaQuery, className, mediaQueryId, selector, property } =
--     inMediaQuery mediaQuery
--         (compileStyleToCss className mediaQueryId selector property)
--
--
-- {-| Generate all the css from a list of tuple : styles and hover
-- -}
-- stylesToCss : List ConditionalStyle -> List String
-- stylesToCss styles =
--     styles
--         |> List.concatMap compileScreenWidths
--         |> List.concatMap compileConditionalStyle
--         |> List.map compileAtomicClass
--         |> List.append [ boxSizingCss ]
--         |> List.Extra.unique
--
--
-- boxSizingCss : String
-- boxSizingCss =
--     "*{box-sizing: border-box;}"
--
--
-- screenWidthToCompiledStyle :
--     Maybe String
--     -> ScreenWidth
--     -> ConditionalStyle
-- screenWidthToCompiledStyle suffix { min, max, style } =
--     ConditionalStyle style suffix (Just ( min, max ))
--
--
-- compileScreenWidths : ConditionalStyle -> List ConditionalStyle
-- compileScreenWidths ({ suffix, style } as style_) =
--     let
--         (Style { screenWidths }) =
--             style
--     in
--         style_ :: List.map (screenWidthToCompiledStyle suffix) screenWidths
--
--
-- generateMediaQuery : ( Maybe Int, Maybe Int ) -> String
-- generateMediaQuery ( min, max ) =
--     "@media " ++ mediaQuerySelector min max
--
--
-- inMediaQuery : Maybe String -> String -> String
-- inMediaQuery mediaQuery content =
--     case mediaQuery of
--         Nothing ->
--             content
--
--         Just queries ->
--             queries ++ Helpers.Css.surroundWithBraces content
--
--
-- mediaQuerySelector : Maybe Int -> Maybe Int -> String
-- mediaQuerySelector min max =
--     case min of
--         Nothing ->
--             case max of
--                 Nothing ->
--                     ""
--
--                 Just max_ ->
--                     "(max-width: " ++ toString max_ ++ "px)"
--
--         Just min_ ->
--             case max of
--                 Nothing ->
--                     "(min-width: " ++ toString min_ ++ "px)"
--
--                 Just max_ ->
--                     "(min-width: " ++ toString min_ ++ "px) and (max-width: " ++ toString max_ ++ "px)"
--
--
-- generateProperty : ( String, String ) -> String
-- generateProperty ( attribute, value ) =
--     attribute ++ ":" ++ value
--
--
-- compileStyleToCss : String -> Maybe String -> Maybe String -> String -> String
-- compileStyleToCss className mediaQueryId selector property =
--     "."
--         ++ className
--         ++ (mediaQueryId ? "")
--         ++ (selector ? "")
--         ++ Helpers.Css.surroundWithBraces property
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
