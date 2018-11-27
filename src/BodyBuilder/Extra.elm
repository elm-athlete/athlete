module BodyBuilder.Extra exposing
    ( b
    , centeredDiv
    , centeredImage
    , computeHtmlAndStyle
    , contentIf
    , contentUnless
    , customSpacer
    , customStyle
    , fi
    , grayScaledText
    , htmlToNodeWithStyle
    , ionIcon
    , largePadder
    , largePadderHorizontalAndBottom
    , largePadderTop
    , largeSpacer
    , limitedAndCentered
    , limitedWidth380WithPadding
    , limitedWidthWithPadding
    , rawStyle
    , resetBodyMarginStyle
    , smallSpacer
    , spacer
    , tinySpacer
    , standardVerticallyCentered
    , t
    , verticallyCentered
    )

{-|

@docs b
@docs centeredDiv
@docs centeredImage
@docs computeHtmlAndStyle
@docs contentIf
@docs contentUnless
@docs customSpacer
@docs customStyle
@docs fi
@docs grayScaledText
@docs htmlToNodeWithStyle
@docs ionIcon
@docs largePadder
@docs largePadderHorizontalAndBottom
@docs largePadderTop
@docs largeSpacer
@docs limitedAndCentered
@docs limitedWidth380WithPadding
@docs limitedWidthWithPadding
@docs rawStyle
@docs resetBodyMarginStyle
@docs smallSpacer
@docs spacer
@docs tinySpacer
@docs standardVerticallyCentered
@docs t
@docs verticallyCentered

-}

import BodyBuilder as B exposing (FlexItem, NodeWithStyle)
import BodyBuilder.Attributes as A
import BodyBuilder.Events as E
import BodyBuilder.Router as Router
import BodyBuilder.Style as Style
import Color
import Elegant exposing (percent, px)
import Elegant.Block as Block
import Elegant.Border as Border
import Elegant.Box as Box
import Elegant.Constants as Constants
import Elegant.Cursor as Cursor
import Elegant.Display as Display
import Elegant.Extra exposing (..)
import Elegant.Flex as Flex
import Elegant.Grid as Grid
import Elegant.Grid.Extra as GridExtra
import Elegant.Margin as Margin
import Elegant.Outline as Outline
import Elegant.Overflow as Overflow
import Elegant.Padding as Padding
import Elegant.Typography as Typography
import Html
import Html.Events.Extra.Touch as Touch
import Ionicon
import Ionicon.Ios as Ios
import Json.Decode as Decode
import Modifiers exposing (..)
import Time exposing (Month(..), Posix)


{-| -}
fi : Modifiers (A.FlexItemAttributes msg) -> List (NodeWithStyle msg) -> FlexItem msg
fi =
    B.flexItem


{-| -}
b : String -> NodeWithStyle msg
b val =
    B.span
        [ typography
            [ Typography.weight boldVal
            ]
        ]
        [ B.text val ]


{-| -}
customSpacer : Elegant.SizeUnit -> NodeWithStyle msg
customSpacer size =
    B.div [ paddingAll size ] []


{-| -}
tinySpacer : NodeWithStyle msg
tinySpacer =
    customSpacer Constants.tiny


{-| -}
smallSpacer : NodeWithStyle msg
smallSpacer =
    customSpacer Constants.small


{-| -}
spacer : NodeWithStyle msg
spacer =
    smallSpacer


{-| -}
largeSpacer : NodeWithStyle msg
largeSpacer =
    customSpacer Constants.large


{-| -}
largePadderHorizontalAndBottom : List (NodeWithStyle msg) -> NodeWithStyle msg
largePadderHorizontalAndBottom =
    B.div
        [ paddingHorizontal Constants.large
        , paddingBottom Constants.large
        ]


{-| -}
largePadderTop : List (NodeWithStyle msg) -> NodeWithStyle msg
largePadderTop =
    B.div
        [ paddingTop Constants.large
        ]


{-| -}
largePadder : List (NodeWithStyle msg) -> NodeWithStyle msg
largePadder =
    B.div
        [ paddingAll Constants.large ]


