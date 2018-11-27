module BodyBuilder.Elements.Clickable exposing
    ( blackButton
    , fullSizeButton
    , fullWidthButton
    , greyButton
    , hyperDarkerBlue
    , link
    , mailtoLink
    , monochromeBox
    , monochromeSquaredButton
    , removeButtonStyle
    )

import BodyBuilder as B exposing (FlexItem, NodeWithStyle)
import BodyBuilder.Attributes as A
import BodyBuilder.Events as E
import BodyBuilder.Extra exposing (..)
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


touchOrClick msg =
    [ A.rawAttribute (Touch.onEnd (\_ -> msg)), E.onClick msg ]


hyperDarkerBlue : Color.Color
hyperDarkerBlue =
    Color.rgb 43 143 208


borderColor : Color.Color
borderColor =
    Color.grayscale 0.1


link otherAttributes content msg =
    B.a
        ([ A.style
            [ Style.box
                removeButtonStyle
            ]
         , E.onClick msg
         ]
            ++ otherAttributes
        )
        [ B.text content ]


mailtoLink address =
    B.a [ A.href ("mailto:" ++ address) ] [ B.text address ]


removeButtonStyle =
    [ Box.borderNone
    , Box.backgroundColor (Color.rgba 0 0 0 0)
    , Box.cursorPointer
    , Box.typography [ Typography.size (px 17) ]
    , Box.paddingAll (px 0)
    ]


monochromeBox colors =
    [ Box.border
        [ Border.all
            [ Border.solid
            , Border.color colors.border
            , Border.thickness (px 1)
            ]
        ]
    , Box.paddingAll (px 12)
    , Box.backgroundColor colors.background
    , Box.textColor colors.text
    , Box.cursorPointer
    , Box.typography
        [ Typography.color colors.text
        , Typography.size (px 14)
        , Typography.weight boldVal
        ]
    ]


monochromeSquaredButton colors content msg =
    B.button
        [ A.style
            [ Style.box
                (monochromeBox colors)
            , Style.block
                [ Block.width (percent 100) ]
            ]
        , E.onClick msg
        ]
        [ B.text content ]


greyButton =
    monochromeSquaredButton
        { background = Color.grey
        , border = Color.grey
        , text = Color.white
        }


blackButton =
    monochromeSquaredButton
        { background = Color.black
        , border = Color.black
        , text = Color.white
        }


fullWidthButton : String -> msg -> NodeWithStyle msg
fullWidthButton content msg =
    B.button
        [ A.style
            [ Style.box
                [ Box.borderSolid
                , Box.borderColor borderColor
                , Box.backgroundColor hyperDarkerBlue
                , Box.typography
                    [ Typography.color Color.white
                    , Typography.size (px 14)
                    , Typography.weight boldVal
                    ]
                ]
            , Style.block
                [ Block.width (percent 100), Block.height (percent 100) ]
            ]
        , E.onClick msg
        ]
        [ B.text content ]


fullSizeButton text msg =
    B.button
        [ A.style
            [ Style.block [ Block.height (percent 100), Block.width (percent 100) ]
            , Style.box
                [ Box.margin
                    [ Margin.all
                        (Margin.width Constants.zero)
                    ]
                , Box.paddingAll Constants.zero
                , typoSize 14
                , Box.backgroundColor Color.white
                , Box.borderNone
                ]
            ]
        , cursorPointer
        , E.onClick msg
        ]
        [ verticallyCentered (Just Flex.alignCenter)
            []
            (B.text text)
        ]
