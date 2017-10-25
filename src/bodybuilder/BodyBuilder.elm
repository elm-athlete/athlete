module BodyBuilder exposing (..)

import Html exposing (Html)
import Html.Attributes
import Elegant
import BodyBuilder.Attributes exposing (..)
import Function
import Helpers.Shared exposing (..)
import Display exposing (FlexContainerDetails)
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
    common
        BodyBuilder.Attributes.defaultNodeAttributes
        "bb-node"
        identity
        nothingAttributes
        nothingAttributes
        .block
        BodyBuilder.Attributes.nodeAttributesToHtmlAttributes


flex : Modifiers (FlexContainerAttributes msg) -> List (FlexItem msg) -> Node msg
flex =
    common
        BodyBuilder.Attributes.defaultFlexContainerAttributes
        "bb-flex"
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
        << common
            BodyBuilder.Attributes.defaultFlexItemAttributes
            "bb-flex-item"
            identity
            nothingAttributes
            (.flexItemProperties >> Just)
            .block
            BodyBuilder.Attributes.flexItemAttributesToHtmlAttributes
            modifiers


button : Modifiers (ButtonAttributes msg) -> List (Node msg) -> Node msg
button =
    common
        BodyBuilder.Attributes.defaultButtonAttributes
        "button"
        identity
        nothingAttributes
        nothingAttributes
        .block
        BodyBuilder.Attributes.buttonAttributesToHtmlAttributes


{-| -}
inputText : Modifiers (InputTextAttributes msg) -> Node msg
inputText =
    flip
        (common
            BodyBuilder.Attributes.defaultInputTextAttributes
            "input"
            identity
            nothingAttributes
            nothingAttributes
            .block
            BodyBuilder.Attributes.inputTextAttributesToHtmlAttributes
        )
        []


{-| -}
inputNumber : Modifiers (InputNumberAttributes msg) -> Node msg
inputNumber =
    flip
        (common
            BodyBuilder.Attributes.defaultInputNumberAttributes
            "input"
            identity
            nothingAttributes
            nothingAttributes
            .block
            BodyBuilder.Attributes.inputNumberAttributesToHtmlAttributes
        )
        []


heading : String -> Modifiers (HeadingAttributes msg) -> List (Node msg) -> Node msg
heading tag =
    common
        BodyBuilder.Attributes.defaultHeadingAttributes
        tag
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


common :
    VisibleAttributes a
    -> String
    -> (b -> List (Node msg))
    -> (VisibleAttributes a -> Maybe (List ( Modifiers FlexContainerDetails, StyleSelector )))
    -> (VisibleAttributes a -> Maybe (List ( Modifiers Display.FlexItemDetails, StyleSelector )))
    -> (VisibleAttributes a -> Maybe (List ( Modifiers Display.BlockDetails, StyleSelector )))
    -> (VisibleAttributes a -> List (Html.Attribute msg))
    -> Modifiers (VisibleAttributes a)
    -> b
    -> Node msg
common defaultAttributes nodeName childrenModifiers getFlexContainerProperties getFlexItemProperties getBlockProperties attributesToHtmlAttributes modifiers children =
    computeBlock
        nodeName
        getFlexContainerProperties
        getFlexItemProperties
        getBlockProperties
        defaultAttributes
        attributesToHtmlAttributes
        modifiers
        (childrenModifiers children)


nothingAttributes : b -> Maybe a
nothingAttributes _ =
    Nothing


computeBlock :
    String
    -> (VisibleAttributes a -> Maybe (List ( Modifiers FlexContainerDetails, StyleSelector )))
    -> (VisibleAttributes a -> Maybe (List ( Modifiers Display.FlexItemDetails, StyleSelector )))
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
