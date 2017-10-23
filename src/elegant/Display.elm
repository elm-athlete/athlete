module Display
    exposing
        ( DisplayBox(..)
        , OutsideDisplay(..)
        , InsideDisplay(..)
        , displayBox
        , none
        , block
        , inline
        , inlineFlexContainer
        , flexContainer
        , flexItem
        , flexChildContainer
        , BlockDetails
        , FlexContainerDetails
        , FlexItemDetails
        , ListStyleType
        , listStyleNone
        , listStyleDisc
        , listStyleCircle
        , listStyleSquare
        , listStyleDecimal
        , listStyleGeorgian
        , Alignment
        , alignment
        , alignCenter
        , right
        , cnter
        , left
        , justify
        , overflow
        , TextOverflow
        , textOverflowEllipsis
        , dimensions
        , width
        , height
        , fullWidth
        , FlexDirection
        , direction
        , column
        , row
        , FlexWrap
        , wrap
        , noWrap
        , Align
        , align
        , baseline
        , center
        , flexStart
        , flexEnd
        , inherit
        , initial
        , stretch
        , JustifyContent
        , justifyContent
        , spaceBetween
        , spaceAround
        , justifyContentCenter
        , grow
        , shrink
        , basisAuto
        , basis
        , alignSelf
        , displayBoxToCouples
        )

{-| Display contains everything about an element rendering. It is the basis of
every style, for every element. Each element can be block, inline, flow or flex.


# Types

@docs DisplayBox
@docs displayBox
@docs OutsideDisplay
@docs InsideDisplay
@docs BlockDetails
@docs FlexContainerDetails
@docs FlexItemDetails
@docs ListStyleType
@docs Alignment
@docs TextOverflow
@docs FlexDirection
@docs FlexWrap
@docs Align
@docs JustifyContent


# Displays

@docs none
@docs block
@docs inline
@docs inlineFlexContainer
@docs flexContainer
@docs flexItem
@docs flexChildContainer


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
@docs alignCenter
@docs right
@docs cnter
@docs left
@docs justify


## Overflow

@docs overflow
@docs textOverflowEllipsis

## Dimensions
@docs dimensions
@docs width
@docs height
@docs fullWidth


## FlexDirection

@docs direction
@docs column
@docs row


## FlexWrap

@docs wrap
@docs noWrap


## AlignItems / AlignSelf

@docs align
@docs baseline
@docs center
@docs flexStart
@docs flexEnd
@docs inherit
@docs initial
@docs stretch


## JustifyContent

@docs justifyContent
@docs spaceBetween
@docs spaceAround
@docs justifyContentCenter


## Flex

@docs grow
@docs shrink
@docs basisAuto
@docs basis
@docs alignSelf


# Compilation

@docs displayBoxToCouples
)

-}

import Either exposing (Either(..))
import Helpers.Css
import Box
import Helpers.Shared exposing (..)
import Elegant.Setters exposing (..)
import Display.Overflow as Overflow


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
    | FlexItem (Maybe FlexItemDetails) (Maybe BlockDetails)


{-| Represents the style from inside a display.
Can be flow, or flex (and containing flex details).
-}
type InsideDisplay
    = Flow
    | FlexContainer (Maybe FlexContainerDetails)


{-| -}
displayBox : OutsideDisplay -> InsideDisplay -> Modifiers Box.Box -> DisplayBox
displayBox outsideDisplay insideDisplay =
    ContentsWrapper
        << Contents outsideDisplay insideDisplay
        << modifiedElementOrNothing Box.default


{-| displayNone
The "display none" <display box> is useful to simply don't show
the element in the browser, it is on top of the hierarchy, because
applying any text or box style to a "display none" element doesn't
mean anything.

    Display.none

-}
none : DisplayBox
none =
    None


{-| The display Block
node behaving like a block element
children behaving like inside a flow element => considered block from children

    Display.block
        [ dimensions [ width (px 30) ] ]
        [ Box.padding (px 30) ]

-}
block : Modifiers BlockDetails -> OutsideDisplay
block blockDetailsModifiers =
    (Block (modifiedElementOrNothing defaultBlockDetails blockDetailsModifiers))



-- displayBox
--     (Block (modifiedElementOrNothing defaultBlockDetails blockDetailsModifiers))
--     Flow


{-| The display inline
node behaving like an inline element

    Display.inline
        [ Box.background [ Elegant.color Color.blue ] ]

-}
inline : Modifiers Box.Box -> DisplayBox
inline =
    displayBox
        Inline
        Flow


