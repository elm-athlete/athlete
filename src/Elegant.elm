module Elegant
    exposing
        ( State
        , emptyState
        , Msg
        , update
        , Vector
        , Style
        , SizeUnit(..)
        , small
        , tiny
        , medium
        , simpleStyle
        , hoverStyle
        , responsiveStyle
        , responsiveHoverStyle
        , position
        , left
        , right
        , top
        , bottom
        , absolutelyPositionned
        , verticalAlignMiddle
        , alignItemsBaseline
        , alignItemsCenter
        , alignItemsFlexStart
        , alignItemsFlexEnd
        , alignItemsInherit
        , alignItemsInitial
        , alignItemsStretch
        , padding
        , paddingHorizontal
        , paddingVertical
        , paddingLeft
        , paddingRight
        , paddingTop
        , paddingBottom
        , margin
        , marginHorizontal
        , marginVertical
        , marginTop
        , marginBottom
        , marginLeft
        , marginRight
        , textColor
        , uppercase
        , lowercase
        , capitalize
        , textDecorationNone
        , underline
        , lineThrough
        , bold
        , strong
        , fontWeightNormal
        , fontStyleNormal
        , fontStyleItalic
        , textAlignCenter
        , textAlignRight
        , textAlignLeft
        , textAlignJustify
        , backgroundColor
        , borderColor
        , borderStyle
        , borderWidth
        , borderAndTextColor
        , displayInlineBlock
        , displayBlock
        , displayFlex
        , displayInline
        , displayNone
        , listStyleNone
        , listStyleDisc
        , listStyleCircle
        , listStyleSquare
        , listStyleDecimal
        , listStyleGeorgian
        , roundCorner
        , justifyContentSpaceBetween
        , justifyContentSpaceAround
        , fontInherit
        , width
        , widthPercent
        , height
        , heightPercent
        , transparent
        )

{-| Bla

# Types
@docs State
@docs Msg
@docs State
@docs Vector
@docs Style
@docs SizeUnit

# Initializers
@docs emptyState
@docs update

# Styling
@docs simpleStyle
@docs hoverStyle
@docs responsiveStyle
@docs responsiveHoverStyle

# Utilities
@docs small
@docs tiny
@docs medium

# Styles
@docs position
@docs left
@docs right
@docs top
@docs bottom
@docs absolutelyPositionned
@docs verticalAlignMiddle
@docs alignItemsBaseline
@docs alignItemsCenter
@docs alignItemsFlexStart
@docs alignItemsFlexEnd
@docs alignItemsInherit
@docs alignItemsInitial
@docs alignItemsStretch
@docs padding
@docs paddingHorizontal
@docs paddingVertical
@docs paddingLeft
@docs paddingRight
@docs paddingTop
@docs paddingBottom
@docs margin
@docs marginHorizontal
@docs marginVertical
@docs marginTop
@docs marginBottom
@docs marginLeft
@docs marginRight
@docs textColor
@docs uppercase
@docs lowercase
@docs capitalize
@docs textDecorationNone
@docs underline
@docs lineThrough
@docs bold
@docs strong
@docs fontWeightNormal
@docs fontStyleNormal
@docs fontStyleItalic
@docs textAlignCenter
@docs textAlignLeft
@docs textAlignRight
@docs textAlignJustify
@docs backgroundColor
@docs borderColor
@docs borderStyle
@docs borderWidth
@docs borderAndTextColor
@docs displayBlock
@docs displayInlineBlock
@docs displayFlex
@docs displayInline
@docs displayNone
@docs listStyleNone
@docs listStyleDisc
@docs listStyleCircle
@docs listStyleSquare
@docs listStyleDecimal
@docs listStyleGeorgian
@docs roundCorner
@docs justifyContentSpaceBetween
@docs justifyContentSpaceAround
@docs fontInherit
@docs width
@docs widthPercent
@docs height
@docs heightPercent

# Constants
@docs transparent
-}

import Html exposing (Html)
import Html.Attributes
import Html.Events
import Basics
import Color exposing (Color)
import Color.Convert
import Window


{-| -}
type State
    = State
        { selectedElement : Maybe String
        , windowDimension : Window.Size
        }


