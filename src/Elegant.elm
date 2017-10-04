module Elegant exposing (..)

{-|


# New

@docs color
@docs typography
@docs toInlineStyles
@docs style
@docs padding
@docs styleContents


# Types

@docs Vector
@docs Style
@docs SizeUnit
@docs BoxShadow
@docs Offset

# Styling
@docs defaultStyle
@docs inlineStyle
@docs convertStyles
@docs classes
@docs classesHover
@docs classesFocus
@docs stylesToCss
@docs screenWidthBetween
@docs screenWidthGE
@docs screenWidthLE
-- @docs userSelectNone
-- @docs userSelectAll

# Styles
## Positions
-- @docs positionStatic
-- @docs positionAbsolute
-- @docs positionRelative
-- @docs positionFixed
-- @docs positionSticky
-- @docs left
-- @docs right
-- @docs top
-- @docs bottom
-- @docs absolutelyPositionned
-- @docs verticalAlignMiddle

## Align Items
-- @docs alignItemsBaseline
-- @docs alignItemsCenter
-- @docs alignItemsFlexStart
-- @docs alignItemsFlexEnd
-- @docs alignItemsInherit
-- @docs alignItemsInitial
-- @docs alignItemsStretch
-- @docs alignSelfCenter


## SizeUnit operations

@docs opposite

## Paddings
-- @docs padding
-- @docs paddingHorizontal
-- @docs paddingVertical
-- @docs paddingLeft
-- @docs paddingRight
-- @docs paddingTop
-- @docs paddingBottom

## Margins
-- @docs margin
-- @docs marginAuto
-- @docs marginHorizontal
-- @docs marginVertical
-- @docs marginTop
-- @docs marginBottom
-- @docs marginLeft
-- @docs marginRight

## Text Attributes
-- @docs textColor
-- @docs uppercase
-- @docs lowercase
-- @docs capitalize
-- @docs textDecorationNone
-- @docs underline
-- @docs lineThrough
-- @docs bold
-- @docs strong
-- @docs lineHeight
-- @docs fontWeight
-- @docs fontWeightNormal
-- @docs fontStyleNormal
-- @docs fontStyleItalic
-- @docs fontSize
-- @docs cursorPointer
-- @docs lineHeightNormal
-- @docs whiteSpaceWrapNoWrap

## Text Alignements
-- @docs textCenter
-- @docs textLeft
-- @docs textRight
-- @docs textJustify
-- @docs backgroundColor
-- @docs backgroundImage
@docs withUrl
-- @docs backgroundImages

## Border
-- @docs borderNone
-- @docs borderColor
-- @docs borderSolid
-- @docs borderDashed
-- @docs borderWidth
-- @docs borderBottomColor
-- @docs borderBottomWidth
-- @docs borderBottomSolid
-- @docs borderBottomDashed
-- @docs borderLeftColor
-- @docs borderLeftWidth
-- @docs borderLeftSolid
-- @docs borderLeftDashed
-- @docs borderTopColor
-- @docs borderTopWidth
-- @docs borderTopSolid
-- @docs borderTopDashed
-- @docs borderRightColor
-- @docs borderRightWidth
-- @docs borderRightSolid
-- @docs borderRightDashed
-- @docs borderBottomLeftRadius
-- @docs borderBottomRightRadius
-- @docs borderTopLeftRadius
-- @docs borderTopRightRadius
-- @docs borderRadius
-- @docs borderAndTextColor
-- @docs outlineWidth
-- @docs outlineStyleSolid
-- @docs outlineStyleDashed
-- @docs outlineColor
-- @docs outlineNone
-- @docs boxShadow
-- @docs boxShadowPlain
-- @docs boxShadowBlurry
-- @docs boxShadowCenteredBlurry

## Display
@docs displayBlock
@docs displayBlockFlexContainer
@docs displayInlineFlexContainer
@docs displayInline
@docs displayNone

## Flex Attributes
-- @docs flex
-- @docs flexWrapWrap
-- @docs flexWrapNoWrap
-- @docs flexBasis
-- @docs flexGrow
-- @docs flexShrink
-- @docs flexDirectionColumn
-- @docs flexDirectionRow

## Opacity
-- @docs opacity

## Overflow
-- @docs overflowAuto
-- @docs overflowHidden
-- @docs overflowScroll
-- @docs overflowVisible
-- @docs overflowXAuto
-- @docs overflowXVisible
-- @docs overflowXHidden
-- @docs overflowXScroll
-- @docs overflowYAuto
-- @docs overflowYVisible
-- @docs overflowYHidden
-- @docs overflowYScroll
-- @docs textOverflowEllipsis

## List Style Type
-- @docs listStyleNone
-- @docs listStyleDisc
-- @docs listStyleCircle
-- @docs listStyleSquare
-- @docs listStyleDecimal
-- @docs listStyleGeorgian

## Round
-- @docs roundCorner
-- @docs round


## Justify Content

-- @docs justifyContentSpaceBetween
-- @docs justifyContentSpaceAround


## -- @docs justifyContentCenter

-- ## Spacings
-- @docs spaceBetween
-- @docs spaceAround

## Width and Height
-- @docs width
-- @docs widthPercent
-- @docs maxWidth
-- @docs minWidth
-- @docs height
-- @docs heightPercent
-- @docs maxHeight
-- @docs minHeight
-- @docs fullWidth
-- @docs fullHeight


## -- @docs fullViewportHeight

-- ## Z-Index


## -- @docs zIndex

-- ## Visibility
-- @docs visibilityHidden


# Constants

## Sizes
@docs huge
@docs large
@docs medium
@docs small
@docs tiny
@docs zero

## Color


## -- @docs transparent

--


## -- ## Headings Helper functions

@docs h1S
@docs h2S
@docs h3S
@docs h4S
@docs h5S
@docs h6S
@docs heading

## Font Sizes
@docs alpha
@docs beta
@docs gamma
@docs delta
@docs epsilon
@docs zeta
@docs eta
@docs theta
@docs iota
@docs kappa

-}

import Html exposing (Html)
import Html.Attributes
import Function exposing (compose)
import List.Extra
import Elegant.Helpers as Helpers exposing (emptyListOrApply)
import Maybe.Extra as Maybe exposing ((?))
import Color exposing (Color)
import Color.Convert
import Setters exposing (..)
import Function
import Shared exposing (..)
import Typography
import Either exposing (Either(..))


type alias SizeUnit =
    Shared.SizeUnit


px : Int -> SizeUnit
px =
    Px


pt : Int -> SizeUnit
pt =
    Pt


percent : Float -> SizeUnit
percent =
    Percent


vh : Float -> SizeUnit
vh =
    Vh


em : Float -> SizeUnit
em =
    Em


rem : Float -> SizeUnit
rem =
    Rem


type Auto
    = Auto


{-| -}
type alias Vector a =
    ( a, a )


{-| Offset type
-}
type alias Offset =
    ( SizeUnit, SizeUnit )


{-| BoxShadow type
-}
type alias BoxShadow =
    { inset : Bool
    , spreadRadius : Maybe SizeUnit
    , blurRadius : Maybe SizeUnit
    , maybeColor : Maybe Color
    , offset : Offset
    }


type alias Radiant =
    Float


type alias Degree =
    Float


type Angle
    = Rad Radiant
    | Deg Degree


type alias ColorStop =
    { offset : Maybe SizeUnit
    , color : Color
    }


type alias LinearGradient =
    { angle : Angle
    , colorStops : List ColorStop
    }


type alias RadialGradient =
    { colorStops : List ColorStop }


type Gradient
    = Linear LinearGradient
    | Radial RadialGradient


type Image
    = Gradient Gradient
    | Source String


type alias BackgroundImage =
    { image : Image
    , backgroundPosition : Maybe (Vector SizeUnit)
    }


{-| Simple background image with only an url as source
-}
withUrl : String -> BackgroundImage
withUrl url =
    BackgroundImage (Source url) Nothing


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


type alias FlexContainerDetails =
    { direction : Maybe FlexDirection
    , wrap : Maybe FlexWrap
    , align : Maybe Align
    , justifyContent : Maybe JustifyContent
    }


defaultFlexContainerDetails : FlexContainerDetails
defaultFlexContainerDetails =
    FlexContainerDetails Nothing Nothing Nothing Nothing


flexContainerDetailsDirection : FlexDirection -> FlexContainerDetails -> FlexContainerDetails
flexContainerDetailsDirection val el =
    { el | direction = Just val }


flexContainerDetailsWrap : FlexWrap -> FlexContainerDetails -> FlexContainerDetails
flexContainerDetailsWrap val el =
    { el | wrap = Just val }


flexContainerDetailsalign : Align -> FlexContainerDetails -> FlexContainerDetails
flexContainerDetailsalign val el =
    { el | align = Just val }


flexContainerDetailsJustify : JustifyContent -> { a | justifyContent : Maybe JustifyContent } -> { a | justifyContent : Maybe JustifyContent }
flexContainerDetailsJustify val el =
    { el | justifyContent = Just val }


type alias FlexItemDetails =
    { grow : Maybe Int
    , shrink : Maybe Int
    , basis : Maybe (Either SizeUnit Auto)
    , alignSelf : Maybe Align
    }


defaultFlexItemDetails : FlexItemDetails
defaultFlexItemDetails =
    FlexItemDetails Nothing Nothing Nothing Nothing



-- type VerticalAlign
--     = VerticalAlignMiddle