{-| The display inline-flex container :
node behaving like an inline element, contained nodes will behave like flex children

    Display.inlineFlexContainer [] []

-}
inlineFlexContainer : Modifiers FlexContainerDetails -> Modifiers Box.Box -> DisplayBox
inlineFlexContainer flexContainerDetailsModifiers =
    displayBox
        Inline
        (FlexContainer (modifiedElementOrNothing defaultFlexContainerDetails flexContainerDetailsModifiers))


{-| The display blockflex container :
node behaving like an block element, contained nodes will behave like flex children

    Display.blockFlexContainer [] [] []

-}
flexContainer : Modifiers FlexContainerDetails -> InsideDisplay
flexContainer flexContainerDetailsModifiers =
    FlexContainer (modifiedElementOrNothing defaultFlexContainerDetails flexContainerDetailsModifiers)


{-| The display flexitemdetails container :
node behaving like an flex child (not being a flex father himself)

    Display.flexChild [] []

-}
flexItem : Modifiers FlexItemDetails -> Modifiers BlockDetails -> OutsideDisplay
flexItem flexItemDetailsModifiers blockDetailsModifiers =
    FlexItem
        (modifiedElementOrNothing defaultFlexItemDetails flexItemDetailsModifiers)
        (modifiedElementOrNothing defaultBlockDetails blockDetailsModifiers)


{-| The display flexchildcontainer container :
node behaving like an flex child being a flex father himself.

    Display.flexChildContainer [] [] []

-}
flexChildContainer : Modifiers FlexContainerDetails -> Modifiers FlexItemDetails -> Modifiers BlockDetails -> Modifiers Box.Box -> DisplayBox
flexChildContainer flexContainerDetailsModifiers flexItemDetailsModifiers blockDetailsModifiers =
    displayBox
        (FlexItem
            (modifiedElementOrNothing defaultFlexItemDetails flexItemDetailsModifiers)
            (modifiedElementOrNothing defaultBlockDetails blockDetailsModifiers)
        )
        (FlexContainer (modifiedElementOrNothing defaultFlexContainerDetails flexContainerDetailsModifiers))


{-| Contains all styles which can be applied to a block.
It is automatically instanciated by `Display.block`.
-}
type alias BlockDetails =
    { listStyleType : Maybe ListStyleType
    , alignment : Maybe Alignment
    , overflow : Maybe Overflow.FullOverflow
    , textOverflow : Maybe TextOverflow
    , dimensions : Maybe Dimensions
    }


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


{-| Defines the alignment as center.
-}
alignCenter : Modifier BlockDetails
alignCenter =
    alignment AlignmentCenter


{-| Defines the alignment as right.
-}
right : Alignment
right =
    AlignmentRight


{-| Defines the alignment as center.
-}
cnter : Alignment
cnter =
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


type alias Dimensions =
    ( DimensionAxis, DimensionAxis )


defaultDimensions : ( DimensionAxis, DimensionAxis )
defaultDimensions =
    ( defaultDimensionAxis, defaultDimensionAxis )


type alias DimensionAxis =
    { min : Maybe SizeUnit
    , dimension : Maybe SizeUnit
    , max : Maybe SizeUnit
    }


defaultDimensionAxis : DimensionAxis
defaultDimensionAxis =
    DimensionAxis Nothing Nothing Nothing


{-| Accepts dimensions modifiers and modifies the block accordingly.
-}
dimensions : Modifiers Dimensions -> Modifier BlockDetails
dimensions =
    getModifyAndSet .dimensions setDimensionsIn defaultDimensions


{-| -}
width : SizeUnit -> Modifier Dimensions
width value ( x, y ) =
    ( x |> setDimension (Just value), y )


{-| -}
height : SizeUnit -> Modifier Dimensions
height value ( x, y ) =
    ( x, y |> setDimension (Just value) )


{-| put a fullWidth dimensions
-}
fullWidth : Modifier BlockDetails
fullWidth =
    dimensions [ width (Percent 100) ]


{-| Contains all style which can be applied on a flex container.
This contains flex-direction, flex-wrap, align-items and justify-content.
-}
type alias FlexContainerDetails =
    { direction : Maybe FlexDirection
    , wrap : Maybe FlexWrap
    , align : Maybe Align
    , justifyContent : Maybe JustifyContent
    }


defaultFlexContainerDetails : FlexContainerDetails
defaultFlexContainerDetails =
    FlexContainerDetails Nothing Nothing Nothing Nothing


{-| Represents a flex direction.
Can be column or row.
-}
type FlexDirection
    = FlexDirectionColumn
    | FlexDirectionRow


{-| Accepts a flex-direction and modifies the flex container accordingly.
-}
direction : FlexDirection -> Modifier FlexContainerDetails
direction =
    setDirection << Just


{-| Defines the flex direction column.
-}
column : FlexDirection
column =
    FlexDirectionColumn


