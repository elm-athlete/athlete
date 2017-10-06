module Layout exposing (..)

import Color exposing (Color)
import Color.Convert
import Maybe.Extra as Maybe
import Helpers.Shared exposing (..)
import Helpers.Setters exposing (..)
import Helpers.Vector exposing (Vector)
import Elegant.Helpers as Helpers
import Typography
import Padding
import Border
import Corner
import Margin
import Outline
import BoxShadow
import Cursor
import Surrounded exposing (Surrounded)


type alias Radiant =
    Float


type alias Degree =
    Float


type Visibility
    = VisibilityHidden
    | VisibilityVisible


hidden : Visibility
hidden =
    VisibilityHidden


visible : Visibility
visible =
    VisibilityVisible


type alias Background =
    { color : Maybe Color
    , images : List BackgroundImage
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


type alias Layout =
    { position : Maybe Position
    , visibility : Maybe Visibility
    , typography : Maybe Typography.Typography
    , padding : Maybe (Surrounded Padding.Padding)
    , border : Maybe (Surrounded Border.Border)
    , corner : Maybe Corner.Corner
    , margin : Maybe (Surrounded Margin.Margin)
    , outline : Maybe Outline.Outline
    , boxShadow : Maybe BoxShadow.BoxShadow
    , background : Maybe Background
    , opacity : Maybe Float
    , cursor : Maybe Cursor.Cursor
    , zIndex : Maybe Int
    }


defaultLayout : Layout
defaultLayout =
    Layout
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing
        Nothing


border : Modifiers (Surrounded Border.Border) -> Modifier Layout
border =
    getModifyAndSet .border setBorderIn Surrounded.default


boxShadow : Modifiers BoxShadow.BoxShadow -> Modifier Layout
boxShadow =
    getModifyAndSet .boxShadow setBoxShadowIn BoxShadow.default


corner : Modifiers Corner.Corner -> Modifier Layout
corner =
    getModifyAndSet .corner setCornerIn Corner.default


cursor : Cursor.Cursor -> Modifier Layout
cursor =
    setMaybeValue setCursor


margin : Modifiers (Surrounded Margin.Margin) -> Modifier Layout
margin =
    getModifyAndSet .margin setMarginIn Surrounded.default


opacity : Float -> Modifier Layout
opacity =
    setMaybeValue setOpacity


outline : Modifiers Outline.Outline -> Modifier Layout
outline =
    getModifyAndSet .outline setOutlineIn Outline.default


padding : Modifiers (Surrounded Padding.Padding) -> Modifier Layout
padding =
    getModifyAndSet .padding setPaddingIn Surrounded.default


typography : Modifiers Typography.Typography -> Modifier Layout
typography =
    getModifyAndSet .typography setTypographyIn Typography.default


visibility : Visibility -> Modifier Layout
visibility =
    setMaybeValue setVisibility


zIndex : Int -> Modifier Layout
zIndex =
    setMaybeValue setZIndex


layoutToCouples : Layout -> List ( String, String )
layoutToCouples layout =
    [ unwrapToCouple .visibility visibilityToCouple
    , unwrapToCouple .opacity opacityToCouple
    , unwrapToCouple .zIndex zIndexToCouple
    , unwrapToCouple .cursor Cursor.cursorToCouple
    , unwrapToCouples .typography Typography.typographyToCouples
    , unwrapToCouple .boxShadow BoxShadow.boxShadowToCouple
    , unwrapToCouples .border Border.borderToCouples
    , unwrapToCouples .outline Outline.outlineToCouples
    , unwrapToCouples .corner Corner.cornerToCouples
    , unwrapToCouples .margin Margin.marginToCouples
    , unwrapToCouples .padding Padding.paddingToCouples
    ]
        |> List.concatMap (callOn layout)


opacityToCouple : Float -> ( String, String )
opacityToCouple opacity =
    ( "opacity", toString opacity )


visibilityToCouple : Visibility -> ( String, String )
visibilityToCouple visibility =
    ( "visibility", visibilityToString visibility )


visibilityToString : Visibility -> String
visibilityToString val =
    case val of
        VisibilityHidden ->
            "hidden"

        VisibilityVisible ->
            "visible"


zIndexToCouple : Int -> ( String, String )
zIndexToCouple zIndex =
    ( "z-index", toString zIndex )


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


angleToString : Angle -> String
angleToString angle =
    case angle of
        Rad a ->
            (a |> toString) ++ "rad"

        Deg a ->
            (a |> toString) ++ "deg"


colorToString : Color -> String
colorToString =
    Color.Convert.colorToCssRgba


maybeColorToString : Maybe Color -> Maybe String
maybeColorToString =
    nothingOrJust colorToString


colorStopToString : ColorStop -> String
colorStopToString colorStop =
    case colorStop of
        { color, offset } ->
            [ Just (colorToString color), maybeSizeUnitToString offset ] |> Maybe.values |> String.join " "


maybeSizeUnitToString : Maybe SizeUnit -> Maybe String
maybeSizeUnitToString =
    nothingOrJust sizeUnitToString


colorStopsToString : List ColorStop -> String
colorStopsToString colorStops =
    colorStops |> List.map colorStopToString |> String.join ", "


applyCssFunction : String -> String -> String
applyCssFunction funName content =
    funName ++ (Helpers.surroundWithParentheses content)


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
