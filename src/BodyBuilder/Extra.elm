module BodyBuilder.Extra exposing
    ( b
    , betaSpacer
    , centeredDiv
    , centeredImage
    , computeHtmlAndStyle
    , contentIf
    , contentUnless
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
    , standardVerticallyCentered
    , t
    , verticallyCentered
    )

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


fi =
    B.flexItem


b val =
    B.span [ typography [ Typography.weight boldVal ] ] [ B.text val ]


smallSpacer : NodeWithStyle msg
smallSpacer =
    B.div [ A.style [ Style.box [ Box.paddingAll (px 3) ] ] ] []


spacer : NodeWithStyle msg
spacer =
    B.div [ A.style [ Style.box [ Box.paddingAll (px 6) ] ] ] []


betaSpacer : NodeWithStyle msg
betaSpacer =
    B.div [ A.style [ Style.box [ Box.paddingTop Constants.beta ] ] ] []


largeSpacer : NodeWithStyle msg
largeSpacer =
    B.div [ A.style [ Style.box [ Box.paddingAll Constants.large ] ] ] []


largePadderHorizontalAndBottom =
    B.div
        [ A.style
            [ Style.box
                [ Box.paddingHorizontal Constants.large
                , Box.paddingBottom Constants.large
                ]
            ]
        ]


largePadderTop =
    B.div
        [ A.style
            [ Style.box
                [ Box.paddingTop Constants.large
                ]
            ]
        ]


largePadder =
    B.div
        [ A.style
            [ Style.box
                [ Box.paddingAll Constants.large ]
            ]
        ]


grayScaledText shade content =
    B.span [ A.style [ Style.box [ Box.textColor (Color.grayscale shade) ] ] ] [ B.text content ]


centeredDiv =
    B.div [ A.style [ Style.blockProperties [ Block.alignCenter ] ] ]


t content =
    B.div [] [ B.text content ]


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


standardVerticallyCentered =
    verticallyCentered Nothing []


limitedWidth380WithPadding =
    limitedWidthWithPadding 380


limitedWidthWithPadding width =
    B.div
        [ A.style
            [ Style.blockProperties
                [ Block.maxWidth (px width)
                ]
            , Style.box
                [ Box.marginAuto
                , Box.paddingHorizontal Constants.medium
                ]
            ]
        ]


limitedAndCentered =
    standardVerticallyCentered << limitedWidth380WithPadding


contentIf question content =
    if question then
        content

    else
        B.none


contentUnless question content =
    if question then
        B.none

    else
        content


customStyle : String -> Html.Html msg
customStyle style =
    Html.node "style" [] [ Html.text style ]


htmlToNodeWithStyle htmlContent =
    ( htmlContent, [] )


resetBodyMarginStyle =
    rawStyle "body { margin: 0; }"


rawStyle =
    htmlToNodeWithStyle << customStyle


computeHtmlAndStyle viewFun =
    let
        ( content, style ) =
            viewFun
    in
    Html.div []
        [ customStyle (String.join " " style)
        , content
        ]


type alias RGBA =
    { red : Float
    , green : Float
    , blue : Float
    , alpha : Float
    }


ionIcon fun =
    ( fun 16
        (RGBA 0 0 0 1)
    , []
    )
