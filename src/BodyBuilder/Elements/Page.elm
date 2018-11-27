module BodyBuilder.Elements.Page exposing
    ( backButton
    , headerButtonStyle
    , headerButtonStyleCenter
    , headerButtonStyleLeft
    , headerButtonStyleRight
    , headerElement
    , limitedPage
    , limitedPageQ
    , menuLinkTo
    , menuLinkToHref
    , menuLinkToWithIcon
    , namedPage
    , namedPageQ
    , namedPageWithAction
    , namedPageWithoutBack
    , pageTitle
    , pageView
    , pageWithAutoMargin
    , pageWithMargin
    , title
    , verticallyCenteredPage
    , verticallyCenteredPageQ
    )

{-|

@docs backButton
@docs headerButtonStyle
@docs headerButtonStyleCenter
@docs headerButtonStyleLeft
@docs headerButtonStyleRight
@docs headerElement
@docs limitedPage
@docs limitedPageQ
@docs menuLinkTo
@docs menuLinkToHref
@docs menuLinkToWithIcon
@docs namedPage
@docs namedPageQ
@docs namedPageWithAction
@docs namedPageWithoutBack
@docs pageTitle
@docs pageView
@docs pageWithAutoMargin
@docs pageWithMargin
@docs title
@docs verticallyCenteredPage
@docs verticallyCenteredPageQ

-}

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


{-| -}
title : B.NodeWithStyle msg -> B.NodeWithStyle msg
title content =
    B.div
        [ A.style
            [ Style.box [ Box.padding [ Padding.all (Elegant.px 12) ] ]
            ]
        ]
        [ content ]


{-| -}
pageView :
    { a
        | center : NodeWithStyle msg
        , left : NodeWithStyle msg
        , right : NodeWithStyle msg
    }
    -> NodeWithStyle msg
    -> NodeWithStyle msg
pageView topMenu content =
    B.grid
        [ A.style
            [ Style.block [ Block.height (percent 100) ]
            , Style.gridContainerProperties
                [ Grid.columns
                    [ Grid.template
                        [ Grid.simple (Grid.fractionOfAvailableSpace 1)
                        ]
                    , Grid.align Grid.stretch
                    , Grid.alignItems (Grid.alignWrapper Grid.stretch)
                    ]
                , Grid.rows
                    [ Grid.template
                        [ Grid.simple Grid.auto
                        , Grid.simple (Grid.fractionOfAvailableSpace 1)
                        ]
                    , Grid.align Grid.stretch
                    , Grid.alignItems (Grid.alignWrapper Grid.stretch)
                    ]
                ]
            , Style.box []
            ]
        ]
        [ B.gridItem [ borderBottomBlack ] [ headerElement topMenu ]
        , B.gridItem [] [ content ]
        ]


{-| display header
-}
headerElement :
    { a | center : NodeWithStyle msg, left : NodeWithStyle msg, right : NodeWithStyle msg }
    -> NodeWithStyle msg
headerElement { left, center, right } =
    B.node
        [ A.style
            [ Style.block
                [ Block.width <| percent 100 ]
            , Style.box
                [ Box.background [ Elegant.color Color.white ]
                ]
            ]
        ]
        [ B.flex
            [ A.style
                [ Style.block [ Block.width (percent 100) ]
                , Style.flexContainerProperties [ Flex.direction Flex.row, Flex.align Flex.alignCenter ]
                ]
            ]
            [ B.flexItem [ headerButtonStyleLeft ] [ left ]
            , B.flexItem [ headerButtonStyleCenter ] [ center ]
            , B.flexItem [ headerButtonStyleRight ] [ right ]
            ]
        ]


{-| -}
headerButtonStyle :
    Elegant.SizeUnit
    -> Modifier Display.BlockDetails
    -> Modifier (A.FlexItemAttributes msg)
headerButtonStyle width align =
    A.style
        [ Style.flexItemProperties [ Flex.basis width ]
        , Style.block
            [ Display.overflow
                [ Overflow.overflowXY Overflow.hidden ]
            , Display.textOverflowEllipsis
            , align
            ]
        , Style.box
            [ Box.cursor Cursor.pointer
            , typoSize 12
            ]
        ]


{-| -}
headerButtonStyleLeft : Modifier (A.FlexItemAttributes msg)
headerButtonStyleLeft =
    headerButtonStyle (percent 28) (Display.alignment Display.left)


{-| -}
headerButtonStyleCenter : Modifier (A.FlexItemAttributes msg)
headerButtonStyleCenter =
    headerButtonStyle (percent 44) Block.alignCenter


{-| -}
headerButtonStyleRight : Modifier (A.FlexItemAttributes msg)
headerButtonStyleRight =
    headerButtonStyle (percent 28) (Display.alignment Display.right)


{-| -}
touchOrClick msg =
    [ A.rawAttribute (Touch.onEnd (\_ -> msg)), E.onClick msg ]


{-| -}
menuLinkTo : msg -> String -> NodeWithStyle msg
menuLinkTo msg label =
    B.div
        ([ A.style
            [ Style.box
                [ Box.cursorPointer
                , typoSize 17
                ]
            ]
         ]
            ++ touchOrClick msg
        )
        [ title (B.text label) ]


