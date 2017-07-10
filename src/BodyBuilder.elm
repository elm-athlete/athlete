module BodyBuilder exposing (..)

import Elegant exposing (Style)
import Html
import Function exposing (..)
import BodyBuilderHtml exposing (HtmlAttributes)
import Color exposing (Color)
import Color.Convert as Color
import Maybe.Extra as Maybe


unwrap : (a -> b -> b) -> Maybe a -> b -> b
unwrap =
    Maybe.unwrap identity


type Interactive
    = Interactive


type NotInteractive
    = NotInteractive


type Phrasing
    = Phrasing


type NotPhrasing
    = NotPhrasing


type Spanning
    = Spanning


type NotSpanning
    = NotSpanning


type InsideHeading
    = InsideHeading


type OutsideHeading
    = OutsideHeading


type ListElement
    = ListElement


type NotListElement
    = NotListElement


type alias OnMouseEventsInside msg =
    { click : Maybe msg
    , doubleClick : Maybe msg
    , mouseDown : Maybe msg
    , mouseUp : Maybe msg
    , mouseEnter : Maybe msg
    , mouseLeave : Maybe msg
    , mouseOver : Maybe msg
    , mouseOut : Maybe msg
    }


defaultOnMouseEvents : OnMouseEventsInside msg
defaultOnMouseEvents =
    OnMouseEventsInside Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing


type alias OnMouseEvents msg a =
    { a | onMouseEvents : OnMouseEventsInside msg }


type alias VisibleAttributes a =
    { a | visible : VisibleAttributesInside }


type alias VisibleAttributesInside =
    ClassAttribute (StyleAttribute (IdAttribute {}))


type alias VisibleAttributesAndEvents msg a =
    OnMouseEvents msg (VisibleAttributes a)


defaultVisibleAttributes : VisibleAttributesInside
defaultVisibleAttributes =
    { class = [], id = Nothing, style = [], hoverStyle = [] }


type alias StyleAttribute a =
    { a
        | style : List (Style -> Style)
        , hoverStyle : List (Style -> Style)
    }


type alias IdAttribute a =
    { a | id : Maybe String }


type alias ClassAttribute a =
    { a | class : List String }


type alias TargetAttribute a =
    { a | target : Maybe String }


type alias Url =
    String


type alias HrefAttribute a =
    { a | href : Maybe Url }


type alias Hlah a =
    { a | value : Int }


type alias SrcAttribute a =
    { a | src : String }


type alias AltAttribute a =
    { a | alt : String }


type alias ValueAttribute b a =
    { a | value : Maybe b }


type alias NameAttribute a =
    { a | name : Maybe String }


type alias AAttributes msg =
    TargetAttribute (HrefAttribute (VisibleAttributesAndEvents msg {}))


type alias FlowAttributes msg =
    VisibleAttributesAndEvents msg {}


type alias ImgAttributes msg =
    AltAttribute (SrcAttribute (VisibleAttributesAndEvents msg {}))


type alias IframeAttributes msg =
    SrcAttribute (VisibleAttributesAndEvents msg {})


type alias StringValue a =
    ValueAttribute String a


type alias IntValue a =
    ValueAttribute Int a


type alias ColorValue a =
    ValueAttribute Color a


type alias InputAttributes a =
    NameAttribute { a | type_ : String }


type alias InputHiddenAttributes =
    InputAttributes (StringValue { visible : ClassAttribute (IdAttribute {}), type_ : String })


type alias InputVisibleAttributes msg a =
    VisibleAttributesAndEvents msg (InputAttributes a)


type alias InputTextAttributes msg a =
    StringValue (InputVisibleAttributes msg a)


type alias TextareaAttributes msg =
    NameAttribute (StringValue (VisibleAttributesAndEvents msg {}))


type alias ButtonAttributes msg a =
    VisibleAttributesAndEvents msg a


type alias InputNumberAttributes msg =
    IntValue (InputVisibleAttributes msg {})


type alias InputSliderAttributes msg =
    InputNumberAttributes msg


type alias InputColorAttributes msg =
    ColorValue (InputVisibleAttributes msg {})


type alias InputCheckboxAttributes msg =
    InputTextAttributes msg { checked : Bool }


type alias InputFileAttributes msg =
    InputVisibleAttributes msg {}


type alias InputPasswordAttributes msg =
    InputTextAttributes msg {}


