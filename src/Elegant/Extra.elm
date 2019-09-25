module Elegant.Extra exposing
    ( alignCenter
    , alignItemsCenter
    , fillHeight
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
    , overflowHidden
    , cornerRadius
    , cursorPointer
    , displayBlock
    , flexContainerProperties
    , flexItemProperties
    , fontSize
    , goodTypo
    , goodTypoStyle
    , gray
    , gridContainerProperties
    , grow
    , italic
    , margin
    , marginAuto
    , noDecoration
    , noMargin
    , padding
    , paddingAll
    , paddingBottom
    , paddingBottomLarge
    , paddingHorizontal
    , paddingLeft
    , paddingRight
    , paddingTop
    , paddingVertical
    , regular
    , spaceBetween
    , standardCellStyle
    , textCenter
    , textColor
    , thinTypo
    , typography
    , typoSize
    , underline
    )

{-|

@docs alignCenter
@docs alignItemsCenter
@docs fillHeight
@docs backgroundColor
@docs block
@docs blockProperties
@docs blockWithWidth
@docs bold
@docs boldVal
@docs border
@docs borderBottomBlack
@docs borderTopBlack
@docs box
@docs overflowHidden
@docs cornerRadius
@docs cursorPointer
@docs displayBlock
@docs flexContainerProperties
@docs flexItemProperties
@docs fontSize
@docs goodTypo
@docs goodTypoStyle
@docs gray
@docs gridContainerProperties
@docs grow
@docs italic
@docs margin
@docs marginAuto
@docs noDecoration
@docs noMargin
@docs padding
@docs paddingAll
@docs paddingBottom
@docs paddingBottomLarge
@docs paddingHorizontal
@docs paddingLeft
@docs paddingRight
@docs paddingTop
@docs paddingVertical
@docs regular
@docs spaceBetween
@docs standardCellStyle
@docs textCenter
@docs textColor
@docs thinTypo
@docs typography
@docs typoSize
@docs underline

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
import Elegant.Flex as Flex
import Elegant.Grid as Grid
import Elegant.Grid.Extra as GridExtra
import Elegant.Margin as Margin
import Elegant.Outline as Outline
import Elegant.Overflow as Overflow
import Elegant.Padding as Padding
import Elegant.Surrounded as Surrounded exposing (Surrounded)
import Elegant.Typography as Typography
import Html
import Html.Events.Extra.Touch as Touch
import Ionicon
import Ionicon.Ios as Ios
import Json.Decode as Decode
import Modifiers exposing (..)
import Time exposing (Month(..), Posix)


type alias BoxContainerModifier a =
    Modifier (A.BoxContainer a)


{-| -}
boldVal : Int
boldVal =
    700


{-| -}
regular : Int
regular =
    400


{-| -}
typography : Modifiers Typography.Typography -> BoxContainerModifier a
typography typo =
    box [ Box.typography typo ]


{-| -}
bold : BoxContainerModifier a
bold =
    typography [ Typography.weight boldVal ]


{-| -}
thinTypo : BoxContainerModifier a
thinTypo =
    typography [ Typography.weight 100 ]


{-| -}
italic : BoxContainerModifier a
italic =
    typography [ Typography.italic ]


{-| -}
fontSize : Elegant.SizeUnit -> BoxContainerModifier a
fontSize fSize =
    typography [ Typography.size fSize ]


{-| -}
noDecoration : BoxContainerModifier a
noDecoration =
    typography [ Typography.noDecoration ]


{-| -}
underline : BoxContainerModifier a
underline =
    typography [ Typography.underline ]


{-| -}
goodTypo : Modifier Box.Box
goodTypo =
    Box.typography
        [ Typography.fontFamilyInherit
        , Typography.size Constants.zeta
        ]


{-| -}
typoSize : Int -> Modifier Box.Box
typoSize pxNumber =
    Box.typography
        [ Typography.size (px pxNumber)
        ]


{-| -}
goodTypoStyle : BoxContainerModifier a
goodTypoStyle =
    box [ goodTypo ]


{-| -}
box : Modifiers Box.Box -> BoxContainerModifier a
box boxContent =
    A.style [ Style.box boxContent ]


{-| -}
cursorPointer : BoxContainerModifier a
cursorPointer =
    box [ Box.cursorPointer ]


{-| -}
paddingAll : Elegant.SizeUnit -> BoxContainerModifier a
paddingAll val =
    padding [ Padding.all val ]


{-| -}
paddingRight : Elegant.SizeUnit -> BoxContainerModifier a
paddingRight val =
    padding [ Padding.right val ]


{-| -}
paddingLeft : Elegant.SizeUnit -> BoxContainerModifier a
paddingLeft val =
    padding [ Padding.left val ]


{-| -}
paddingBottomLarge : BoxContainerModifier a
paddingBottomLarge =
    paddingBottom Constants.large


{-| -}
paddingBottom : Elegant.SizeUnit -> BoxContainerModifier a
paddingBottom val =
    padding [ Padding.bottom val ]


{-| -}
paddingTop : Elegant.SizeUnit -> BoxContainerModifier a
paddingTop val =
    padding [ Padding.top val ]


{-| -}
paddingHorizontal : Elegant.SizeUnit -> BoxContainerModifier a
paddingHorizontal val =
    padding [ Padding.horizontal val ]


{-| -}
paddingVertical : Elegant.SizeUnit -> BoxContainerModifier a
paddingVertical val =
    padding [ Padding.vertical val ]


{-| -}
padding : Modifiers (Surrounded Padding.Padding) -> BoxContainerModifier a
padding val =
    box [ Box.padding val ]


{-| -}
alignCenter : Modifier (A.MaybeBlockContainer a)
alignCenter =
    block [ Block.alignCenter ]


{-| -}
displayBlock : Modifier (A.MaybeBlockContainer a)
displayBlock =
    block [ Block.fullWidth ]


{-| -}
block : Modifiers Display.BlockDetails -> Modifier (A.MaybeBlockContainer a)
block e =
    A.style [ Style.block e ]


{-| -}
blockWithWidth : Elegant.SizeUnit -> Modifier (A.MaybeBlockContainer a)
blockWithWidth width =
    block [ Block.width width ]


{-| -}
blockProperties : Modifiers Display.BlockDetails -> Modifier (A.BlockContainer a)
blockProperties e =
    A.style [ Style.blockProperties e ]


{-| -}
fillHeight : Modifier (A.MaybeBlockContainer a)
fillHeight =
    block [ Block.height (Elegant.percent 100) ]


{-| -}
overflowHidden : Modifiers.Modifier (A.MaybeBlockContainer a)
overflowHidden =
    block [ Block.overflowHidden ]


{-| -}
textCenter : Modifier (A.BlockContainer a)
textCenter =
    blockProperties
        [ Block.alignCenter
        ]


{-| -}
gray : Color.Color
gray =
    Color.grayscale 0.02


{-| -}
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


{-| -}
backgroundColor : Color.Color -> BoxContainerModifier a
backgroundColor val =
    box [ Box.backgroundColor val ]


{-| -}
textColor : Color.Color -> BoxContainerModifier a
textColor val =
    box [ Box.textColor val ]


{-| -}
marginAuto : BoxContainerModifier a
marginAuto =
    box [ Box.marginAuto ]


{-| -}
noMargin : BoxContainerModifier a
noMargin =
    margin [ Margin.all (Margin.width (px 0)) ]


{-| -}
margin : Modifiers (Surrounded Margin.Margin) -> BoxContainerModifier a
margin val =
    box [ Box.margin val ]


{-| -}
borderBottomBlack : BoxContainerModifier a
borderBottomBlack =
    border
        [ Border.bottom
            [ Border.color Color.black
            , Border.solid
            , Border.thickness (px 1)
            ]
        ]


{-| -}
borderTopBlack : BoxContainerModifier a
borderTopBlack =
    border
        [ Border.top
            [ Border.solid
            , Border.thickness (px 1)
            , Border.color Color.black
            ]
        ]


{-| -}
border : Modifiers (Surrounded Border.Border) -> BoxContainerModifier a
border e =
    box [ Box.border e ]


{-| -}
cornerRadius : Int -> BoxContainerModifier a
cornerRadius val =
    box [ Box.cornerRadius val ]


{-| -}
grow : Modifier (A.FlexItemAttributes a)
grow =
    flexItemProperties
        [ Flex.grow
            1
        ]


{-| -}
flexItemProperties : Modifiers Flex.FlexItemDetails -> Modifier (A.FlexItemAttributes msg)
flexItemProperties e =
    A.style
        [ Style.flexItemProperties e ]


{-| -}
spaceBetween : Modifier (A.FlexContainerAttributes a)
spaceBetween =
    flexContainerProperties
        [ Flex.justifyContent
            Flex.spaceBetween
        ]


{-| -}
alignItemsCenter : Modifier (A.FlexContainerAttributes msg)
alignItemsCenter =
    flexContainerProperties
        [ Flex.align
            Flex.alignCenter
        ]


{-| -}
flexContainerProperties : Modifiers Flex.FlexContainerDetails -> Modifier (A.FlexContainerAttributes msg)
flexContainerProperties e =
    A.style
        [ Style.flexContainerProperties
            e
        ]


{-| -}
gridContainerProperties : Modifiers Grid.GridContainerDetails -> Modifier (A.GridContainerAttributes msg)
gridContainerProperties a =
    A.style [ Style.gridContainerProperties a ]
