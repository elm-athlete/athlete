module Elegant exposing (..)

import Html exposing (Html)
import Html.Attributes
import Helpers.Shared exposing (..)
import Helpers.Style as CommonStyle
import Display exposing (DisplayBox)
import Elegant.Convert
import Elegant.Setters exposing (..)


{-| Contains all style for an element used with Elegant.
-}
type Style
    = Style CommonStyle.Style


{-| -}
style : DisplayBox -> Style
style display =
    Style
        { display = Just display
        , screenWidths = []
        , suffix = Nothing
        }


setSuffix : String -> Style -> Style
setSuffix value (Style style) =
    style
        |> CommonStyle.setSuffix value
        |> Style


withScreenWidth : List CommonStyle.ScreenWidth -> Modifier Style
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
        |> Elegant.Convert.classesNamesFromStyle
        |> String.join " "


classesWithSuffix : Style -> String
classesWithSuffix (Style style) =
    style
        |> Elegant.Convert.classesNamesFromStyle
        |> String.join " "


{-| Generate all the classes of a list of Hover Styles
-}
classesHover : Style -> String
classesHover =
    classesWithSuffix


{-| Generate all the classes of a list of Focus Styles
-}
classesFocus : Style -> String
classesFocus =
    classesWithSuffix


stylesToCss : List Style -> List String
stylesToCss styles =
    styles
        |> List.map toCommonStyle
        |> Elegant.Convert.stylesToCss


toCommonStyle : Style -> CommonStyle.Style
toCommonStyle (Style style) =
    style



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