type alias InputRadioAttributes msg =
    InputTextAttributes msg {}


type alias InputRangeAttributes msg =
    InputNumberAttributes msg


type alias InputSubmitAttributes msg =
    ButtonAttributes msg { type_ : String }


type alias InputUrlAttributes msg =
    InputTextAttributes msg {}


type alias SelectAttributes msg =
    StringValue (OptionsAttribute (VisibleAttributesAndEvents msg {}))


type alias OptionsAttribute a =
    { a | options : List { value : String, label : String } }


type alias ProgressAttributes msg =
    VisibleAttributesAndEvents msg {}


type alias AudioAttributes msg =
    VisibleAttributesAndEvents msg {}


type alias VideoAttributes msg =
    VisibleAttributesAndEvents msg {}


type alias CanvasAttributes msg =
    VisibleAttributesAndEvents msg {}


type Never
    = Never


type Node interactiveContent phrasingContent spanningContent listContent msg
    = A (AAttributes msg) (List (Node NotInteractive phrasingContent spanningContent NotListElement msg))
    | Div (FlowAttributes msg) (List (Node interactiveContent phrasingContent Spanning NotListElement msg))
    | P (FlowAttributes msg) (List (Node interactiveContent Phrasing Spanning NotListElement msg))
    | Span (FlowAttributes msg) (List (Node interactiveContent Phrasing NotSpanning NotListElement msg))
    | H Int (FlowAttributes msg) (List (Node interactiveContent Phrasing Spanning NotListElement msg))
    | Ul (FlowAttributes msg) (List (Node interactiveContent phrasingContent spanningContent ListElement msg))
    | Ol (FlowAttributes msg) (List (Node interactiveContent phrasingContent spanningContent ListElement msg))
    | Li (FlowAttributes msg) (List (Node interactiveContent phrasingContent spanningContent NotListElement msg))
    | Br (FlowAttributes msg)
    | Table (List (Node interactiveContent phrasingContent spanningContent listContent msg)) (List (List (Node interactiveContent phrasingContent spanningContent NotListElement msg)))
    | Button (ButtonAttributes msg {}) (List (Node NotInteractive phrasingContent spanningContent NotListElement msg))
    | Progress (ProgressAttributes msg)
    | Audio (AudioAttributes msg)
    | Video (VideoAttributes msg)
    | Img (ImgAttributes msg)
    | Canvas (CanvasAttributes msg)
    | Textarea (TextareaAttributes msg)
    | InputHidden InputHiddenAttributes
    | InputText (InputTextAttributes msg {})
    | InputNumber (InputNumberAttributes msg)
    | InputSlider (InputSliderAttributes msg)
    | InputColor (InputColorAttributes msg)
    | InputCheckbox (InputCheckboxAttributes msg)
    | InputFile (InputFileAttributes msg)
    | InputPassword (InputPasswordAttributes msg)
    | InputRadio (InputRadioAttributes msg)
    | InputRange (InputRangeAttributes msg)
    | InputSubmit (InputSubmitAttributes msg)
    | InputUrl (InputUrlAttributes msg)
    | Select (SelectAttributes msg)
    | Text String


defaultsComposedToAttrs : a -> List (a -> a) -> a
defaultsComposedToAttrs defaults attrs =
    (defaults |> (attrs |> compose))


flowDefaultsComposedToAttrs :
    List
        ({ visible : VisibleAttributesInside
         , onMouseEvents : OnMouseEventsInside msg
         }
         ->
            { visible : VisibleAttributesInside
            , onMouseEvents : OnMouseEventsInside msg
            }
        )
    ->
        { visible : VisibleAttributesInside
        , onMouseEvents : OnMouseEventsInside msg
        }
flowDefaultsComposedToAttrs =
    defaultsComposedToAttrs { visible = defaultVisibleAttributes, onMouseEvents = defaultOnMouseEvents }


h1 : List (FlowAttributes msg -> FlowAttributes msg) -> List (Node interactiveContent Phrasing Spanning NotListElement msg) -> Node interactiveContent NotPhrasing Spanning NotListElement msg
h1 =
    H 1 << flowDefaultsComposedToAttrs


h2 : List (FlowAttributes msg -> FlowAttributes msg) -> List (Node interactiveContent Phrasing Spanning NotListElement msg) -> Node interactiveContent NotPhrasing Spanning NotListElement msg
h2 =
    H 2 << flowDefaultsComposedToAttrs


