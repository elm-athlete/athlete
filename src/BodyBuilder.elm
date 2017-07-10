module BodyBuilder exposing (..)

import Elegant exposing (Style)
import Html
import Function exposing (..)
import BodyBuilderHtml exposing (HtmlAttributes)
import Color exposing (Color)
import Color.Convert as Color
import Maybe.Extra as Maybe


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


type alias OnMouseEnter msg a =
    { a | onMouseEnter : Maybe msg }


type alias OnClick msg a =
    { a | onClick : Maybe msg }


type alias VisibleAttributes msg a =
    OnMouseEnter msg (OnClick msg (ClassAttribute (StyleAttribute (IdAttribute a))))


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
    TargetAttribute (HrefAttribute (VisibleAttributes msg {}))


type alias FlowAttributes msg =
    VisibleAttributes msg {}


type alias ImgAttributes msg =
    AltAttribute (SrcAttribute (VisibleAttributes msg {}))


type alias IframeAttributes msg =
    SrcAttribute (VisibleAttributes msg {})


type alias StringValue a =
    ValueAttribute String a


type alias IntValue a =
    ValueAttribute Int a


type alias ColorValue a =
    ValueAttribute Color a


type alias InputAttributes a =
    NameAttribute { a | type_ : String }


type alias InputHiddenAttributes =
    InputAttributes (ClassAttribute (IdAttribute (StringValue { type_ : String })))


type alias InputVisibleAttributes msg a =
    VisibleAttributes msg (InputAttributes a)


type alias InputTextAttributes msg a =
    StringValue (InputVisibleAttributes msg a)


type alias TextareaAttributes msg =
    StringValue (VisibleAttributes msg {})


type alias ButtonAttributes msg a =
    VisibleAttributes msg a


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
    StringValue (OptionsAttribute (VisibleAttributes msg {}))


type alias OptionsAttribute a =
    { a | options : List { value : String, label : String } }


type alias ProgressAttributes msg =
    VisibleAttributes msg {}


type alias AudioAttributes msg =
    VisibleAttributes msg {}


type alias VideoAttributes msg =
    VisibleAttributes msg {}


type alias CanvasAttributes msg =
    VisibleAttributes msg {}


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


type Msg
    = Click


defaultsComposedToAttrs : a -> List (a -> a) -> a
defaultsComposedToAttrs defaults attrs =
    (defaults |> (attrs |> compose))


flowDefaultsComposedToAttrs :
    List
        ({ class : List b
         , hoverStyle : List c
         , id : Maybe a
         , style : List d
         , onMouseEnter : Maybe msg
         , onClick : Maybe msg
         }
         ->
            { class : List b
            , hoverStyle : List c
            , id : Maybe a
            , style : List d
            , onMouseEnter : Maybe msg
            , onClick : Maybe msg
            }
        )
    ->
        { class : List b
        , hoverStyle : List c
        , id : Maybe a
        , style : List d
        , onMouseEnter : Maybe msg
        , onClick : Maybe msg
        }
flowDefaultsComposedToAttrs =
    defaultsComposedToAttrs { class = [], id = Nothing, style = [], hoverStyle = [], onMouseEnter = Nothing, onClick = Nothing }


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
    A << defaultsComposedToAttrs { href = Nothing, target = Nothing, class = [], id = Nothing, style = [], hoverStyle = [], onClick = Nothing, onMouseEnter = Nothing }


button : List (ButtonAttributes msg {} -> ButtonAttributes msg {}) -> List (Node NotInteractive phrasingContent spanningContent NotListElement msg) -> Node Interactive phrasingContent spanningContent NotListElement msg
button =
    Button << defaultsComposedToAttrs { class = [], id = Nothing, style = [], hoverStyle = [], onClick = Nothing, onMouseEnter = Nothing }


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
    Textarea << defaultsComposedToAttrs { value = Nothing, class = [], id = Nothing, style = [], hoverStyle = [], onClick = Nothing, onMouseEnter = Nothing }


img : String -> String -> List (ImgAttributes msg -> ImgAttributes msg) -> Node interactiveContent phrasingContent spanningContent NotListElement msg
img alt src =
    Img << defaultsComposedToAttrs { src = src, alt = alt, class = [], id = Nothing, style = [], hoverStyle = [], onClick = Nothing, onMouseEnter = Nothing }


audio : List (AudioAttributes msg -> AudioAttributes msg) -> Node Interactive phrasingContent spanningContent NotListElement msg
audio =
    Audio << defaultsComposedToAttrs { class = [], id = Nothing, style = [], hoverStyle = [], onClick = Nothing, onMouseEnter = Nothing }


progress : List (ProgressAttributes msg -> ProgressAttributes msg) -> Node Interactive phrasingContent spanningContent NotListElement msg
progress =
    Progress << defaultsComposedToAttrs { class = [], id = Nothing, style = [], hoverStyle = [], onClick = Nothing, onMouseEnter = Nothing }


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
    InputHidden << defaultsComposedToAttrs { id = Nothing, name = Nothing, class = [], type_ = "hidden", value = Nothing }


baseInputAttributes : String -> InputVisibleAttributes msg (ValueAttribute a {})
baseInputAttributes type_ =
    { id = Nothing, name = Nothing, class = [], type_ = type_, value = Nothing, style = [], hoverStyle = [], onClick = Nothing, onMouseEnter = Nothing }


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
    InputCheckbox << defaultsComposedToAttrs { id = Nothing, name = Nothing, class = [], type_ = "checkbox", value = Nothing, style = [], hoverStyle = [], checked = False, onClick = Nothing, onMouseEnter = Nothing }