type alias DimensionAxis =
    { min : Maybe SizeUnit
    , dimension : Maybe SizeUnit
    , max : Maybe SizeUnit
    }


type alias Dimensions =
    ( DimensionAxis, DimensionAxis )


defaultDimensionAxis : DimensionAxis
defaultDimensionAxis =
    DimensionAxis Nothing Nothing Nothing


defaultDimensions : ( DimensionAxis, DimensionAxis )
defaultDimensions =
    ( defaultDimensionAxis, defaultDimensionAxis )



-- dimensions [ width (Px 30) ]


blah : DisplayBox
blah =
    displayBlock
        [ textOverflow TextOverflowEllipsis
        , dimensions [ width (Px 10) ]
        ]
        [ padding (Px 20) ]


type ListStyleType
    = ListStyleTypeNone
    | ListStyleTypeDisc
    | ListStyleTypeCircle
    | ListStyleTypeSquare
    | ListStyleTypeDecimal
    | ListStyleTypeGeorgian


type Align
    = AlignBaseline
    | AlignCenter
    | AlignFlexStart
    | AlignFlexEnd
    | AlignInherit
    | AlignInitial
    | AlignStretch


type JustifyContent
    = JustifyContentSpaceBetween
    | JustifyContentSpaceAround
    | JustifyContentCenter


type Alignment
    = AlignmentCenter
    | AlignmentRight
    | AlignmentLeft
    | AlignmentJustify


type Overflow
    = OverflowVisible
    | OverflowHidden
    | OverflowAuto
    | OverflowScroll


type FlexWrap
    = FlexWrapWrap
    | FlexWrapNoWrap


type FlexDirection
    = FlexDirectionColumn
    | FlexDirectionRow


type Visibility
    = VisibilityHidden


type Border
    = BorderSolid
    | BorderDashed


type TextOverflow
    = TextOverflowEllipsis


type alias SideBorder =
    { color : Maybe Color
    , width : Maybe SizeUnit
    , style : Maybe Border
    }


type alias Surrounded surroundType =
    { top : Maybe surroundType
    , right : Maybe surroundType
    , bottom : Maybe surroundType
    , left : Maybe surroundType
    }


type alias CompleteBorder =
    Surrounded SideBorder


type alias MarginValue =
    Either SizeUnit Auto


type alias Margin =
    Surrounded MarginValue


type alias Padding =
    Surrounded SizeUnit


type alias BorderRadius =
    { topLeft : Maybe SizeUnit
    , topRight : Maybe SizeUnit
    , bottomRight : Maybe SizeUnit
    , bottomLeft : Maybe SizeUnit
    }


type Horizontal a
    = PositionLeft a
    | PositionRight a


type Vertical a
    = PositionTop a
    | PositionBottom a


type alias PositionCoordinates a =
    { horizontal : Horizontal a
    , vertical : Vertical a
    }


type DynamicPositionningType
    = PositionAbsolute
    | PositionRelative
    | PositionFixed
    | PositionSticky


type Position
    = PositionDynamic DynamicPositionningType (PositionCoordinates SizeUnit)
    | PositionStatic


type alias Outline =
    Border


{-| -}
color : a -> { b | color : Maybe a } -> { b | color : Maybe a }
color =
    setColor << Just


type alias Background =
    { color : Maybe Color
    , images : List BackgroundImage
    }


type alias FullOverflow =
    Vector (Maybe Overflow)


type alias Layout =
    { position : Maybe Position
    , visibility : Maybe Visibility
    , typography : Maybe Typography.Typography
    , padding : Maybe Padding
    , border : Maybe CompleteBorder
    , radius : Maybe BorderRadius
    , margin : Maybe Margin
    , outline : Maybe Outline
    , boxShadow : Maybe BoxShadow
    , background : Maybe Background
    , opacity : Maybe Float
    , cursor : Maybe String
    , zIndex : Maybe Int
    }


{-| -}
typography : Modifiers Typography.Typography -> Layout -> Layout
typography modifiers layout =
    layout
        |> .typography
        |> Maybe.withDefault Typography.default
        |> Function.compose modifiers
        |> Just
        |> setTypographyIn layout


type alias BlockDetails =
    { listStyleType : Maybe ListStyleType
    , alignment : Maybe Alignment
    , overflow : Maybe FullOverflow
    , textOverflow : Maybe TextOverflow
    , dimensions : Maybe Dimensions
    }


defaultBlockDetails : BlockDetails
defaultBlockDetails =
    BlockDetails Nothing Nothing Nothing Nothing Nothing


defaultLayout : Layout
defaultLayout =
    Layout Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing


type InsideDisplay
    = DisplayFlow
    | DisplayFlexContainer (Maybe FlexContainerDetails)


type OutsideDisplay
    = DisplayInline
    | DisplayBlock (Maybe BlockDetails)
    | DisplayFlexItem (Maybe FlexItemDetails)


type alias DisplayContents =
    ( ( OutsideDisplay, InsideDisplay ), Maybe Layout )


type DisplayBox
    = DisplayNone
    | DisplayContentsWrapper DisplayContents


{-| Contains all style for an element used with Elegant.
-}
type Style
    = Style
        { display : Maybe DisplayBox
        , screenWidths : List ScreenWidth
        }


{-| -}
style : Maybe DisplayBox -> List ScreenWidth -> Style
style display screenWidths =
    Style
        { display = display
        , screenWidths = screenWidths
        }


{-| -}
styleContents : DisplayContents -> List ScreenWidth -> Style
styleContents displayContents =
    style (Just (DisplayContentsWrapper displayContents))


{-| displayNone
The "display none" <display box> is useful to simply don't show
the element in the browser, it is on top of the hierarchy, because
applying any text or
layout style to a "display none" element doesn't mean anything.
ex : displayNone
-}
displayNone : DisplayBox
displayNone =
    DisplayNone


displayStyle : OutsideDisplay -> InsideDisplay -> Maybe Layout -> DisplayContents
displayStyle outsideDisplay insideDisplay layoutStyle =
    ( ( outsideDisplay, insideDisplay ), layoutStyle )


modifiedElementOrNothing : a -> Modifiers a -> Maybe a
modifiedElementOrNothing default modifiers =
    if List.isEmpty modifiers then
        Nothing
    else
        Just ((modifiers |> compose) default)


{-| The display Block
node behaving like a block element
children behaving like inside a flow element => considered block from children

    displayBlock [dimensions [width (Px 30)]] [padding (Px 30)]

-}
displayBlock : Modifiers BlockDetails -> Modifiers Layout -> DisplayBox
displayBlock blockDetailsModifiers layoutModifiers =
    DisplayContentsWrapper
        (displayStyle
            (DisplayBlock (modifiedElementOrNothing defaultBlockDetails blockDetailsModifiers))
            DisplayFlow
            (modifiedElementOrNothing defaultLayout layoutModifiers)
        )


leftSurrounding : a -> Surrounded a -> Surrounded a
leftSurrounding =
    setLeft << Just


rightSurrounding : a -> Surrounded a -> Surrounded a
rightSurrounding =
    setRight << Just


topSurrounding : a -> Surrounded a -> Surrounded a
topSurrounding =
    setTop << Just


bottomSurrounding : a -> Surrounded a -> Surrounded a
bottomSurrounding =
    setBottom << Just


fullSurrounding : a -> Surrounded a -> Surrounded a
fullSurrounding val =
    leftSurrounding val
        << rightSurrounding val
        << bottomSurrounding val
        << topSurrounding val


defaultSurrounded : Surrounded a
defaultSurrounded =
    { left = Nothing
    , right = Nothing
    , bottom = Nothing
    , top = Nothing
    }


{-| The display inline
node behaving like an inline element

    displayInline [background [color Color.blue]] [textCenter]

-}
displayInline : Modifiers Layout -> DisplayBox
displayInline layoutModifiers =
    DisplayContentsWrapper
        (displayStyle
            DisplayInline
            DisplayFlow
            (modifiedElementOrNothing defaultLayout layoutModifiers)
        )


{-| The display inline-flex container :
node behaving like an inline element, contained nodes will behave like flex children

    displayInlineFlexContainer [] []

-}
displayInlineFlexContainer : Modifiers FlexContainerDetails -> Modifiers Layout -> DisplayBox
displayInlineFlexContainer flexContainerDetailsModifiers layoutModifiers =
    DisplayContentsWrapper
        (displayStyle
            DisplayInline
            (DisplayFlexContainer (modifiedElementOrNothing defaultFlexContainerDetails flexContainerDetailsModifiers))
            (modifiedElementOrNothing defaultLayout layoutModifiers)
        )


{-| The display blockflex container :
node behaving like an block element, contained nodes will behave like flex children

    displayFlexContainer [] [] []

-}
displayBlockFlexContainer : Modifiers FlexContainerDetails -> Modifiers BlockDetails -> Modifiers Layout -> DisplayBox
displayBlockFlexContainer flexContainerDetailsModifiers blockDetailsModifiers layoutModifiers =
    DisplayContentsWrapper
        (displayStyle
            (DisplayBlock (modifiedElementOrNothing defaultBlockDetails blockDetailsModifiers))
            (DisplayFlexContainer (modifiedElementOrNothing defaultFlexContainerDetails flexContainerDetailsModifiers))
            (modifiedElementOrNothing defaultLayout layoutModifiers)
        )