h3 : List (FlowAttributes msg -> FlowAttributes msg) -> List (Node interactiveContent Phrasing Spanning NotListElement msg) -> Node interactiveContent NotPhrasing Spanning NotListElement msg
h3 =
    H 3 << flowDefaultsComposedToAttrs


h4 : List (FlowAttributes msg -> FlowAttributes msg) -> List (Node interactiveContent Phrasing Spanning NotListElement msg) -> Node interactiveContent NotPhrasing Spanning NotListElement msg
h4 =
    H 4 << flowDefaultsComposedToAttrs


h5 : List (FlowAttributes msg -> FlowAttributes msg) -> List (Node interactiveContent Phrasing Spanning NotListElement msg) -> Node interactiveContent NotPhrasing Spanning NotListElement msg
h5 =
    H 5 << flowDefaultsComposedToAttrs


h6 : List (FlowAttributes msg -> FlowAttributes msg) -> List (Node interactiveContent Phrasing Spanning NotListElement msg) -> Node interactiveContent NotPhrasing Spanning NotListElement msg
h6 =
    H 6 << flowDefaultsComposedToAttrs


a : List (AAttributes msg -> AAttributes msg) -> List (Node NotInteractive phrasingContent spanningContent NotListElement msg) -> Node Interactive phrasingContent spanningContent NotListElement msg
a =
    A << defaultsComposedToAttrs { href = Nothing, target = Nothing, visible = defaultVisibleAttributes, onMouseEvents = defaultOnMouseEvents }


button : List (ButtonAttributes msg {} -> ButtonAttributes msg {}) -> List (Node NotInteractive phrasingContent spanningContent NotListElement msg) -> Node Interactive phrasingContent spanningContent NotListElement msg
button =
    Button << defaultsComposedToAttrs { visible = defaultVisibleAttributes, onMouseEvents = defaultOnMouseEvents }


div : List (FlowAttributes msg -> FlowAttributes msg) -> List (Node interactiveContent phrasingContent Spanning NotListElement msg) -> Node interactiveContent phrasingContent Spanning NotListElement msg
div =
    Div << flowDefaultsComposedToAttrs


ul : List (FlowAttributes msg -> FlowAttributes msg) -> List (Node interactiveContent phrasingContent Spanning ListElement msg) -> Node interactiveContent phrasingContent Spanning NotListElement msg
ul =
    Ul << flowDefaultsComposedToAttrs


ol : List (FlowAttributes msg -> FlowAttributes msg) -> List (Node interactiveContent phrasingContent Spanning ListElement msg) -> Node interactiveContent phrasingContent Spanning NotListElement msg
ol =
    Ol << flowDefaultsComposedToAttrs


li : List (FlowAttributes msg -> FlowAttributes msg) -> List (Node interactiveContent phrasingContent Spanning NotListElement msg) -> Node interactiveContent phrasingContent Spanning ListElement msg
li =
    Li << flowDefaultsComposedToAttrs


p : List (FlowAttributes msg -> FlowAttributes msg) -> List (Node interactiveContent Phrasing Spanning NotListElement msg) -> Node interactiveContent NotPhrasing spanningContent NotListElement msg
p =
    P << flowDefaultsComposedToAttrs


br : List (FlowAttributes msg -> FlowAttributes msg) -> Node interactiveContent Phrasing spanningContent NotListElement msg
br =
    Br << flowDefaultsComposedToAttrs


span : List (FlowAttributes msg -> FlowAttributes msg) -> List (Node interactiveContent Phrasing NotSpanning NotListElement msg) -> Node interactiveContent phrasingContent spanningContent NotListElement msg
span =
    Span << flowDefaultsComposedToAttrs


textarea : List (TextareaAttributes msg -> TextareaAttributes msg) -> Node Interactive phrasingContent spanningContent NotListElement msg
textarea =
    Textarea << defaultsComposedToAttrs { value = Nothing, name = Nothing, visible = defaultVisibleAttributes, onMouseEvents = defaultOnMouseEvents }


img : String -> String -> List (ImgAttributes msg -> ImgAttributes msg) -> Node interactiveContent phrasingContent spanningContent NotListElement msg
img alt src =
    Img << defaultsComposedToAttrs { src = src, alt = alt, visible = defaultVisibleAttributes, onMouseEvents = defaultOnMouseEvents }


