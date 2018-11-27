module Elegant.Extra exposing
    ( alignCenter
    , alignItemsCenter
    , backgroundColor
    , block
    , blockProperties
    , blockWithWidth
    , bold
    , boldVal
    , border
    , borderBottomBlack
    , borderTopBlack
    , box
    , cursorPointer
    , displayBlock
    , flexContainerProperties
    , fontSize
    , goodTypo
    , goodTypoStyle
    , gray
    , grow
    , italic
    , margin
    , marginAuto
    , noMargin
    , padding
    , paddingAll
    , paddingBottom
    , paddingBottomLarge
    , paddingHorizontal
    , paddingTop
    , paddingVertical
    , regular
    , spaceBetween
    , standardCellStyle
    , textCenter
    , thinTypo
    , typoSize
    , typography
    , underline
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


thinTypo =
    typography [ Typography.weight 100 ]


typography typo =
    box [ Box.typography typo ]


box boxContent =
    A.style [ Style.box boxContent ]


grow =
    A.style [ Style.flexItemProperties [ Flex.grow 1 ] ]


cursorPointer =
    box [ Box.cursorPointer ]


padding val =
    box [ Box.padding val ]


paddingAll val =
    padding [ Padding.all val ]


paddingBottom val =
    padding [ Padding.bottom val ]


paddingBottomLarge =
    paddingBottom Constants.large


paddingTop val =
    padding [ Padding.top val ]


paddingHorizontal val =
    padding [ Padding.horizontal val ]


paddingVertical val =
    padding [ Padding.vertical val ]


displayBlock =
    block [ Block.fullWidth ]


underline =
    typography [ Typography.underline ]


block e =
    A.style [ Style.block e ]


blockWithWidth width =
    block [ Block.width width ]


blockProperties e =
    A.style [ Style.blockProperties e ]


boldVal : Int
boldVal =
    700


regular : Int
regular =
    400


bold =
    typography [ Typography.weight boldVal ]


gray : Color.Color
gray =
    Color.grayscale 0.02


goodTypo =
    Box.typography
        [ Typography.fontFamilyInherit
        , Typography.size Constants.zeta
        ]


standardCellStyle : Modifier (A.BoxContainer (A.MaybeBlockContainer a))
standardCellStyle =
    A.style
        [ Style.block
            [ Display.alignment Display.left
            , Display.fullWidth
            ]
        , Style.box
            [ Box.cursor Cursor.pointer
            , Box.border
                [ Border.all [ Border.none ]
                ]
            , Box.outline [ Outline.none ]
            , goodTypo
            ]
        ]


{-| returns a background with a color
-}
backgroundColor : Color.Color -> Modifier Box.Box
backgroundColor color =
    Box.background [ Elegant.color color ]


margin val =
    A.style [ Style.box [ Box.margin val ] ]


italic =
    typography [ Typography.italic ]


noMargin =
    margin [ Margin.all (Margin.width (px 0)) ]


marginAuto =
    box [ Box.marginAuto ]


typoSize pxNumber =
    Box.typography [ Typography.size (px pxNumber) ]


fontSize fSize =
    typography [ Typography.size fSize ]


goodTypoStyle =
    A.style [ Style.box [ goodTypo ] ]


alignCenter =
    block [ Block.alignCenter ]


borderBottomBlack =
    border
        [ Border.bottom
            [ Border.color Color.black
            , Border.solid
            , Border.thickness (px 1)
            ]
        ]


border e =
    box [ Box.border e ]


spaceBetween =
    A.style
        [ Style.flexContainerProperties
            [ Flex.justifyContent
                Flex.spaceBetween
            ]
        ]


alignItemsCenter =
    flexContainerProperties
        [ Flex.align
            Flex.alignCenter
        ]


flexContainerProperties e =
    A.style
        [ Style.flexContainerProperties e
        ]


borderTopBlack =
    A.style
        [ Style.box
            [ Box.border
                [ Border.top
                    [ Border.solid
                    , Border.thickness (px 1)
                    , Border.color Color.black
                    ]
                ]
            ]
        ]


textCenter =
    A.style [ Style.blockProperties [ Block.alignCenter ] ]
