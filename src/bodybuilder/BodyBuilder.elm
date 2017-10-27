module BodyBuilder exposing (..)

import Html exposing (Html)
import Html.Attributes
import BodyBuilder.Attributes exposing (..)
import BodyBuilder.Convert
import BodyBuilder.Shared as Shared
import Helpers.Shared exposing (..)
import Elegant
import Function
import Flex exposing (FlexContainerDetails)
import Display
import Grid


type alias Node msg =
    Html msg


type FlexItem msg
    = FlexItem (Node msg)


extractNodeInFlexItem : FlexItem msg -> Node msg
extractNodeInFlexItem (FlexItem item) =
    item


type GridItem msg
    = GridItem (Node msg)


extractNodeInGridItem : GridItem msg -> Node msg
extractNodeInGridItem (GridItem item) =
    item


type Option msg
    = Option (Html msg)


extractOption : Option msg -> Html msg
extractOption (Option option) =
    option


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
        nothingAttributes
        nothingAttributes
        .block
        BodyBuilder.Attributes.flexContainerAttributesToHtmlAttributes


flexItem : Modifiers (FlexItemAttributes msg) -> List (Node msg) -> FlexItem msg
flexItem modifiers =
    FlexItem
        << commonNode
            "bb-flex-item"
            BodyBuilder.Attributes.defaultFlexItemAttributes
            identity
            nothingAttributes
            (.flexItemProperties >> Just)
            nothingAttributes
            nothingAttributes
            .block
            BodyBuilder.Attributes.flexItemAttributesToHtmlAttributes
            modifiers


grid : Modifiers (GridContainerAttributes msg) -> List (GridItem msg) -> Node msg
grid =
    commonNode
        "bb-grid"
        BodyBuilder.Attributes.defaultGridContainerAttributes
        (List.map extractNodeInGridItem)
        nothingAttributes
        nothingAttributes
        (.gridContainerProperties >> Just)
        nothingAttributes
        .block
        BodyBuilder.Attributes.gridContainerAttributesToHtmlAttributes


gridItem : Modifiers (GridItemAttributes msg) -> List (Node msg) -> GridItem msg
gridItem modifiers =
    GridItem
        << commonNode
            "bb-grid-item"
            BodyBuilder.Attributes.defaultGridItemAttributes
            identity
            nothingAttributes
            nothingAttributes
            nothingAttributes
            (.gridItemProperties >> Just)
            .block
            BodyBuilder.Attributes.gridItemAttributesToHtmlAttributes
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
    inputAndLabel
        BodyBuilder.Attributes.defaultInputTextAttributes
        BodyBuilder.Attributes.inputTextAttributesToHtmlAttributes


inputPassword : Modifiers (InputPasswordAttributes msg) -> Node msg
inputPassword =
    inputAndLabel
        BodyBuilder.Attributes.defaultInputPasswordAttributes
        BodyBuilder.Attributes.inputPasswordAttributesToHtmlAttributes


{-| -}
inputRange : Modifiers (InputRangeAttributes msg) -> Node msg
inputRange =
    inputAndLabel
        BodyBuilder.Attributes.defaultInputRangeAttributes
        BodyBuilder.Attributes.inputRangeAttributesToHtmlAttributes


{-| -}
inputNumber : Modifiers (InputNumberAttributes msg) -> Node msg
inputNumber =
    inputAndLabel
        BodyBuilder.Attributes.defaultInputNumberAttributes
        BodyBuilder.Attributes.inputNumberAttributesToHtmlAttributes


inputRadio : Modifiers (InputRadioAttributes msg) -> Node msg
inputRadio =
    inputAndLabel
        BodyBuilder.Attributes.defaultInputRadioAttributes
        BodyBuilder.Attributes.inputRadioAttributesToHtmlAttributes


inputCheckbox : Modifiers (InputCheckboxAttributes msg) -> Node msg
inputCheckbox =
    inputAndLabel
        BodyBuilder.Attributes.defaultInputCheckboxAttributes
        BodyBuilder.Attributes.inputCheckboxAttributesToHtmlAttributes


