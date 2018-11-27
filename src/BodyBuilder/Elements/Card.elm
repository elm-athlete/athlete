module BodyBuilder.Elements.Card exposing
    ( field
    , header
    , headerElement
    , headerWithText
    )

{-|

@docs field
@docs header
@docs headerElement
@docs headerWithText

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
lightBlack : Color.Color
lightBlack =
    Color.grayscale 0.8


{-| -}
darkerBlue : Color.Color
darkerBlue =
    Color.rgba 43 143 208 0.1


{-| -}
headerWithText : String -> NodeWithStyle msg
headerWithText =
    header << B.text


{-| -}
header : NodeWithStyle msg -> NodeWithStyle msg
header content =
    B.flex
        [ A.style
            [ Style.block []
            , Style.box
                [ Box.paddingAll (px 12)
                , Box.backgroundColor darkerBlue
                , Box.border
                    [ Border.bottom
                        [ Border.color darkerBlue
                        , Border.solid
                        , Border.thickness (px 1)
                        ]
                    ]
                ]
            ]
        ]
        [ headerElement content ]


{-| -}
headerElement : NodeWithStyle msg -> FlexItem msg
headerElement content =
    B.flexItem
        [ A.style
            [ Style.box
                [ Box.paddingHorizontal (px 3)
                , Box.typography
                    [ Typography.color lightBlack
                    , Typography.bold
                    ]
                ]
            ]
        ]
        [ content ]


{-| -}
field : String -> String -> NodeWithStyle msg
field label content =
    B.div
        [ A.style
            [ Style.box
                [ Box.paddingVertical (px 3)
                , Box.paddingHorizontal (px 12)
                ]
            ]
        ]
        [ B.div
            [ A.style
                [ Style.box
                    [ Box.typography
                        [ Typography.color (Color.rgb 159 198 223)
                        ]
                    ]
                ]
            ]
            [ B.text label ]
        , B.div
            [ A.style
                [ Style.box
                    [ Box.paddingAll (px 6)
                    , Box.typography [ Typography.color lightBlack ]
                    ]
                ]
            ]
            [ B.text content ]
        ]
