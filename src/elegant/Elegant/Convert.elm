module Elegant.Convert exposing (..)

import Helpers.Css
import List.Extra
import Maybe.Extra exposing ((?))
import Dict exposing (Dict)


-- import Helpers.Shared exposing (..)

import Helpers.Style exposing (..)
import Display


compileStyle : Display.DisplayBox -> List ( String, String )
compileStyle displayBox =
    Display.displayBoxToCouples displayBox



{- This parts focused on generating classes names from Style and ScreenWidths.
   classesNamesFromStyle accepts the content of a Style object, and
   generates a list of Strings containing all classes names relative to the Style object.
   The function can take a suffix, which is a Maybe String. This symbolize the
   possible suffix of the style, i.e. the pseudo-classes and selectors in CSS.

   classesNamesFromStyle (Just "hover") generates classes names
   looking like my-example-class-name_hover, where classesNamesFromStyle
   Nothing generates classes names looking like my-example-class-name. This is useful
   to later generates the corresponding CSS class my-example-class-name_hover:hover
   containing styles, visible only on hover. This allows to handle all possible
   pseudo-classes and selectors, while keeping CSS classes as short as possible.
-}


classesNamesFromStyle : Style -> List String
classesNamesFromStyle ({ screenWidths, display, suffix } as style) =
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



{- This part focus on generating CSS classes from Style. The main function is
   stylesToCss, accepting a list of Style, and generating the list of corresponding
   CSS classes. The first step consists to extract all the styles from the various
   screen widths (i.e. media queries in CSS), and merging them with the default styles.
   Then, they are transformed to atomic classes. They are records with the strict
   minimum inside, to turn them in CSS classes easily. Pre-compiled code are then added
   before returning the result.

   Using the same classes names generator than before, the classes matches easily
   and gives the correct behavior.
-}


stylesToCss : List Style -> List String
stylesToCss styles =
    styles
        |> List.foldr fetchStylesOrCompute ( Dict.empty, [] )
        |> Tuple.second
        |> List.append [ boxSizingCss ]
        |> List.Extra.unique


type FetchOrComputeStyle
    = FetchedAtomicCss (List String)
    | ComputedAtomicClasses (List AtomicClass)


type FetchOrComputeAtomicClasses
    = FetchedAtomicClassesCss (List String)
    | ComputedAtomicCss ( String, AtomicClass )


fetchStylesOrCompute :
    Style
    -> ( Dict String (List String), List String )
    -> ( Dict String (List String), List String )
fetchStylesOrCompute style ( cache, accumulator ) =
    case fetchStyleAtomicCss cache style of
        FetchedAtomicCss fetchedAtomicCss ->
            ( cache, fetchedAtomicCss ++ accumulator )

        ComputedAtomicClasses computedAtomicClasses ->
            let
                { fetched, computed } =
                    fetchAtomicClassAtomicCss cache computedAtomicClasses

                atomicCss =
                    fetched ++ (List.map Tuple.first computed)
            in
                computed
                    |> List.foldl insertAtomicClassAtomicCss cache
                    |> Dict.insert (toString style) atomicCss
                    |> flip (,) (atomicCss ++ accumulator)


insertAtomicClassAtomicCss : ( String, AtomicClass ) -> Dict String (List String) -> Dict String (List String)
insertAtomicClassAtomicCss ( computedCss, atomicClass ) cacheAcc =
    Dict.insert (toString atomicClass) [ computedCss ] cacheAcc



-- case fetchAtomicClassAtomicCss cache computedAtomicClasses of
--     FetchedAtomicClassesCss fetchedAtomicCss ->
--         ( Dict.insert (toString style) fetchedAtomicCss cache
--         , fetchedAtomicCss :: accumulator
--         )
--     ComputedAtomicCss computedAtomicCss ->
--         ( computedAtomicCss
--             |> List.foldr insertAtomicClassAtomicCss cache
--             |> Dict.insert (toString style) computedAtomicCss
--         , computedAtomicCss :: accumulator
--         )


fetchStyleAtomicCss : Dict String (List String) -> Style -> FetchOrComputeStyle
fetchStyleAtomicCss cache style =
    case Dict.get (toString style) cache of
        Just atomicCss ->
            FetchedAtomicCss atomicCss

        Nothing ->
            style
                |> extractScreenWidths
                |> List.concatMap compileConditionalStyle
                |> ComputedAtomicClasses


fetchAtomicClassAtomicCss :
    Dict String (List String)
    -> List AtomicClass
    -> { fetched : List String, computed : List ( String, AtomicClass ) }