{-| -}
pageTitle : String -> NodeWithStyle msg
pageTitle text =
    B.div
        [ paddingVertical (px 18)
        , typography [ Typography.whiteSpaceNoWrap, Typography.size (px 17) ]
        ]
        [ B.text text ]


{-| -}
menuLinkToWithIcon : msg -> { icon : Int -> RGBA -> Html.Html msg, size : Int, color : RGBA } -> String -> NodeWithStyle msg
menuLinkToWithIcon msg { icon, size, color } label =
    B.div
        ([ A.style
            [ Style.box
                [ Box.cursorPointer
                ]
            ]
         ]
            ++ touchOrClick msg
        )
        [ title
            (B.flex
                [ A.style
                    [ Style.flexContainerProperties
                        [ Flex.align Flex.alignCenter
                        ]
                    , Style.block []
                    ]
                ]
                [ B.flexItem
                    [ A.style
                        [ Style.block
                            [ Block.height (px size)
                            ]
                        ]
                    ]
                    [ ( icon size color, [] ) ]
                , B.flexItem []
                    [ B.p
                        [ A.style
                            [ Style.box
                                [ Box.margin [ Margin.all (Margin.width (px 0)) ]
                                , typoSize 17
                                ]
                            ]
                        ]
                        [ B.text label ]
                    ]
                ]
            )
        ]


{-| -}
namedPageWithAction : NodeWithStyle msg -> String -> ( String, msg ) -> NodeWithStyle msg -> NodeWithStyle msg
namedPageWithAction backButton_ title_ ( actionLabel, actionMsg ) =
    pageView
        { left = backButton_
        , center = pageTitle title_
        , right = menuLinkTo actionMsg actionLabel
        }


{-| -}
namedPage : NodeWithStyle msg -> NodeWithStyle msg -> String -> NodeWithStyle msg -> NodeWithStyle msg
namedPage defaultRight_ backButton_ title_ =
    pageView
        { left = backButton_
        , center = pageTitle title_
        , right = defaultRight_
        }


{-| -}
namedPageQ : NodeWithStyle msg -> NodeWithStyle msg -> Bool -> String -> NodeWithStyle msg -> NodeWithStyle msg
namedPageQ defaultRight_ backButton_ hasBack title_ =
    pageView
        { left =
            if hasBack then
                backButton_

            else
                B.none
        , center = pageTitle title_
        , right = defaultRight_
        }


{-| -}
namedPageWithoutBack : NodeWithStyle msg -> String -> NodeWithStyle msg -> NodeWithStyle msg
namedPageWithoutBack defaultRight_ title_ =
    pageView
        { left = B.none
        , center = pageTitle title_
        , right = defaultRight_
        }


{-| -}
limitedPage : NodeWithStyle msg -> NodeWithStyle msg -> String -> List (NodeWithStyle msg) -> NodeWithStyle msg
limitedPage defaultRight_ backButton_ title_ content =
    namedPage defaultRight_ backButton_ title_ (limitedWidth380WithPadding content)


{-| -}
limitedPageQ : NodeWithStyle msg -> NodeWithStyle msg -> Bool -> String -> List (NodeWithStyle msg) -> NodeWithStyle msg
limitedPageQ defaultRight_ backButton_ q title_ content =
    namedPageQ defaultRight_ backButton_ q title_ (limitedWidth380WithPadding content)


{-| -}
verticallyCenteredPage : NodeWithStyle msg -> NodeWithStyle msg -> String -> List (NodeWithStyle msg) -> NodeWithStyle msg
verticallyCenteredPage defaultRight_ backButton_ title_ content =
    namedPage defaultRight_ backButton_ title_ (limitedAndCentered content)


{-| -}
verticallyCenteredPageQ : NodeWithStyle msg -> NodeWithStyle msg -> Bool -> String -> List (NodeWithStyle msg) -> NodeWithStyle msg
verticallyCenteredPageQ defaultRight_ backButton_ q title_ content =
    namedPageQ defaultRight_ backButton_ q title_ (limitedAndCentered content)


{-| -}
type alias RGBA =
    { red : Float
    , green : Float
    , blue : Float
    , alpha : Float
    }


{-| -}
backButton : (Router.StandardHistoryMsg -> msg) -> NodeWithStyle msg
backButton wrapper =
    menuLinkToWithIcon (wrapper Router.Back)
        { icon = Ios.arrowLeft, size = 32, color = RGBA 0 0 0 1 }
        "Back"


{-| -}
pageWithAutoMargin : Int -> NodeWithStyle msg -> NodeWithStyle msg
pageWithAutoMargin pxNumber content =
    B.div
        [ box [ Box.marginAuto ]
        , blockProperties
            [ Block.maxWidth (px pxNumber) ]
        ]
        [ content ]


{-| -}
pageWithMargin : NodeWithStyle msg -> NodeWithStyle msg
pageWithMargin =
    pageWithAutoMargin 700


{-| -}
menuLinkToHref : String -> String -> NodeWithStyle msg
menuLinkToHref href label =
    B.a
        [ A.style
            [ Style.box
                [ Box.cursorPointer
                ]
            ]
        , A.href href
        ]
        [ title (B.text label) ]
