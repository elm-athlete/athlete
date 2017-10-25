module BodyBuilder exposing (..)

import Html exposing (Html)
import Html.Attributes
import Elegant
import BodyBuilder.Attributes exposing (..)
import Function
import Helpers.Shared exposing (..)
import Flex exposing (FlexContainerDetails)
import Display
import BodyBuilder.Convert


type alias Node msg =
    Html msg


type FlexItem msg
    = FlexItem (Node msg)


text : String -> Node msg
text =
    Html.text


br : Node msg
br =
    Html.br [] []


program :
    { init : ( model, Cmd msg )
    , subscriptions : model -> Sub msg
    , update : msg -> model -> ( model, Cmd msg )
    , view : model -> Html msg
    }
    -> Program Never model msg
program =
    Html.program


node : Modifiers (NodeAttributes msg) -> List (Node msg) -> Node msg
node =
    commonBlockFlexlessNode
        "bb-node"
        BodyBuilder.Attributes.defaultNodeAttributes
        BodyBuilder.Attributes.nodeAttributesToHtmlAttributes


flex : Modifiers (FlexContainerAttributes msg) -> List (FlexItem msg) -> Node msg
flex =
    commonNode
        "bb-flex"
        BodyBuilder.Attributes.defaultFlexContainerAttributes
        (List.map extractNodeInFlexItem)
        (.flexContainerProperties >> Just)
        nothingAttributes
        .block
        BodyBuilder.Attributes.flexContainerAttributesToHtmlAttributes


extractNodeInFlexItem : FlexItem msg -> Node msg
extractNodeInFlexItem (FlexItem item) =
    item


flexItem : Modifiers (FlexItemAttributes msg) -> List (Node msg) -> FlexItem msg
flexItem modifiers =
    FlexItem
        << commonNode
            "bb-flex-item"
            BodyBuilder.Attributes.defaultFlexItemAttributes
            identity
            nothingAttributes
            (.flexItemProperties >> Just)
            .block
            BodyBuilder.Attributes.flexItemAttributesToHtmlAttributes
            modifiers


a : Modifiers (AAttributes msg) -> List (Node msg) -> Node msg
a =
    commonBlockFlexlessNode
        "a"
        BodyBuilder.Attributes.defaultAAttributes
        BodyBuilder.Attributes.aAttributesToHtmlAttributes


img : String -> String -> Modifiers (ImgAttributes msg) -> Node msg
img alt src =
    commonBlockFlexlessChildlessNode
        "img"
        (BodyBuilder.Attributes.defaultImgAttributes alt src)
        BodyBuilder.Attributes.imgAttributesToHtmlAttributes


audio : Modifiers (AudioAttributes msg) -> Node msg
audio =
    commonBlockFlexlessChildlessNode
        "audio"
        BodyBuilder.Attributes.defaultAudioAttributes
        BodyBuilder.Attributes.audioAttributesToHtmlAttributes


progress : Modifiers (ProgressAttributes msg) -> Node msg
progress =
    commonBlockFlexlessChildlessNode
        "progress"
        BodyBuilder.Attributes.defaultProgressAttributes
        BodyBuilder.Attributes.progressAttributesToHtmlAttributes


button : Modifiers (ButtonAttributes msg) -> List (Node msg) -> Node msg
button =
    commonBlockFlexlessNode
        "button"
        BodyBuilder.Attributes.defaultButtonAttributes
        BodyBuilder.Attributes.buttonAttributesToHtmlAttributes


inputHidden : Modifiers InputHiddenAttributes -> Node msg
inputHidden modifiers =
    Html.input
        (BodyBuilder.Attributes.defaultInputHiddenAttributes
            |> Function.compose modifiers
            |> BodyBuilder.Attributes.inputHiddenAttributesToHtmlAttributes
        )
        []


{-| -}
inputText : Modifiers (InputTextAttributes msg) -> Node msg
inputText =
    commonBlockFlexlessChildlessNode
        "input"
        BodyBuilder.Attributes.defaultInputTextAttributes
        BodyBuilder.Attributes.inputTextAttributesToHtmlAttributes


