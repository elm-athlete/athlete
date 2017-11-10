module Style exposing (..)

{-|
@docs box
@docs block
@docs blockProperties
@docs flexContainerProperties
@docs flexItemProperties
@docs gridContainerProperties
@docs gridItemProperties
@docs waitForStyleSelector
@docs media
@docs setMedia
@docs greater
@docs lesser
@docs between
@docs pseudoClass
@docs setPseudoClass
@docs hover
@docs focus
-}

import BodyBuilder.Attributes exposing (..)
import BodyBuilder.Setters exposing (..)
import Helpers.Shared exposing (..)
import Box
import Display
import Flex
import Grid


{-| -}
box : Modifiers Box.Box -> StyleModifier (BoxContainer a)
box =
    waitForStyleSelector setBox


{-| -}
block : Modifiers Display.BlockDetails -> StyleModifier (MaybeBlockContainer a)
block =
    waitForStyleSelector setMaybeBlock


{-| -}
blockProperties : Modifiers Display.BlockDetails -> StyleModifier (BlockContainer a)
blockProperties =
    waitForStyleSelector setBlock


{-| -}
flexContainerProperties : Modifiers Flex.FlexContainerDetails -> StyleModifier (FlexContainerAttributes msg)
flexContainerProperties =
    waitForStyleSelector setFlexContainerProperties


{-| -}
flexItemProperties : Modifiers Flex.FlexItemDetails -> StyleModifier (FlexItemAttributes msg)
flexItemProperties =
    waitForStyleSelector setFlexItemProperties


{-| -}
gridContainerProperties : Modifiers Grid.GridContainerDetails -> StyleModifier (GridContainerAttributes msg)
gridContainerProperties =
    waitForStyleSelector setGridContainerProperties


{-| -}
gridItemProperties : Modifiers Grid.GridItemDetails -> StyleModifier (GridItemAttributes msg)
gridItemProperties =
    waitForStyleSelector setGridItemProperties


{-| -}
waitForStyleSelector : (( a, StyleSelector ) -> b -> b) -> a -> StyleModifier b
waitForStyleSelector setter val selector =
    setter ( val, selector )


{-| -}
media : MediaQuery -> StyleModifier a -> StyleModifier a
media mediaQuery fun =
    setMedia mediaQuery >> fun


{-| -}
setMedia : MediaQuery -> Modifier StyleSelector
setMedia mediaQuery styleSelector =
    { styleSelector | media = Just mediaQuery }


{-| -}
greater : Int -> MediaQuery
greater =
    Greater


{-| -}
lesser : Int -> MediaQuery
lesser =
    Lesser


{-| -}
between : Int -> Int -> MediaQuery
between =
    Between


{-| -}
pseudoClass : String -> StyleModifier a -> StyleModifier a
pseudoClass class fun =
    setPseudoClass class >> fun


{-| -}
setPseudoClass : String -> Modifier StyleSelector
setPseudoClass class styleSelector =
    { styleSelector | pseudoClass = Just class }


{-| -}
hover : StyleModifier a -> StyleModifier a
hover =
    pseudoClass "hover"


{-| -}
focus : StyleModifier a -> StyleModifier a
focus =
    pseudoClass "focus"