{-| The display flexitemdetails container :
node behaving like an flex child (not being a flex father himself)

    displayFlexChild [] []

-}
displayFlexChild : Modifiers FlexItemDetails -> Modifiers Layout -> DisplayBox
displayFlexChild flexItemDetailsModifiers layoutModifiers =
    DisplayContentsWrapper
        (displayStyle
            (DisplayFlexItem (modifiedElementOrNothing defaultFlexItemDetails flexItemDetailsModifiers))
            DisplayFlow
            (modifiedElementOrNothing defaultLayout layoutModifiers)
        )


{-| The display flexchildcontainer container :
node behaving like an flex child being a flex father himself.

    displayFlexChildContainer [] [] []

-}
displayFlexChildContainer : Modifiers FlexContainerDetails -> Modifiers FlexItemDetails -> Modifiers Layout -> DisplayBox
displayFlexChildContainer flexContainerDetailsModifiers flexItemDetailsModifiers layoutModifiers =
    DisplayContentsWrapper
        (displayStyle
            (DisplayFlexItem (modifiedElementOrNothing defaultFlexItemDetails flexItemDetailsModifiers))
            (DisplayFlexContainer (modifiedElementOrNothing defaultFlexContainerDetails flexContainerDetailsModifiers))
            (modifiedElementOrNothing defaultLayout layoutModifiers)
        )


valueToPair : (a -> b) -> c -> List ( d, c -> Maybe a ) -> List ( d, b )
valueToPair fun value =
    List.foldr
        (\( key, valueFun ) acu ->
            acu
                |> List.append ((unwrapEmptyList (\e -> [ ( key, e |> fun ) ]) (valueFun value)))
        )
        []


dimensionsToString : Dimensions -> List ( String, String )
dimensionsToString size =
    [ ( "width", Tuple.first >> .dimension )
    , ( "min-width", Tuple.first >> .min )
    , ( "max-width", Tuple.first >> .max )
    , ( "height", Tuple.second >> .dimension )
    , ( "max-height", Tuple.second >> .max )
    , ( "min-height", Tuple.second >> .min )
    ]
        |> valueToPair sizeUnitToString size


maybeDimensionsToString : Maybe Dimensions -> List ( String, String )
maybeDimensionsToString =
    unwrapEmptyList dimensionsToString


blockDetailsToString : BlockDetails -> List ( String, String )
blockDetailsToString blockDetails =
    []


maybeBlockDetailsToString : Maybe BlockDetails -> List ( String, String )
maybeBlockDetailsToString =
    unwrapEmptyList blockDetailsToString


unwrapEmptyList : (a -> List b) -> Maybe a -> List b
unwrapEmptyList =
    Maybe.unwrap []



-- verticalAlignToString : VerticalAlign -> String
-- verticalAlignToString verticalAlign =
--     case verticalAlign of
--         VerticalAlignMiddle ->
--             "middle"
--
-- maybeVerticalAlignToString : VerticalAlign -> List ( String, String )
-- maybeVerticalAlignToString =
--     (\val ->
--         [ ( "vertical-align", verticalAlignToString val ) ]
--     )


flexContainerDetailsToString : a -> List b
flexContainerDetailsToString flexContainerDetails =
    []


flexItemDetailsToString : a -> List b
flexItemDetailsToString flexContainerDetails =
    []


layoutStyleToString : a -> List b
layoutStyleToString a =
    []


outsideInsideDisplayToString : ( OutsideDisplay, InsideDisplay ) -> List ( String, String )
outsideInsideDisplayToString outsideAndInsideDisplay =
    let
        joiner ( a, b ) ( c, d ) =
            ( a ++ " " ++ c, b ++ d )

        ( dis, rest ) =
            case outsideAndInsideDisplay of
                ( outer, inner ) ->
                    (case outer of
                        DisplayInline ->
                            ( "inline", [] )

                        DisplayBlock blockDetails ->
                            ( "block", maybeBlockDetailsToString blockDetails )

                        DisplayFlexItem flexItemDetails ->
                            ( "block", flexItemDetailsToString flexItemDetails )
                    )
                        |> joiner
                            (case inner of
                                DisplayFlow ->
                                    ( "flow", [] )

                                DisplayFlexContainer flexContainerDetails ->
                                    ( "flex", flexContainerDetailsToString flexContainerDetails )
                            )
    in
        [ ( "display", dis |> toLegacyDisplayCss ) ] ++ rest


toLegacyDisplayCss : String -> String
toLegacyDisplayCss str =
    case str of
        "inline flow" ->
            "inline"

        "inline flex" ->
            "inline-flex"

        "block flow" ->
            "block"

        "block flex" ->
            "flex"

        _ ->
            "block"


layoutToCouples : Layout -> List ( String, String )
layoutToCouples layout =
    [ unwrapToCouples .visibility visibilityToCouple
    , unwrapToCouples .typography Typography.typographyToCouples
    ]
        |> List.concatMap (\fun -> fun layout)


visibilityToCouple : Visibility -> List ( String, String )
visibilityToCouple visibility =
    [ ( "visibility", visibilityToString visibility ) ]


displayBoxToString : Maybe DisplayBox -> List ( String, String )
displayBoxToString =
    unwrapEmptyList
        (\val ->
            case val of
                DisplayNone ->
                    [ ( "display", "none" ) ]

                DisplayContentsWrapper ( display, layout ) ->
                    outsideInsideDisplayToString display ++ (layout |> Maybe.map layoutToCouples |> Maybe.withDefault [])
        )


type alias ScreenWidth =
    { min : Maybe Int
    , max : Maybe Int
    , style : Style
    }


{-| -}
screenWidthBetween : Int -> Int -> List (Style -> Style) -> Style -> Style
screenWidthBetween min max insideStyle (Style style) =
    Style
        { style
            | screenWidths =
                { min = Just min
                , max = Just max
                , style = (compose insideStyle) defaultStyle
                }
                    :: style.screenWidths
        }


{-| -}
screenWidthGE : Int -> List (Style -> Style) -> Style -> Style
screenWidthGE min insideStyle (Style style) =
    Style
        { style
            | screenWidths =
                { min = Just min
                , max = Nothing
                , style = (compose insideStyle) defaultStyle
                }
                    :: style.screenWidths
        }


{-| -}
screenWidthLE : Int -> List (Style -> Style) -> Style -> Style
screenWidthLE max insideStyle (Style style) =
    Style
        { style
            | screenWidths =
                { min = Nothing
                , max = Just max
                , style = (compose insideStyle) defaultStyle
                }
                    :: style.screenWidths
        }


{-| -}
huge : SizeUnit
huge =
    Px 48


{-| -}
large : SizeUnit
large =
    Px 24


{-| -}
medium : SizeUnit
medium =
    Px 12


{-| -}
small : SizeUnit
small =
    Px 6


{-| -}
tiny : SizeUnit
tiny =
    Px 3


{-| -}
zero : SizeUnit
zero =
    Px 0


{-| -}
defaultStyle : Style
defaultStyle =
    Style
        { display = Nothing
        , screenWidths = []
        }


nothingOrJust : (a -> b) -> Maybe a -> Maybe b
nothingOrJust fun =
    Maybe.andThen (Just << fun)


positionToString : Maybe Position -> Maybe String
positionToString =
    nothingOrJust
        (\val ->
            case val of
                PositionDynamic positionningType coordinates ->
                    "TODO"

                PositionStatic ->
                    "static"
        )


colorToString : Color -> String
colorToString =
    Color.Convert.colorToCssRgba


maybeColorToString : Maybe Color -> Maybe String
maybeColorToString =
    nothingOrJust colorToString


alignItemsToString : Maybe Align -> Maybe String
alignItemsToString =
    nothingOrJust
        (\val ->
            case val of
                AlignBaseline ->
                    "baseline"

                AlignCenter ->
                    "center"

                AlignFlexStart ->
                    "flex-start"

                AlignFlexEnd ->
                    "flex-end"

                AlignInherit ->
                    "inherit"

                AlignInitial ->
                    "initial"

                AlignStretch ->
                    "stretch"
        )


maybeSizeUnitToString : Maybe SizeUnit -> Maybe String
maybeSizeUnitToString =
    nothingOrJust sizeUnitToString


listStyleTypeToString : Maybe ListStyleType -> Maybe String
listStyleTypeToString =
    nothingOrJust
        (\val ->
            case val of
                ListStyleTypeNone ->
                    "none"

                ListStyleTypeDisc ->
                    "disc"

                ListStyleTypeCircle ->
                    "circle"

                ListStyleTypeSquare ->
                    "square"

                ListStyleTypeDecimal ->
                    "decimal"

                ListStyleTypeGeorgian ->
                    "georgian"
        )


justifyContentToString : Maybe JustifyContent -> Maybe String
justifyContentToString =
    nothingOrJust
        (\val ->
            case val of
                JustifyContentSpaceBetween ->
                    "space-between"

                JustifyContentSpaceAround ->
                    "space-around"

                JustifyContentCenter ->
                    "center"
        )


textAlignToString : Maybe Alignment -> Maybe String
textAlignToString =
    nothingOrJust
        (\val ->
            case val of
                AlignmentCenter ->
                    "center"

                AlignmentLeft ->
                    "left"

                AlignmentRight ->
                    "right"

                AlignmentJustify ->
                    "justify"
        )


textOverflowToString : Maybe TextOverflow -> Maybe String
textOverflowToString =
    nothingOrJust
        (\val ->
            case val of
                TextOverflowEllipsis ->
                    "ellipsis"
        )