{-| -}
grayScaledText : Float -> String -> NodeWithStyle msg
grayScaledText shade content =
    B.span [ box [ Box.textColor (Color.grayscale shade) ] ] [ B.text content ]


{-| -}
centeredDiv : List (NodeWithStyle msg) -> NodeWithStyle msg
centeredDiv =
    B.div [ blockProperties [ Block.alignCenter ] ]


{-| -}
t : String -> NodeWithStyle msg
t content =
    B.div [] [ B.text content ]


{-| -}
centeredImage : Modifiers Display.BlockDetails -> String -> String -> NodeWithStyle msg
centeredImage blockProps alt src =
    B.flex
        [ displayBlock
        , flexContainerProperties
            [ Flex.justifyContent Flex.justifyContentCenter
            ]
        ]
        [ B.flexItem []
            [ B.img
                alt
                src
                [ paddingVertical (px 36)
                , block blockProps
                ]
            ]
        ]


{-| -}
verticallyCentered : Maybe Flex.Align -> Modifiers Box.Box -> NodeWithStyle msg -> NodeWithStyle msg
verticallyCentered alignItems boxStyle content =
    B.flex
        [ block [ Block.height (percent 100), Block.maxHeight (Elegant.vh 90) ]
        , flexContainerProperties
            ([ Flex.direction Flex.column
             , Flex.justifyContent Flex.justifyContentCenter
             ]
                ++ Maybe.withDefault [] (Maybe.map (Flex.align >> List.singleton) alignItems)
            )
        , box boxStyle
        ]
        [ B.flexItem []
            [ content ]
        ]


{-| -}
standardVerticallyCentered : NodeWithStyle msg -> NodeWithStyle msg
standardVerticallyCentered =
    verticallyCentered Nothing []


{-| -}
limitedWidth380WithPadding : List (NodeWithStyle msg) -> NodeWithStyle msg
limitedWidth380WithPadding =
    limitedWidthWithPadding 380


{-| -}
limitedWidthWithPadding : Int -> List (NodeWithStyle msg) -> NodeWithStyle msg
limitedWidthWithPadding width =
    B.div
        [ blockProperties
            [ Block.maxWidth (px width)
            ]
        , marginAuto
        , paddingHorizontal Constants.medium
        ]


{-| -}
limitedAndCentered : List (NodeWithStyle msg) -> NodeWithStyle msg
limitedAndCentered =
    standardVerticallyCentered << limitedWidth380WithPadding


{-| -}
contentIf : Bool -> NodeWithStyle msg -> NodeWithStyle msg
contentIf question content =
    if question then
        content

    else
        B.none


{-| -}
contentUnless : Bool -> NodeWithStyle msg -> NodeWithStyle msg
contentUnless question content =
    if question then
        B.none

    else
        content


{-| -}
customStyle : String -> Html.Html msg
customStyle style =
    Html.node "style" [] [ Html.text style ]


{-| -}
htmlToNodeWithStyle : Html.Html msg -> NodeWithStyle msg
htmlToNodeWithStyle htmlContent =
    ( htmlContent, [] )


{-| -}
resetBodyMarginStyle : NodeWithStyle msg
resetBodyMarginStyle =
    rawStyle "body { margin: 0; }"


{-| -}
rawStyle : String -> NodeWithStyle msg
rawStyle =
    htmlToNodeWithStyle << customStyle


{-| -}
computeHtmlAndStyle : ( Html.Html msg, List String ) -> Html.Html msg
computeHtmlAndStyle viewFun =
    let
        ( content, style ) =
            viewFun
    in
    Html.div []
        [ customStyle (String.join " " style)
        , content
        ]


{-| -}
type alias RGBA =
    { red : Float
    , green : Float
    , blue : Float
    , alpha : Float
    }


{-| -}
ionIcon : (number -> RGBA -> Html.Html msg) -> NodeWithStyle msg
ionIcon fun =
    ( fun 16
        (RGBA 0 0 0 1)
    , []
    )
