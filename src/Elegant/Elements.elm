module Elegant.Elements
    exposing
        ( border
        , borderBottom
        , flexnav
        , link
        , pageCenter
        , centerHorizontal
        )

{-| @docs border
@docs flexnav
@docs border
@docs borderBottom
@docs link
@docs pageCenter
@docs centerHorizontal
-}

import Elegant exposing (..)
import Color exposing (Color)
import Html
import Html.Attributes
import Function exposing (..)


{-| Create a nice looking Link
-}
link : Color -> Style -> Style
link color =
    [ textDecorationNone
    , textColor color
    ]
        |> compose


{-| Create a solid border with 1px of width and the color is a parameter
-}
border : Color -> Style -> Style
border color =
    [ borderColor color
    , borderSolid
    , borderWidth 1
    ]
        |> compose


{-| Create a solid border bottom with 1px of width and the color is a parameter
-}
borderBottom : Color -> Style -> Style
borderBottom color =
    [ borderBottomColor color
    , borderBottomSolid
    , borderBottomWidth 1
    ]
        |> compose


{-| Create a flex navigation
-}
flexnav : Style -> Style
flexnav =
    [ listStyleNone
    , displayFlex
    , alignItemsCenter
    , justifyContentSpaceBetween
    , widthPercent 100
    ]
        |> compose


{-| Create a centered element (vertically and horizontally)
-}
pageCenter : Style -> Style
pageCenter =
    [ displayFlex
    , alignItemsCenter
    , justifyContentCenter
    , height (Vh 100)
    ]
        |> compose


{-| Create a centered element (vertically and horizontally)
-}
centerHorizontal : Style -> Style
centerHorizontal =
    [ displayFlex
    , justifyContentCenter
    ]
        |> compose


main : Html.Html msg
main =
    Html.div []
        [ Html.a [ inlineStyle [ fontSize gamma, paddingRight medium ] ] [ Html.text "Brand" ]
        , Html.input
            [ Html.Attributes.type_ "text"
            , inlineStyle
                [ borderRadius 4
                , border Color.gray
                , marginRight (Px 4)
                ]
            ]
            []
        , Html.button
            [ inlineStyle
                [ borderRadius 4
                , border Color.gray
                , textColor Color.black
                , backgroundColor Color.white
                ]
            ]
            [ Html.text "Brand" ]
        ]