overflowToString : Maybe Overflow -> Maybe String
overflowToString =
    nothingOrJust
        (\val ->
            case val of
                OverflowAuto ->
                    "auto"

                OverflowScroll ->
                    "scroll"

                OverflowHidden ->
                    "hidden"

                OverflowVisible ->
                    "visible"
        )


autoOrSizeUnitToString : Maybe (Either SizeUnit Auto) -> Maybe String
autoOrSizeUnitToString =
    nothingOrJust
        (\val ->
            case val of
                Left su ->
                    sizeUnitToString su

                Right _ ->
                    "auto"
        )


flexWrapToString : Maybe FlexWrap -> Maybe String
flexWrapToString =
    nothingOrJust
        (\val ->
            case val of
                FlexWrapWrap ->
                    "wrap"

                FlexWrapNoWrap ->
                    "nowrap"
        )


flexDirectionToString : Maybe FlexDirection -> Maybe String
flexDirectionToString =
    nothingOrJust
        (\val ->
            case val of
                FlexDirectionColumn ->
                    "column"

                FlexDirectionRow ->
                    "row"
        )



-- alignSelfToString : Maybe AlignSelf -> Maybe String
-- alignSelfToString =
--     nothingOrJust
--         (\val ->
--             case val of
--                 AlignSelfCenter ->
--                     "center"
--         )


visibilityToString : Visibility -> String
visibilityToString val =
    case val of
        VisibilityHidden ->
            "hidden"


borderToString : Maybe Border -> Maybe String
borderToString =
    nothingOrJust
        (\val ->
            case val of
                BorderSolid ->
                    "solid"

                BorderDashed ->
                    "dashed"
        )


maybeToString : Maybe a -> Maybe String
maybeToString =
    nothingOrJust
        (\val ->
            toString val
        )


offsetToStringList : ( SizeUnit, SizeUnit ) -> List String
offsetToStringList ( x, y ) =
    [ x, y ]
        |> List.map sizeUnitToString


boxShadowToString : Maybe BoxShadow -> Maybe String
boxShadowToString =
    nothingOrJust
        (\{ offset, blurRadius, spreadRadius, maybeColor, inset } ->
            List.concat
                [ offsetToStringList offset
                , [ blurRadius, spreadRadius ]
                    |> List.map (emptyListOrApply sizeUnitToString)
                    |> List.concat
                , maybeColorToString maybeColor
                    |> Maybe.map (\a -> [ a ])
                    |> Maybe.withDefault []
                , if inset then
                    [ "inset" ]
                  else
                    []
                ]
                |> String.join " "
        )


applyCssFunction : String -> String -> String
applyCssFunction funName content =
    funName ++ (Helpers.surroundWithParentheses content)


angleToString : Angle -> String
angleToString angle =
    case angle of
        Rad a ->
            (a |> toString) ++ "rad"

        Deg a ->
            (a |> toString) ++ "deg"


colorStopToString : ColorStop -> String
colorStopToString colorStop =
    case colorStop of
        { color, offset } ->
            [ Just (colorToString color), maybeSizeUnitToString offset ] |> Maybe.values |> String.join " "


colorStopsToString : List ColorStop -> String
colorStopsToString colorStops =
    colorStops |> List.map colorStopToString |> String.join ", "


gradientToString : Gradient -> String
gradientToString gradient =
    case gradient of
        Linear { angle, colorStops } ->
            applyCssFunction "linear-gradient" ([ angleToString angle, colorStopsToString colorStops ] |> String.join ", ")

        Radial { colorStops } ->
            applyCssFunction "radial-gradient" (colorStopsToString colorStops)


imageToString : Image -> String
imageToString image =
    case image of
        Gradient gradient ->
            gradientToString gradient

        Source src ->
            applyCssFunction "url" src


backgroundImagesToString : List BackgroundImage -> Maybe String
backgroundImagesToString backgroundImages =
    if backgroundImages == [] then
        Nothing
    else
        Just
            (backgroundImages
                |> List.map (\{ image } -> imageToString image)
                |> String.join (" ")
            )


compileStyle : Style -> List ( String, String )
compileStyle (Style style) =
    displayBoxToString style.display



-- [ ( "position", positionToString << .position )
-- , ( "left", maybeSizeUnitToString << .left )
-- , ( "top", maybeSizeUnitToString << .top )
-- , ( "bottom", maybeSizeUnitToString << .bottom )
-- , ( "right", maybeSizeUnitToString << .right )
-- , ( "color", maybeColorToString << .textColor )
-- , ( "display", displayToString << .display )
-- , ( "user-select", userSelectToString << .userSelect )
-- , ( "flex-grow", maybeToString << .flexGrow )
-- , ( "flex-shrink", maybeToString << .flexShrink )
-- , ( "flex-basis", autoOrSizeUnitToString << .flexBasis )
-- , ( "flex-wrap", flexWrapToString << .flexWrap )
-- , ( "flex-direction", flexDirectionToString << .flexDirection )
-- , ( "opacity", maybeToString << .opacity )
-- , ( "overflow-x", overflowToString << .overflowX )
-- , ( "overflow-y", overflowToString << .overflowY )
-- , ( "text-overflow", textOverflowToString << .textOverflow )
-- , ( "text-align", textAlignToString << .textAlign )
-- , ( "text-transform", textTransformToString << .textTransform )
-- , ( "text-decoration", textDecorationToString << .textDecoration )
-- , ( "white-space", whiteSpaceWrapToString << .whiteSpaceWrap )
-- , ( "lineHeight", normalOrSizeUnitToString << .lineHeight )
-- , ( "background-color", maybeColorToString << .backgroundColor )
-- , ( "background-image", backgroundImagesToString << .backgroundImages )
-- , ( "border-bottom-color", maybeColorToString << .borderBottomColor )
-- , ( "border-bottom-width", maybeSizeUnitToString << .borderBottomWidth )
-- , ( "border-bottom-style", borderToString << .borderBottomStyle )
-- , ( "border-left-color", maybeColorToString << .borderLeftColor )
-- , ( "border-left-width", maybeSizeUnitToString << .borderLeftWidth )
-- , ( "border-left-style", borderToString << .borderLeftStyle )
-- , ( "border-top-color", maybeColorToString << .borderTopColor )
-- , ( "border-top-width", maybeSizeUnitToString << .borderTopWidth )
-- , ( "border-top-style", borderToString << .borderTopStyle )
-- , ( "border-right-color", maybeColorToString << .borderRightColor )
-- , ( "border-right-width", maybeSizeUnitToString << .borderRightWidth )
-- , ( "border-right-style", borderToString << .borderRightStyle )
-- , ( "border-bottom-left-radius", maybeSizeUnitToString << .borderBottomLeftRadius )
-- , ( "border-bottom-right-radius", maybeSizeUnitToString << .borderBottomRightRadius )
-- , ( "border-top-left-radius", maybeSizeUnitToString << .borderTopLeftRadius )
-- , ( "border-top-right-radius", maybeSizeUnitToString << .borderTopRightRadius )
-- , ( "outline-color", maybeColorToString << .outlineColor )
-- , ( "outline-width", maybeSizeUnitToString << .outlineWidth )
-- , ( "outline-style", borderToString << .outlineStyle )
-- , ( "box-shadow", boxShadowToString << .boxShadow )
-- , ( "padding-left", maybeSizeUnitToString << .paddingLeft )
-- , ( "padding-right", maybeSizeUnitToString << .paddingRight )
-- , ( "padding-top", maybeSizeUnitToString << .paddingTop )
-- , ( "padding-bottom", maybeSizeUnitToString << .paddingBottom )
-- , ( "margin-left", autoOrSizeUnitToString << .marginLeft )
-- , ( "margin-right", autoOrSizeUnitToString << .marginRight )
-- , ( "margin-top", autoOrSizeUnitToString << .marginTop )
-- , ( "margin-bottom", autoOrSizeUnitToString << .marginBottom )
-- , ( "list-style-type", listStyleTypeToString << .listStyleType )
-- , ( "align-items", alignItemsToString << .alignItems )
-- , ( "align-self", alignItemsToString << .alignSelf )
-- , ( "justify-content", justifyContentToString << .justifyContent )
-- , ( "font-weight", maybeToString << .fontWeight )
-- , ( "font-style", fontStyleToString << .fontStyle )
-- , ( "font-size", maybeSizeUnitToString << .fontSize )
-- , ( "font-family", fontFamilyToString << .fontFamily )
-- , ( "width", maybeSizeUnitToString << .width )
-- , ( "max-width", maybeSizeUnitToString << .maxWidth )
-- , ( "min-width", maybeSizeUnitToString << .minWidth )
-- , ( "height", maybeSizeUnitToString << .height )
-- , ( "max-height", maybeSizeUnitToString << .maxHeight )
-- , ( "min-height", maybeSizeUnitToString << .minHeight )
-- , ( "z-index", maybeToString << .zIndex )
-- , ( "cursor", .cursor )
-- , ( "visibility", visibilityToString << .visibility )
-- , ( "vertical-align", .verticalAlign )
-- ]
--     |> List.map
--         (\( attrName, fun ) ->
--             ( attrName, fun styleValues )
--         )


removeEmptyStyles : List ( String, Maybe String ) -> List ( String, String )
removeEmptyStyles =
    List.concatMap <|
        \( attr, maybe_ ) ->
            case maybe_ of
                Nothing ->
                    []

                Just val ->
                    [ ( attr, val ) ]