{-| Defines the flex direction row.
-}
row : FlexDirection
row =
    FlexDirectionRow


{-| Represents a flex wrap.
Can be wrap or no-wrap.
-}
type FlexWrap
    = FlexWrapWrap
    | FlexWrapNoWrap


{-| Modifies the flex-wrap to wrap.
-}
wrap : Modifier FlexContainerDetails
wrap =
    setWrap <| Just FlexWrapWrap


{-| Modifies the flex-wrap to no-wrap.
-}
noWrap : Modifier FlexContainerDetails
noWrap =
    setWrap <| Just FlexWrapNoWrap


{-| Represents the alignment in flex.
Can be baseline, center, flex-start, flex-end, inherit, initial or stretch.
-}
type Align
    = AlignBaseline
    | AlignCenter
    | AlignFlexStart
    | AlignFlexEnd
    | AlignInherit
    | AlignInitial
    | AlignStretch


{-| Accepts an Align, and modifies the flex container accordingly.
-}
align : Align -> Modifier FlexContainerDetails
align =
    setAlign << Just


{-| Generates a baseline alignment.
-}
baseline : Align
baseline =
    AlignBaseline


{-| Generates a center alignment.
-}
center : Align
center =
    AlignCenter


{-| Generates a flex-start alignment.
-}
flexStart : Align
flexStart =
    AlignFlexStart


{-| Generates a flex-end alignment.
-}
flexEnd : Align
flexEnd =
    AlignFlexEnd


{-| Generates a inherit alignment.
-}
inherit : Align
inherit =
    AlignInherit


{-| Generates a initial alignment.
-}
initial : Align
initial =
    AlignInitial


{-| Generates a stretch alignment.
-}
stretch : Align
stretch =
    AlignStretch


{-| Represents the value of justify-content.
Can be space-between, space-around or center.
-}
type JustifyContent
    = JustifyContentSpaceBetween
    | JustifyContentSpaceAround
    | JustifyContentCenter


{-| Accepts a justify-content and modifies the flex container accordingly.
-}
justifyContent : JustifyContent -> Modifier FlexContainerDetails
justifyContent =
    setJustifyContent << Just


{-| Defines the justify-content space-between.
-}
spaceBetween : JustifyContent
spaceBetween =
    JustifyContentSpaceBetween


{-| Defines the justify-content space-around.
-}
spaceAround : JustifyContent
spaceAround =
    JustifyContentSpaceAround


{-| Defines the justify-content center.
-}
justifyContentCenter : JustifyContent
justifyContentCenter =
    JustifyContentCenter


{-| Contains all style which can be used on a flex item.
This contains flex-grow, flex-shrink, flex-basis and align-self.
-}
type alias FlexItemDetails =
    { grow : Maybe Int
    , shrink : Maybe Int
    , basis : Maybe (Either SizeUnit Auto)
    , alignSelf : Maybe Align
    }


defaultFlexItemDetails : FlexItemDetails
defaultFlexItemDetails =
    FlexItemDetails Nothing Nothing Nothing Nothing


{-| Accepts an int and sets the flex-grow accordingly.
-}
grow : Int -> Modifier FlexItemDetails
grow =
    setGrow << Just


{-| Accepts an int and sets the flex-shrink accordingly.
-}
shrink : Int -> Modifier FlexItemDetails
shrink =
    setShrink << Just


{-| Sets the flex-basis as auto.
-}
basisAuto : Modifier FlexItemDetails
basisAuto =
    setBasis <| Just <| Right Auto


{-| Accepts a size and sets the flex-basis accordingly.
-}
basis : SizeUnit -> Modifier FlexItemDetails
basis =
    setBasis << Just << Left


{-| Accepts an align and modifies the flex item accordingly.
-}
alignSelf : Align -> Modifier FlexItemDetails
alignSelf =
    setAlignSelf << Just


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



-- Internals


outsideInsideDisplayToCouples : OutsideDisplay -> InsideDisplay -> List ( String, String )
outsideInsideDisplayToCouples outsideDisplay =
    insideDisplayToCouples
        >> Helpers.Css.joiner (outsideDisplayToCouples outsideDisplay)
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
            ( "block", List.append (unwrapEmptyList flexItemDetailsToCouples flexItemDetails) (unwrapEmptyList blockDetailsToCouples blockDetails) )


insideDisplayToCouples : InsideDisplay -> ( String, List ( String, String ) )
insideDisplayToCouples insideDisplay =
    case insideDisplay of
        Flow ->
            ( "flow", [] )

        FlexContainer flexContainerDetails ->
            ( "flex", unwrapEmptyList flexContainerDetailsToCouples flexContainerDetails )


