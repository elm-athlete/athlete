module Elegant.Display
    exposing
        ( Alignment
        , BlockDetails
        , Contents
        , DisplayBox(..)
        , InsideDisplay(..)
        , ListStyleType
        , OutsideDisplay(..)
        , TextOverflow
        , alignment
        , center
        , defaultBlockDetails
        , dimensions
        , displayBoxToCouples
        , fullWidth
        , justify
        , left
        , listStyleCircle
        , listStyleDecimal
        , listStyleDisc
        , listStyleGeorgian
        , listStyleNone
        , listStyleSquare
        , overflow
        , right
        , textOverflowEllipsis
        )

{-| Display contains everything about an element rendering. It is the basis of
every style, for every element. Each element can be block, inline, flow or flex.


# Types

@docs DisplayBox
@docs Contents
@docs OutsideDisplay
@docs InsideDisplay
@docs BlockDetails
@docs ListStyleType
@docs Alignment
@docs TextOverflow
@docs defaultBlockDetails


# Modifiers


## List

@docs listStyleNone
@docs listStyleDisc
@docs listStyleCircle
@docs listStyleSquare
@docs listStyleDecimal
@docs listStyleGeorgian


## Alignment

@docs alignment
@docs right
@docs center
@docs left
@docs justify


## Overflow

@docs overflow
@docs textOverflowEllipsis

## Dimensions
@docs dimensions
@docs fullWidth


# Compilation

@docs displayBoxToCouples

-}

import Elegant.Box as Box
import Elegant.Dimensions as Dimensions
import Elegant.Flex as Flex
import Elegant.Grid as Grid
import Elegant.Helpers.Css
import Elegant.Helpers.Shared exposing (..)
import Elegant.Internals.Setters exposing (..)
import Elegant.Overflow as Overflow
import Function exposing (callOn)
import Modifiers exposing (..)


{-| Represents a box and contains all the style inside.
If the display is none, no style is included. Otherwise, the display
type requires the corresponding styles. I.e. if using a flex container,
then only styles applying to flex container can be used. If using a block
container, only styles applying to block can be used, and so on.

You don't use it directly, but rather generating one with the corresponding
functions, then giving it to a function which needs one. If you want to bypass
it, you can use `Display.displayBoxToCouples`, which generates the equivalent
CSS.

-}
type DisplayBox
    = None
    | ContentsWrapper Contents


displayBox : OutsideDisplay -> InsideDisplay -> Modifiers Box.Box -> DisplayBox
displayBox outsideDisplay insideDisplay =
    ContentsWrapper
        << Contents outsideDisplay insideDisplay
        << modifiedElementOrNothing Box.default


{-| -}
type alias Contents =
    { outsideDisplay : OutsideDisplay
    , insideDisplay : InsideDisplay
    , maybeBox : Maybe Box.Box
    }


{-| Represents the style from outside the display.
Can be inline, block, or flex-item.
-}
type OutsideDisplay
    = Inline
    | Block (Maybe BlockDetails)
    | FlexItem (Maybe Flex.FlexItemDetails) (Maybe BlockDetails)
    | GridItem (Maybe Grid.GridItemDetails) (Maybe BlockDetails)


{-| Represents the style from inside a display.
Can be flow, or flex (and containing flex details).
-}
type InsideDisplay
    = Flow
    | FlexContainer (Maybe Flex.FlexContainerDetails)
    | GridContainer (Maybe Grid.GridContainerDetails)


{-| Contains all styles which can be applied to a block.
It is automatically instanciated by `Display.block`.
-}
type alias BlockDetails =
    { listStyleType : Maybe ListStyleType
    , alignment : Maybe Alignment
    , overflow : Maybe Overflow.FullOverflow
    , textOverflow : Maybe TextOverflow
    , dimensions : Maybe Dimensions.Dimensions
    }


{-| -}
defaultBlockDetails : BlockDetails
defaultBlockDetails =
    BlockDetails Nothing Nothing Nothing Nothing Nothing


{-| Represents the type of the list style.
Can be none, disc, circle, square, decimal or georgian.
-}
type ListStyleType
    = ListStyleTypeNone
    | ListStyleTypeDisc
    | ListStyleTypeCircle
    | ListStyleTypeSquare
    | ListStyleTypeDecimal
    | ListStyleTypeGeorgian