{-| -}
toInlineStyles : Style -> List ( String, String )
toInlineStyles =
    compileStyle


{-| -}
convertStyles : Style -> List ( String, String )
convertStyles =
    toInlineStyles


{-| -}
inlineStyle : Style -> Html.Attribute msg
inlineStyle =
    Html.Attributes.style
        << convertStyles



-- position : Position -> Style -> Style
-- position value (Style style) =
--     Style { style | position = Just value }
-- {-| -}
-- positionAbsolute : Style -> Style
-- positionAbsolute =
--     position PositionAbsolute
--
--
-- {-| -}
-- positionSticky : Style -> Style
-- positionSticky =
--     position PositionSticky
--
--
-- {-| -}
-- positionRelative : Style -> Style
-- positionRelative =
--     position PositionRelative
--
--
-- {-| -}
-- positionFixed : Style -> Style
-- positionFixed =
--     position PositionFixed
--
--
-- {-| -}
-- positionStatic : Style -> Style
-- positionStatic =
--     position PositionStatic
--
-- {-| -}
-- left : SizeUnit -> Style -> Style
-- left value (Style style) =
--     Style { style | left = Just value }
--
--
-- {-| -}
-- right : SizeUnit -> Style -> Style
-- right value (Style style) =
--     Style { style | right = Just value }
--
--
-- {-| -}
-- top : SizeUnit -> Style -> Style
-- top value (Style style) =
--     Style { style | top = Just value }
--
--
-- {-| -}
-- bottom : SizeUnit -> Style -> Style
-- bottom value (Style style) =
--     Style { style | bottom = Just value }
-- {-| -}
-- absolutelyPositionned : Vector Float -> Style -> Style
-- absolutelyPositionned ( x, y ) =
--     [ position PositionAbsolute
--     , left <| Px <| Basics.round <| x
--     , right <| Px <| Basics.round <| x
--     ]
--         |> compose
-- {-| -}
-- verticalAlignMiddle : Style -> Style
-- verticalAlignMiddle (Style style) =
--     Style { style | verticalAlign = Just "middle" }
--
--
-- alignItems : Align -> Style -> Style
-- alignItems value (Style style) =
--     Style { style | alignItems = Just value }
--
--
-- {-| -}
-- alignItemsBaseline : Style -> Style
-- alignItemsBaseline =
--     alignItems AlignBaseline
--
--
-- {-| -}
-- alignItemsCenter : Style -> Style
-- alignItemsCenter =
--     alignItems AlignCenter
--
--
-- {-| -}
-- alignItemsFlexStart : Style -> Style
-- alignItemsFlexStart =
--     alignItems AlignFlexStart
--
--
-- {-| -}
-- alignItemsFlexEnd : Style -> Style
-- alignItemsFlexEnd =
--     alignItems AlignFlexEnd
--
--
-- {-| -}
-- alignItemsInherit : Style -> Style
-- alignItemsInherit =
--     alignItems AlignInherit
--
--
-- {-| -}
-- alignItemsInitial : Style -> Style
-- alignItemsInitial =
--     alignItems AlignInitial
--
--
-- {-| -}
-- alignItemsStretch : Style -> Style
-- alignItemsStretch =
--     alignItems AlignStretch
--
--
-- alignSelf : Align -> Style -> Style
-- alignSelf value (Style style) =
--     Style { style | alignSelf = Just value }
--
--
-- {-| -}
-- alignSelfCenter : Style -> Style
-- alignSelfCenter =
--     alignSelf AlignCenter
--
--


{-| -}
padding : SizeUnit -> Layout -> Layout
padding val layout =
    { layout
        | padding =
            Just
                (fullSurrounding val
                    (layout.padding |> Maybe.withDefault defaultSurrounded)
                )
    }


paddingLeft : SizeUnit -> Layout -> Layout
paddingLeft val layout =
    layout
        |> .padding
        |> Maybe.withDefault defaultSurrounded
        |> leftSurrounding val
        |> Just
        |> setPaddingIn layout


paddingRight : SizeUnit -> Layout -> Layout
paddingRight val ({ padding } as layout) =
    padding
        |> Maybe.withDefault defaultSurrounded
        |> rightSurrounding val
        |> Just
        |> setPaddingIn layout


setSurroundingValue :
    (surroundingContainer -> Maybe (Surrounded a))
    -> (surroundingContainer -> Maybe (Surrounded a) -> surroundingContainer)
    -> (a -> Surrounded a -> Surrounded a)
    -> a
    -> surroundingContainer
    -> surroundingContainer
setSurroundingValue getter propertySetter valueSetter val surroundingContainer =
    surroundingContainer
        |> getter
        |> Maybe.withDefault defaultSurrounded
        |> valueSetter val
        |> Just
        |> propertySetter surroundingContainer


setMarginValue :
    (MarginValue -> Surrounded MarginValue -> Surrounded MarginValue)
    -> MarginValue
    -> Layout
    -> Layout
setMarginValue =
    setSurroundingValue .margin setMarginIn


marginRight : MarginValue -> Layout -> Layout
marginRight =
    setMarginValue rightSurrounding


marginLeft : MarginValue -> Layout -> Layout
marginLeft =
    setMarginValue leftSurrounding



-- padding : SizeUnit -> Layout -> Layout
-- padding val ({ padding } as layout) =
--     padding
--         |> Maybe.withDefault defaultSurrounded
--         |> fullSurrounding val
--         |> Just
--         |> setPaddingIn layout
-- {-| -}
-- padding : SizeUnit -> Style -> Style
-- padding size =
--     paddingHorizontal size << paddingVertical size
--
--
-- {-| -}
-- paddingHorizontal : SizeUnit -> Style -> Style
-- paddingHorizontal size =
--     paddingLeft size << paddingRight size
--
--
-- {-| -}
-- paddingVertical : SizeUnit -> Style -> Style
-- paddingVertical size =
--     paddingBottom size << paddingTop size
--
--
--
--
-- {-| -}
-- paddingTop : SizeUnit -> Style -> Style
-- paddingTop size (Style style) =
--     Style { style | paddingTop = Just size }
--
--
-- {-| -}
-- paddingRight : SizeUnit -> Style -> Style
-- paddingRight size (Style style) =
--     Style { style | paddingRight = Just size }
--
--
-- {-| -}
-- paddingBottom : SizeUnit -> Style -> Style
-- paddingBottom size (Style style) =
--     Style { style | paddingBottom = Just size }
--
--
-- {-| -}
-- margin : SizeUnit -> Style -> Style
-- margin size =
--     marginHorizontal size << marginVertical size
--
--
-- {-| -}
-- marginAuto : Style -> Style
-- marginAuto =
--     marginHorizontalAuto
--
--
-- {-| -}
-- marginHorizontal : SizeUnit -> Style -> Style
-- marginHorizontal size =
--     marginLeft size << marginRight size
--
--
-- marginHorizontalAuto : Style -> Style
-- marginHorizontalAuto =
--     marginLeftAuto << marginRightAuto
--
--
-- {-| -}
-- marginVertical : SizeUnit -> Style -> Style
-- marginVertical size =
--     marginBottom size << marginTop size
--
--
-- {-| -}
-- marginLeft : SizeUnit -> Style -> Style
-- marginLeft size (Style style) =
--     Style { style | marginLeft = Just <| Left size }
--
--
-- marginLeftAuto : Style -> Style
-- marginLeftAuto (Style style) =
--     Style { style | marginLeft = Just <| Right Auto }
--
--
-- {-| -}
-- marginTop : SizeUnit -> Style -> Style
-- marginTop size (Style style) =
--     Style { style | marginTop = Just <| Left size }
--
--
-- {-| -}
-- marginRight : SizeUnit -> Style -> Style
-- marginRight size (Style style) =
--     Style { style | marginRight = Just <| Left size }
--
--
-- marginRightAuto : Style -> Style
-- marginRightAuto (Style style) =
--     Style { style | marginRight = Just <| Right Auto }
--
--
-- {-| -}
-- marginBottom : SizeUnit -> Style -> Style
-- marginBottom size (Style style) =
--     Style { style | marginBottom = Just <| Left size }
--
--
-- textTransform : Capitalization -> Style -> Style
-- textTransform val (Style style) =
--     Style { style | textTransform = Just val }
--
--
-- {-| -}
-- uppercase : Style -> Style
-- uppercase =
--     textTransform CapitalizationUppercase
--
--
-- {-| -}
-- lowercase : Style -> Style
-- lowercase =
--     textTransform CapitalizationLowercase
--
--
-- {-| -}
-- capitalize : Style -> Style
-- capitalize =
--     textTransform CapitalizationCapitalize
--
--
-- {-| -}
-- textColor : Color -> Style -> Style
-- textColor value (Style style) =
--     Style { style | textColor = Just value }
--
--
-- textDecoration : TextDecoration -> Style -> Style
-- textDecoration val (Style style) =
--     Style { style | textDecoration = Just val }
--
--
-- {-| -}
-- textDecorationNone : Style -> Style
-- textDecorationNone =
--     textDecoration TextDecorationNone
--
--
-- {-| -}
-- underline : Style -> Style
-- underline =
--     textDecoration TextDecorationUnderline
--
--
-- {-| -}
-- lineThrough : Style -> Style
-- lineThrough =
--     textDecoration TextDecorationLineThrough
--
--
-- {-| -}
-- bold : Style -> Style
-- bold =
--     fontWeight 700
--
--
-- {-| -}
-- strong : Style -> Style
-- strong =
--     bold
--
--
-- lineHeightGeneric : Either SizeUnit Normal -> Style -> Style
-- lineHeightGeneric val (Style style) =
--     Style { style | lineHeight = Just val }
--
--
-- {-| -}
-- lineHeight : SizeUnit -> Style -> Style
-- lineHeight =
--     lineHeightGeneric << Left
--
--
-- {-| -}
-- lineHeightNormal : Style -> Style
-- lineHeightNormal =
--     lineHeightGeneric <| Right Normal
--
--
-- {-| -}
-- fontWeightNormal : Style -> Style
-- fontWeightNormal =
--     fontWeight 400
--
--
-- {-| -}
-- fontWeight : Int -> Style -> Style
-- fontWeight val (Style style) =
--     Style { style | fontWeight = Just val }
--
--
-- fontStyle : FontTilt -> Style -> Style
-- fontStyle val (Style style) =
--     Style { style | fontStyle = Just val }
--
--
-- {-| -}
-- fontStyleNormal : Style -> Style
-- fontStyleNormal =
--     fontStyle FontTiltNormal
--
--
-- {-| -}
-- fontStyleItalic : Style -> Style
-- fontStyleItalic =
--     fontStyle FontTiltItalic
--
--
-- {-| -}
-- fontSize : SizeUnit -> Style -> Style
-- fontSize val (Style style) =
--     Style { style | fontSize = Just val }
--
--


