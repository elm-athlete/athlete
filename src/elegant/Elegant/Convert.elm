module Elegant.Convert exposing (..)

import Helpers.Css
import Maybe.Extra exposing ((?))
import Helpers.Style exposing (..)
import Display
import Native.Elegant


computeStyle : Display.DisplayBox -> List ( String, String )
computeStyle displayBox =
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
                (Helpers.Css.cssValidName (toString min ++ toString max))
            )


addScreenWidthToClassName : String -> String -> String
addScreenWidthToClassName =
    flip (++)



{- This part focus on generating CSS classes from Style. The main function is
   stylesToCss, accepting a list of Style, and generating the list of corresponding
   CSS classes. The first step consists to extract all the styles from the various
   screen widths (i.e. media queries in CSS), and merging them with the default styles.
   Then, they are transformed to atomic classes. They are records with the strict
   minimum inside, to turn them in CSS classes easily. Pre-compiled code are then added
   before returning the result.

   Using the same classes names generator than before, the classes matches easily
   and gives the correct behavior. The main function (fetchStylesOrCompute) is a
   caching function. The first thing done is to fetch if the Style has already
   been compiled. If it is, it just extract the styles from the cache, and returns
   them. Otherwise, it compiles the styles, and inserts them into the cache, for
   later use.
-}
-- stylesToCss : List Style -> List String
-- stylesToCss styles =
--     styles
--         |> List.concatMap fetchStylesOrCompute
--         |> List.append [ boxSizingCss ]
--         |> List.Extra.unique


fetchStylesOrCompute : String -> Style -> List String
fetchStylesOrCompute styleHash style =
    case Native.Elegant.fetchStyles styleHash of
        Nothing ->
            let
                classesNames =
                    style
                        |> extractScreenWidths
                        |> List.concatMap compileConditionalStyle
                        |> List.map computeAtomicClass
                        |> Native.Elegant.addStyles styleHash
            in
                classesNames

        Just classesNames ->
            classesNames


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
            toString atomicClass
    in
        case Native.Elegant.fetchAtomicClass classHash of
            Nothing ->
                let
                    classNameComplete =
                        String.join ""
                            [ className
                            , (mediaQueryId ? "")
                            ]

                    test =
                        computeStyleToCss className mediaQueryId selector property
                            |> inMediaQuery mediaQuery
                            |> Native.Elegant.addAtomicClass classHash classNameComplete
                in
                    classNameComplete

            Just class ->
                class


inMediaQuery : Maybe String -> String -> String
inMediaQuery mediaQuery content =
    mediaQuery
        |> Maybe.map (flip (++) (Helpers.Css.surroundWithBraces content))
        |> Maybe.withDefault content


computeStyleToCss : String -> Maybe String -> Maybe String -> String -> String
computeStyleToCss className mediaQueryId selector property =
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