audio : List (AudioAttributes msg -> AudioAttributes msg) -> Node Interactive phrasingContent spanningContent NotListElement msg
audio =
    Audio << defaultsComposedToAttrs { visible = defaultVisibleAttributes, onMouseEvents = defaultOnMouseEvents }


progress : List (ProgressAttributes msg -> ProgressAttributes msg) -> Node Interactive phrasingContent spanningContent NotListElement msg
progress =
    Progress << defaultsComposedToAttrs { visible = defaultVisibleAttributes, onMouseEvents = defaultOnMouseEvents }


table :
    List (Node interactiveContent phrasingContent spanningContent NotListElement msg)
    -> List (List (Node interactiveContent phrasingContent spanningContent NotListElement msg))
    -> Node interactiveContent phrasingContent spanningContent NotListElement msg
table =
    Table


text : String -> Node interactiveContent phrasingContent spanningContent NotListElement msg
text =
    Text


node :
    List (FlowAttributes msg -> FlowAttributes msg)
    -> List (Node interactiveContent phrasingContent Spanning NotListElement msg)
    -> Node interactiveContent phrasingContent Spanning NotListElement msg
node =
    div


leaf :
    List (FlowAttributes msg -> FlowAttributes msg)
    -> Node interactiveContent phrasingContent Spanning NotListElement msg
leaf =
    flip node []


container :
    List (Node interactiveContent phrasingContent Spanning NotListElement msg)
    -> Node interactiveContent phrasingContent Spanning NotListElement msg
container =
    node []


mapLis :
    List (Node interactiveContent phrasingContent Spanning NotListElement msg)
    -> List (Node interactiveContent phrasingContent Spanning ListElement msg)
mapLis =
    List.map (\content -> li [] [ content ])


olLi :
    List (FlowAttributes msg -> FlowAttributes msg)
    -> List (Node interactiveContent phrasingContent Spanning NotListElement msg)
    -> Node interactiveContent phrasingContent Spanning NotListElement msg
olLi attributes insideLis =
    ol attributes (mapLis insideLis)


ulLi :
    List (FlowAttributes msg -> FlowAttributes msg)
    -> List (Node interactiveContent phrasingContent Spanning NotListElement msg)
    -> Node interactiveContent phrasingContent Spanning NotListElement msg
ulLi attributes insideLis =
    ul attributes (mapLis insideLis)


inputHidden :
    List (InputHiddenAttributes -> InputHiddenAttributes)
    -> Node interactiveContent phrasingContent spanningContent listContent msg
inputHidden =
    InputHidden << defaultsComposedToAttrs { name = Nothing, visible = { class = [], id = Nothing }, type_ = "hidden", value = Nothing }


baseInputAttributes : String -> InputVisibleAttributes msg (ValueAttribute a {})
baseInputAttributes type_ =
    { visible = defaultVisibleAttributes
    , name = Nothing
    , type_ = type_
    , value = Nothing
    , onMouseEvents = defaultOnMouseEvents
    }


inputText :
    List (InputTextAttributes msg {} -> InputTextAttributes msg {})
    -> Node interactiveContent phrasingContent spanningContent listContent msg
inputText =
    InputText << defaultsComposedToAttrs (baseInputAttributes "text")


inputNumber :
    List (InputNumberAttributes msg -> InputNumberAttributes msg)
    -> Node interactiveContent phrasingContent spanningContent listContent msg
inputNumber =
    InputNumber << defaultsComposedToAttrs (baseInputAttributes "number")


inputSlider :
    List (InputSliderAttributes msg -> InputSliderAttributes msg)
    -> Node interactiveContent phrasingContent spanningContent listContent msg
inputSlider =
    InputSlider << defaultsComposedToAttrs (baseInputAttributes "range")


inputColor :
    List (InputColorAttributes msg -> InputColorAttributes msg)
    -> Node interactiveContent phrasingContent spanningContent listContent msg
inputColor =
    InputColor << defaultsComposedToAttrs (baseInputAttributes "color")


inputCheckbox :
    List (InputCheckboxAttributes msg -> InputCheckboxAttributes msg)
    -> Node interactiveContent phrasingContent spanningContent listContent msg
inputCheckbox =
    InputCheckbox << defaultsComposedToAttrs { name = Nothing, type_ = "checkbox", value = Nothing, checked = False, visible = defaultVisibleAttributes, onMouseEvents = defaultOnMouseEvents }