{-| helper function to create a heading
-}
heading : SizeUnit -> Style -> Style
heading val =
    identity



-- [ margin zero
-- , marginBottom (Rem 0.5)
-- , fontWeight 600
-- , fontSize val
-- ]
--     |> compose


{-| helper function to create a h1 style
-}
h1S : Style -> Style
h1S =
    heading alpha


{-| helper function to create a h2 style
-}
h2S : Style -> Style
h2S =
    heading beta


{-| helper function to create a h3 style
-}
h3S : Style -> Style
h3S =
    heading gamma


{-| helper function to create a h4 style
-}
h4S : Style -> Style
h4S =
    heading delta


{-| helper function to create a h5 style
-}
h5S : Style -> Style
h5S =
    heading epsilon


{-| helper function to create a h6 style
-}
h6S : Style -> Style
h6S =
    heading zeta


{-| -}
alpha : SizeUnit
alpha =
    Rem 2.5


{-| -}
beta : SizeUnit
beta =
    Rem 2


{-| -}
gamma : SizeUnit
gamma =
    Rem 1.75


{-| -}
delta : SizeUnit
delta =
    Rem 1.5


{-| -}
epsilon : SizeUnit
epsilon =
    Rem 1.25


{-| -}
zeta : SizeUnit
zeta =
    Rem 1


{-| -}
eta : SizeUnit
eta =
    Em 0.75


{-| -}
theta : SizeUnit
theta =
    Em 0.5


{-| -}
iota : SizeUnit
iota =
    Em 0.25


{-| -}
kappa : SizeUnit
kappa =
    Em 0.125



-- textAlign : Alignment -> Style -> Style
-- textAlign val (Style style) =
--     Style { style | textAlign = Just val }
--
--
-- {-| -}
-- textCenter : Style -> Style
-- textCenter =
--     textAlign AlignmentCenter
--
--
-- {-| -}
-- textRight : Style -> Style
-- textRight =
--     textAlign AlignmentRight
--
--
-- {-| -}
-- textLeft : Style -> Style
-- textLeft =
--     textAlign AlignmentLeft
--
--
-- {-| -}
-- textJustify : Style -> Style
-- textJustify =
--     textAlign AlignmentJustify
--
--
-- whiteSpace : WhiteSpace -> Style -> Style
-- whiteSpace value (Style style) =
--     Style { style | whiteSpace = Just value }
--
--
-- {-| -}
-- whiteSpaceNoWrap : Style -> Style
-- whiteSpaceNoWrap =
--     whiteSpace WhiteSpaceNoWrap
--
--


textOverflow : TextOverflow -> BlockDetails -> BlockDetails
textOverflow value blockAttributes =
    { blockAttributes | textOverflow = Just value }


dimensions : Modifiers Dimensions -> BlockDetails -> BlockDetails
dimensions dimensionsModifiers blockAttributes =
    { blockAttributes | dimensions = Just (defaultDimensions |> (dimensionsModifiers |> compose)) }