listStyleType : ListStyleType -> Modifier BlockDetails
listStyleType =
    setListStyleType << Just


{-| Set the list style to none.
-}
listStyleNone : Modifier BlockDetails
listStyleNone =
    listStyleType ListStyleTypeNone


{-| Set the list style to disc.
-}
listStyleDisc : Modifier BlockDetails
listStyleDisc =
    listStyleType ListStyleTypeDisc


{-| Set the list style to circle.
-}
listStyleCircle : Modifier BlockDetails
listStyleCircle =
    listStyleType ListStyleTypeCircle


{-| Set the list style to square.
-}
listStyleSquare : Modifier BlockDetails
listStyleSquare =
    listStyleType ListStyleTypeSquare


{-| Set the list style to decimal.
-}
listStyleDecimal : Modifier BlockDetails
listStyleDecimal =
    listStyleType ListStyleTypeDecimal


{-| Set the list style to georgian.
-}
listStyleGeorgian : Modifier BlockDetails
listStyleGeorgian =
    listStyleType ListStyleTypeGeorgian


{-| Represents the alignment inside a block. Can be center, right, left or justify.
-}
type Alignment
    = AlignmentCenter
    | AlignmentRight
    | AlignmentLeft
    | AlignmentJustify


{-| Accepts the alignment and modifies the block accordingly.
-}
alignment : Alignment -> Modifier BlockDetails
alignment =
    setAlignment << Just


{-| Accepts dimensions modifiers and modifies the block accordingly.
-}
dimensions : Modifiers Dimensions.Dimensions -> Modifier BlockDetails
dimensions =
    getModifyAndSet .dimensions setDimensionsIn Dimensions.defaultDimensions


{-| Defines the alignment as right.
-}
right : Alignment
right =
    AlignmentRight


{-| Defines the alignment as center.
-}
center : Alignment
center =
    AlignmentCenter


{-| Defines the alignment as left.
-}
left : Alignment
left =
    AlignmentLeft


{-| Defines the alignment as justify.
-}
justify : Alignment
justify =
    AlignmentJustify


{-| Accepts a list of Overflow modifiers and modifies the block accordingly.
-}
overflow : Modifiers Overflow.FullOverflow -> Modifier BlockDetails
overflow =
    getModifyAndSet .overflow setOverflowIn Overflow.default


{-| Represents the text-overflow.
Can be ellipsis.
-}
type TextOverflow
    = TextOverflowEllipsis


{-| Modifies the block to give an text-overflow ellipsis.
-}
textOverflowEllipsis : Modifier BlockDetails
textOverflowEllipsis =
    setTextOverflow <| Just TextOverflowEllipsis


{-| Compiles a DisplayBox to the corresponding CSS list of tuples.
Handles only defined styles, ignoring `Nothing` fields.
-}
displayBoxToCouples : DisplayBox -> List ( String, String )
displayBoxToCouples val =
    case val of
        None ->
            [ ( "display", "none" ) ]

        ContentsWrapper { outsideDisplay, insideDisplay, maybeBox } ->
            outsideInsideDisplayToCouples outsideDisplay insideDisplay
                ++ (maybeBox |> Maybe.map Box.boxToCouples |> Maybe.withDefault [])


{-| Compiles a DisplayBox to the corresponding CSS list of tuples.
Handles only defined styles, ignoring `Nothing` fields.
-}
extractDisplayBoxCouples : DisplayBox -> List ( String, String )
extractDisplayBoxCouples val =
    case val of
        None ->
            [ ( "display", "none" ) ]

        ContentsWrapper { outsideDisplay, insideDisplay, maybeBox } ->
            outsideInsideDisplayToCouples outsideDisplay insideDisplay
                ++ (maybeBox |> Maybe.map Box.boxToCouples |> Maybe.withDefault [])



-- Internals


outsideInsideDisplayToCouples : OutsideDisplay -> InsideDisplay -> List ( String, String )
outsideInsideDisplayToCouples outsideDisplay =
    insideDisplayToCouples
        >> Elegant.Helpers.Css.joiner (outsideDisplayToCouples outsideDisplay)
        >> convertDisplayToLegacyCss