inputFile :
    List (InputFileAttributes msg -> InputFileAttributes msg)
    -> Node interactiveContent phrasingContent spanningContent listContent msg
inputFile =
    InputFile << defaultsComposedToAttrs { id = Nothing, name = Nothing, class = [], type_ = "file", style = [], hoverStyle = [], onClick = Nothing, onMouseEnter = Nothing }


inputPassword :
    List (InputPasswordAttributes msg -> InputPasswordAttributes msg)
    -> Node interactiveContent phrasingContent spanningContent listContent msg
inputPassword =
    InputPassword << defaultsComposedToAttrs { id = Nothing, name = Nothing, class = [], type_ = "password", value = Nothing, style = [], hoverStyle = [], onClick = Nothing, onMouseEnter = Nothing }


inputRadio :
    List (InputRadioAttributes msg -> InputRadioAttributes msg)
    -> Node interactiveContent phrasingContent spanningContent listContent msg
inputRadio =
    InputRadio << defaultsComposedToAttrs { id = Nothing, name = Nothing, class = [], type_ = "radio", value = Nothing, style = [], hoverStyle = [], onClick = Nothing, onMouseEnter = Nothing }


inputRange :
    List (InputRangeAttributes msg -> InputRangeAttributes msg)
    -> Node interactiveContent phrasingContent spanningContent listContent msg
inputRange =
    InputRange << defaultsComposedToAttrs { id = Nothing, name = Nothing, class = [], type_ = "range", value = Nothing, style = [], hoverStyle = [], onClick = Nothing, onMouseEnter = Nothing }


inputSubmit :
    List (InputSubmitAttributes msg -> InputSubmitAttributes msg)
    -> Node interactiveContent phrasingContent spanningContent listContent msg
inputSubmit =
    InputSubmit << defaultsComposedToAttrs { id = Nothing, class = [], type_ = "submit", style = [], hoverStyle = [], onClick = Nothing, onMouseEnter = Nothing }


inputUrl :
    List (InputUrlAttributes msg -> InputUrlAttributes msg)
    -> Node interactiveContent phrasingContent spanningContent listContent msg
inputUrl =
    InputUrl << defaultsComposedToAttrs { id = Nothing, class = [], name = Nothing, value = Nothing, type_ = "url", style = [], hoverStyle = [], onClick = Nothing, onMouseEnter = Nothing }


select :
    List (SelectAttributes msg -> SelectAttributes msg)
    -> Node interactiveContent phrasingContent spanningContent listContent msg
select list =
    (Select << defaultsComposedToAttrs { id = Nothing, class = [], value = Nothing, style = [], hoverStyle = [], options = [], onClick = Nothing, onMouseEnter = Nothing }) list


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


style : List (Style -> Style) -> StyleAttribute a -> StyleAttribute a
style val attrs =
    { attrs | style = val }


hoverStyle : List (Style -> Style) -> StyleAttribute a -> StyleAttribute a
hoverStyle val attrs =
    { attrs | hoverStyle = val }


class : List String -> ClassAttribute a -> ClassAttribute a
class val attrs =
    { attrs | class = val }


target : String -> TargetAttribute a -> TargetAttribute a
target val attrs =
    { attrs | target = Just val }


id : String -> IdAttribute a -> IdAttribute a
id val attrs =
    { attrs | id = Just val }


name : String -> NameAttribute a -> NameAttribute a
name val attrs =
    { attrs | name = Just val }


handleHref :
    { a | href : Maybe String }
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleHref { href } =
    href
        |> Maybe.unwrap identity BodyBuilderHtml.href


handleStyle :
    { a | hoverStyle : List (Style -> Style), style : List (Style -> Style) }
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleStyle { style, hoverStyle } =
    BodyBuilderHtml.style style << BodyBuilderHtml.hoverStyle hoverStyle


handleSrc : { a | src : String } -> HtmlAttributes msg -> HtmlAttributes msg
handleSrc { src } =
    BodyBuilderHtml.src src


handleAlt : { a | alt : String } -> HtmlAttributes msg -> HtmlAttributes msg
handleAlt { alt } =
    BodyBuilderHtml.alt alt


handleClass : { a | class : List String } -> HtmlAttributes msg -> HtmlAttributes msg
handleClass { class } =
    BodyBuilderHtml.class class


handleId : { a | id : Maybe String } -> HtmlAttributes msg -> HtmlAttributes msg
handleId { id } =
    id
        |> Maybe.unwrap identity BodyBuilderHtml.id


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
handleTarget { target } attributes =
    case target of
        Nothing ->
            attributes

        Just target_ ->
            BodyBuilderHtml.target target_ attributes


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


type alias BaseAttributes a =
    { a
        | class : List String
        , hoverStyle : List (Style -> Style)
        , id : Maybe String
        , style : List (Style -> Style)
    }


baseHandling : List (BaseAttributes a -> HtmlAttributes msg -> HtmlAttributes msg)
baseHandling =
    [ handleStyle, handleClass, handleId ]


inputAttributesHandling : List (NameAttribute (BaseAttributes { a | type_ : String }) -> HtmlAttributes msg -> HtmlAttributes msg)
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
            childToHtml attributes "input" [ handleStringValue, handleType, handleName, handleClass, handleId ]

        Textarea attributes ->
            -- childToHtml attributes "textarea" (inputAttributesHandling |> List.append [ handleStringValue ])
            BodyBuilderHtml.none

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