{-| -}
emptyState : State
emptyState =
    State
        { selectedElement = Nothing
        , windowDimension =
            { width = 0
            , height = 0
            }
        }


{-| -}
type Msg
    = OnMouseEnter String
    | OnMouseLeave String
    | OnResizes Window.Size


{-| -}
update : Msg -> State -> State
update msg (State state) =
    case msg of
        OnMouseEnter s ->
            State { state | selectedElement = Just s }

        OnMouseLeave s ->
            State { state | selectedElement = Nothing }

        OnResizes size ->
            State { state | windowDimension = size }


{-| -}
type alias Vector =
    ( Float, Float )


{-| -}
type SizeUnit
    = Px Int
    | Pt Int
    | Percent Float
    | Em Float


type Position
    = PositionAbsolute
    | PositionRelative
    | PositionFixed


type Display
    = DisplayInlineBlock
    | DisplayBlock
    | DisplayFlex
    | DisplayInline
    | DisplayNone


type ListStyleType
    = ListStyleTypeNone
    | ListStyleTypeDisc
    | ListStyleTypeCircle
    | ListStyleTypeSquare
    | ListStyleTypeDecimal
    | ListStyleTypeGeorgian


type AlignItems
    = AlignItemsBaseline
    | AlignItemsCenter
    | AlignItemsFlexStart
    | AlignItemsFlexEnd
    | AlignItemsInherit
    | AlignItemsInitial
    | AlignItemsStretch


type JustifyContent
    = JustifyContentSpaceBetween
    | JustifyContentSpaceAround


type TextTransform
    = TextTransformUppercase
    | TextTransformLowercase
    | TextTransformCapitalize


type TextAlign
    = TextAlignCenter
    | TextAlignRight
    | TextAlignLeft
    | TextAlignJustify


type TextDecoration
    = TextDecorationNone
    | TextDecorationUnderline
    | TextDecorationLineThrough


type FontStyle
    = FontStyleNormal
    | FontStyleItalic


{-| Contains all style for an element used with Elegant.
-}
type Style
    = Style
        { position : Maybe Position
        , left : Maybe SizeUnit
        , top : Maybe SizeUnit
        , bottom : Maybe SizeUnit
        , right : Maybe SizeUnit
        , textColor : Maybe Color
        , backgroundColor : Maybe Color
        , borderColor : Maybe Color
        , borderWidth : Maybe SizeUnit
        , borderStyle : Maybe String
        , borderRadius : Maybe SizeUnit
        , paddingRight : Maybe SizeUnit
        , paddingLeft : Maybe SizeUnit
        , paddingBottom : Maybe SizeUnit
        , paddingTop : Maybe SizeUnit
        , marginRight : Maybe SizeUnit
        , marginLeft : Maybe SizeUnit
        , marginBottom : Maybe SizeUnit
        , marginTop : Maybe SizeUnit
        , display : Maybe Display
        , listStyleType : Maybe ListStyleType
        , verticalAlign : Maybe String
        , textAlign : Maybe TextAlign
        , textTransform : Maybe TextTransform
        , textDecoration : Maybe TextDecoration
        , fontWeight : Maybe Int
        , fontStyle : Maybe FontStyle
        , font : Maybe String
        , alignItems : Maybe AlignItems
        , justifyContent : Maybe JustifyContent
        , width : Maybe SizeUnit
        , height : Maybe SizeUnit
        }


type alias StyleTransformer =
    Style -> Style


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


defaultStyle : Style
defaultStyle =
    Style
        { position = Nothing
        , left = Nothing
        , top = Nothing
        , bottom = Nothing
        , right = Nothing
        , textColor = Nothing
        , backgroundColor = Nothing
        , borderColor = Nothing
        , borderWidth = Nothing
        , borderStyle = Nothing
        , borderRadius = Nothing
        , paddingRight = Nothing
        , paddingLeft = Nothing
        , paddingBottom = Nothing
        , paddingTop = Nothing
        , marginRight = Nothing
        , marginLeft = Nothing
        , marginBottom = Nothing
        , marginTop = Nothing
        , display = Nothing
        , listStyleType = Nothing
        , verticalAlign = Nothing
        , textAlign = Nothing
        , textTransform = Nothing
        , textDecoration = Nothing
        , fontWeight = Nothing
        , fontStyle = Nothing
        , font = Nothing
        , alignItems = Nothing
        , justifyContent = Nothing
        , width = Nothing
        , height = Nothing
        }