inputFile :
    List (InputFileAttributes msg -> InputFileAttributes msg)
    -> Node interactiveContent phrasingContent spanningContent listContent msg
inputFile =
    InputFile << defaultsComposedToAttrs { name = Nothing, type_ = "file", visible = defaultVisibleAttributes, onMouseEvents = defaultOnMouseEvents }


inputPassword :
    List (InputPasswordAttributes msg -> InputPasswordAttributes msg)
    -> Node interactiveContent phrasingContent spanningContent listContent msg
inputPassword =
    InputPassword << defaultsComposedToAttrs { name = Nothing, type_ = "password", value = Nothing, visible = defaultVisibleAttributes, onMouseEvents = defaultOnMouseEvents }


inputRadio :
    List (InputRadioAttributes msg -> InputRadioAttributes msg)
    -> Node interactiveContent phrasingContent spanningContent listContent msg
inputRadio =
    InputRadio << defaultsComposedToAttrs { name = Nothing, type_ = "radio", value = Nothing, visible = defaultVisibleAttributes, onMouseEvents = defaultOnMouseEvents }


inputRange :
    List (InputRangeAttributes msg -> InputRangeAttributes msg)
    -> Node interactiveContent phrasingContent spanningContent listContent msg
inputRange =
    InputRange << defaultsComposedToAttrs { name = Nothing, type_ = "range", value = Nothing, visible = defaultVisibleAttributes, onMouseEvents = defaultOnMouseEvents }


inputSubmit :
    List (InputSubmitAttributes msg -> InputSubmitAttributes msg)
    -> Node interactiveContent phrasingContent spanningContent listContent msg
inputSubmit =
    InputSubmit << defaultsComposedToAttrs { type_ = "submit", visible = defaultVisibleAttributes, onMouseEvents = defaultOnMouseEvents }


inputUrl :
    List (InputUrlAttributes msg -> InputUrlAttributes msg)
    -> Node interactiveContent phrasingContent spanningContent listContent msg
inputUrl =
    InputUrl << defaultsComposedToAttrs { name = Nothing, value = Nothing, type_ = "url", visible = defaultVisibleAttributes, onMouseEvents = defaultOnMouseEvents }


select :
    List (SelectAttributes msg -> SelectAttributes msg)
    -> Node interactiveContent phrasingContent spanningContent listContent msg
select list =
    (Select << defaultsComposedToAttrs { value = Nothing, options = [], visible = defaultVisibleAttributes, onMouseEvents = defaultOnMouseEvents }) list


options :
    List { value : String, label : String }
    -> OptionsAttribute a
    -> OptionsAttribute a
options val attrs =
    { attrs | options = val }


option : String -> String -> { label : String, value : String }
option value label =
    { value = value
    , label = label
    }


selectedOption : String -> StringValue a -> StringValue a
selectedOption val attrs =
    { attrs | value = Just val }


href : String -> HrefAttribute a -> HrefAttribute a
href val attrs =
    { attrs | href = Just val }


value : a -> ValueAttribute a b -> ValueAttribute a b
value val attrs =
    { attrs | value = Just val }


checked : { a | checked : Bool } -> { a | checked : Bool }
checked attrs =
    { attrs | checked = True }


id :
    String
    -> { a | visible : { b | id : Maybe String } }
    -> { a | visible : { b | id : Maybe String } }
id val ({ visible } as attrs) =
    let
        newId =
            { visible | id = Just val }
    in
        { attrs | visible = newId }


class :
    List String
    -> { a | visible : { b | class : List String } }
    -> { a | visible : { b | class : List String } }
class val ({ visible } as attrs) =
    let
        newClass =
            { visible | class = val }
    in
        { attrs | visible = newClass }


style :
    List (Style -> Style)
    -> { a | visible : { b | style : List (Style -> Style) } }
    -> { a | visible : { b | style : List (Style -> Style) } }
style val ({ visible } as attrs) =
    let
        newStyle =
            { visible | style = val }
    in
        { attrs | visible = newStyle }


hoverStyle :
    List (Style -> Style)
    -> { a | visible : { b | hoverStyle : List (Style -> Style) } }
    -> { a | visible : { b | hoverStyle : List (Style -> Style) } }
