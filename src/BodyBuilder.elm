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
    NameAttribute (ClassAttribute (IdAttribute { a | type_ : String }))


type alias InputHiddenAttributes =
    InputAttributes (StringValue { type_ : String })


type alias InputVisibleAttributes a =
    StyleAttribute (InputAttributes a)


type alias InputTextAttributes a =
    StringValue (VisibleAttributes (InputVisibleAttributes a))


type alias TextareaAttributes =
    StringValue (VisibleAttributes {})


type alias ButtonAttributes =
    VisibleAttributes {}


type alias InputNumberAttributes =
    IntValue (InputVisibleAttributes {})


type alias InputSliderAttributes =
    InputNumberAttributes


type alias InputColorAttributes =
    ColorValue (InputVisibleAttributes {})


type alias InputCheckboxAttributes =
    InputTextAttributes { checked : Bool }


type alias InputFileAttributes =
    InputTextAttributes {}


type alias InputPasswordAttributes =
    InputTextAttributes {}


type alias InputRadioAttributes =
    InputTextAttributes {}


type alias InputRangeAttributes =
    InputTextAttributes {}


type alias InputSubmitAttributes =
    InputTextAttributes {}


type alias InputUrlAttributes =
    InputTextAttributes {}


type alias SelectAttributes =
    InputTextAttributes {}


type alias ProgressAttributes =
    VisibleAttributes {}


type alias AudioAttributes =
    VisibleAttributes {}


type alias VideoAttributes =
    VisibleAttributes {}


type alias CanvasAttributes =
    VisibleAttributes {}


type Node interactiveContent phrasingContent spanningContent listContent
    = A AAttributes (List (Node NotInteractive phrasingContent spanningContent listContent))
    | Div FlowAttributes (List (Node interactiveContent phrasingContent Spanning listContent))
    | P FlowAttributes (List (Node interactiveContent Phrasing Spanning listContent))
    | Span FlowAttributes (List (Node interactiveContent Phrasing NotSpanning listContent))
    | H Int FlowAttributes (List (Node interactiveContent Phrasing Spanning listContent))
    | Ul FlowAttributes (List (Node interactiveContent phrasingContent spanningContent ListElement))
    | Ol FlowAttributes (List (Node interactiveContent phrasingContent spanningContent ListElement))
    | Li FlowAttributes (List (Node interactiveContent phrasingContent spanningContent NotListElement))
    | Br FlowAttributes
    | Table (List (Node interactiveContent phrasingContent spanningContent listContent)) (List (List (Node interactiveContent phrasingContent spanningContent listContent)))
    | Button ButtonAttributes (List (Node NotInteractive phrasingContent spanningContent listContent))
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
    container
        [ a [ style [ Elegant.textColor Color.grey ], href "blah", class [ "toto" ], id "titi" ]
            [ container
                [ container
                    [ h1 [ style [ Elegant.textColor Color.green ], hoverStyle [ Elegant.textColor Color.red ] ]
                        [ span [] [ text "Toto" ]
                        , span [] [ img "alt" "toto" [] ]
                        , table [ container [ span [] [] ] ] [ [ leaf [] ], [ leaf [] ] ]
                        ]
                    ]
                ]
            , inputHidden [ name "inputHidden", value "inputHidden_", class [ "class" ], id "id" ]
            , inputText [ name "inputText", value "inputText_", class [ "class" ], id "id" ]
            , inputNumber [ name "inputNumber", value 12, class [ "class" ], id "id" ]
            , inputSlider [ name "inputSlider", value 12, class [ "class" ], id "id" ]
            , inputColor [ name "inputSlider", value Color.yellow, class [ "class" ], id "id" ]
            , inputCheckbox [ name "inputSlider", value "test", class [ "class" ], id "id", checked ]
            , inputCheckbox [ name "inputSlider", value "test", class [ "class" ], id "id" ]
            , olLi [] [ p [] [ text "1" ], p [] [ text "2", br [], text "3" ] ]
            , ulLi [] [ p [] [ text "blahblah" ], text "toto" ]
            , ul []
                [ li [] []
                , li [] []
                ]
            , ol []
                [ li [] []
                , li [] []
                ]
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


button : List (ButtonAttributes -> ButtonAttributes) -> List (Node NotInteractive phrasingContent spanningContent NotListElement) -> Node Interactive phrasingContent spanningContent NotListElement
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

        InputFile _ ->
            -- TODO
            BodyBuilderHtml.none

        InputPassword _ ->
            -- TODO
            BodyBuilderHtml.none

        InputRadio _ ->
            -- TODO
            BodyBuilderHtml.none

        InputRange _ ->
            -- TODO
            BodyBuilderHtml.none

        InputSubmit _ ->
            -- TODO
            BodyBuilderHtml.none

        InputUrl _ ->
            -- TODO
            BodyBuilderHtml.none

        Select _ ->
            -- TODO
            BodyBuilderHtml.none


nodeToHtml : Node interactiveContent phrasingContent spanningContent listContent -> Html.Html msg
nodeToHtml node =
    node
        |> toTree
        |> BodyBuilderHtml.view


main : Html.Html msg
main =
    nodeToHtml blah