nothingOrJust : (a -> b) -> Maybe a -> Maybe b
nothingOrJust fun =
    Maybe.andThen (Just << fun)


positionToString : Maybe Position -> Maybe String
positionToString =
    nothingOrJust
        (\val ->
            case val of
                PositionAbsolute ->
                    "absolute"

                PositionRelative ->
                    "relative"

                PositionFixed ->
                    "fixed"
        )


displayToString : Maybe Display -> Maybe String
displayToString =
    nothingOrJust
        (\val ->
            case val of
                DisplayBlock ->
                    "block"

                DisplayInlineBlock ->
                    "inline-block"

                DisplayFlex ->
                    "flex"

                DisplayInline ->
                    "inline"

                DisplayNone ->
                    "none"
        )


colorToString : Maybe Color -> Maybe String
colorToString =
    nothingOrJust Color.Convert.colorToCssRgba


alignItemsToString : Maybe AlignItems -> Maybe String
alignItemsToString =
    nothingOrJust
        (\val ->
            case val of
                AlignItemsBaseline ->
                    "baseline"

                AlignItemsCenter ->
                    "center"

                AlignItemsFlexStart ->
                    "flex-start"

                AlignItemsFlexEnd ->
                    "flex-end"

                AlignItemsInherit ->
                    "inherit"

                AlignItemsInitial ->
                    "initial"

                AlignItemsStretch ->
                    "stretch"
        )


concatNumberWithString : number -> String -> String
concatNumberWithString number str =
    (number |> toString) ++ str


sizeUnitToString : Maybe SizeUnit -> Maybe String
sizeUnitToString =
    nothingOrJust
        (\val ->
            case val of
                Px x ->
                    concatNumberWithString x "px"

                Pt x ->
                    concatNumberWithString x "pt"

                Percent x ->
                    concatNumberWithString x "%"

                Em x ->
                    concatNumberWithString x "em"
        )


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
        )


textTransformToString : Maybe TextTransform -> Maybe String
textTransformToString =
    nothingOrJust
        (\val ->
            case val of
                TextTransformLowercase ->
                    "lowercase"

                TextTransformUppercase ->
                    "uppercase"

                TextTransformCapitalize ->
                    "capitalize"
        )


textDecorationToString : Maybe TextDecoration -> Maybe String
textDecorationToString =
    nothingOrJust
        (\val ->
            case val of
                TextDecorationNone ->
                    "none"

                TextDecorationUnderline ->
                    "underline"

                TextDecorationLineThrough ->
                    "line-through"
        )


fontStyleToString : Maybe FontStyle -> Maybe String
fontStyleToString =
    nothingOrJust
        (\val ->
            case val of
                FontStyleNormal ->
                    "normal"

                FontStyleItalic ->
                    "italic"
        )


textAlignToString : Maybe TextAlign -> Maybe String
textAlignToString =
    nothingOrJust
        (\val ->
            case val of
                TextAlignCenter ->
                    "center"

                TextAlignLeft ->
                    "right"

                TextAlignRight ->
                    "left"

                TextAlignJustify ->
                    "justify"
        )


maybeToString : Maybe a -> Maybe String
maybeToString =
    nothingOrJust
        (\val ->
            toString val
        )