hoverStyle val ({ visible } as attrs) =
    let
        newHoverStyle =
            { visible | hoverStyle = val }
    in
        { attrs | visible = newHoverStyle }


target : String -> TargetAttribute a -> TargetAttribute a
target val attrs =
    { attrs | target = Just val }


name : String -> NameAttribute a -> NameAttribute a
name val attrs =
    { attrs | name = Just val }


handleHref :
    { a | href : Maybe String }
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleHref { href } =
    href |> Maybe.unwrap identity BodyBuilderHtml.href


handleStyle :
    { a | visible : VisibleAttributesInside }
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleStyle { visible } =
    let
        { style, hoverStyle } =
            visible
    in
        BodyBuilderHtml.style style
            << BodyBuilderHtml.hoverStyle hoverStyle


handleMouseEvents :
    { a | onMouseEvents : OnMouseEventsInside msg }
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleMouseEvents { onMouseEvents } =
    let
        { click, doubleClick, mouseUp, mouseOut, mouseOver, mouseDown, mouseLeave, mouseEnter } =
            onMouseEvents
    in
        unwrap BodyBuilderHtml.onClick click
            >> unwrap BodyBuilderHtml.onDoubleClick doubleClick
            >> unwrap BodyBuilderHtml.onMouseUp mouseUp
            >> unwrap BodyBuilderHtml.onMouseOut mouseOut
            >> unwrap BodyBuilderHtml.onMouseOver mouseOver
            >> unwrap BodyBuilderHtml.onMouseDown mouseDown
            >> unwrap BodyBuilderHtml.onMouseLeave mouseLeave
            >> unwrap BodyBuilderHtml.onMouseEnter mouseEnter


handleSrc : { a | src : String } -> HtmlAttributes msg -> HtmlAttributes msg
handleSrc { src } =
    BodyBuilderHtml.src src


handleAlt : { a | alt : String } -> HtmlAttributes msg -> HtmlAttributes msg
handleAlt { alt } =
    BodyBuilderHtml.alt alt


handleClass : { a | visible : { b | class : List String } } -> HtmlAttributes msg -> HtmlAttributes msg
handleClass { visible } =
    BodyBuilderHtml.class visible.class


handleId : { a | visible : { b | id : Maybe String } } -> HtmlAttributes msg -> HtmlAttributes msg
handleId { visible } =
    unwrap BodyBuilderHtml.id visible.id


handleType : { a | type_ : String } -> HtmlAttributes msg -> HtmlAttributes msg
handleType { type_ } =
    BodyBuilderHtml.type_ type_


handleStringValue :
    { a | value : Maybe String }
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleStringValue { value } =
    BodyBuilderHtml.value value


handleIntValue :
    { a | value : Maybe Int }
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleIntValue { value } =
    value
        |> Maybe.map toString
        |> BodyBuilderHtml.value


handleColorValue :
    { b | value : Maybe Color }
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleColorValue { value } =
    value
        |> Maybe.map Color.colorToHex
        |> BodyBuilderHtml.value


handleName : { a | name : Maybe String } -> HtmlAttributes msg -> HtmlAttributes msg
handleName { name } =
    case name of
        Nothing ->
            identity

        Just name_ ->
            BodyBuilderHtml.name name_


handleOptions :
    OptionsAttribute a
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleOptions { options } =
    BodyBuilderHtml.content (List.map optionsToBodyBuilderHtml options)


optionsToBodyBuilderHtml : { label : String, value : String } -> HtmlAttributes msg
optionsToBodyBuilderHtml { value, label } =
    BodyBuilderHtml.node
        [ BodyBuilderHtml.tag "option"
        , BodyBuilderHtml.value (Just value)
        ]
        [ BodyBuilderHtml.text label ]


handleSelectedOptions :
    StringValue a
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleSelectedOptions { value } =
    BodyBuilderHtml.selectOption value


handleChecked :
    { a | checked : Bool }
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleChecked { checked } =
    BodyBuilderHtml.checked checked


handleTarget :
    { a | target : Maybe String }
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleTarget { target } =
    unwrap BodyBuilderHtml.target target


handleContent :
    { a | value : Maybe String }
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleContent { value } =
    unwrap setTextareaValue value


setTextareaValue :
    String
    -> HtmlAttributes msg
    -> HtmlAttributes msg
setTextareaValue value =
    BodyBuilderHtml.value (Just value)
        >> BodyBuilderHtml.content [ BodyBuilderHtml.text value ]