convertDisplayToLegacyCss : ( String, List ( String, String ) ) -> List ( String, String )
convertDisplayToLegacyCss ( dis, rest ) =
    ( "display", dis |> toLegacyDisplayCss ) :: rest


outsideDisplayToCouples : OutsideDisplay -> ( String, List ( String, String ) )
outsideDisplayToCouples outsideDisplay =
    case outsideDisplay of
        Inline ->
            ( "inline", [] )

        Block blockDetails ->
            ( "block", unwrapEmptyList blockDetailsToCouples blockDetails )

        FlexItem flexItemDetails blockDetails ->
            ( "block", List.append (unwrapEmptyList Flex.flexItemDetailsToCouples flexItemDetails) (unwrapEmptyList blockDetailsToCouples blockDetails) )

        GridItem gridItemDetails blockDetails ->
            ( "block", List.append (unwrapEmptyList Grid.gridItemDetailsToCouples gridItemDetails) (unwrapEmptyList blockDetailsToCouples blockDetails) )


insideDisplayToCouples : InsideDisplay -> ( String, List ( String, String ) )
insideDisplayToCouples insideDisplay =
    case insideDisplay of
        Flow ->
            ( "flow", [] )

        FlexContainer flexContainerDetails ->
            ( "flex", unwrapEmptyList Flex.flexContainerDetailsToCouples flexContainerDetails )

        GridContainer gridContainerDetails ->
            ( "grid", unwrapEmptyList Grid.gridContainerDetailsToCouples gridContainerDetails )


blockDetailsToCouples : BlockDetails -> List ( String, String )
blockDetailsToCouples blockDetails =
    [ unwrapToCouple .listStyleType listStyleTypeToCouple
    , unwrapToCouple .alignment textAlignToCouple
    , unwrapToCouples .overflow overflowToCouples
    , unwrapToCouple .textOverflow textOverflowToCouple
    , unwrapToCouples .dimensions Dimensions.dimensionsToCouples
    ]
        |> List.concatMap (callOn blockDetails)


{-| -}
fullWidth : Modifier BlockDetails
fullWidth =
    dimensions [ Dimensions.width (Percent 100) ]


toLegacyDisplayCss : String -> String
toLegacyDisplayCss str =
    case str of
        "inline flow" ->
            "inline"

        "block flow" ->
            "block"

        "inline flex" ->
            "inline-flex"

        "block flex" ->
            "flex"

        "inline grid" ->
            "inline-grid"

        "block grid" ->
            "grid"

        str_ ->
            str_


listStyleTypeToCouple : ListStyleType -> ( String, String )
listStyleTypeToCouple =
    Tuple.pair "list-style" << listStyleTypeToString


listStyleTypeToString : ListStyleType -> String
listStyleTypeToString val =
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


textAlignToCouple : Alignment -> ( String, String )
textAlignToCouple =
    Tuple.pair "text-align" << textAlignToString


textAlignToString : Alignment -> String
textAlignToString val =
    case val of
        AlignmentCenter ->
            "center"

        AlignmentLeft ->
            "left"

        AlignmentRight ->
            "right"

        AlignmentJustify ->
            "justify"


textOverflowToCouple : TextOverflow -> ( String, String )
textOverflowToCouple =
    Tuple.pair "text-overflow" << textOverflowToString


textOverflowToString : TextOverflow -> String
textOverflowToString val =
    case val of
        TextOverflowEllipsis ->
            "ellipsis"


overflowToCouples : Overflow.FullOverflow -> List ( String, String )
overflowToCouples ( x, y ) =
    [ ( "overflow-x", x ), ( "overflow-y", y ) ]
        |> List.map (Tuple.mapSecond (Maybe.map overflowToString))
        |> keepJustValues


overflowToString : Overflow.Overflow -> String
overflowToString val =
    case val of
        Overflow.OverflowAuto ->
            "auto"

        Overflow.OverflowScroll ->
            "scroll"

        Overflow.OverflowHidden ->
            "hidden"

        Overflow.OverflowVisible ->
            "visible"
