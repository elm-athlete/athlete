module Elegant.Box exposing
    ( Box
    , Visibility
    , appearanceNone
    , background
    , border
    , boxShadow
    , shadow
    , corner
    , cursor
    , margin
    , opacity
    , outline
    , padding
    , position
    , typography
    , visibility
    , transform
    , zIndex
    , outlineNone
    , backgroundColor
    , cornerRound
    , cornerRadius
    , borderNone
    , borderColor
    , borderWidth
    , borderSolid
    , paddingAll
    , paddingHorizontal
    , paddingVertical
    , paddingTop
    , paddingRight
    , paddingBottom
    , paddingLeft
    , shadowCenteredBlurry
    , marginAuto
    , fontFamilySansSerif
    , systemFont
    , textColor
    , willChange
    , cursorPointer
    , default
    , visible
    , hidden
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
@docs shadow
@docs corner
@docs cursor
@docs margin
@docs opacity
@docs outline
@docs padding
@docs position
@docs typography
@docs visibility
@docs transform
@docs zIndex


# Shortcuts

@docs outlineNone
@docs backgroundColor
@docs cornerRound
@docs cornerRadius
@docs borderNone
@docs borderColor
@docs borderWidth
@docs borderSolid
@docs paddingAll
@docs paddingHorizontal
@docs paddingVertical
@docs paddingTop
@docs paddingRight
@docs paddingBottom
@docs paddingLeft
@docs shadowCenteredBlurry
@docs marginAuto
@docs fontFamilySansSerif
@docs systemFont
@docs textColor
@docs willChange
@docs cursorPointer


# Values

@docs default
@docs visible
@docs hidden


# Compilation

@docs boxToCouples

-}

import Color exposing (Color)
import Elegant.Background as Background
import Elegant.Border as Border
import Elegant.Corner as Corner
import Elegant.Cursor as Cursor
import Elegant.Helpers.Shared exposing (..)
import Elegant.Internals.Setters exposing (..)
import Elegant.Margin as Margin
import Elegant.Outline as Outline
import Elegant.Padding as Padding
import Elegant.Position as Position
import Elegant.Shadow as Shadow
import Elegant.Surrounded exposing (Surrounded)
import Elegant.Transform as Transform
import Elegant.Typography as Typography
import Function exposing (callOn)
import Modifiers exposing (..)


{-| Represents a box, handling the properties of boxes. They are automatically
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
    , boxShadow : Maybe Shadow.Shadow
    , corner : Maybe Corner.Corner
    , cursor : Maybe Cursor.Cursor
    , margin : Maybe (Surrounded Margin.Margin)
    , opacity : Maybe Float
    , outline : Maybe Outline.Outline
    , padding : Maybe (Surrounded Padding.Padding)
    , position : Maybe Position.Position
    , typography : Maybe Typography.Typography
    , visibility : Maybe Visibility
    , transform : Maybe Transform.Transform
    , zIndex : Maybe Int
    , willChange : Maybe (List WillChange)
    }


type alias WillChange =
    String


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
    getModifyAndSet .border setBorderIn Elegant.Surrounded.default


{-| Accepts a list of modifiers for the `transform` and modifies the Box accordingly.
-}
transform : Modifiers Transform.Transform -> Modifier Box
transform =
    getModifyAndSet .transform setTransformIn Transform.default


{-| Accepts a list of modifiers for the `Shadow` and modifies the Box accordingly.
-}
boxShadow : Modifiers Shadow.Shadow -> Modifier Box
boxShadow =
    getModifyAndSet .boxShadow setShadowIn Shadow.default


{-| Alias of boxShadow
-}
shadow : Modifiers Shadow.Shadow -> Modifier Box
shadow =
    boxShadow


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


{-| Because we always need to set the cursor to pointer !
-}
cursorPointer : Modifier Box
cursorPointer =
    cursor Cursor.pointer


{-| Accepts a list of modifiers for the `Margin` and modifies the Box accordingly.
-}
margin : Modifiers (Surrounded Margin.Margin) -> Modifier Box
margin =
    getModifyAndSet .margin setMarginIn Elegant.Surrounded.default


{-| Accepts a size for the `opacity` and modifies the Box accordingly.
-}
opacity : Float -> Modifier Box
opacity =
    setMaybeValue setOpacity


