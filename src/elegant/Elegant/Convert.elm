module Elegant.Convert exposing (..)

import Helpers.Css


-- import Helpers.Shared exposing (..)

import Helpers.Style exposing (..)
import Display


compileStyle : Display.DisplayBox -> List ( String, String )
compileStyle displayBox =
    Display.displayBoxToCouples displayBox



{- This parts focused on generating classes names from Style and ScreenWidths.
   classesNamesFromStyleAndScreenWidths accepts the content of a Style object, and
   generates a list of Strings containing all classes names relative to the Style object.
   The function can take a suffix, which is a Maybe String. This symbolize the
   possible suffix of the style, i.e. the pseudo-classes and selectors in CSS.

   classesNamesFromStyleAndScreenWidths (Just "hover") generates classes names
   looking like my-example-class-name_hover, where classesNamesFromStyleAndScreenWidths
   Nothing generates classes names looking like my-example-class-name. This is useful
   to later generates the corresponding CSS class my-example-class-name_hover:hover
   containing styles, visible only on hover. This allows to handle all possible
   pseudo-classes and selectors, while keeping CSS classes as short as possible.
-}


classesNamesFromStyleAndScreenWidths : Maybe String -> StyleAndScreenWidths -> List String
classesNamesFromStyleAndScreenWidths suffix ({ screenWidths, display } as style) =
    let
        standardClassesNames =
            display
                |> Maybe.map compileStyle
                |> Maybe.withDefault []
                |> classesNameGeneration suffix
    in
        screenWidths
            |> List.concatMap (screenWidthToClassesNames suffix)
            |> List.append standardClassesNames


classesNameGeneration : Maybe String -> List ( String, String ) -> List String
classesNameGeneration suffix =
    List.map (generateClassName suffix)


generateClassName : Maybe String -> ( String, String ) -> String
generateClassName suffix ( attribute, value ) =
    [ attribute, value ]
        |> String.join "-"
        |> addSuffixToClassName suffix
        |> Helpers.Css.cssValidName


addSuffixToClassName : Maybe String -> String -> String
addSuffixToClassName suffix className =
    suffix
        |> Maybe.map Helpers.Css.prependUnderscore
        |> Maybe.withDefault ""
        |> (++) className


screenWidthToClassesNames : Maybe String -> ScreenWidth -> List String
screenWidthToClassesNames suffix { min, max, style } =
    style
        |> compileStyle
        |> classesNameGeneration suffix
        |> List.map (addScreenWidthToClassName min max)


addScreenWidthToClassName : Maybe Int -> Maybe Int -> String -> String
addScreenWidthToClassName min max className =
    (toString min ++ toString max)
        |> Helpers.Css.cssValidName
        |> (++) className