--
--
-- {-| -}
-- textOverflowEllipsis : Style -> Style
-- textOverflowEllipsis =
--     textOverflow TextOverflowEllipsis
--
--
-- {-| -}
-- backgroundColor : Color -> Style -> Style
-- backgroundColor color (Style style) =
--     Style { style | backgroundColor = Just color }
--
--
-- {-| Add multiple background images to the styles
-- -}
-- backgroundImages : List BackgroundImage -> Style -> Style
-- backgroundImages backgroundImages (Style style) =
--     Style { style | backgroundImages = backgroundImages }
--
--
-- {-| Add a background image to the styles
-- -}
-- backgroundImage : BackgroundImage -> Style -> Style
-- backgroundImage backgroundImage (Style style) =
--     Style { style | backgroundImages = [ backgroundImage ] }
--
--
-- {-| Remove the border
-- -}
-- borderNone : Style -> Style
-- borderNone =
--     borderWidth 0
--
--
-- {-| -}
-- borderColor : Color -> Style -> Style
-- borderColor color =
--     borderBottomColor color
--         << borderLeftColor color
--         << borderTopColor color
--         << borderRightColor color
--
--
-- {-| -}
-- borderSolid : Style -> Style
-- borderSolid =
--     borderBottomSolid
--         << borderLeftSolid
--         << borderTopSolid
--         << borderRightSolid
--
--
-- {-| -}
-- borderDashed : Style -> Style
-- borderDashed =
--     borderBottomDashed
--         << borderLeftDashed
--         << borderTopDashed
--         << borderRightDashed
--
--
-- {-| -}
-- borderWidth : Int -> Style -> Style
-- borderWidth size =
--     borderBottomWidth size
--         << borderLeftWidth size
--         << borderTopWidth size
--         << borderRightWidth size
--
--
-- {-| -}
-- borderBottomColor : Color -> Style -> Style
-- borderBottomColor color (Style style) =
--     Style { style | borderBottomColor = Just color }
--
--
-- {-| -}
-- borderBottomStyle : Border -> Style -> Style
-- borderBottomStyle style_ (Style style) =
--     Style { style | borderBottomStyle = Just style_ }
--
--
-- {-| -}
-- borderBottomSolid : Style -> Style
-- borderBottomSolid =
--     borderBottomStyle BorderSolid
--
--
-- {-| -}
-- borderBottomDashed : Style -> Style
-- borderBottomDashed =
--     borderBottomStyle BorderDashed
--
--
-- {-| -}
-- borderBottomWidth : Int -> Style -> Style
-- borderBottomWidth size_ (Style style) =
--     Style { style | borderBottomWidth = Just (Px size_) }
--
--
-- {-| -}
-- borderLeftColor : Color -> Style -> Style
-- borderLeftColor color (Style style) =
--     Style { style | borderLeftColor = Just color }
--
--
-- {-| -}
-- borderLeftStyle : Border -> Style -> Style
-- borderLeftStyle style_ (Style style) =
--     Style { style | borderLeftStyle = Just style_ }
--
--
-- {-| -}
-- borderLeftSolid : Style -> Style
-- borderLeftSolid =
--     borderLeftStyle BorderSolid
--
--
-- {-| -}
-- borderLeftDashed : Style -> Style
-- borderLeftDashed =
--     borderLeftStyle BorderDashed
--
--
-- {-| -}
-- borderLeftWidth : Int -> Style -> Style
-- borderLeftWidth size_ (Style style) =
--     Style { style | borderLeftWidth = Just (Px size_) }
--
--
-- {-| -}
-- borderTopColor : Color -> Style -> Style
-- borderTopColor color (Style style) =
--     Style { style | borderTopColor = Just color }
--
--
-- {-| -}
-- borderTopStyle : Border -> Style -> Style
-- borderTopStyle style_ (Style style) =
--     Style { style | borderTopStyle = Just style_ }
--
--
-- {-| -}
-- borderTopSolid : Style -> Style
-- borderTopSolid =
--     borderTopStyle BorderSolid
--
--
-- {-| -}
-- borderTopDashed : Style -> Style
-- borderTopDashed =
--     borderTopStyle BorderDashed
--
--
-- {-| -}
-- borderTopWidth : Int -> Style -> Style
-- borderTopWidth size_ (Style style) =
--     Style { style | borderTopWidth = Just (Px size_) }
--
--
-- {-| -}
-- borderRightColor : Color -> Style -> Style
-- borderRightColor color (Style style) =
--     Style { style | borderRightColor = Just color }
--
--
-- {-| -}
-- borderRightStyle : Border -> Style -> Style
-- borderRightStyle style_ (Style style) =
--     Style { style | borderRightStyle = Just style_ }
--
--
-- {-| -}
-- borderRightSolid : Style -> Style
-- borderRightSolid =
--     borderRightStyle BorderSolid
--
--
-- {-| -}
-- borderRightDashed : Style -> Style
-- borderRightDashed =
--     borderRightStyle BorderDashed
--
--
-- {-| -}
-- borderRightWidth : Int -> Style -> Style
-- borderRightWidth size_ (Style style) =
--     Style { style | borderRightWidth = Just (Px size_) }
--
--
-- {-| -}
-- borderBottomLeftRadius : Int -> Style -> Style
-- borderBottomLeftRadius size_ (Style style) =
--     Style { style | borderBottomLeftRadius = Just (Px size_) }
--
--
-- {-| -}
-- borderBottomRightRadius : Int -> Style -> Style
-- borderBottomRightRadius size_ (Style style) =
--     Style { style | borderBottomRightRadius = Just (Px size_) }
--
--
-- {-| -}
-- borderTopLeftRadius : Int -> Style -> Style
-- borderTopLeftRadius size_ (Style style) =
--     Style { style | borderTopLeftRadius = Just (Px size_) }
--
--
-- {-| -}
-- borderTopRightRadius : Int -> Style -> Style
-- borderTopRightRadius size_ (Style style) =
--     Style { style | borderTopRightRadius = Just (Px size_) }
--
--
-- {-| -}
-- borderRadius : Int -> Style -> Style
-- borderRadius size_ =
--     [ borderTopRightRadius size_
--     , borderTopLeftRadius size_
--     , borderBottomLeftRadius size_
--     , borderBottomRightRadius size_
--     ]
--         |> compose
-- {-| Set both text and border in same color.
-- -}
-- borderAndTextColor : Color -> Style -> Style
-- borderAndTextColor val =
--     borderColor val << textColor val
-- {-| -}
-- outlineColor : Color -> Style -> Style
-- outlineColor val (Style style) =
--     Style { style | outlineColor = Just val }
--
--
-- outlineStyle : Border -> Style -> Style
-- outlineStyle val (Style style) =
--     Style { style | outlineStyle = Just val }
--
--
-- {-| -}
-- outlineStyleSolid : Style -> Style
-- outlineStyleSolid =
--     outlineStyle BorderSolid
--
--
-- {-| -}
-- outlineStyleDashed : Style -> Style
-- outlineStyleDashed =
--     outlineStyle BorderDashed
--
--
-- {-| -}
-- outlineWidth : Int -> Style -> Style
-- outlineWidth val (Style style) =
--     Style { style | outlineWidth = Just (Px val) }
--
--
-- {-| -}
-- outlineNone : Style -> Style
-- outlineNone =
--     outlineWidth 0
--
--
-- standardBoxShadow : Maybe SizeUnit -> Maybe Color -> Offset -> BoxShadow
-- standardBoxShadow =
--     BoxShadow False Nothing
--
--
-- {-| Set the box shadow
-- -}
-- boxShadow : BoxShadow -> Style -> Style
-- boxShadow val (Style style) =
--     Style { style | boxShadow = Just val }
--
--
-- {-| Create a plain box shadow
-- -}
-- boxShadowPlain : Offset -> Color -> Style -> Style
-- boxShadowPlain offset color =
--     boxShadow
--         (standardBoxShadow Nothing (Just color) offset)
--
--
-- {-| Create a blurry box shadow
-- -}
-- boxShadowBlurry : Offset -> SizeUnit -> Color -> Style -> Style
-- boxShadowBlurry offset blurRadius color =
--     boxShadow
--         (standardBoxShadow (Just blurRadius) (Just color) offset)
--
--
-- {-| Create a centered blurry box shadow
-- -}
-- boxShadowCenteredBlurry : SizeUnit -> Color -> Style -> Style
-- boxShadowCenteredBlurry =
--     boxShadowBlurry ( Px 0, Px 0 )
--
-- display : DisplayBox -> Style -> Style
-- display val (Style style) =
--     Style { style | display = Just val }
--
-- {-| -}
-- displayInlineBlock : Style -> Style
-- displayInlineBlock =
--     display DisplayInlineBlock
-- {-| -}
-- displayBlock : Style -> Style
-- displayBlock =
--     display DisplayBlock
-- {-| -}
-- displayFlex : Style -> Style
-- displayFlex =
--     display DisplayFlex
-- displayInlineFlex : Style -> Style
-- displayInlineFlex =
--     display DisplayInlineFlex
-- {-| -}
-- displayInline : Style -> Style
-- displayInline =
--     display DisplayInline
--
--
--
--
-- {-| -}
-- flexGrow : Int -> Style -> Style
-- flexGrow val (Style style) =
--     Style { style | flexGrow = Just val }
--
--
-- {-| -}
-- flexShrink : Int -> Style -> Style
-- flexShrink val (Style style) =
--     Style { style | flexShrink = Just val }
--
--
-- {-| -}
-- flexBasisGeneric : Either SizeUnit Auto -> Style -> Style
-- flexBasisGeneric val (Style style) =
--     Style { style | flexBasis = Just val }
--
--
-- {-| -}
-- flexBasis : SizeUnit -> Style -> Style
-- flexBasis =
--     flexBasisGeneric << Left
--
--
-- {-| -}
-- flex : Int -> Style -> Style
-- flex val =
--     [ flexGrow val
--     , flexShrink 1
--     , flexBasis (Px 0)
--     ]
--         |> compose
--
--
-- flexWrap : FlexWrap -> Style -> Style
-- flexWrap val (Style style) =
--     Style { style | flexWrap = Just val }
--
--
-- {-| -}
-- flexWrapWrap : Style -> Style
-- flexWrapWrap =
--     flexWrap FlexWrapWrap
--
--
-- {-| -}
-- flexWrapNoWrap : Style -> Style
-- flexWrapNoWrap =
--     flexWrap FlexWrapNoWrap
--
--
-- flexDirection : FlexDirection -> Style -> Style
-- flexDirection value (Style style) =
--     Style { style | flexDirection = Just value }
--
--
-- {-| -}
-- flexDirectionColumn : Style -> Style
-- flexDirectionColumn =
--     flexDirection FlexDirectionColumn
--
--
-- {-| -}
-- flexDirectionRow : Style -> Style
-- flexDirectionRow =
--     flexDirection FlexDirectionRow
--
--
-- {-| -}
-- opacity : Float -> Style -> Style
-- opacity val (Style style) =
--     Style { style | opacity = Just val }
--
--
-- {-| -}
-- overflowX : Overflow -> Style -> Style
-- overflowX val (Style style) =
--     Style { style | overflowX = Just val }
--
--
-- {-| -}
-- overflowY : Overflow -> Style -> Style
-- overflowY val (Style style) =
--     Style { style | overflowY = Just val }
--
--
-- overflow : Overflow -> Style -> Style
-- overflow val =
--     overflowX val << overflowY val
--
--
-- {-| -}
-- overflowAuto : Style -> Style
-- overflowAuto =
--     overflow OverflowAuto
--
--
-- {-| -}
-- overflowVisible : Style -> Style
-- overflowVisible =
--     overflow OverflowVisible
--
--
-- {-| -}
-- overflowHidden : Style -> Style
-- overflowHidden =
--     overflow OverflowHidden
--
--
-- {-| -}
-- overflowScroll : Style -> Style
-- overflowScroll =
--     overflow OverflowScroll
--
--
-- {-| -}
-- overflowXAuto : Style -> Style
-- overflowXAuto =
--     overflowX OverflowAuto
--
--
-- {-| -}
-- overflowXVisible : Style -> Style
-- overflowXVisible =
--     overflowX OverflowVisible
--
--
-- {-| -}
-- overflowXHidden : Style -> Style
-- overflowXHidden =
--     overflowX OverflowHidden
--
--
-- {-| -}
-- overflowXScroll : Style -> Style
-- overflowXScroll =
--     overflowX OverflowScroll
--
--
-- {-| -}
-- overflowYAuto : Style -> Style
-- overflowYAuto =
--     overflowY OverflowAuto
--
--
-- {-| -}
-- overflowYVisible : Style -> Style
-- overflowYVisible =
--     overflowY OverflowVisible
--
--
-- {-| -}
-- overflowYHidden : Style -> Style
-- overflowYHidden =
--     overflowY OverflowHidden
--
--
-- {-| -}
-- overflowYScroll : Style -> Style
-- overflowYScroll =
--     overflowY OverflowScroll
--
--
-- listStyleType : ListStyleType -> Style -> Style
-- listStyleType value (Style style) =
--     Style { style | listStyleType = Just value }
--
--
-- {-| -}
-- listStyleNone : Style -> Style
-- listStyleNone =
--     listStyleType ListStyleTypeNone
--
--
-- {-| -}
-- listStyleDisc : Style -> Style
-- listStyleDisc =
--     listStyleType ListStyleTypeDisc
--
--
-- {-| -}
-- listStyleCircle : Style -> Style
-- listStyleCircle =
--     listStyleType ListStyleTypeCircle
--
--
-- {-| -}
-- listStyleSquare : Style -> Style
-- listStyleSquare =
--     listStyleType ListStyleTypeSquare
--
--
-- {-| -}
-- listStyleDecimal : Style -> Style
-- listStyleDecimal =
--     listStyleType ListStyleTypeDecimal
--
--
-- {-| -}
-- listStyleGeorgian : Style -> Style
-- listStyleGeorgian =
--     listStyleType ListStyleTypeGeorgian
--
--
-- {-| -}
-- round : Style -> Style
-- round =
--     roundCorner 300
--
--
-- {-| -}
-- roundCorner : Int -> Style -> Style
-- roundCorner value =
--     borderBottomLeftRadius value
--         << borderBottomRightRadius value
--         << borderTopLeftRadius value
--         << borderTopRightRadius value
--
--
-- justifyContent : JustifyContent -> Style -> Style
-- justifyContent value (Style style) =
--     Style { style | justifyContent = Just value }
--
--
-- {-| -}
-- justifyContentSpaceBetween : Style -> Style
-- justifyContentSpaceBetween =
--     justifyContent JustifyContentSpaceBetween
--
--
-- {-| -}
-- spaceBetween : Style -> Style
-- spaceBetween =
--     justifyContentSpaceBetween
--
--
-- {-| -}
-- justifyContentSpaceAround : Style -> Style
-- justifyContentSpaceAround =
--     justifyContent JustifyContentSpaceAround
--
--
-- {-| -}
-- spaceAround : Style -> Style
-- spaceAround =
--     justifyContentSpaceAround
--
--
-- {-| -}
-- justifyContentCenter : Style -> Style
-- justifyContentCenter =
--     justifyContent JustifyContentCenter
--
--
--
--