getStyles : Style -> List ( String, Maybe String )
getStyles (Style styleValues) =
    [ ( "position", positionToString << .position )
    , ( "left", sizeUnitToString << .left )
    , ( "top", sizeUnitToString << .top )
    , ( "bottom", sizeUnitToString << .bottom )
    , ( "right", sizeUnitToString << .right )
    , ( "color", colorToString << .textColor )
    , ( "display", displayToString << .display )
    , ( "text-align", textAlignToString << .textAlign )
    , ( "text-transform", textTransformToString << .textTransform )
    , ( "text-decoration", textDecorationToString << .textDecoration )
    , ( "background-color", colorToString << .backgroundColor )
    , ( "border-radius", sizeUnitToString << .borderRadius )
    , ( "border-color", colorToString << .borderColor )
    , ( "border-width", sizeUnitToString << .borderWidth )
    , ( "border-style", .borderStyle )
    , ( "padding-left", sizeUnitToString << .paddingLeft )
    , ( "padding-right", sizeUnitToString << .paddingRight )
    , ( "padding-top", sizeUnitToString << .paddingTop )
    , ( "padding-bottom", sizeUnitToString << .paddingBottom )
    , ( "margin-left", sizeUnitToString << .marginLeft )
    , ( "margin-right", sizeUnitToString << .marginRight )
    , ( "margin-top", sizeUnitToString << .marginTop )
    , ( "margin-bottom", sizeUnitToString << .marginBottom )
    , ( "list-style-type", listStyleTypeToString << .listStyleType )
    , ( "align-items", alignItemsToString << .alignItems )
    , ( "justify-content", justifyContentToString << .justifyContent )
    , ( "font-weight", maybeToString << .fontWeight )
    , ( "font-style", fontStyleToString << .fontStyle )
    , ( "width", sizeUnitToString << .width )
    , ( "height", sizeUnitToString << .height )
    ]
        |> List.map
            (\( attrName, fun ) ->
                ( attrName, fun styleValues )
            )


compose : List (a -> a) -> (a -> a)
compose =
    List.foldr (>>) identity


toHtmlStyles : List ( String, Maybe String ) -> List ( String, String )
toHtmlStyles =
    List.concatMap <|
        \( attr, maybe_ ) ->
            case maybe_ of
                Nothing ->
                    []

                Just val ->
                    [ ( attr, val ) ]


toInlineStyles : StyleTransformer -> List ( String, String )
toInlineStyles styleTransformer =
    defaultStyle
        |> styleTransformer
        |> getStyles
        |> toHtmlStyles


convertStyles : List StyleTransformer -> List ( String, String )
convertStyles =
    toInlineStyles << compose


{-| -}
simpleStyle :
    List StyleTransformer
    -> List (Html.Attribute msg)
simpleStyle =
    List.singleton
        << Html.Attributes.style
        << convertStyles


{-| -}
hoverStyle :
    ( State, String, Msg -> msg )
    -> (Bool -> List StyleTransformer)
    -> List (Html.Attribute msg)
hoverStyle ( state, id, msg ) styles =
    selectedElement state id
        |> styles
        |> simpleStyle
        |> List.append
            [ Html.Events.onMouseEnter <| msg <| OnMouseEnter id
            , Html.Events.onMouseLeave <| msg <| OnMouseLeave id
            ]


{-| -}
responsiveStyle :
    State
    -> (Window.Size -> List StyleTransformer)
    -> List (Html.Attribute msg)
responsiveStyle (State state) styles =
    state.windowDimension
        |> styles
        |> simpleStyle


{-| -}
responsiveHoverStyle :
    ( State, String, Msg -> msg )
    -> (Window.Size -> Bool -> List StyleTransformer)
    -> List (Html.Attribute msg)
responsiveHoverStyle ( State state, id, msg ) styles =
    selectedElement (State state) id
        |> styles state.windowDimension
        |> simpleStyle
        |> List.append
            [ Html.Events.onMouseEnter <| msg <| OnMouseEnter id
            , Html.Events.onMouseLeave <| msg <| OnMouseLeave id
            ]


selectedElement : State -> String -> Bool
selectedElement (State state) id =
    state.selectedElement == Just id


{-| -}
position : Position -> Style -> Style
position value (Style style) =
    Style { style | position = Just value }


{-| -}
left : SizeUnit -> Style -> Style
left value (Style style) =
    Style { style | left = Just value }


{-| -}
right : SizeUnit -> Style -> Style
right value (Style style) =
    Style { style | right = Just value }


{-| -}
top : SizeUnit -> Style -> Style
top value (Style style) =
    Style { style | top = Just value }


{-| -}
bottom : SizeUnit -> Style -> Style
bottom value (Style style) =
    Style { style | bottom = Just value }


{-| -}
absolutelyPositionned : Vector -> Style -> Style
absolutelyPositionned ( x, y ) =
    [ position PositionAbsolute
    , left <| Px <| Basics.round <| x
    , right <| Px <| Basics.round <| x
    ]
        |> compose


{-| -}
verticalAlignMiddle : Style -> Style
verticalAlignMiddle (Style style) =
    Style { style | verticalAlign = Just "middle" }