inputSubmit : Modifiers (InputSubmitAttributes msg) -> Node msg
inputSubmit =
    inputAndLabel
        BodyBuilder.Attributes.defaultInputSubmitAttributes
        BodyBuilder.Attributes.inputSubmitAttributesToHtmlAttributes


inputUrl : Modifiers (InputUrlAttributes msg) -> Node msg
inputUrl =
    inputAndLabel
        BodyBuilder.Attributes.defaultInputUrlAttributes
        BodyBuilder.Attributes.inputUrlAttributesToHtmlAttributes


inputColor : Modifiers (InputColorAttributes msg) -> Node msg
inputColor =
    inputAndLabel
        BodyBuilder.Attributes.defaultInputColorAttributes
        BodyBuilder.Attributes.inputColorAttributesToHtmlAttributes


inputFile : Modifiers (InputFileAttributes msg) -> Node msg
inputFile =
    inputAndLabel
        BodyBuilder.Attributes.defaultInputFileAttributes
        BodyBuilder.Attributes.inputFileAttributesToHtmlAttributes


textarea : Modifiers (TextareaAttributes msg) -> Node msg
textarea =
    commonBlockFlexlessChildlessNode
        "textarea"
        BodyBuilder.Attributes.defaultTextareaAttributes
        BodyBuilder.Attributes.textareaAttributesToHtmlAttributes


select : Modifiers (SelectAttributes msg) -> List (Option msg) -> Node msg
select =
    commonNode
        "select"
        BodyBuilder.Attributes.defaultSelectAttributes
        (List.map extractOption)
        nothingAttributes
        nothingAttributes
        nothingAttributes
        nothingAttributes
        .block
        BodyBuilder.Attributes.selectAttributesToHtmlAttributes


option : String -> String -> Option msg
option value content =
    Option <| Html.option [ Html.Attributes.value value ] [ Html.text content ]


heading : String -> Modifiers (HeadingAttributes msg) -> List (Node msg) -> Node msg
heading tag =
    commonNode
        tag
        BodyBuilder.Attributes.defaultHeadingAttributes
        identity
        nothingAttributes
        nothingAttributes
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


div : Modifiers (HeadingAttributes msg) -> List (Node msg) -> Node msg
div =
    heading "div"


span : Modifiers (NodeAttributes msg) -> List (Node msg) -> Node msg
span =
    node



-- Internals


commonNode :
    String
    -> VisibleAttributes a
    -> (b -> List (Node msg))
    -> (VisibleAttributes a -> Maybe (List ( Modifiers Flex.FlexContainerDetails, StyleSelector )))
    -> (VisibleAttributes a -> Maybe (List ( Modifiers Flex.FlexItemDetails, StyleSelector )))
    -> (VisibleAttributes a -> Maybe (List ( Modifiers Grid.GridContainerDetails, StyleSelector )))
    -> (VisibleAttributes a -> Maybe (List ( Modifiers Grid.GridItemDetails, StyleSelector )))
    -> (VisibleAttributes a -> Maybe (List ( Modifiers Display.BlockDetails, StyleSelector )))
    -> (VisibleAttributes a -> List (Html.Attribute msg))
    -> Modifiers (VisibleAttributes a)
    -> b
    -> Node msg
commonNode nodeName defaultAttributes childrenModifiers getFlexContainerProperties getFlexItemProperties getGridContainerProperties getGridItemProperties getBlockProperties attributesToHtmlAttributes modifiers children =
    computeBlock
        nodeName
        getFlexContainerProperties
        getFlexItemProperties
        getGridContainerProperties
        getGridItemProperties
        getBlockProperties
        defaultAttributes
        attributesToHtmlAttributes
        modifiers
        (childrenModifiers children)


