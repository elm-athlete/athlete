module Box
    exposing
        ( Box
        , default
        , Visibility
        , appearanceNone
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
        , boxToCouples
        )

{-| Handles all modifications for the box. You don't need to instanciate one,
as it's automatically done by Elegant and the different display elements.
It contains only modifiers, and they can be found in the respective modules.


# Types

@docs Box
@docs Visibility


# Modifiers

@docs appearanceNone
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

@docs boxToCouples

-}

import Helpers.Shared exposing (..)
import Elegant.Setters exposing (..)
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


{-| Represents a box, handling the properties of blocks. They are automatically
instanciated to avoid to deal with it directly. The focus is on the modifiers, available
in respective modules.

    Elegant.displayBlock []
        [ Box.cursor Cursor.default
        -- You can use any Box functions here to add custom style...
        ]

-}
type alias Box =
    { appearance : Maybe String
    , background : Maybe Background.Background
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


{-| Generates a default empty Box.
-}
default : Box
default =
    Box
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
        Nothing


{-| Accepts a `Position` and modifies the Box accordingly.
-}
position : Position.Position -> Modifier Box
position =
    setMaybeValue setPosition


{-| Accepts a list of modifiers for the `Background` and modifies the Box accordingly.
-}
background : Modifiers Background.Background -> Modifier Box
background =
    getModifyAndSet .background setBackgroundIn Background.default


{-| Accepts a list of modifiers for the `Border` and modifies the Box accordingly.
-}
border : Modifiers (Surrounded Border.Border) -> Modifier Box
border =
    getModifyAndSet .border setBorderIn Surrounded.default


{-| Accepts a list of modifiers for the `BoxShadow` and modifies the Box accordingly.
-}
boxShadow : Modifiers BoxShadow.BoxShadow -> Modifier Box
boxShadow =
    getModifyAndSet .boxShadow setBoxShadowIn BoxShadow.default


{-| Accepts a list of modifiers for the `Corner` and modifies the Box accordingly.
-}
corner : Modifiers Corner.Corner -> Modifier Box
corner =
    getModifyAndSet .corner setCornerIn Corner.default


{-| Accepts a `Cursor` and modifies the Box accordingly.
-}
cursor : Cursor.Cursor -> Modifier Box
cursor =
    setMaybeValue setCursor


{-| Accepts a list of modifiers for the `Margin` and modifies the Box accordingly.
-}
margin : Modifiers (Surrounded Margin.Margin) -> Modifier Box
margin =
    getModifyAndSet .margin setMarginIn Surrounded.default


{-| Accepts a size for the `opacity` and modifies the Box accordingly.
-}
opacity : Float -> Modifier Box
opacity =
    setMaybeValue setOpacity


{-| Accepts a list of modifiers for the `Outline` and modifies the Box accordingly.
-}
outline : Modifiers Outline.Outline -> Modifier Box
outline =
    getModifyAndSet .outline setOutlineIn Outline.default


{-| Accepts a list of modifiers for the `Padding` and modifies the Box accordingly.
-}
padding : Modifiers (Surrounded Padding.Padding) -> Modifier Box
padding =
    getModifyAndSet .padding setPaddingIn Surrounded.default


{-| Accepts a list of modifiers for the `Typography` and modifies the Box accordingly.
-}
typography : Modifiers Typography.Typography -> Modifier Box
typography =
    getModifyAndSet .typography setTypographyIn Typography.default


{-| Accepts a `Visibility` and modifies the Box accordingly.
-}
visibility : Visibility -> Modifier Box
visibility =
    setMaybeValue setVisibility


{-| Accepts an Int for the `zIndex` and modifies the Box accordingly.
-}
zIndex : Int -> Modifier Box
zIndex =
    setMaybeValue setZIndex


{-| Accepts an Int for the `zIndex` and modifies the Box accordingly.
-}
appearanceNone : Modifier Box
appearanceNone box =
    { box | appearance = Just "none" }


{-| Compiles a `Box` to the corresponding CSS list of tuples.
Compiles only the defined styles, ignoring the `Nothing` fields.
-}
boxToCouples : Box -> List ( String, String )
boxToCouples box =
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
    , unwrapToCouples .appearance appearance
    ]
        |> List.concatMap (callOn box)


appearance : a -> List ( String, a )
appearance e =
    [ ( "-webkit-appearance", e )
    , ( "appearance", e )
    , ( "-moz-appearance", e )
    ]


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
