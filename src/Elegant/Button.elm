module Elegant.Button exposing (btnStyle)

{-|
@docs btnStyle
-}

import Html exposing (Html)
import Html.Attributes
import Elegant exposing (..)
import Elegant.Elements exposing (..)
import Elegant.Helpers exposing (..)
import Color exposing (Color)


{-| Create a nice looking button
-}
btnStyle : ( SizeUnit, SizeUnit ) -> List (Style -> Style)
btnStyle ( paddingVertical_, paddingHorizontal_ ) =
    [ displayInlineBlock
    , verticalAlignMiddle
    , fontInherit
    , margin (Px 0)
    , textCenter
    , paddingVertical paddingVertical_
    , paddingHorizontal paddingHorizontal_
    ]


type alias Styles =
    { default : List (Style -> Style)
    , hover : Maybe (List (Style -> Style))
    , selected : Maybe (List (Style -> Style))
    }


type ButtonStyle
    = ButtonStyle
        { size : ( SizeUnit, SizeUnit )
        , round : Bool
        , color : Color
        , hoverColor : Maybe Color
        , reverse : Bool
        , link : Bool
        }


defaultStyle : ButtonStyle
defaultStyle =
    ButtonStyle
        { size = ( medium, medium )
        , round = False
        , color = Color.black
        , hoverColor = Nothing
        , reverse = False
        , link = False
        }


small : ButtonStyle -> ButtonStyle
small (ButtonStyle style_) =
    ButtonStyle { style_ | size = ( Elegant.small, Elegant.small ) }


custom : ( SizeUnit, SizeUnit ) -> ButtonStyle -> ButtonStyle
custom size_ (ButtonStyle style_) =
    ButtonStyle { style_ | size = size_ }


round : ButtonStyle -> ButtonStyle
round (ButtonStyle style_) =
    ButtonStyle { style_ | round = True }


color : Color -> ButtonStyle -> ButtonStyle
color color_ (ButtonStyle style_) =
    ButtonStyle { style_ | color = color_ }


reverse : ButtonStyle -> ButtonStyle
reverse (ButtonStyle style_) =
    ButtonStyle { style_ | reverse = True }


link : ButtonStyle -> ButtonStyle
link (ButtonStyle style_) =
    ButtonStyle { style_ | link = True }


hoverColor : Color -> ButtonStyle -> ButtonStyle
hoverColor color_ (ButtonStyle style_) =
    ButtonStyle { style_ | hoverColor = Just color_ }


btn : List (ButtonStyle -> ButtonStyle) -> Styles
btn styles =
    let
        { size, round, color, hoverColor, reverse, link } =
            case (compose styles) defaultStyle of
                ButtonStyle styles_ ->
                    styles_
    in
        { default =
            List.append
                (btnStyle size)
                [ if round then
                    Elegant.round
                  else
                    identity
                , Elegant.textColor <|
                    if reverse && not link then
                        Color.white
                    else
                        color
                , Elegant.backgroundColor <|
                    if reverse && not link then
                        color
                    else
                        transparent
                , if link then
                    identity
                  else
                    border color
                , if link then
                    textDecorationNone
                  else
                    identity
                ]
        , hover =
            Just
                [ Elegant.backgroundColor <|
                    if link then
                        transparent
                    else
                        color
                , Elegant.textColor <|
                    case hoverColor of
                        Nothing ->
                            Color.white

                        Just color ->
                            color
                ]
        , selected = Nothing
        }


label : String -> List (Html msg)
label label_ =
    [ Html.text label_ ]


icon : String -> Html msg
icon icon_ =
    Html.i
        (List.concat
            [ [ Html.Attributes.class "icon"
              , Html.Attributes.class icon_
              ]
            , [ style
                    [ fontSize beta
                    , verticalAlignMiddle
                    ]
              ]
            ]
        )
        []