inputPassword : Modifiers (InputPasswordAttributes msg) -> Node msg
inputPassword =
    commonBlockFlexlessChildlessNode
        "input"
        BodyBuilder.Attributes.defaultInputPasswordAttributes
        BodyBuilder.Attributes.inputPasswordAttributesToHtmlAttributes


{-| -}
inputRange : Modifiers (InputRangeAttributes msg) -> Node msg
inputRange =
    commonBlockFlexlessChildlessNode
        "input"
        BodyBuilder.Attributes.defaultInputRangeAttributes
        BodyBuilder.Attributes.inputRangeAttributesToHtmlAttributes


{-| -}
inputNumber : Modifiers (InputNumberAttributes msg) -> Node msg
inputNumber =
    commonBlockFlexlessChildlessNode
        "input"
        BodyBuilder.Attributes.defaultInputNumberAttributes
        BodyBuilder.Attributes.inputNumberAttributesToHtmlAttributes


inputRadio : Modifiers (InputRadioAttributes msg) -> Node msg
inputRadio =
    commonBlockFlexlessChildlessNode
        "input"
        BodyBuilder.Attributes.defaultInputRadioAttributes
        BodyBuilder.Attributes.inputRadioAttributesToHtmlAttributes


inputCheckbox : Modifiers (InputCheckboxAttributes msg) -> Node msg
inputCheckbox =
    commonBlockFlexlessChildlessNode
        "input"
        BodyBuilder.Attributes.defaultInputCheckboxAttributes
        BodyBuilder.Attributes.inputCheckboxAttributesToHtmlAttributes


inputSubmit : Modifiers (InputSubmitAttributes msg) -> Node msg
inputSubmit =
    commonBlockFlexlessChildlessNode
        "input"
        BodyBuilder.Attributes.defaultInputSubmitAttributes
        BodyBuilder.Attributes.inputSubmitAttributesToHtmlAttributes


inputUrl : Modifiers (InputUrlAttributes msg) -> Node msg
inputUrl =
    commonBlockFlexlessChildlessNode
        "input"
        BodyBuilder.Attributes.defaultInputUrlAttributes
        BodyBuilder.Attributes.inputUrlAttributesToHtmlAttributes


inputColor : Modifiers (InputColorAttributes msg) -> Node msg
inputColor =
    commonBlockFlexlessChildlessNode
        "input"
        BodyBuilder.Attributes.defaultInputColorAttributes
        BodyBuilder.Attributes.inputColorAttributesToHtmlAttributes


inputFile : Modifiers (InputFileAttributes msg) -> Node msg
inputFile =
    commonBlockFlexlessChildlessNode
        "input"
        BodyBuilder.Attributes.defaultInputFileAttributes
        BodyBuilder.Attributes.inputFileAttributesToHtmlAttributes



-- TextareaAttributes
-- SelectAttributes


heading : String -> Modifiers (HeadingAttributes msg) -> List (Node msg) -> Node msg
heading tag =
    commonNode
        tag
        BodyBuilder.Attributes.defaultHeadingAttributes
        identity
        nothingAttributes
        nothingAttributes
        (.block >> Just)
        BodyBuilder.Attributes.headingAttributesToHtmlAttributes


h1 : Modifiers (HeadingAttributes msg) -> List (Node msg) -> Node msg
h1 =
    heading "h1"


h2 : Modifiers (HeadingAttributes msg) -> List (Node msg) -> Node msg
h2 =
    heading "h2"


h3 : Modifiers (HeadingAttributes msg) -> List (Node msg) -> Node msg
h3 =
    heading "h3"


h4 : Modifiers (HeadingAttributes msg) -> List (Node msg) -> Node msg
h4 =
    heading "h4"


h5 : Modifiers (HeadingAttributes msg) -> List (Node msg) -> Node msg
h5 =
    heading "h5"


h6 : Modifiers (HeadingAttributes msg) -> List (Node msg) -> Node msg
h6 =
    heading "h6"


p : Modifiers (HeadingAttributes msg) -> List (Node msg) -> Node msg
p =
    heading "p"



-- Internals


