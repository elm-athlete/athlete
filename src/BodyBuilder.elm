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


type alias VisibleAttributes a =
    ClassAttribute (StyleAttribute (IdAttribute a))


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


type alias SrcAttribute a =
    { a | src : String }


type alias AltAttribute a =
    { a | alt : String }


type alias ValueAttribute a b =
    { b | value : Maybe a }


type alias NameAttribute a =
    { a | name : Maybe String }


type alias AAttributes =
    TargetAttribute (HrefAttribute (VisibleAttributes {}))


type alias FlowAttributes =
    VisibleAttributes {}


type alias ImgAttributes =
    AltAttribute (SrcAttribute (VisibleAttributes {}))


type alias IframeAttributes =
    SrcAttribute (VisibleAttributes {})


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


type alias InputVisibleAttributes a =
    VisibleAttributes (InputAttributes a)


type alias InputTextAttributes a =
    StringValue (InputVisibleAttributes a)


type alias TextareaAttributes =
    StringValue (VisibleAttributes {})


type alias ButtonAttributes a =
    VisibleAttributes a


type alias InputNumberAttributes =
    IntValue (InputVisibleAttributes {})


type alias InputSliderAttributes =
    InputNumberAttributes


type alias InputColorAttributes =
    ColorValue (InputVisibleAttributes {})


type alias InputCheckboxAttributes =
    InputTextAttributes { checked : Bool }


type alias InputFileAttributes =
    InputVisibleAttributes {}


type alias InputPasswordAttributes =
    InputTextAttributes {}


type alias InputRadioAttributes =
    InputTextAttributes {}


type alias InputRangeAttributes =
    InputNumberAttributes


type alias InputSubmitAttributes =
    ButtonAttributes { type_ : String }


type alias InputUrlAttributes =
    InputTextAttributes {}


type alias SelectAttributes =
    StringValue (OptionsAttribute (VisibleAttributes {}))


type alias OptionsAttribute a =
    { a | options : List { value : String, label : String } }


type alias ProgressAttributes =
    VisibleAttributes {}


type alias AudioAttributes =
    VisibleAttributes {}


type alias VideoAttributes =
    VisibleAttributes {}


type alias CanvasAttributes =
    VisibleAttributes {}


type Never
    = Never


type Node interactiveContent phrasingContent spanningContent listContent
    = A AAttributes (List (Node NotInteractive phrasingContent spanningContent NotListElement))
    | Div FlowAttributes (List (Node interactiveContent phrasingContent Spanning NotListElement))
    | P FlowAttributes (List (Node interactiveContent Phrasing Spanning NotListElement))
    | Span FlowAttributes (List (Node interactiveContent Phrasing NotSpanning NotListElement))
    | H Int FlowAttributes (List (Node interactiveContent Phrasing Spanning NotListElement))
    | Ul FlowAttributes (List (Node interactiveContent phrasingContent spanningContent ListElement))
    | Ol FlowAttributes (List (Node interactiveContent phrasingContent spanningContent ListElement))
    | Li FlowAttributes (List (Node interactiveContent phrasingContent spanningContent NotListElement))
    | Br FlowAttributes
    | Table (List (Node interactiveContent phrasingContent spanningContent listContent)) (List (List (Node interactiveContent phrasingContent spanningContent NotListElement)))
    | Button (ButtonAttributes {}) (List (Node NotInteractive phrasingContent spanningContent NotListElement))
    | Progress ProgressAttributes
    | Audio AudioAttributes
    | Video VideoAttributes
    | Img ImgAttributes
    | Canvas CanvasAttributes
    | Textarea TextareaAttributes
    | InputHidden InputHiddenAttributes
    | InputText (InputTextAttributes {})
    | InputNumber InputNumberAttributes
    | InputSlider InputSliderAttributes
    | InputColor InputColorAttributes
    | InputCheckbox InputCheckboxAttributes
    | InputFile InputFileAttributes
    | InputPassword InputPasswordAttributes
    | InputRadio InputRadioAttributes
    | InputRange InputRangeAttributes
    | InputSubmit InputSubmitAttributes
    | InputUrl InputUrlAttributes
    | Select SelectAttributes
    | Text String


