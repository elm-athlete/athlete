module Elegant.Internals.Convert exposing (..)

import Elegant.Display
import Elegant.Helpers.Css
import Elegant.Helpers.Style exposing (..)
import Function
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
    let
        toString a =
            case a of
                Nothing ->
                    "error"

                Just int ->
                    String.fromInt int
    in
    -- TODO : Fix that (it's very ugly)
    style
        |> computeStyle
        |> classesNameGeneration suffix
        |> List.map
            (addScreenWidthToClassName
                (Helpers.Css.cssValidName (toString min ++ toString max))
            )


addScreenWidthToClassName : String -> String -> String
addScreenWidthToClassName =
    Function.flip (++)


fetchStylesOrCompute : String -> Style -> List ( String, String )
fetchStylesOrCompute styleHash style =
    style
        |> extractScreenWidths
        |> List.concatMap compileConditionalStyle
        |> List.map computeAtomicClass


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
    { mediaQuery = Maybe.map Elegant.Helpers.Css.generateMediaQuery mediaQuery
    , className = Elegant.Helpers.Css.generateClassName suffix property
    , mediaQueryId = Maybe.map Elegant.Helpers.Css.generateMediaQueryId mediaQuery
    , selector = Elegant.Helpers.Css.generateSelector suffix
    , property = Elegant.Helpers.Css.generateProperty property
    }


computeAtomicClass : AtomicClass -> ( String, String )
computeAtomicClass ({ mediaQuery, className, mediaQueryId, selector, property } as atomicClass) =
    let
        classHash =
            atomicClass

        classNameComplete =
            String.join ""
                [ className
                , Maybe.withDefault "" mediaQueryId
                ]

        test =
            computeStyleToCss className mediaQueryId selector property
                |> inMediaQuery mediaQuery
    in
    ( classNameComplete, test )


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
        , Elegant.Helpers.Css.surroundWithBraces property
        ]


boxSizingCss : String
boxSizingCss =
    "*{box-sizing: border-box;}"