alignItems : AlignItems -> Style -> Style
alignItems value (Style style) =
    Style { style | alignItems = Just value }


{-| -}
alignItemsBaseline : Style -> Style
alignItemsBaseline =
    alignItems AlignItemsBaseline


{-| -}
alignItemsCenter : Style -> Style
alignItemsCenter =
    alignItems AlignItemsCenter


{-| -}
alignItemsFlexStart : Style -> Style
alignItemsFlexStart =
    alignItems AlignItemsFlexStart


{-| -}
alignItemsFlexEnd : Style -> Style
alignItemsFlexEnd =
    alignItems AlignItemsFlexEnd


{-| -}
alignItemsInherit : Style -> Style
alignItemsInherit =
    alignItems AlignItemsInherit


{-| -}
alignItemsInitial : Style -> Style
alignItemsInitial =
    alignItems AlignItemsInitial


{-| -}
alignItemsStretch : Style -> Style
alignItemsStretch =
    alignItems AlignItemsStretch


{-| -}
padding : SizeUnit -> Style -> Style
padding size =
    paddingHorizontal size << paddingVertical size


{-| -}
paddingHorizontal : SizeUnit -> Style -> Style
paddingHorizontal size =
    paddingLeft size << paddingRight size


{-| -}
paddingVertical : SizeUnit -> Style -> Style
paddingVertical size =
    paddingBottom size << paddingTop size


{-| -}
paddingLeft : SizeUnit -> Style -> Style
paddingLeft size (Style style) =
    Style { style | paddingLeft = Just size }


{-| -}
paddingTop : SizeUnit -> Style -> Style
paddingTop size (Style style) =
    Style { style | paddingTop = Just size }


{-| -}
paddingRight : SizeUnit -> Style -> Style
paddingRight size (Style style) =
    Style { style | paddingRight = Just size }


{-| -}
paddingBottom : SizeUnit -> Style -> Style
paddingBottom size (Style style) =
    Style { style | paddingBottom = Just size }


{-| -}
margin : SizeUnit -> Style -> Style
margin size =
    marginHorizontal size << marginVertical size


{-| -}
marginHorizontal : SizeUnit -> Style -> Style
marginHorizontal size =
    marginLeft size << marginRight size


{-| -}
marginVertical : SizeUnit -> Style -> Style
marginVertical size =
    marginBottom size << marginTop size


{-| -}
marginLeft : SizeUnit -> Style -> Style
marginLeft size (Style style) =
    Style { style | marginLeft = Just size }


{-| -}
marginTop : SizeUnit -> Style -> Style
marginTop size (Style style) =
    Style { style | marginTop = Just size }


{-| -}
marginRight : SizeUnit -> Style -> Style
marginRight size (Style style) =
    Style { style | marginRight = Just size }


{-| -}
marginBottom : SizeUnit -> Style -> Style
marginBottom size (Style style) =
    Style { style | marginBottom = Just size }


textTransform : TextTransform -> Style -> Style
textTransform val (Style style) =
    Style { style | textTransform = Just val }


{-| -}
uppercase : Style -> Style
uppercase =
    textTransform TextTransformUppercase


{-| -}
lowercase : Style -> Style
lowercase =
    textTransform TextTransformLowercase


{-| -}
capitalize : Style -> Style
capitalize =
    textTransform TextTransformCapitalize


{-| -}
textColor : Color -> Style -> Style
textColor value (Style style) =
    Style { style | textColor = Just value }


textDecoration : TextDecoration -> Style -> Style
textDecoration val (Style style) =
    Style { style | textDecoration = Just val }


{-| -}
textDecorationNone : Style -> Style
textDecorationNone =
    textDecoration TextDecorationNone


{-| -}
underline : Style -> Style
underline =
    textDecoration TextDecorationUnderline


{-| -}
lineThrough : Style -> Style
lineThrough =
    textDecoration TextDecorationLineThrough


{-| -}
bold : Style -> Style
bold =
    fontWeight 700


{-| -}
strong : Style -> Style
strong =
    bold


{-| -}
fontWeightNormal : Style -> Style
fontWeightNormal =
    fontWeight 400


{-| -}
fontWeight : Int -> Style -> Style
fontWeight val (Style style) =
    Style { style | fontWeight = Just val }