blockDetailsToCouples : BlockDetails -> List ( String, String )
blockDetailsToCouples blockDetails =
    [ unwrapToCouple .listStyleType listStyleTypeToCouple
    , unwrapToCouple .alignment textAlignToCouple
    , unwrapToCouples .overflow overflowToCouples
    , unwrapToCouple .textOverflow textOverflowToCouple
    , unwrapToCouples .dimensions dimensionsToCouples
    ]
        |> List.concatMap (callOn blockDetails)


flexItemDetailsToCouples : FlexItemDetails -> List ( String, String )
flexItemDetailsToCouples flexContainerDetails =
    [ unwrapToCouple .grow growToCouple
    , unwrapToCouple .shrink shrinkToCouple
    , unwrapToCouple .basis basisToCouple
    , unwrapToCouple .alignSelf alignSelfToCouple
    ]
        |> List.concatMap (callOn flexContainerDetails)


flexContainerDetailsToCouples : FlexContainerDetails -> List ( String, String )
flexContainerDetailsToCouples flexContainerDetails =
    [ unwrapToCouple .direction directionToCouple
    , unwrapToCouple .wrap flexWrapToCouple
    , unwrapToCouple .align alignItemsToCouple
    , unwrapToCouple .justifyContent justifyContentToCouple
    ]
        |> List.concatMap (callOn flexContainerDetails)


directionToCouple : FlexDirection -> ( String, String )
directionToCouple =
    (,) "flex-direction" << directionToString


directionToString : FlexDirection -> String
directionToString direction =
    case direction of
        FlexDirectionColumn ->
            "column"

        FlexDirectionRow ->
            "row"


growToCouple : Int -> ( String, String )
growToCouple =
    (,) "flex-grow" << toString


shrinkToCouple : Int -> ( String, String )
shrinkToCouple =
    (,) "flex-shrink" << toString


basisToCouple : Either SizeUnit Auto -> ( String, String )
basisToCouple =
    (,) "flex-basis" << basisToString


basisToString : Either SizeUnit Auto -> String
basisToString autoSizeUnitEither =
    case autoSizeUnitEither of
        Left su ->
            sizeUnitToString su

        Right _ ->
            "auto"


dimensionsToCouples : Dimensions -> List ( String, String )
dimensionsToCouples size =
    [ ( "width", Tuple.first >> .dimension )
    , ( "min-width", Tuple.first >> .min )
    , ( "max-width", Tuple.first >> .max )
    , ( "height", Tuple.second >> .dimension )
    , ( "max-height", Tuple.second >> .max )
    , ( "min-height", Tuple.second >> .min )
    ]
        |> List.map (Tuple.mapSecond (callOn size))
        |> keepJustValues
        |> List.map (Tuple.mapSecond sizeUnitToString)


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

        str ->
            str


alignItemsToCouple : Align -> ( String, String )
alignItemsToCouple =
    (,) "align-items" << alignToString


alignSelfToCouple : Align -> ( String, String )
alignSelfToCouple =
    (,) "align-self" << alignToString


alignToString : Align -> String
alignToString align =
    case align of
        AlignBaseline ->
            "baseline"

        AlignCenter ->
            "center"

        AlignFlexStart ->
            "flex-start"

        AlignFlexEnd ->
            "flex-end"

        AlignInherit ->
            "flex-end"

        AlignInitial ->
            "initial"

        AlignStretch ->
            "stretch"


listStyleTypeToCouple : ListStyleType -> ( String, String )
listStyleTypeToCouple =
    (,) "list-style" << listStyleTypeToString


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


justifyContentToCouple : JustifyContent -> ( String, String )
justifyContentToCouple =
    (,) "justify-content" << justifyContentToString


justifyContentToString : JustifyContent -> String
justifyContentToString val =
    case val of
        JustifyContentSpaceBetween ->
            "space-between"

        JustifyContentSpaceAround ->
            "space-around"

        JustifyContentCenter ->
            "center"


textAlignToCouple : Alignment -> ( String, String )
textAlignToCouple =
    (,) "text-align" << textAlignToString


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
    (,) "text-overflow" << textOverflowToString


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


flexWrapToCouple : FlexWrap -> ( String, String )
flexWrapToCouple =
    (,) "flex-wrap" << flexWrapToString


flexWrapToString : FlexWrap -> String
flexWrapToString val =
    case val of
        FlexWrapWrap ->
            "wrap"

        FlexWrapNoWrap ->
            "nowrap"


flexDirectionToCouple : FlexDirection -> ( String, String )
flexDirectionToCouple =
    (,) "flex-direction" << flexDirectionToString


flexDirectionToString : FlexDirection -> String
flexDirectionToString val =
    case val of
        FlexDirectionColumn ->
            "column"

        FlexDirectionRow ->
            "row"