blah : Node Interactive NotPhrasing Spanning NotListElement
blah =
    div
        [ style
            [ Elegant.width (Elegant.Px 300)
            , Elegant.marginAuto
            ]
        ]
        [ a
            [ style [ Elegant.textColor Color.grey ]
            , href "#"
            , class [ "toto" ]
            , id "titi"
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


defaultsComposedToAttrs : a -> List (a -> a) -> a
defaultsComposedToAttrs defaults attrs =
    (defaults |> (attrs |> compose))


flowDefaultsComposedToAttrs :
    List
        ({ class : List b, hoverStyle : List c, id : Maybe a, style : List d }
         ->
            { class : List b
            , hoverStyle : List c
            , id : Maybe a
            , style : List d
            }
        )
    -> { class : List b, hoverStyle : List c, id : Maybe a, style : List d }
flowDefaultsComposedToAttrs =
    defaultsComposedToAttrs { class = [], id = Nothing, style = [], hoverStyle = [] }


h1 : List (FlowAttributes -> FlowAttributes) -> List (Node interactiveContent Phrasing Spanning NotListElement) -> Node interactiveContent NotPhrasing Spanning NotListElement
h1 =
    H 1 << flowDefaultsComposedToAttrs


h2 : List (FlowAttributes -> FlowAttributes) -> List (Node interactiveContent Phrasing Spanning NotListElement) -> Node interactiveContent NotPhrasing Spanning NotListElement
h2 =
    H 2 << flowDefaultsComposedToAttrs


h3 : List (FlowAttributes -> FlowAttributes) -> List (Node interactiveContent Phrasing Spanning NotListElement) -> Node interactiveContent NotPhrasing Spanning NotListElement
h3 =
    H 3 << flowDefaultsComposedToAttrs


h4 : List (FlowAttributes -> FlowAttributes) -> List (Node interactiveContent Phrasing Spanning NotListElement) -> Node interactiveContent NotPhrasing Spanning NotListElement
h4 =
    H 4 << flowDefaultsComposedToAttrs


h5 : List (FlowAttributes -> FlowAttributes) -> List (Node interactiveContent Phrasing Spanning NotListElement) -> Node interactiveContent NotPhrasing Spanning NotListElement
h5 =
    H 5 << flowDefaultsComposedToAttrs


h6 : List (FlowAttributes -> FlowAttributes) -> List (Node interactiveContent Phrasing Spanning NotListElement) -> Node interactiveContent NotPhrasing Spanning NotListElement
h6 =
    H 6 << flowDefaultsComposedToAttrs


a : List (AAttributes -> AAttributes) -> List (Node NotInteractive phrasingContent spanningContent NotListElement) -> Node Interactive phrasingContent spanningContent NotListElement
a =
    A << defaultsComposedToAttrs { href = Nothing, class = [], id = Nothing, target = Nothing, style = [], hoverStyle = [] }


button : List (ButtonAttributes {} -> ButtonAttributes {}) -> List (Node NotInteractive phrasingContent spanningContent NotListElement) -> Node Interactive phrasingContent spanningContent NotListElement
button =
    Button << defaultsComposedToAttrs { class = [], id = Nothing, style = [], hoverStyle = [] }


div : List (FlowAttributes -> FlowAttributes) -> List (Node interactiveContent phrasingContent Spanning NotListElement) -> Node interactiveContent phrasingContent Spanning NotListElement
div =
    Div << flowDefaultsComposedToAttrs


ul : List (FlowAttributes -> FlowAttributes) -> List (Node interactiveContent phrasingContent Spanning ListElement) -> Node interactiveContent phrasingContent Spanning NotListElement
ul =
    Ul << flowDefaultsComposedToAttrs


ol : List (FlowAttributes -> FlowAttributes) -> List (Node interactiveContent phrasingContent Spanning ListElement) -> Node interactiveContent phrasingContent Spanning NotListElement
ol =
    Ol << flowDefaultsComposedToAttrs


li : List (FlowAttributes -> FlowAttributes) -> List (Node interactiveContent phrasingContent Spanning NotListElement) -> Node interactiveContent phrasingContent Spanning ListElement
li =
    Li << flowDefaultsComposedToAttrs


p : List (FlowAttributes -> FlowAttributes) -> List (Node interactiveContent Phrasing Spanning NotListElement) -> Node interactiveContent NotPhrasing spanningContent NotListElement
p =
    P << flowDefaultsComposedToAttrs


br : List (FlowAttributes -> FlowAttributes) -> Node interactiveContent Phrasing spanningContent NotListElement
br =
    Br << flowDefaultsComposedToAttrs


span : List (FlowAttributes -> FlowAttributes) -> List (Node interactiveContent Phrasing NotSpanning NotListElement) -> Node interactiveContent phrasingContent spanningContent NotListElement
span =
    Span << flowDefaultsComposedToAttrs


textarea : List (TextareaAttributes -> TextareaAttributes) -> Node Interactive phrasingContent spanningContent NotListElement
textarea =
    Textarea << defaultsComposedToAttrs { value = Nothing, class = [], id = Nothing, style = [], hoverStyle = [] }


img : String -> String -> List (ImgAttributes -> ImgAttributes) -> Node interactiveContent phrasingContent spanningContent NotListElement
img alt src =
    Img << defaultsComposedToAttrs { src = src, alt = alt, class = [], id = Nothing, style = [], hoverStyle = [] }


audio : List (AudioAttributes -> AudioAttributes) -> Node Interactive phrasingContent spanningContent NotListElement
audio =
    Audio << defaultsComposedToAttrs { class = [], id = Nothing, style = [], hoverStyle = [] }


progress : List (ProgressAttributes -> ProgressAttributes) -> Node Interactive phrasingContent spanningContent NotListElement
progress =
    Progress << defaultsComposedToAttrs { class = [], id = Nothing, style = [], hoverStyle = [] }


table :
    List (Node interactiveContent phrasingContent spanningContent NotListElement)
    -> List (List (Node interactiveContent phrasingContent spanningContent NotListElement))
    -> Node interactiveContent phrasingContent spanningContent NotListElement
table =
    Table


text : String -> Node interactiveContent phrasingContent spanningContent NotListElement
text =
    Text


node :
    List (FlowAttributes -> FlowAttributes)
    -> List (Node interactiveContent phrasingContent Spanning NotListElement)
    -> Node interactiveContent phrasingContent Spanning NotListElement
node =
    div


leaf :
    List (FlowAttributes -> FlowAttributes)
    -> Node interactiveContent phrasingContent Spanning NotListElement
leaf =
    flip node []


container :
    List (Node interactiveContent phrasingContent Spanning NotListElement)
    -> Node interactiveContent phrasingContent Spanning NotListElement
container =
    node []


mapLis :
    List (Node interactiveContent phrasingContent Spanning NotListElement)
    -> List (Node interactiveContent phrasingContent Spanning ListElement)
mapLis =
    List.map (\content -> li [] [ content ])


olLi :
    List (FlowAttributes -> FlowAttributes)
    -> List (Node interactiveContent phrasingContent Spanning NotListElement)
    -> Node interactiveContent phrasingContent Spanning NotListElement
olLi attributes insideLis =
    ol attributes (mapLis insideLis)


ulLi :
    List (FlowAttributes -> FlowAttributes)
    -> List (Node interactiveContent phrasingContent Spanning NotListElement)
    -> Node interactiveContent phrasingContent Spanning NotListElement
ulLi attributes insideLis =
    ul attributes (mapLis insideLis)


inputHidden :
    List (InputHiddenAttributes -> InputHiddenAttributes)
    -> Node interactiveContent phrasingContent spanningContent listContent
inputHidden =
    InputHidden << defaultsComposedToAttrs { id = Nothing, name = Nothing, class = [], type_ = "hidden", value = Nothing }


baseInputAttributes : String -> InputVisibleAttributes (ValueAttribute a {})
baseInputAttributes type_ =
    { id = Nothing, name = Nothing, class = [], type_ = type_, value = Nothing, style = [], hoverStyle = [] }


inputText :
    List (InputTextAttributes {} -> InputTextAttributes {})
    -> Node interactiveContent phrasingContent spanningContent listContent
inputText =
    InputText << defaultsComposedToAttrs (baseInputAttributes "text")


inputNumber :
    List (InputNumberAttributes -> InputNumberAttributes)
    -> Node interactiveContent phrasingContent spanningContent listContent
inputNumber =
    InputNumber << defaultsComposedToAttrs (baseInputAttributes "number")


inputSlider :
    List (InputSliderAttributes -> InputSliderAttributes)
    -> Node interactiveContent phrasingContent spanningContent listContent
inputSlider =
    InputSlider << defaultsComposedToAttrs (baseInputAttributes "range")


inputColor :
    List (InputColorAttributes -> InputColorAttributes)
    -> Node interactiveContent phrasingContent spanningContent listContent
inputColor =
    InputColor << defaultsComposedToAttrs (baseInputAttributes "color")


inputCheckbox :
    List (InputCheckboxAttributes -> InputCheckboxAttributes)
    -> Node interactiveContent phrasingContent spanningContent listContent
inputCheckbox =
    InputCheckbox << defaultsComposedToAttrs { id = Nothing, name = Nothing, class = [], type_ = "checkbox", value = Nothing, style = [], hoverStyle = [], checked = False }


inputFile :
    List (InputFileAttributes -> InputFileAttributes)
    -> Node interactiveContent phrasingContent spanningContent listContent
inputFile =
    InputFile << defaultsComposedToAttrs { id = Nothing, name = Nothing, class = [], type_ = "file", style = [], hoverStyle = [] }


inputPassword :
    List (InputPasswordAttributes -> InputPasswordAttributes)
    -> Node interactiveContent phrasingContent spanningContent listContent
inputPassword =
    InputPassword << defaultsComposedToAttrs { id = Nothing, name = Nothing, class = [], type_ = "password", value = Nothing, style = [], hoverStyle = [] }


inputRadio :
    List (InputRadioAttributes -> InputRadioAttributes)
    -> Node interactiveContent phrasingContent spanningContent listContent
inputRadio =
    InputRadio << defaultsComposedToAttrs { id = Nothing, name = Nothing, class = [], type_ = "radio", value = Nothing, style = [], hoverStyle = [] }


inputRange :
    List (InputRangeAttributes -> InputRangeAttributes)
    -> Node interactiveContent phrasingContent spanningContent listContent
inputRange =
    InputRange << defaultsComposedToAttrs { id = Nothing, name = Nothing, class = [], type_ = "range", value = Nothing, style = [], hoverStyle = [] }


inputSubmit :
    List (InputSubmitAttributes -> InputSubmitAttributes)
    -> Node interactiveContent phrasingContent spanningContent listContent
inputSubmit =
    InputSubmit << defaultsComposedToAttrs { id = Nothing, class = [], type_ = "submit", style = [], hoverStyle = [] }


inputUrl :
    List (InputUrlAttributes -> InputUrlAttributes)
    -> Node interactiveContent phrasingContent spanningContent listContent
inputUrl =
    InputUrl << defaultsComposedToAttrs { id = Nothing, class = [], name = Nothing, value = Nothing, type_ = "url", style = [], hoverStyle = [] }


select :
    List (SelectAttributes -> SelectAttributes)
    -> Node interactiveContent phrasingContent spanningContent listContent
select list =
    (Select << defaultsComposedToAttrs { id = Nothing, class = [], value = Nothing, style = [], hoverStyle = [], options = [] }) list


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


buildNode :
    List (Node interactiveContent phrasingContent spanningContent listContent)
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
    List (Node interactiveContent phrasingContent spanningContent listContent)
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


toTree : Node interactiveContent phrasingContent spanningContent listContent -> BodyBuilderHtml.HtmlAttributes msg
toTree node =
    case node of
        A attributes children ->
            parentToHtml children attributes "a" (baseHandling |> List.append [ handleHref ])

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

        Textarea _ ->
            -- TODO
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
    Node interactiveContent phrasingContent spanningContent listContent
    -> Html.Html msg
toHtml node =
    node
        |> toTree
        |> BodyBuilderHtml.view


type alias BodyBuilderProgramArgs model msg a b c =
    { init : ( model, Cmd msg )
    , subscriptions : model -> Sub msg
    , update : msg -> model -> ( model, Cmd msg )
    , view : model -> Node a b c NotListElement
    }


program : BodyBuilderProgramArgs model msg a b c -> Program Basics.Never model msg
program { init, update, subscriptions, view } =
    Html.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = toHtml << view
        }


main : Html.Html msg
main =
    toHtml blah