buildNode :
    List (Node interactiveContent phrasingContent spanningContent listContent msg)
    -> attributes
    -> String
    -> List (attributes -> HtmlAttributes msg -> HtmlAttributes msg)
    -> HtmlAttributes msg
buildNode children attributes tag usedBodyToBodyHtmlFunctions =
    let
        newAttrs =
            usedBodyToBodyHtmlFunctions |> List.map (\fun -> fun attributes)
    in
        BodyBuilderHtml.node ([ BodyBuilderHtml.tag tag ] |> List.append newAttrs) (List.map (\x -> toTree x) children)


parentToHtml :
    List (Node interactiveContent phrasingContent spanningContent listContent msg)
    -> attributes
    -> String
    -> List (attributes -> HtmlAttributes msg -> HtmlAttributes msg)
    -> HtmlAttributes msg
parentToHtml =
    buildNode


childToHtml :
    attributes
    -> String
    -> List (attributes -> HtmlAttributes msg -> HtmlAttributes msg)
    -> HtmlAttributes msg
childToHtml attributes =
    buildNode [] attributes


baseHandling : List (VisibleAttributesAndEvents msg a -> HtmlAttributes msg -> HtmlAttributes msg)
baseHandling =
    [ handleStyle, handleClass, handleId ]


inputAttributesHandling : List (NameAttribute (VisibleAttributesAndEvents msg { a | type_ : String }) -> HtmlAttributes msg -> HtmlAttributes msg)
inputAttributesHandling =
    List.append baseHandling [ handleType, handleName ]


toTree : Node interactiveContent phrasingContent spanningContent listContent msg -> BodyBuilderHtml.HtmlAttributes msg
toTree node =
    case node of
        A attributes children ->
            parentToHtml children attributes "a" (baseHandling |> List.append [ handleHref, handleTarget ])

        Ul attributes children ->
            parentToHtml children attributes "ul" baseHandling

        Ol attributes children ->
            parentToHtml children attributes "ol" baseHandling

        Li attributes children ->
            parentToHtml children attributes "li" baseHandling

        Div attributes children ->
            parentToHtml children attributes "div" baseHandling

        P attributes children ->
            parentToHtml children attributes "p" baseHandling

        Span attributes children ->
            parentToHtml children attributes "span" baseHandling

        H number attributes children ->
            parentToHtml children attributes ("h" ++ (number |> toString)) baseHandling

        Img attributes ->
            childToHtml attributes "img" (baseHandling |> List.append [ handleSrc, handleAlt ])

        Button attributes children ->
            parentToHtml children attributes "button" baseHandling

        Text str ->
            BodyBuilderHtml.text str

        Br attributes ->
            childToHtml attributes "br" baseHandling

        Table _ _ ->
            -- TODO
            BodyBuilderHtml.none

        Progress attributes ->
            childToHtml attributes "progress" baseHandling

        Audio attributes ->
            childToHtml attributes "audio" baseHandling

        Video attributes ->
            childToHtml attributes "video" baseHandling

        Canvas attributes ->
            childToHtml attributes "canvas" baseHandling

        InputHidden attributes ->
            childToHtml attributes "input" [ handleStringValue, handleName, handleClass, handleId ]

        Textarea attributes ->
            childToHtml attributes "textarea" (baseHandling |> List.append [ handleName, handleContent ])

        InputText attributes ->
            childToHtml attributes "input" (inputAttributesHandling |> List.append [ handleStringValue ])

        InputNumber attributes ->
            childToHtml attributes "input" (inputAttributesHandling |> List.append [ handleIntValue ])

        InputSlider attributes ->
            childToHtml attributes "input" (inputAttributesHandling |> List.append [ handleIntValue ])

        InputColor attributes ->
            childToHtml attributes "input" (inputAttributesHandling |> List.append [ handleColorValue ])

        InputCheckbox attributes ->
            childToHtml attributes "input" (inputAttributesHandling |> List.append [ handleChecked ])

        InputFile attributes ->
            childToHtml attributes "input" (inputAttributesHandling)

        InputPassword attributes ->
            childToHtml attributes "input" (inputAttributesHandling |> List.append [ handleStringValue ])

        InputRadio attributes ->
            childToHtml attributes "input" (inputAttributesHandling |> List.append [ handleStringValue ])

        InputRange attributes ->
            childToHtml attributes "input" (inputAttributesHandling |> List.append [ handleIntValue ])

        InputSubmit attributes ->
            childToHtml attributes "button" (baseHandling |> List.append [ handleType ])

        InputUrl attributes ->
            childToHtml attributes "input" (inputAttributesHandling |> List.append [ handleStringValue ])

        Select attributes ->
            childToHtml attributes
                "select"
                (baseHandling
                    |> List.append
                        [ handleOptions
                        , handleSelectedOptions
                        ]
                )


