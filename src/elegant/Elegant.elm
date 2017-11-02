module Elegant
    exposing
        ( Modifier
        , Modifiers
        , SizeUnit
        , Style
        , CommonStyle
        , commonStyle
        , classes
        , color
        , em
        , emptyStyle
        , inlineStyle
        , opposite
        , percent
        , pt
        , px
        , rem
        , screenWidthBetween
        , screenWidthGE
        , screenWidthLE
        , setSuffix
        , style
        , commonStyleToCss
        , styleToCss
        , toCommonStyle
        , toInlineStyles
        , vh
        , withScreenWidth
        )

{-|
@docs Modifier
@docs Modifiers
@docs SizeUnit
@docs Style
@docs classes
@docs color
@docs em
@docs emptyStyle
@docs inlineStyle
@docs opposite
@docs percent
@docs pt
@docs px
@docs rem
@docs screenWidthBetween
@docs screenWidthGE
@docs screenWidthLE
@docs setSuffix
@docs style
@docs styleToCss
@docs toCommonStyle
@docs toInlineStyles
@docs vh
@docs withScreenWidth
-}

import Html exposing (Html)
import Html.Attributes
import Helpers.Shared exposing (..)
import Helpers.Style as CommonStyle
import Display exposing (DisplayBox)
import Elegant.Convert
import Elegant.Setters exposing (..)
import Native.BodyBuilder


{-| Contains all style for an element used with Elegant.
-}
type Style
    = Style CommonStyle.Style


type alias CommonStyle =
    CommonStyle.Style


commonStyle :
    Maybe DisplayBox
    -> List CommonStyle.ScreenWidth
    -> Maybe String
    -> CommonStyle.Style
commonStyle =
    CommonStyle.Style


{-| -}
type alias Modifiers a =
    Helpers.Shared.Modifiers a


{-| -}
type alias Modifier a =
    Helpers.Shared.Modifier a


{-| -}
style : DisplayBox -> Style
style display =
    Style
        { display = Just display
        , screenWidths = []
        , suffix = Nothing
        }


{-| -}
emptyStyle : Style
emptyStyle =
    Style
        { display = Nothing
        , screenWidths = []
        , suffix = Nothing
        }


{-| -}
setSuffix : String -> Style -> Style
setSuffix value (Style style) =
    style
        |> CommonStyle.setSuffix value
        |> Style


{-| -}
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
        |> Maybe.map Elegant.Convert.computeStyle
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



-- stylesToCss : List Style -> List String
-- stylesToCss styles =
--     styles
--         |> List.map toCommonStyle
--         |> Elegant.Convert.stylesToCss


commonStyleToCss : CommonStyle -> String
commonStyleToCss style =
    let
        styleHash =
            toString style
    in
        case Native.BodyBuilder.fetchClassesNames styleHash of
            Nothing ->
                style
                    |> Elegant.Convert.fetchStylesOrCompute styleHash
                    |> String.join " "
                    |> Native.BodyBuilder.addClassesNames styleHash

            Just classesNames ->
                classesNames


{-| -}
styleToCss : Style -> String
styleToCss (Style style) =
    commonStyleToCss style


{-| -}
toCommonStyle : Style -> CommonStyle.Style
toCommonStyle (Style style) =
    style



-- Alias


{-| -}
type alias SizeUnit =
    Helpers.Shared.SizeUnit


{-| -}
px : Int -> SizeUnit
px =
    Px


{-| -}
pt : Int -> SizeUnit
pt =
    Pt


{-| -}
percent : Float -> SizeUnit
percent =
    Percent


{-| -}
vh : Float -> SizeUnit
vh =
    Vh


{-| -}
em : Float -> SizeUnit
em =
    Em


{-| -}
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