fontStyle : FontStyle -> Style -> Style
fontStyle val (Style style) =
    Style { style | fontStyle = Just val }


{-| -}
fontStyleNormal : Style -> Style
fontStyleNormal =
    fontStyle FontStyleNormal


{-| -}
fontStyleItalic : Style -> Style
fontStyleItalic =
    fontStyle FontStyleItalic


textAlign : TextAlign -> Style -> Style
textAlign val (Style style) =
    Style { style | textAlign = Just val }


{-| -}
textAlignCenter : Style -> Style
textAlignCenter =
    textAlign TextAlignCenter


{-| -}
textAlignRight : Style -> Style
textAlignRight =
    textAlign TextAlignRight


{-| -}
textAlignLeft : Style -> Style
textAlignLeft =
    textAlign TextAlignLeft


{-| -}
textAlignJustify : Style -> Style
textAlignJustify =
    textAlign TextAlignJustify


{-| -}
backgroundColor : Color -> Style -> Style
backgroundColor color (Style style) =
    Style { style | backgroundColor = Just color }


{-| -}
borderColor : Color -> Style -> Style
borderColor color (Style style) =
    Style { style | borderColor = Just color }


{-| -}
borderStyle : String -> Style -> Style
borderStyle style_ (Style style) =
    Style { style | borderStyle = Just style_ }


{-| -}
borderWidth : Int -> Style -> Style
borderWidth size_ (Style style) =
    Style { style | borderWidth = Just (Px size_) }


{-| Set both text and border in same color.
-}
borderAndTextColor : Color -> Style -> Style
borderAndTextColor val =
    borderColor val << textColor val


display : Display -> Style -> Style
display val (Style style) =
    Style { style | display = Just val }


{-| -}
displayInlineBlock : Style -> Style
displayInlineBlock =
    display DisplayInlineBlock


{-| -}
displayBlock : Style -> Style
displayBlock =
    display DisplayBlock


{-| -}
displayFlex : Style -> Style
displayFlex =
    display DisplayFlex


{-| -}
displayInline : Style -> Style
displayInline =
    display DisplayInline


{-| -}
displayNone : Style -> Style
displayNone =
    display DisplayNone


listStyleType : ListStyleType -> Style -> Style
listStyleType value (Style style) =
    Style { style | listStyleType = Just value }


{-| -}
listStyleNone : Style -> Style
listStyleNone =
    listStyleType ListStyleTypeNone


{-| -}
listStyleDisc : Style -> Style
listStyleDisc =
    listStyleType ListStyleTypeDisc


{-| -}
listStyleCircle : Style -> Style
listStyleCircle =
    listStyleType ListStyleTypeCircle


{-| -}
listStyleSquare : Style -> Style
listStyleSquare =
    listStyleType ListStyleTypeSquare


{-| -}
listStyleDecimal : Style -> Style
listStyleDecimal =
    listStyleType ListStyleTypeDecimal


{-| -}
listStyleGeorgian : Style -> Style
listStyleGeorgian =
    listStyleType ListStyleTypeGeorgian


{-| -}
roundCorner : Style -> Style
roundCorner (Style style) =
    Style { style | borderRadius = Just (Px 300) }


justifyContent : JustifyContent -> Style -> Style
justifyContent value (Style style) =
    Style { style | justifyContent = Just value }


{-| -}
justifyContentSpaceBetween : Style -> Style
justifyContentSpaceBetween =
    justifyContent JustifyContentSpaceBetween


{-| -}
justifyContentSpaceAround : Style -> Style
justifyContentSpaceAround =
    justifyContent JustifyContentSpaceAround


{-| -}
fontInherit : Style -> Style
fontInherit (Style style) =
    Style { style | font = Just "inherit" }


{-| -}
width : SizeUnit -> Style -> Style
width value (Style style) =
    Style { style | width = Just value }


{-| -}
widthPercent : Float -> Style -> Style
widthPercent =
    width << Percent


{-| -}
height : SizeUnit -> Style -> Style
height value (Style style) =
    Style { style | height = Just value }


{-| -}
heightPercent : Int -> Style -> Style
heightPercent =
    height << Px


{-| -}
transparent : Color
transparent =
    Color.rgba 0 0 0 0.0