toHtml :
    Node interactiveContent phrasingContent spanningContent listContent msg
    -> Html.Html msg
toHtml node =
    node
        |> toTree
        |> BodyBuilderHtml.view


type alias BodyBuilderProgramArgs model a b c msg =
    { init : ( model, Cmd msg )
    , subscriptions : model -> Sub msg
    , update : msg -> model -> ( model, Cmd msg )
    , view : model -> Node a b c NotListElement msg
    }


program : BodyBuilderProgramArgs model a b c msg -> Program Basics.Never model msg
program { init, update, subscriptions, view } =
    Html.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = toHtml << view
        }


blah : Node Interactive NotPhrasing Spanning NotListElement msg
blah =
    div
        [ style
            [ Elegant.width (Elegant.Px 300)
            , Elegant.marginAuto
            ]
        ]
        [ a
            [ style [ Elegant.textColor Color.grey ]
            , href "https://github.com"
            , class [ "toto" ]

            -- , onClick Click
            , id "titi"
            , target "_blank"
            ]
            [ container
                [ container
                    [ h1
                        [ style [ Elegant.textColor Color.green ]
                        , hoverStyle [ Elegant.textColor Color.red ]
                        ]
                        [ span [] [ text "Toto" ]
                        , span [] [ img "alt" "toto" [] ]
                        , table [ container [ span [] [] ] ] [ [ leaf [] ], [ leaf [] ] ]
                        ]
                    ]
                ]
            , olLi []
                [ p [] [ text "First li in olLi" ]
                , p [] [ text "Second li in olLi", br [], text "Line breaking" ]
                ]
            , ulLi []
                [ p [] [ text "First li in ulLi" ]
                , text "Second li in ulLi"
                ]
            , ul []
                [ li [] [ text "First li in ul" ]
                , li [] [ text "Second li in ul" ]
                ]
            , ol []
                [ li [] [ text "First li in ol" ]
                , li [] [ text "Second li in ol" ]
                ]
            ]
        , inputHidden [ name "inputHidden", value "inputHidden_", class [ "class" ], id "id" ]
        , inputText [ style [ Elegant.displayBlock ], name "inputText", value "inputText_", class [ "class" ], id "id" ]
        , inputNumber [ style [ Elegant.displayBlock ], name "inputNumber", value 12, class [ "class" ], id "id" ]
        , inputSlider [ style [ Elegant.displayBlock ], name "inputSlider", value 12, class [ "class" ], id "id" ]
        , inputColor [ style [ Elegant.displayBlock ], name "inputSlider", value Color.yellow, class [ "class" ], id "id" ]
        , inputCheckbox [ style [ Elegant.displayBlock ], name "inputSlider", value "test", class [ "class" ], id "id", checked ]
        , inputCheckbox [ style [ Elegant.displayBlock ], name "inputSlider", value "test", class [ "class" ], id "id" ]
        , inputFile [ style [ Elegant.displayBlock ], name "inputSlider", class [ "class" ], id "id" ]
        , inputPassword [ style [ Elegant.displayBlock ], name "inputSlider", value "", class [ "class" ], id "id" ]
        , inputRadio [ style [ Elegant.displayBlock ], name "inputSlider", value "Test", class [ "class" ], id "id" ]
        , inputSlider [ style [ Elegant.displayBlock ], name "inputSlider", value 15, class [ "class" ], id "id" ]
        , inputSubmit [ style [ Elegant.displayBlock ], class [ "class" ], id "id" ]
        , inputUrl [ style [ Elegant.displayBlock ], class [ "class" ], id "id", name "inputUrl", value "" ]
        , select
            [ options
                [ option "value" "label"
                , option "value2" "label2"
                ]
            , selectedOption "value2"
            ]
        , button [] [ text "toto" ]
        ]


main : Html.Html msg
main =
    toHtml blah
