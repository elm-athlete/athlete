module Layout
    exposing
        ( Layout
        , default
        , Visibility
        , hidden
        , visible
        , background
        , border
        , boxShadow
        , corner
        , cursor
        , margin
        , opacity
        , outline
        , padding
        , position
        , typography
        , visibility
        , zIndex
        , layoutToCouples
        )

{-| Handles all modifications for the layout. You don't need to instanciate one,
as it's automatically done by Elegant and the different display elements.
It contains only modifiers, and they can be found in the respective modules.


# Types

@docs Layout
@docs Visibility


# Modifiers

@docs background
@docs border
@docs boxShadow
@docs corner
@docs cursor
@docs margin
@docs opacity
@docs outline
@docs padding
@docs position
@docs typography
@docs visibility
@docs zIndex


# Values

@docs default
@docs visible
@docs hidden


# Compilation

@docs layoutToCouples

-}

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


{-| Represents a layout, handling the properties of blocks. They are automatically
instanciated to avoid to deal with it directly. The focus is on the modifiers, available
in respective modules.

    Elegant.displayBlock []
        [ Layout.cursor Cursor.default
        -- You can use any Layout functions here to add custom style...
        ]

-}
type alias Layout =
    { background : Maybe Background.Background
    , border : Maybe (Surrounded Border.Border)
    , boxShadow : Maybe BoxShadow.BoxShadow
    , corner : Maybe Corner.Corner
    , cursor : Maybe Cursor.Cursor
    , margin : Maybe (Surrounded Margin.Margin)
    , opacity : Maybe Float
    , outline : Maybe Outline.Outline
    , padding : Maybe (Surrounded Padding.Padding)
    , position : Maybe Position.Position
    , typography : Maybe Typography.Typography
    , visibility : Maybe Visibility
    , zIndex : Maybe Int
    }


{-| Generates a default empty Layout.
-}
default : Layout
default =
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


{-| Accepts a `Position` and modifies the Layout accordingly.
-}
position : Position.Position -> Modifier Layout
position =
    setMaybeValue setPosition


{-| Accepts a list of modifiers for the `Background` and modifies the Layout accordingly.
-}
background : Modifiers Background.Background -> Modifier Layout
background =
    getModifyAndSet .background setBackgroundIn Background.default


{-| Accepts a list of modifiers for the `Border` and modifies the Layout accordingly.
-}
border : Modifiers (Surrounded Border.Border) -> Modifier Layout
border =
    getModifyAndSet .border setBorderIn Surrounded.default


{-| Accepts a list of modifiers for the `BoxShadow` and modifies the Layout accordingly.
-}
boxShadow : Modifiers BoxShadow.BoxShadow -> Modifier Layout
boxShadow =
    getModifyAndSet .boxShadow setBoxShadowIn BoxShadow.default


{-| Accepts a list of modifiers for the `Corner` and modifies the Layout accordingly.
-}
corner : Modifiers Corner.Corner -> Modifier Layout
corner =
    getModifyAndSet .corner setCornerIn Corner.default


{-| Accepts a `Cursor` and modifies the Layout accordingly.
-}
cursor : Cursor.Cursor -> Modifier Layout
cursor =
    setMaybeValue setCursor


{-| Accepts a list of modifiers for the `Margin` and modifies the Layout accordingly.
-}
margin : Modifiers (Surrounded Margin.Margin) -> Modifier Layout
margin =
    getModifyAndSet .margin setMarginIn Surrounded.default


{-| Accepts a size for the `opacity` and modifies the Layout accordingly.
-}
opacity : Float -> Modifier Layout
opacity =
    setMaybeValue setOpacity


{-| Accepts a list of modifiers for the `Outline` and modifies the Layout accordingly.
-}
outline : Modifiers Outline.Outline -> Modifier Layout
outline =
    getModifyAndSet .outline setOutlineIn Outline.default


{-| Accepts a list of modifiers for the `Padding` and modifies the Layout accordingly.
-}
padding : Modifiers (Surrounded Padding.Padding) -> Modifier Layout
padding =
    getModifyAndSet .padding setPaddingIn Surrounded.default


{-| Accepts a list of modifiers for the `Typography` and modifies the Layout accordingly.
-}
typography : Modifiers Typography.Typography -> Modifier Layout
typography =
    getModifyAndSet .typography setTypographyIn Typography.default


{-| Accepts a `Visibility` and modifies the Layout accordingly.
-}
visibility : Visibility -> Modifier Layout
visibility =
    setMaybeValue setVisibility


{-| Accepts an Int for the `zIndex` and modifies the Layout accordingly.
-}
zIndex : Int -> Modifier Layout
zIndex =
    setMaybeValue setZIndex


{-| Compiles a `Layout` to the corresponding CSS list of tuples.
Compiles only the defined styles, ignoring the `Nothing` fields.
-}
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


{-| Defines the visibility of an element. It can be either visible or hidden.
-}
type Visibility
    = VisibilityHidden
    | VisibilityVisible


{-| -}
hidden : Visibility
hidden =
    VisibilityHidden


{-| -}
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