commonNode :
    String
    -> VisibleAttributes a
    -> (b -> List (Node msg))
    -> (VisibleAttributes a -> Maybe (List ( Modifiers FlexContainerDetails, StyleSelector )))
    -> (VisibleAttributes a -> Maybe (List ( Modifiers Flex.FlexItemDetails, StyleSelector )))
    -> (VisibleAttributes a -> Maybe (List ( Modifiers Display.BlockDetails, StyleSelector )))
    -> (VisibleAttributes a -> List (Html.Attribute msg))
    -> Modifiers (VisibleAttributes a)
    -> b
    -> Node msg
commonNode nodeName defaultAttributes childrenModifiers getFlexContainerProperties getFlexItemProperties getBlockProperties attributesToHtmlAttributes modifiers children =
    computeBlock
        nodeName
        getFlexContainerProperties
        getFlexItemProperties
        getBlockProperties
        defaultAttributes
        attributesToHtmlAttributes
        modifiers
        (childrenModifiers children)


commonChildlessNode :
    String
    -> VisibleAttributes a
    -> (List b -> List (Node msg))
    -> (VisibleAttributes a -> Maybe (List ( Modifiers FlexContainerDetails, StyleSelector )))
    -> (VisibleAttributes a -> Maybe (List ( Modifiers Flex.FlexItemDetails, StyleSelector )))
    -> (VisibleAttributes a -> Maybe (List ( Modifiers Display.BlockDetails, StyleSelector )))
    -> (VisibleAttributes a -> List (Html.Attribute msg))
    -> Modifiers (VisibleAttributes a)
    -> Node msg
commonChildlessNode nodeName defaultAttributes childrenModifiers getFlexContainerProperties getFlexItemProperties getBlockProperties attributesToHtmlAttributes =
    flip
        (commonNode
            nodeName
            defaultAttributes
            childrenModifiers
            getFlexContainerProperties
            getFlexItemProperties
            getBlockProperties
            attributesToHtmlAttributes
        )
        []


commonBlockFlexlessNode :
    String
    -> VisibleAttributes (MaybeBlockContainer a)
    -> (VisibleAttributes (MaybeBlockContainer a) -> List (Html.Attribute msg))
    -> Modifiers (VisibleAttributes (MaybeBlockContainer a))
    -> List (Node msg)
    -> Node msg
commonBlockFlexlessNode tag defaultAttributes convertAttributes =
    commonNode
        tag
        defaultAttributes
        identity
        nothingAttributes
        nothingAttributes
        .block
        convertAttributes


commonBlockFlexlessChildlessNode :
    String
    -> VisibleAttributes (MaybeBlockContainer a)
    -> (VisibleAttributes (MaybeBlockContainer a) -> List (Html.Attribute msg))
    -> Modifiers (VisibleAttributes (MaybeBlockContainer a))
    -> Node msg
commonBlockFlexlessChildlessNode tag defaultAttributes convertAttributes =
    commonChildlessNode
        tag
        defaultAttributes
        identity
        nothingAttributes
        nothingAttributes
        .block
        convertAttributes


nothingAttributes : b -> Maybe a
nothingAttributes _ =
    Nothing


computeBlock :
    String
    -> (VisibleAttributes a -> Maybe (List ( Modifiers FlexContainerDetails, StyleSelector )))
    -> (VisibleAttributes a -> Maybe (List ( Modifiers Flex.FlexItemDetails, StyleSelector )))
    -> (VisibleAttributes a -> Maybe (List ( Modifiers Display.BlockDetails, StyleSelector )))
    -> VisibleAttributes a
    -> (VisibleAttributes a -> List (Html.Attribute msg))
    -> Modifiers (VisibleAttributes a)
    -> List (Html msg)
    -> Html msg
computeBlock tag flexModifiers flexItemModifiers blockModifiers defaultAttributes attributesToHtmlAttributes visibleModifiers content =
    let
        attributes =
            (Function.compose visibleModifiers)
                defaultAttributes
    in
        Html.node tag
            (BodyBuilder.Convert.toElegantStyle
                (flexModifiers attributes)
                (flexItemModifiers attributes)
                (blockModifiers attributes)
                attributes.box
                |> List.map Elegant.styleToCss
                |> String.join " "
                |> Html.Attributes.class
                |> flip (::) (attributesToHtmlAttributes attributes)
            )
            content