{-| WillChange helps the browser to know which property will change.
It's very useful for the optimization of animations
-}
willChange : List WillChange -> Modifier Box
willChange =
    setMaybeValue setWillChange


setWillChange willChange_ e =
    { e | willChange = willChange_ }


{-| Accepts a list of modifiers for the `Outline` and modifies the Box accordingly.
-}
outline : Modifiers Outline.Outline -> Modifier Box
outline =
    getModifyAndSet .outline setOutlineIn Outline.default


{-| Accepts a list of modifiers for the `Padding` and modifies the Box accordingly.
-}
padding : Modifiers (Surrounded Padding.Padding) -> Modifier Box
padding =
    getModifyAndSet .padding setPaddingIn Elegant.Surrounded.default


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
    , unwrapToCouple .willChange willChangeToCouples
    , unwrapToCouple .cursor Cursor.cursorToCouple
    , unwrapToCouple .boxShadow Shadow.boxShadowToCouple
    , unwrapToCouples .transform Transform.transformToCouples
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



-- Shortcuts


{-| -}
outlineNone : Modifier Box
outlineNone =
    outline [ Outline.none ]


{-| -}
backgroundColor : Color -> Modifier Box
backgroundColor color =
    background [ setColor (Just color) ]


{-| -}
cornerRound : Modifier Box
cornerRound =
    corner [ Corner.circular Corner.all (Px 300) ]


{-| -}
cornerRadius : Int -> Modifier Box
cornerRadius size =
    corner [ Corner.circular Corner.all (Px size) ]


{-| -}
borderNone : Modifier Box
borderNone =
    border [ Border.all [ Border.none ] ]


{-| -}
borderWidth : Int -> Modifier Box
borderWidth size =
    border [ Border.all [ Border.thickness (Px size) ] ]


{-| -}
borderSolid : Modifier Box
borderSolid =
    border [ Border.all [ Border.solid ] ]


{-| -}
borderColor : Color -> Modifier Box
borderColor color =
    border [ Border.all [ setColor (Just color) ] ]


{-| -}
paddingAll : SizeUnit -> Modifier Box
paddingAll size =
    padding [ Padding.all size ]


{-| -}
paddingHorizontal : SizeUnit -> Modifier Box
paddingHorizontal size =
    padding [ Padding.horizontal size ]


{-| -}
paddingVertical : SizeUnit -> Modifier Box
paddingVertical size =
    padding [ Padding.vertical size ]


{-| -}
paddingTop : SizeUnit -> Modifier Box
paddingTop size =
    padding [ Padding.top size ]


{-| -}
paddingRight : SizeUnit -> Modifier Box
paddingRight size =
    padding [ Padding.right size ]


{-| -}
paddingBottom : SizeUnit -> Modifier Box
paddingBottom size =
    padding [ Padding.bottom size ]


{-| -}
paddingLeft : SizeUnit -> Modifier Box
paddingLeft size =
    padding [ Padding.left size ]


{-| -}
shadowCenteredBlurry : SizeUnit -> Color -> Modifier Box
shadowCenteredBlurry size color =
    boxShadow
        [ setColor color
        , Shadow.blurRadius size
        ]


{-| -}
marginAuto : Modifier Box
marginAuto =
    margin [ Margin.all Margin.auto ]


{-| -}
fontFamilySansSerif : Modifier Box
fontFamilySansSerif =
    typography [ Typography.fontFamilySansSerif ]


{-| -}
systemFont : String -> Modifier Box
systemFont font =
    typography [ Typography.fontFamily [ Typography.systemFont font ] ]


{-| -}
textColor : Color -> Modifier Box
textColor color =
    typography [ setColor (Just color) ]



-- Internals


opacityToCouple : Float -> ( String, String )
opacityToCouple opacity_ =
    ( "opacity", String.fromFloat opacity_ )


willChangeToCouples : List WillChange -> ( String, String )
willChangeToCouples willChange_ =
    ( "will-change", String.join ", " willChange_ )


visibilityToCouple : Visibility -> ( String, String )
visibilityToCouple visibility_ =
    ( "visibility", visibilityToString visibility_ )


visibilityToString : Visibility -> String
visibilityToString val =
    case val of
        VisibilityHidden ->
            "hidden"

        VisibilityVisible ->
            "visible"


zIndexToCouple : Int -> ( String, String )
zIndexToCouple zIndex_ =
    ( "z-index", String.fromInt zIndex_ )