{-| -}
width : SizeUnit -> Dimensions -> Dimensions
width value ( x, y ) =
    ( x |> setDimension value, y )


{-| -}
height : SizeUnit -> Dimensions -> Dimensions
height value ( x, y ) =
    ( x, y |> setDimension value )


setDimension : SizeUnit -> DimensionAxis -> DimensionAxis
setDimension value dimensionAxis =
    { dimensionAxis | dimension = Just value }



--
--
-- {-| -}
-- widthPercent : Float -> Style -> Style
-- widthPercent =
--     width << Percent
--
--
-- {-| -}
-- fullWidth : Style -> Style
-- fullWidth =
--     widthPercent 100
--
--
-- {-| -}
-- maxWidth : SizeUnit -> Style -> Style
-- maxWidth value (Style style) =
--     Style { style | maxWidth = Just value }
--
--
-- {-| -}
-- minWidth : SizeUnit -> Style -> Style
-- minWidth value (Style style) =
--     Style { style | minWidth = Just value }
--
--
-- {-| -}
-- height : SizeUnit -> Style -> Style
-- height value (Style style) =
--     Style { style | height = Just value }
--
--
-- {-| -}
-- maxHeight : SizeUnit -> Style -> Style
-- maxHeight value (Style style) =
--     Style { style | maxHeight = Just value }
--
--
-- {-| -}
-- minHeight : SizeUnit -> Style -> Style
-- minHeight value (Style style) =
--     Style { style | minHeight = Just value }
--
--
-- {-| -}
-- heightPercent : Float -> Style -> Style
-- heightPercent =
--     height << Percent
--
--
-- {-| -}
-- fullHeight : Style -> Style
-- fullHeight =
--     heightPercent 100
--
--
-- {-| -}
-- fullViewportHeight : Style -> Style
-- fullViewportHeight =
--     height (Vh 100)
--
--
-- {-| -}
-- zIndex : Int -> Style -> Style
-- zIndex value (Style style) =
--     Style { style | zIndex = Just value }
--
--
-- cursor : String -> Style -> Style
-- cursor value (Style style) =
--     Style { style | cursor = Just value }
-- {-| -}
-- cursorPointer : Style -> Style
-- cursorPointer =
--     cursor "pointer"
--
--
-- visibility : Visibility -> Style -> Style
-- visibility value (Style style) =
--     Style { style | visibility = Just value }
--
--
-- {-| -}
-- visibilityHidden : Style -> Style
-- visibilityHidden =
--     visibility VisibilityHidden
--
--
-- {-| -}
-- transparent : Color
-- transparent =
--     Color.rgba 0 0 0 0.0
--
--
-- userSelect : UserSelect -> Style -> Style
-- userSelect val (Style style) =
--     Style { style | userSelect = Just val }
--
--
-- {-| -}
-- userSelectNone : Style -> Style
-- userSelectNone =
--     userSelect UserSelectNone
--
--
-- {-| -}
-- userSelectAll : Style -> Style
-- userSelectAll =
--     userSelect UserSelectAll
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
classes =
    classesAndScreenWidths Nothing


conditionalClasses : String -> Style -> String
conditionalClasses condition =
    classesAndScreenWidths (Just condition)


{-| Generate all the classes of a list of Hover Styles
-}
classesHover : Style -> String
classesHover =
    conditionalClasses "hover"


{-| Generate all the classes of a list of Focus Styles
-}
classesFocus : Style -> String
classesFocus =
    conditionalClasses "focus"


classesNameGeneration : Maybe String -> Style -> List String
classesNameGeneration suffix =
    compileStyle
        >> List.map (generateClassName suffix)


classesAndScreenWidths : Maybe String -> Style -> String
classesAndScreenWidths suffix (Style style) =
    let
        standardClassesNames =
            classesNameGeneration suffix (Style style)

        mediaQueriesClassesNames =
            style.screenWidths
                |> List.map (screenWidthToClassNames suffix)
                |> List.concat
    in
        List.append standardClassesNames mediaQueriesClassesNames
            |> String.join " "


screenWidthToClassNames : Maybe String -> ScreenWidth -> List String
screenWidthToClassNames suffix { min, max, style } =
    List.map
        (addMediaQueryId min max)
        (classesNameGeneration suffix style)


addMediaQueryId : Maybe Int -> Maybe Int -> String -> String
addMediaQueryId min max =
    flip (++) (String.filter Helpers.isValidInCssName (toString min ++ toString max))


generateClassName : Maybe String -> ( String, String ) -> String
generateClassName maybeSuffix ( attribute, value ) =
    attribute ++ "-" ++ (String.filter Helpers.isValidInCssName (value ++ generateSuffix maybeSuffix))


generateSuffix : Maybe String -> String
generateSuffix =
    Maybe.map (\suffix -> "_" ++ suffix)
        >> Maybe.withDefault ""


generateSelector : Maybe String -> Maybe String
generateSelector =
    Maybe.map ((++) ":")


addSuffix : String -> String -> String
addSuffix =
    flip (++)


type alias ConditionalStyle =
    { style : Style
    , suffix : Maybe String
    , mediaQuery : Maybe ( Maybe Int, Maybe Int )
    }


type alias AtomicClass =
    { mediaQuery : Maybe String
    , className : String
    , mediaQueryId : Maybe String
    , selector : Maybe String
    , property : String
    }


generateMediaQueryId : ( Maybe Int, Maybe Int ) -> String
generateMediaQueryId ( min, max ) =
    String.filter Helpers.isValidInCssName (toString min ++ toString max)


coupleToAtomicClass : Maybe String -> Maybe ( Maybe Int, Maybe Int ) -> ( String, String ) -> AtomicClass
coupleToAtomicClass suffix mediaQuery property =
    { mediaQuery = Maybe.map generateMediaQuery mediaQuery
    , className = generateClassName suffix property
    , mediaQueryId = Maybe.map generateMediaQueryId mediaQuery
    , selector = generateSelector suffix
    , property = generateProperty property
    }


compileConditionalStyle : ConditionalStyle -> List AtomicClass
compileConditionalStyle { style, suffix, mediaQuery } =
    List.map (coupleToAtomicClass suffix mediaQuery) (compileStyle style)


compileAtomicClass : AtomicClass -> String
compileAtomicClass { mediaQuery, className, mediaQueryId, selector, property } =
    inMediaQuery mediaQuery
        (compileStyleToCss className mediaQueryId selector property)


{-| Generate all the css from a list of tuple : styles and hover
-}
stylesToCss : List ConditionalStyle -> List String
stylesToCss styles =
    styles
        |> List.concatMap compileScreenWidths
        |> List.concatMap compileConditionalStyle
        |> List.map compileAtomicClass
        |> List.append [ boxSizingCss ]
        |> List.Extra.unique


boxSizingCss : String
boxSizingCss =
    "*{box-sizing: border-box;}"


screenWidthToCompiledStyle :
    Maybe String
    -> ScreenWidth
    -> ConditionalStyle
screenWidthToCompiledStyle suffix { min, max, style } =
    ConditionalStyle style suffix (Just ( min, max ))


compileScreenWidths : ConditionalStyle -> List ConditionalStyle
compileScreenWidths ({ suffix, style } as style_) =
    let
        (Style { screenWidths }) =
            style
    in
        style_ :: List.map (screenWidthToCompiledStyle suffix) screenWidths


generateMediaQuery : ( Maybe Int, Maybe Int ) -> String
generateMediaQuery ( min, max ) =
    "@media " ++ mediaQuerySelector min max


inMediaQuery : Maybe String -> String -> String
inMediaQuery mediaQuery content =
    case mediaQuery of
        Nothing ->
            content

        Just queries ->
            queries ++ Helpers.surroundWithBraces content


mediaQuerySelector : Maybe Int -> Maybe Int -> String
mediaQuerySelector min max =
    case min of
        Nothing ->
            case max of
                Nothing ->
                    ""

                Just max_ ->
                    "(max-width: " ++ toString max_ ++ "px)"

        Just min_ ->
            case max of
                Nothing ->
                    "(min-width: " ++ toString min_ ++ "px)"

                Just max_ ->
                    "(min-width: " ++ toString min_ ++ "px) and (max-width: " ++ toString max_ ++ "px)"


generateProperty : ( String, String ) -> String
generateProperty ( attribute, value ) =
    attribute ++ ":" ++ value


compileStyleToCss : String -> Maybe String -> Maybe String -> String -> String
compileStyleToCss className mediaQueryId selector property =
    "."
        ++ className
        ++ (mediaQueryId ? "")
        ++ (selector ? "")
        ++ Helpers.surroundWithBraces property
