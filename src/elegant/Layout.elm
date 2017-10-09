module Layout exposing (..)

import Helpers.Shared exposing (..)
import Helpers.Setters exposing (..)
import Typography
import Padding
import Border
import Corner
import Margin
import Outline
import BoxShadow
import Cursor
import Surrounded exposing (Surrounded)
import Background
import Position


type alias Layout =
    { position : Maybe Position.Position
    , visibility : Maybe Visibility
    , typography : Maybe Typography.Typography
    , padding : Maybe (Surrounded Padding.Padding)
    , border : Maybe (Surrounded Border.Border)
    , corner : Maybe Corner.Corner
    , margin : Maybe (Surrounded Margin.Margin)
    , outline : Maybe Outline.Outline
    , boxShadow : Maybe BoxShadow.BoxShadow
    , background : Maybe Background.Background
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


position : Position.Position -> Modifier Layout
position =
    setMaybeValue setPosition


background : Modifiers Background.Background -> Modifier Layout
background =
    getModifyAndSet .background setBackgroundIn Background.default


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
    , unwrapToCouple .boxShadow BoxShadow.boxShadowToCouple
    , unwrapToCouples .background Background.backgroundToCouples
    , unwrapToCouples .typography Typography.typographyToCouples
    , unwrapToCouples .border Border.borderToCouples
    , unwrapToCouples .outline Outline.outlineToCouples
    , unwrapToCouples .corner Corner.cornerToCouples
    , unwrapToCouples .margin Margin.marginToCouples
    , unwrapToCouples .padding Padding.paddingToCouples
    , unwrapToCouples .position Position.positionToCouples
    ]
        |> List.concatMap (callOn layout)


type Visibility
    = VisibilityHidden
    | VisibilityVisible


hidden : Visibility
hidden =
    VisibilityHidden


visible : Visibility
visible =
    VisibilityVisible



-- Internals


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
