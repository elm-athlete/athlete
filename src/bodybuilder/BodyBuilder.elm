module BodyBuilder
    exposing
        ( BlockAttributes
        , FlexItem
        , GridItem
        , Node
        , Option
        , a
        , article
        , aside
        , audio
        , br
        , button
        , div
        , flex
        , flexItem
        , footer
        , grid
        , gridItem
        , h1
        , h2
        , h3
        , h4
        , h5
        , h6
        , header
        , img
        , inputCheckbox
        , inputColor
        , inputFile
        , inputHidden
        , inputNumber
        , inputPassword
        , inputRadio
        , inputRange
        , inputSubmit
        , inputTel
        , inputText
        , inputUrl
        , nav
        , node
        , none
        , option
        , p
        , program
        , progress
        , section
        , select
        , span
        , text
        , textarea
        )

{-| This module entirely replaces Html, providing a type-safer alternatives.
This also manages inlining styling through Elegant.
It is perfectly compatible with Html, though.

  - [Types](#types)
      - [Elements](#elements-types)
      - [Attributes](#attributes)
  - [Elements](#elements)
      - [Special](#special)
      - [Inline](#inline)
      - [Block](#block)
  - [Program](#program)


# Types


## Elements Types

@docs Node, FlexItem, GridItem, Option


## Attributes

@docs BlockAttributes


# Elements


## Special

@docs text, none, flexItem, gridItem, option, br


## Inline

Those elements are inline by default. However, their behavior can be overrided by
using `Style.block []`. They become block, and behaves like this.

@docs node, span, flex, grid, a, button, img, audio, inputColor, inputFile, inputHidden, inputNumber, inputCheckbox, inputPassword, inputRadio, inputRange, inputSubmit, inputTel, inputText, inputUrl, progress, select, textarea


## Block

Those elements are block by default. Their behavior can't be overrided.
It is possible to style those elements using `Style.blockProperties`.

@docs div, header, footer, nav, section, article, aside, h1, h2, h3, h4, h5, h6, p


# Program

@docs program

-}

import BodyBuilder.Attributes exposing (..)
import BodyBuilder.Convert
import BodyBuilder.Shared as Shared
import Display
import Elegant
import Flex exposing (FlexContainerDetails)
import Function
import Grid
import Html exposing (Html)
import Html.Attributes
import Modifiers exposing (..)


{-| The main type of BodyBuilder. It is an alias to Html, in order to keep
perfect backward compatibility.
-}
type alias Node msg =
    Html msg


{-| The type of the flex items. A flex container contains only specific items.
Those are represented by this type. They're generated by the flexItem function,
to be used exclusively in flex.
-}
type FlexItem msg
    = FlexItem (Node msg)


extractNodeInFlexItem : FlexItem msg -> Node msg
extractNodeInFlexItem (FlexItem item) =
    item


{-| The type of the grid items. A grid container contains only specific items.
Those are represented by this type. They're generated by the gridItem function,
to be used exclusively in grid.
-}
type GridItem msg
    = GridItem (Node msg)


extractNodeInGridItem : GridItem msg -> Node msg
extractNodeInGridItem (GridItem item) =
    item


{-| Represents the different options used in select items. They're generated by
the option function, exclusively to be used in select.
-}
type Option msg
    = Option (Html msg)


extractOption : Option msg -> Html msg
extractOption (Option option) =
    option


{-| Puts plain text in the DOM. You can't set any attributes or events on it.
-}
text : String -> Node msg
text =
    Html.text


{-| Don't create anything in the DOM. This is useful when you have a conditionnal
and are forced to return a Node.

    textOrNone : Maybe String -> Node msg
    textOrNone value =
        case value of
            Nothing ->
                BodyBuilder.none

            Just content ->
                BodyBuilder.text content

-}
none : Node msg
none =
    text ""


{-| Puts a br in the DOM. You can't set any attributes or events on it, since
you want br to insert a carriage return.
-}
br : Node msg
br =
    Html.br [] []


{-| Creates a program, like you could with Html. This allows you to completely
overrides Html to focus on BodyBuilder.
-}
program :
    { init : ( model, Cmd msg )
    , subscriptions : model -> Sub msg
    , update : msg -> model -> ( model, Cmd msg )
    , view : model -> Html msg
    }
    -> Program Never model msg
program =
    Html.program


inlineNode : String -> Modifiers (NodeAttributes msg) -> List (Node msg) -> Node msg
inlineNode tagName =
    commonBlockFlexlessNode
        tagName
        BodyBuilder.Attributes.defaultNodeAttributes
        BodyBuilder.Attributes.nodeAttributesToHtmlAttributes


{-| Generates an empty inline node in the DOM. A node is inline by default, but
changes its behavior when specifically set as block. You don't have to worry about
the display: use a node whenever you want, style like you want, it will adapt to
what you wrote.

    inlineElement : Node msg
    inlineElement =
        -- This produces an inline node in the DOM.
        BodyBuilder.node [] []

    blockElement : Node msg
    blockElement =
        -- This produces a block node in the DOM.
        BodyBuilder.node [ BodyBuilder.Attributes.style [ Style.block [] ] ] []

-}
node : Modifiers (NodeAttributes msg) -> List (Node msg) -> Node msg
node =
    inlineNode "bb-node"


{-| For backward compatibilty. It behaves like node, but avoids to rewrote all your
code when switching to BodyBuilder.
-}
span : Modifiers (NodeAttributes msg) -> List (Node msg) -> Node msg
span =
    inlineNode "span"


{-| Generates an inline flex in the DOM. A flex is inline by default, but
changes its behavior when specifically set as block. You don't have to worry about
the display: use a flex whenever you want, style like you want, it will adapt to
what you wrote.

    inlineFlex : Node msg
    inlineFlex =
        -- This produces an inline flex in the DOM.
        BodyBuilder.flex [] []

    blockFlex : Node msg
    blockFlex =
        -- This produces a block flex in the DOM.
        BodyBuilder.flex [ BodyBuilder.Attributes.style [ Style.block [] ] ] []

-}
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


{-| Generates a flexItem in the DOM. A flexItem is only used inside flex, and
can contains the specific styling of the flexChildren.

    flexElement : Node msg
    flexElement =
        BodyBuilder.flex []
            [ BodyBuilder.flexItem []
                [ Html.text "I'm inside a flex-item!" ]
            ]

-}
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


{-| Generates an inline grid in the DOM. A grid is inline by default, but
changes its behavior when specifically set as block. You don't have to worry about
the display: use a grid whenever you want, style like you want, it will adapt to
what you wrote.

    inlineGrid : Node msg
    inlineGrid =
        -- This produces an inline grid in the DOM.
        BodyBuilder.grid [] []

    blockGrid : Node msg
    blockGrid =
        -- This produces a block grid in the DOM.
        BodyBuilder.grid [ BodyBuilder.Attributes.style [ Style.block [] ] ] []

-}
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


{-| Generates a gridItem in the DOM. A gridItem is only used inside grid, and
can contains the specific styling of the gridChildren.

    gridElement : Node msg
    gridElement =
        BodyBuilder.grid []
            [ BodyBuilder.gridItem []
                [ Html.text "I'm inside a grid-item!" ]
            ]

-}
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


{-| Generates a link in the DOM. A link is inline by default, but
changes its behavior when specifically set as block. You don't have to worry about
the display: use an a whenever you want, style like you want, it will adapt to
what you wrote.

    inlineLink : Node msg
    inlineLink =
        -- This produces an inline a in the DOM.
        BodyBuilder.a [] []

    blockLink : Node msg
    blockLink =
        -- This produces a block a in the DOM.
        BodyBuilder.a [ BodyBuilder.Attributes.style [ Style.block [] ] ] []

-}
a : Modifiers (AAttributes msg) -> List (Node msg) -> Node msg
a =
    commonBlockFlexlessNode
        "a"
        BodyBuilder.Attributes.defaultAAttributes
        BodyBuilder.Attributes.aAttributesToHtmlAttributes


{-| Generates an image in the DOM. An image is inline by default, but
changes its behavior when specifically set as block. You don't have to worry about
the display: use an img whenever you want, style like you want, it will adapt to
what you wrote.

    inlineImage : Node msg
    inlineImage =
        -- This produces an inline img in the DOM.
        BodyBuilder.img [] []

    blockImage : Node msg
    blockImage =
        -- This produces a block img in the DOM.
        BodyBuilder.img [ BodyBuilder.Attributes.style [ Style.block [] ] ] []

-}
img : String -> String -> Modifiers (ImgAttributes msg) -> Node msg
img alt src =
    commonBlockFlexlessChildlessNode
        "img"
        (BodyBuilder.Attributes.defaultImgAttributes alt src)
        BodyBuilder.Attributes.imgAttributesToHtmlAttributes


{-| Generates an audio in the DOM. An audio is inline by default, but
changes its behavior when specifically set as block. You don't have to worry about
the display: use an audio whenever you want, style like you want, it will adapt to
what you wrote.

    inlineAudio : Node msg
    inlineAudio =
        -- This produces an inline audio in the DOM.
        BodyBuilder.audio [] []

    blockAudio : Node msg
    blockAudio =
        -- This produces a block audio in the DOM.
        BodyBuilder.audio [ BodyBuilder.Attributes.style [ Style.block [] ] ] []

-}
audio : Modifiers (AudioAttributes msg) -> Node msg
audio =
    commonBlockFlexlessChildlessNode
        "audio"
        BodyBuilder.Attributes.defaultAudioAttributes
        BodyBuilder.Attributes.audioAttributesToHtmlAttributes


{-| Generates a progress in the DOM. A progress is inline by default, but
changes its behavior when specifically set as block. You don't have to worry about
the display: use an progress whenever you want, style like you want, it will adapt to
what you wrote.

    inlineProgress : Node msg
    inlineProgress =
        -- This produces an inline progress in the DOM.
        BodyBuilder.progress [] []

    blockProgress : Node msg
    blockProgress =
        -- This produces a block progress in the DOM.
        BodyBuilder.progress [ BodyBuilder.Attributes.style [ Style.block [] ] ] []

-}
progress : Modifiers (ProgressAttributes msg) -> Node msg
progress =
    commonBlockFlexlessChildlessNode
        "progress"
        BodyBuilder.Attributes.defaultProgressAttributes
        BodyBuilder.Attributes.progressAttributesToHtmlAttributes


{-| Generates a button in the DOM. A button is inline by default, but
changes its behavior when specifically set as block. You don't have to worry about
the display: use an button whenever you want, style like you want, it will adapt to
what you wrote.

    inlineButton : Node msg
    inlineButton =
        -- This produces an inline button in the DOM.
        BodyBuilder.button [] []

    blockButton : Node msg
    blockButton =
        -- This produces a block button in the DOM.
        BodyBuilder.button [ BodyBuilder.Attributes.style [ Style.block [] ] ] []

-}
button : Modifiers (ButtonAttributes msg) -> List (Node msg) -> Node msg
button =
    commonBlockFlexlessNode
        "button"
        BodyBuilder.Attributes.defaultButtonAttributes
        BodyBuilder.Attributes.buttonAttributesToHtmlAttributes


{-| Generates an hidden input in the DOM. An hidden input is not displayed in the DOM.

    hiddenInput : Node msg
    hiddenInput =
        -- This produces an hidden input in the DOM.
        BodyBuilder.inputHidden []

-}
inputHidden : Modifiers InputHiddenAttributes -> Node msg
inputHidden modifiers =
    Html.input
        (BodyBuilder.Attributes.defaultInputHiddenAttributes
            |> Function.compose modifiers
            |> BodyBuilder.Attributes.inputHiddenAttributesToHtmlAttributes
        )
        []


{-| Generates a text input in the DOM. A text input is inline by default, but
changes its behavior when specifically set as block. You don't have to worry about
the display: use an inputText whenever you want, style like you want, it will adapt to
what you wrote.

    inlineTextInput : Node msg
    inlineTextInput =
        -- This produces an inline text input in the DOM.
        BodyBuilder.inputText [] []

    blockTextInput : Node msg
    blockTextInput =
        -- This produces a block text input in the DOM.
        BodyBuilder.inputText [ BodyBuilder.Attributes.style [ Style.block [] ] ] []

-}
inputText : Modifiers (InputTextAttributes msg) -> Node msg
inputText =
    inputAndLabel
        BodyBuilder.Attributes.defaultInputTextAttributes
        BodyBuilder.Attributes.inputTextAttributesToHtmlAttributes


{-| Generates a tel input in the DOM. A tel input is inline by default, but
changes its behavior when specifically set as block. You don't have to worry about
the display: use an inputTel whenever you want, style like you want, it will adapt to
what you wrote.

    inlineTelInput : Node msg
    inlineTelInput =
        -- This produces an inline tel input in the DOM.
        BodyBuilder.inputTel [] []

    blockTelInput : Node msg
    blockTelInput =
        -- This produces a block tel input in the DOM.
        BodyBuilder.inputTel [ BodyBuilder.Attributes.style [ Style.block [] ] ] []

-}
inputTel : Modifiers (InputTextAttributes msg) -> Node msg
inputTel =
    inputAndLabel
        BodyBuilder.Attributes.defaultInputTelAttributes
        BodyBuilder.Attributes.inputTextAttributesToHtmlAttributes


{-| Generates a password input in the DOM. A password input is inline by default, but
changes its behavior when specifically set as block. You don't have to worry about
the display: use an inputPassword whenever you want, style like you want, it will adapt to
what you wrote.

    inlinePasswordInput : Node msg
    inlinePasswordInput =
        -- This produces an inline password input in the DOM.
        BodyBuilder.inputPassword [] []

    blockPasswordInput : Node msg
    blockPasswordInput =
        -- This produces a block password input in the DOM.
        BodyBuilder.inputPassword [ BodyBuilder.Attributes.style [ Style.block [] ] ] []

-}
inputPassword : Modifiers (InputPasswordAttributes msg) -> Node msg
inputPassword =
    inputAndLabel
        BodyBuilder.Attributes.defaultInputPasswordAttributes
        BodyBuilder.Attributes.inputPasswordAttributesToHtmlAttributes


{-| Generates a range input in the DOM. A range input is inline by default, but
changes its behavior when specifically set as block. You don't have to worry about
the display: use an inputRange whenever you want, style like you want, it will adapt to
what you wrote.

    inlineRangeInput : Node msg
    inlineRangeInput =
        -- This produces an inline range input in the DOM.
        BodyBuilder.inputRange [] []

    blockRangeInput : Node msg
    blockRangeInput =
        -- This produces a block range input in the DOM.
        BodyBuilder.inputRange [ BodyBuilder.Attributes.style [ Style.block [] ] ] []

-}
inputRange : Modifiers (InputRangeAttributes msg) -> Node msg
inputRange =
    inputAndLabel
        BodyBuilder.Attributes.defaultInputRangeAttributes
        BodyBuilder.Attributes.inputRangeAttributesToHtmlAttributes


{-| Generates a number input in the DOM. A number input is inline by default, but
changes its behavior when specifically set as block. You don't have to worry about
the display: use an inputNumber whenever you want, style like you want, it will adapt to
what you wrote.

    inlineNumberInput : Node msg
    inlineNumberInput =
        -- This produces an inline number input in the DOM.
        BodyBuilder.inputNumber [] []

    blockNumberInput : Node msg
    blockNumberInput =
        -- This produces a block number input in the DOM.
        BodyBuilder.inputNumber [ BodyBuilder.Attributes.style [ Style.block [] ] ] []

-}
inputNumber : Modifiers (InputNumberAttributes msg) -> Node msg
inputNumber =
    inputAndLabel
        BodyBuilder.Attributes.defaultInputNumberAttributes
        BodyBuilder.Attributes.inputNumberAttributesToHtmlAttributes


{-| Generates a radio input in the DOM. A radio input is inline by default, but
changes its behavior when specifically set as block. You don't have to worry about
the display: use an inputRadio whenever you want, style like you want, it will adapt to
what you wrote.

    inlineRadioInput : Node msg
    inlineRadioInput =
        -- This produces an inline radio input in the DOM.
        BodyBuilder.inputRadio [] []

    blockRadioInput : Node msg
    blockRadioInput =
        -- This produces a block radio input in the DOM.
        BodyBuilder.inputRadio [ BodyBuilder.Attributes.style [ Style.block [] ] ] []

-}
inputRadio : Modifiers (InputRadioAttributes msg) -> Node msg
inputRadio =
    inputAndLabel
        BodyBuilder.Attributes.defaultInputRadioAttributes
        BodyBuilder.Attributes.inputRadioAttributesToHtmlAttributes


{-| Generates a checkbox input in the DOM. A checkbox input is inline by default, but
changes its behavior when specifically set as block. You don't have to worry about
the display: use an inputCheckbox whenever you want, style like you want, it will adapt to
what you wrote.

    inlineCheckboxInput : Node msg
    inlineCheckboxInput =
        -- This produces an inline checkbox input in the DOM.
        BodyBuilder.inputCheckbox [] []

    blockCheckboxInput : Node msg
    blockCheckboxInput =
        -- This produces a block checkbox input in the DOM.
        BodyBuilder.inputCheckbox [ BodyBuilder.Attributes.style [ Style.block [] ] ] []

-}
inputCheckbox : Modifiers (InputCheckboxAttributes msg) -> Node msg
inputCheckbox =
    inputAndLabel
        BodyBuilder.Attributes.defaultInputCheckboxAttributes
        BodyBuilder.Attributes.inputCheckboxAttributesToHtmlAttributes


{-| Generates a submit input in the DOM. A submit input is inline by default, but
changes its behavior when specifically set as block. You don't have to worry about
the display: use an inputSubmit whenever you want, style like you want, it will adapt to
what you wrote.

    inlineSubmitInput : Node msg
    inlineSubmitInput =
        -- This produces an inline submit input in the DOM.
        BodyBuilder.inputSubmit [] []

    blockSubmitInput : Node msg
    blockSubmitInput =
        -- This produces a block submit input in the DOM.
        BodyBuilder.inputSubmit [ BodyBuilder.Attributes.style [ Style.block [] ] ] []

-}
inputSubmit : Modifiers (InputSubmitAttributes msg) -> Node msg
inputSubmit =
    inputAndLabel
        BodyBuilder.Attributes.defaultInputSubmitAttributes
        BodyBuilder.Attributes.inputSubmitAttributesToHtmlAttributes


{-| Generates an url input in the DOM. An url input is inline by default, but
changes its behavior when specifically set as block. You don't have to worry about
the display: use an inputUrl whenever you want, style like you want, it will adapt to
what you wrote.

    inlineUrlInput : Node msg
    inlineUrlInput =
        -- This produces an inline url input in the DOM.
        BodyBuilder.inputUrl [] []

    blockUrlInput : Node msg
    blockUrlInput =
        -- This produces a block url input in the DOM.
        BodyBuilder.inputUrl [ BodyBuilder.Attributes.style [ Style.block [] ] ] []

-}
inputUrl : Modifiers (InputUrlAttributes msg) -> Node msg
inputUrl =
    inputAndLabel
        BodyBuilder.Attributes.defaultInputUrlAttributes
        BodyBuilder.Attributes.inputUrlAttributesToHtmlAttributes


{-| Generates a color input in the DOM. A color input is inline by default, but
changes its behavior when specifically set as block. You don't have to worry about
the display: use an inputColor whenever you want, style like you want, it will adapt to
what you wrote.

    inlineColorInput : Node msg
    inlineColorInput =
        -- This produces an inline color input in the DOM.
        BodyBuilder.inputColor [] []

    blockColorInput : Node msg
    blockColorInput =
        -- This produces a block color input in the DOM.
        BodyBuilder.inputColor [ BodyBuilder.Attributes.style [ Style.block [] ] ] []

-}
inputColor : Modifiers (InputColorAttributes msg) -> Node msg
inputColor =
    inputAndLabel
        BodyBuilder.Attributes.defaultInputColorAttributes
        BodyBuilder.Attributes.inputColorAttributesToHtmlAttributes


{-| Generates a file input in the DOM. A file input is inline by default, but
changes its behavior when specifically set as block. You don't have to worry about
the display: use an inputFile whenever you want, style like you want, it will adapt to
what you wrote.

    inlineFileInput : Node msg
    inlineFileInput =
        -- This produces an inline file input in the DOM.
        BodyBuilder.inputFile [] []

    blockFileInput : Node msg
    blockFileInput =
        -- This produces a block file input in the DOM.
        BodyBuilder.inputFile [ BodyBuilder.Attributes.style [ Style.block [] ] ] []

-}
inputFile : Modifiers (InputFileAttributes msg) -> Node msg
inputFile =
    inputAndLabel
        BodyBuilder.Attributes.defaultInputFileAttributes
        BodyBuilder.Attributes.inputFileAttributesToHtmlAttributes


{-| Generates a textarea in the DOM. A textarea is inline by default, but
changes its behavior when specifically set as block. You don't have to worry about
the display: use an textarea whenever you want, style like you want, it will adapt to
what you wrote.

    inlineTextarea : Node msg
    inlineTextarea =
        -- This produces an inline textarea in the DOM.
        BodyBuilder.textarea [] []

    blockTextarea : Node msg
    blockTextarea =
        -- This produces a block textarea in the DOM.
        BodyBuilder.textarea [ BodyBuilder.Attributes.style [ Style.block [] ] ] []

-}
textarea : Modifiers (TextareaAttributes msg) -> Node msg
textarea =
    commonBlockFlexlessChildlessNode
        "textarea"
        BodyBuilder.Attributes.defaultTextareaAttributes
        BodyBuilder.Attributes.textareaAttributesToHtmlAttributes


{-| Generates a select in the DOM. A select is inline by default, but
changes its behavior when specifically set as block. You don't have to worry about
the display: use a select whenever you want, style like you want, it will adapt to
what you wrote.

    inlineSelect : Node msg
    inlineSelect =
        -- This produces an inline select in the DOM.
        BodyBuilder.select [] []

    blockSelect : Node msg
    blockSelect =
        -- This produces a block select in the DOM.
        BodyBuilder.select [ BodyBuilder.Attributes.style [ Style.block [] ] ] []

-}
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


{-| Generates an option in the DOM. An option is only used inside select, and
constituted of to String: the value and the content. It can also be selected, or not.

    selectElement : Node msg
    selectElement =
        BodyBuilder.select []
            [ BodyBuilder.option "Paris" "We're in Paris!" True
            , BodyBuilder.option "London" "We're in London!" False
            , BodyBuilder.option "Berlin" "We're in Berlin!" False
            ]

-}
option : String -> String -> Bool -> Option msg
option value content selected =
    Option <|
        Html.option
            [ Html.Attributes.value value
            , Html.Attributes.selected selected
            ]
            [ Html.text content ]


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


{-| Generates an h1 in the DOM. An h1 is block, and can't be anything else.
You can add custom block style on it, but can't turn it inline.

    title : Node msg
    title =
        BodyBuilder.h1
            [ BodyBuilder.Attributes.style [ Style.blockProperties [] ] ]
            [ Html.text "I'm inside a title!" ]

-}
h1 : Modifiers (HeadingAttributes msg) -> List (Node msg) -> Node msg
h1 =
    heading "h1"


{-| Generates an h2 in the DOM. An h2 is block, and can't be anything else.
You can add custom block style on it, but can't turn it inline.

    title : Node msg
    title =
        BodyBuilder.h2
            [ BodyBuilder.Attributes.style [ Style.blockProperties [] ] ]
            [ Html.text "I'm inside a title!" ]

-}
h2 : Modifiers (HeadingAttributes msg) -> List (Node msg) -> Node msg
h2 =
    heading "h2"


{-| Generates an h3 in the DOM. An h3 is block, and can't be anything else.
You can add custom block style on it, but can't turn it inline.

    title : Node msg
    title =
        BodyBuilder.h3
            [ BodyBuilder.Attributes.style [ Style.blockProperties [] ] ]
            [ Html.text "I'm inside a title!" ]

-}
h3 : Modifiers (HeadingAttributes msg) -> List (Node msg) -> Node msg
h3 =
    heading "h3"


{-| Generates an h4 in the DOM. An h4 is block, and can't be anything else.
You can add custom block style on it, but can't turn it inline.

    title : Node msg
    title =
        BodyBuilder.h4
            [ BodyBuilder.Attributes.style [ Style.blockProperties [] ] ]
            [ Html.text "I'm inside a title!" ]

-}
h4 : Modifiers (HeadingAttributes msg) -> List (Node msg) -> Node msg
h4 =
    heading "h4"


{-| Generates an h5 in the DOM. An h5 is block, and can't be anything else.
You can add custom block style on it, but can't turn it inline.

    title : Node msg
    title =
        BodyBuilder.h5
            [ BodyBuilder.Attributes.style [ Style.blockProperties [] ] ]
            [ Html.text "I'm inside a title!" ]

-}
h5 : Modifiers (HeadingAttributes msg) -> List (Node msg) -> Node msg
h5 =
    heading "h5"


{-| Generates an h6 in the DOM. An h6 is block, and can't be anything else.
You can add custom block style on it, but can't turn it inline.

    title : Node msg
    title =
        BodyBuilder.h6
            [ BodyBuilder.Attributes.style [ Style.blockProperties [] ] ]
            [ Html.text "I'm inside a title!" ]

-}
h6 : Modifiers (HeadingAttributes msg) -> List (Node msg) -> Node msg
h6 =
    heading "h6"


{-| Generates a p in the DOM. A p is block, and can't be anything else.
You can add custom block style on it, but can't turn it inline.

    title : Node msg
    title =
        BodyBuilder.p
            [ BodyBuilder.Attributes.style [ Style.blockProperties [] ] ]
            [ Html.text "I'm inside a paragrah!" ]

-}
p : Modifiers (HeadingAttributes msg) -> List (Node msg) -> Node msg
p =
    heading "p"


{-| Represents the attributes for a block element, i.e. an element which can't be
anything else other than a block. This includes titles, paragraph, section, nav,
article, aside, footer, header and div. This element have to use `Style.blockProperties`
to set style on them.
-}
type alias BlockAttributes msg =
    HeadingAttributes msg


block :
    String
    -> Modifiers (HeadingAttributes msg)
    -> List (Node msg)
    -> Node msg
block =
    heading


{-| For backward compatibilty. It behaves like div in Html.
-}
div : Modifiers (BlockAttributes msg) -> List (Node msg) -> Node msg
div =
    block "div"


{-| Generates the corresponding section in the DOM. This is used mainly to respect
the HTML semantic and for accessibility.
-}
section : Modifiers (BlockAttributes msg) -> List (Node msg) -> Node msg
section =
    block "section"


{-| Generates the corresponding nav in the DOM. This is used mainly to respect
the HTML semantic and for accessibility.
-}
nav : Modifiers (BlockAttributes msg) -> List (Node msg) -> Node msg
nav =
    block "nav"


{-| Generates the corresponding article in the DOM. This is used mainly to respect
the HTML semantic and for accessibility.
-}
article : Modifiers (BlockAttributes msg) -> List (Node msg) -> Node msg
article =
    block "article"


{-| Generates the corresponding aside in the DOM. This is used mainly to respect
the HTML semantic and for accessibility.
-}
aside : Modifiers (BlockAttributes msg) -> List (Node msg) -> Node msg
aside =
    block "aside"


{-| Generates the corresponding footer in the DOM. This is used mainly to respect
the HTML semantic and for accessibility.
-}
footer : Modifiers (BlockAttributes msg) -> List (Node msg) -> Node msg
footer =
    block "footer"


{-| Generates the corresponding header in the DOM. This is used mainly to respect
the HTML semantic and for accessibility.
-}
header : Modifiers (BlockAttributes msg) -> List (Node msg) -> Node msg
header =
    block "header"



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
            Function.compose modifiers
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
                    |> Function.flip (::) (attributesToHtmlAttributes attributes)
                )
                []
    in
    case attributes.label of
        Nothing ->
            computedInput

        Just label ->
            Shared.extractLabel label computedInput


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
            Function.compose modifiers
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
            |> Function.flip (::) (attributesToHtmlAttributes attributes)
        )
        content
