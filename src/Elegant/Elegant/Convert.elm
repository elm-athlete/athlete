module Elegant.Convert exposing (..)

import Display
import Function
import Helpers.Css
import Helpers.Style exposing (..)
import Maybe.Extra


-- import Native.Elegant


computeStyle : Display.DisplayBox -> List ( String, String )
computeStyle displayBox =
    Display.displayBoxToCouples displayBox


{-| This function focuses on generating classes names from Style and ScreenWidths.
classesNamesFromStyle accepts the content of a Style object, and
generates a list of Strings containing all classes names relative to the Style object.
-}
classesNamesFromStyle : Style -> List String
classesNamesFromStyle ({ screenWidths, display, suffix } as style) =
    let
        standardClassesNames =
            display
                |> Maybe.map computeStyle
                |> Maybe.withDefault []
                |> classesNameGeneration suffix
    in
    screenWidths
        |> List.concatMap (screenWidthToClassesNames suffix)
        |> List.append standardClassesNames


classesNameGeneration : Maybe String -> List ( String, String ) -> List String
classesNameGeneration suffix =
    List.map (Helpers.Css.generateClassName suffix)


screenWidthToClassesNames : Maybe String -> ScreenWidth -> List String
screenWidthToClassesNames suffix { min, max, style } =
    style
        |> computeStyle
        |> classesNameGeneration suffix
        |> List.map
            (addScreenWidthToClassName
                (Helpers.Css.cssValidName (String.fromInt min ++ String.fromInt max))
            )


addScreenWidthToClassName : String -> String -> String
addScreenWidthToClassName =
    Function.flip (++)


fetchStylesOrCompute : String -> Style -> List String
fetchStylesOrCompute styleHash style =
    []



-- Todo Fix That
-- case Native.Elegant.fetchStyles styleHash of
--     Nothing ->
--         let
--             classesNames =
--                 style
--                     |> extractScreenWidths
--                     |> List.concatMap compileConditionalStyle
--                     |> List.map computeAtomicClass
--                     |> Native.Elegant.addStyles styleHash
--         in
--         classesNames
--     Just classesNames ->
--         classesNames


type alias ConditionalStyle =
    { display : Display.DisplayBox
    , suffix : Maybe String
    , mediaQuery : Maybe ( Maybe Int, Maybe Int )
    }


extractScreenWidths : Style -> List ConditionalStyle
extractScreenWidths ({ display, suffix, screenWidths } as style) =
    screenWidths
        |> List.map (extractScreenWidth suffix)
        |> addDefaultStyle style


extractScreenWidth : Maybe String -> ScreenWidth -> ConditionalStyle
extractScreenWidth suffix { style, min, max } =
    { display = style
    , suffix = suffix
    , mediaQuery = Just ( min, max )
    }


addDefaultStyle : Style -> List ConditionalStyle -> List ConditionalStyle
addDefaultStyle { display, suffix, screenWidths } styles =
    case display of
        Nothing ->
            styles

        Just display_ ->
            { display = display_
            , suffix = suffix
            , mediaQuery = Nothing
            }
                :: styles


type alias AtomicClass =
    { mediaQuery : Maybe String
    , className : String
    , mediaQueryId : Maybe String
    , selector : Maybe String
    , property : String
    }


compileConditionalStyle : ConditionalStyle -> List AtomicClass
compileConditionalStyle { display, suffix, mediaQuery } =
    display
        |> computeStyle
        |> List.map (coupleToAtomicClass suffix mediaQuery)


coupleToAtomicClass : Maybe String -> Maybe ( Maybe Int, Maybe Int ) -> ( String, String ) -> AtomicClass
coupleToAtomicClass suffix mediaQuery property =
    { mediaQuery = Maybe.map Helpers.Css.generateMediaQuery mediaQuery
    , className = Helpers.Css.generateClassName suffix property
    , mediaQueryId = Maybe.map Helpers.Css.generateMediaQueryId mediaQuery
    , selector = Helpers.Css.generateSelector suffix
    , property = Helpers.Css.generateProperty property
    }


computeAtomicClass : AtomicClass -> String
computeAtomicClass ({ mediaQuery, className, mediaQueryId, selector, property } as atomicClass) =
    let
        classHash =
            atomicClass
    in
    ""



-- Todo : Fix Native
-- case Native.Elegant.fetchAtomicClass classHash of
--     Nothing ->
--         let
--             classNameComplete =
--                 String.join ""
--                     [ className
--                     , Maybe.withDefault "" mediaQueryId
--                     ]
--             test =
--                 computeStyleToCss className mediaQueryId selector property
--                     |> inMediaQuery mediaQuery
--                     |> Native.Elegant.addAtomicClass classHash classNameComplete
--         in
--         classNameComplete
--     Just class ->
--         class


inMediaQuery : Maybe String -> String -> String
inMediaQuery mediaQuery content =
    mediaQuery
        |> Maybe.map (Function.flip (++) (Helpers.Css.surroundWithBraces content))
        |> Maybe.withDefault content


computeStyleToCss : String -> Maybe String -> Maybe String -> String -> String
computeStyleToCss className mediaQueryId selector property =
    String.join ""
        [ "."
        , className
        , Maybe.withDefault "" mediaQueryId
        , Maybe.withDefault "" selector
        , Helpers.Css.surroundWithBraces property
        ]


boxSizingCss : String
boxSizingCss =
    "*{box-sizing: border-box;}"