fetchAtomicClassAtomicCss cache atomicClasses =
    let
        computedAtomicCss =
            List.map (getAtomicClassAtomicCss cache) atomicClasses
    in
        { fetched =
            computedAtomicCss
                |> List.filter selectFetchedAtomicClassesCss
                |> List.concatMap extractFetchedAtomicClassesCss
        , computed =
            computedAtomicCss
                |> List.filter selectComputedAtomicClassesCss
                |> List.concatMap extractComputedAtomicClassesCss
        }


getAtomicClassAtomicCss : Dict String (List String) -> AtomicClass -> FetchOrComputeAtomicClasses
getAtomicClassAtomicCss cache atomicClass =
    case Dict.get (toString atomicClass) cache of
        Nothing ->
            ComputedAtomicCss ( compileAtomicClass atomicClass, atomicClass )

        Just atomicCss ->
            FetchedAtomicClassesCss atomicCss


selectFetchedAtomicClassesCss : FetchOrComputeAtomicClasses -> Bool
selectFetchedAtomicClassesCss fetchedAtomicClassesCss =
    case fetchedAtomicClassesCss of
        FetchedAtomicClassesCss _ ->
            True

        ComputedAtomicCss _ ->
            False


extractFetchedAtomicClassesCss : FetchOrComputeAtomicClasses -> List String
extractFetchedAtomicClassesCss fetchAtomicClassAtomicCss =
    case fetchAtomicClassAtomicCss of
        FetchedAtomicClassesCss value ->
            value

        ComputedAtomicCss _ ->
            []


selectComputedAtomicClassesCss : FetchOrComputeAtomicClasses -> Bool
selectComputedAtomicClassesCss =
    not << selectFetchedAtomicClassesCss


extractComputedAtomicClassesCss
    : FetchOrComputeAtomicClasses
    -> List ( String, AtomicClass )
extractComputedAtomicClassesCss fetchAtomicClassAtomicCss =
    case fetchAtomicClassAtomicCss of
        FetchedAtomicClassesCss _ ->
            []

        ComputedAtomicCss value ->
            [ value ]


-- bar style ( cache, accumulator ) =
--     let
--         styleHash =
--             toString style
--     in
--         case Dict.get styleHash cache of
--             Nothing ->
--                 let
--                     computedStyles =
--                         style
--                             |> extractScreenWidths
--                             |> List.concatMap compileConditionalStyle
--                             |> List.map compileAtomicClass
--                 in
--                     ( Dict.insert styleHash computedStyles cache, List.append computedStyles accumulator )
--
--             Just computedStyles ->
--                 ( cache, List.append computedStyles accumulator )


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
        |> compileStyle
        |> List.map (coupleToAtomicClass suffix mediaQuery)


coupleToAtomicClass : Maybe String -> Maybe ( Maybe Int, Maybe Int ) -> ( String, String ) -> AtomicClass
coupleToAtomicClass suffix mediaQuery property =
    { mediaQuery = Maybe.map generateMediaQuery mediaQuery
    , className = generateClassName suffix property
    , mediaQueryId = Maybe.map generateMediaQueryId mediaQuery
    , selector = generateSelector suffix
    , property = generateProperty property
    }


generateMediaQuery : ( Maybe Int, Maybe Int ) -> String
generateMediaQuery ( min, max ) =
    "@media " ++ mediaQuerySelector min max


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


generateMediaQueryId : ( Maybe Int, Maybe Int ) -> String
generateMediaQueryId ( min, max ) =
    String.filter Helpers.Css.isValidInCssName (toString min ++ toString max)


generateSelector : Maybe String -> Maybe String
generateSelector =
    Maybe.map ((++) ":")


generateProperty : ( String, String ) -> String
generateProperty ( attribute, value ) =
    attribute ++ ":" ++ value


compileAtomicClass : AtomicClass -> String
compileAtomicClass { mediaQuery, className, mediaQueryId, selector, property } =
    inMediaQuery mediaQuery <|
        compileStyleToCss className mediaQueryId selector property


inMediaQuery : Maybe String -> String -> String
inMediaQuery mediaQuery content =
    mediaQuery
        |> Maybe.map
            (flip (++) (Helpers.Css.surroundWithBraces content))
        |> Maybe.withDefault content


compileStyleToCss : String -> Maybe String -> Maybe String -> String -> String
compileStyleToCss className mediaQueryId selector property =
    String.join ""
        [ "."
        , className
        , (mediaQueryId ? "")
        , (selector ? "")
        , Helpers.Css.surroundWithBraces property
        ]


boxSizingCss : String
boxSizingCss =
    "*{box-sizing: border-box;}"