commonChildlessNode :
    String
    -> VisibleAttributes a
    -> (List b -> List (Node msg))
    -> (VisibleAttributes a -> Maybe (List ( Modifiers Flex.FlexContainerDetails, StyleSelector )))
    -> (VisibleAttributes a -> Maybe (List ( Modifiers Flex.FlexItemDetails, StyleSelector )))
    -> (VisibleAttributes a -> Maybe (List ( Modifiers Grid.GridContainerDetails, StyleSelector )))
    -> (VisibleAttributes a -> Maybe (List ( Modifiers Grid.GridItemDetails, StyleSelector )))
    -> (VisibleAttributes a -> Maybe (List ( Modifiers Display.BlockDetails, StyleSelector )))
    -> (VisibleAttributes a -> List (Html.Attribute msg))
    -> Modifiers (VisibleAttributes a)
    -> Node msg
commonChildlessNode nodeName defaultAttributes childrenModifiers getFlexContainerProperties getFlexItemProperties getGridContainerProperties getGridItemProperties getBlockProperties attributesToHtmlAttributes =
    flip
        (commonNode
            nodeName
            defaultAttributes
            childrenModifiers
            getFlexContainerProperties
            getFlexItemProperties
            getGridContainerProperties
            getGridItemProperties
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
        nothingAttributes
        nothingAttributes
        .block
        convertAttributes


nothingAttributes : b -> Maybe a
nothingAttributes _ =
    Nothing


inputAndLabel :
    MaybeBlockContainer (VisibleAttributes { a | label : Maybe (Shared.Label msg) })
    -> (MaybeBlockContainer (VisibleAttributes { a | label : Maybe (Shared.Label msg) }) -> List (Html.Attribute msg))
    -> Modifiers (MaybeBlockContainer (VisibleAttributes { a | label : Maybe (Shared.Label msg) }))
    -> Html msg
inputAndLabel defaultAttributes attributesToHtmlAttributes modifiers =
    let
        attributes =
            (Function.compose modifiers)
                defaultAttributes

        computedInput =
            Html.input
                (BodyBuilder.Convert.toElegantStyle
                    Nothing
                    Nothing
                    Nothing
                    Nothing
                    attributes.block
                    attributes.box
                    |> List.map Elegant.styleToCss
                    |> String.join " "
                    |> Html.Attributes.class
                    |> flip (::) (attributesToHtmlAttributes attributes)
                )
                []
    in
        case attributes.label of
            Nothing ->
                computedInput

            Just label ->
                (Shared.extractLabel label) computedInput


computeBlock :
    String
    -> (VisibleAttributes a -> Maybe (List ( Modifiers Flex.FlexContainerDetails, StyleSelector )))
    -> (VisibleAttributes a -> Maybe (List ( Modifiers Flex.FlexItemDetails, StyleSelector )))
    -> (VisibleAttributes a -> Maybe (List ( Modifiers Grid.GridContainerDetails, StyleSelector )))
    -> (VisibleAttributes a -> Maybe (List ( Modifiers Grid.GridItemDetails, StyleSelector )))
    -> (VisibleAttributes a -> Maybe (List ( Modifiers Display.BlockDetails, StyleSelector )))
    -> VisibleAttributes a
    -> (VisibleAttributes a -> List (Html.Attribute msg))
    -> Modifiers (VisibleAttributes a)
    -> List (Html msg)
    -> Html msg
computeBlock tag flexModifiers flexItemModifiers gridModifiers gridItemModifiers blockModifiers defaultAttributes attributesToHtmlAttributes modifiers content =
    let
        attributes =
            (Function.compose modifiers)
                defaultAttributes
    in
        Html.node tag
            (BodyBuilder.Convert.toElegantStyle
                (flexModifiers attributes)
                (flexItemModifiers attributes)
                (gridModifiers attributes)
                (gridItemModifiers attributes)
                (blockModifiers attributes)
                attributes.box
                |> List.map Elegant.styleToCss
                |> String.join " "
                |> Html.Attributes.class
                |> flip (::) (attributesToHtmlAttributes attributes)
            )
            content
