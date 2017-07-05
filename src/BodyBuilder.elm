module Html2 exposing (..)

import Elegant exposing (Style)
import Html
import Html.Attributes
import Function exposing (..)


type Language
    = English
    | French


type Country
    = Us
    | Uk
    | France


type Charset
    = UTF8


type alias Lang =
    ( Language, Country )


type alias Html =
    { head : Maybe Head
    , body : Maybe Body
    , lang : Lang
    }


type alias Head =
    { title : Maybe String
    , charset : Maybe Charset
    , description : Maybe String
    , keywords : List String
    , author : String
    , otherMeta : List ( String, String )
    }


type alias MimeType =
    String


type alias Source =
    { mime : MimeType
    , src : Url
    }



-- type InsideForm
--     = InsideForm


type alias Url =
    String


type NodeInsideA
    = NodeInsideA


type OutsideInteractive
    = OutsideInteractive


type InsideInteractive
    = InsideInteractive


type InsideP
    = InsideP


type OutsideP
    = OutsideP


type InsideSpan
    = InsideSpan


type OutsideSpan
    = OutsideSpan


type InsideHeading
    = InsideHeading


type OutsideHeading
    = OutsideHeading


type InsideList
    = InsideList


type OutsideList
    = OutsideList


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


type alias HrefAttribute a =
    { a | href : Maybe Url }


type alias SrcAttribute a =
    { a | src : String }


type alias AltAttribute a =
    { a | alt : String }


type alias ValueAttribute b a =
    { a | value : Maybe b }


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


type alias InputHiddenAttributes =
    StringValue {}


type alias InputTextAttributes =
    StringValue (VisibleAttributes {})


type alias TextareaAttributes =
    InputTextAttributes


type alias InputNumberAttributes =
    ValueAttribute Int {}


type alias InputSliderAttributes =
    InputTextAttributes


type alias InputColorAttributes =
    InputTextAttributes


type alias InputCheckboxAttributes =
    InputTextAttributes


type alias InputFileAttributes =
    InputTextAttributes


type alias InputPasswordAttributes =
    InputTextAttributes


type alias InputRadioAttributes =
    InputTextAttributes


type alias InputRangeAttributes =
    InputTextAttributes


type alias InputSubmitAttributes =
    InputTextAttributes


type alias InputUrlAttributes =
    InputTextAttributes


type alias SelectAttributes =
    InputTextAttributes


type alias ProgressAttributes =
    VisibleAttributes {}


type alias AudioAttributes =
    VisibleAttributes {}


type alias VideoAttributes =
    VisibleAttributes {}


type alias CanvasAttributes =
    VisibleAttributes {}


type Node insideInteractive insideP insideSpan insideHeading insideList
    = A AAttributes (List (Node InsideInteractive insideP insideSpan insideHeading insideList))
    | Button (List (Node InsideInteractive insideP insideSpan insideHeading insideList))
    | Div FlowAttributes (List (Node insideInteractive insideP OutsideSpan insideHeading insideList))
    | P FlowAttributes (List (Node insideInteractive InsideP insideSpan insideHeading insideList))
    | Span FlowAttributes (List (Node insideInteractive InsideP InsideSpan insideHeading insideList))
    | H1 FlowAttributes (List (Node insideInteractive InsideP OutsideSpan InsideHeading insideList))
    | Ul FlowAttributes (List (Node insideInteractive insideP insideSpan insideHeading InsideList))
    | Ol FlowAttributes (List (Node insideInteractive insideP insideSpan insideHeading InsideList))
    | Li FlowAttributes (List (Node insideInteractive insideP insideSpan insideHeading OutsideList))
    | Br FlowAttributes
    | Table (List (Node insideInteractive insideP insideSpan insideHeading insideList)) (List (List (Node insideInteractive insideP insideSpan insideHeading insideList)))
    | Progress ProgressAttributes
    | Audio AudioAttributes
    | Video VideoAttributes
    | Img ImgAttributes
    | Canvas CanvasAttributes
    | InputHidden InputHiddenAttributes
    | Textarea TextareaAttributes
    | InputText InputTextAttributes
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


h1 : List (FlowAttributes -> FlowAttributes) -> List (Node insideInteractive InsideP OutsideSpan InsideHeading OutsideList) -> Node insideInteractive insideP OutsideSpan OutsideHeading OutsideList
h1 attrs =
    H1 (flowDefaultsComposedToAttrs attrs)


a : List (AAttributes -> AAttributes) -> List (Node InsideInteractive insideP insideSpan insideHeading OutsideList) -> Node OutsideInteractive insideP insideSpan insideHeading OutsideList
a attrs =
    let
        defaults =
            { href = Nothing, class = [], id = Nothing, target = Nothing, style = [], hoverStyle = [] }
    in
        A (defaults |> (attrs |> compose))


button : List (Node InsideInteractive insideP insideSpan insideHeading OutsideList) -> Node OutsideInteractive insideP insideSpan insideHeading OutsideList
button =
    Button


div : List (FlowAttributes -> FlowAttributes) -> List (Node insideInteractive insideP OutsideSpan insideHeading OutsideList) -> Node insideInteractive insideP OutsideSpan insideHeading OutsideList
div attrs =
    Div (flowDefaultsComposedToAttrs attrs)


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


ul : List (FlowAttributes -> FlowAttributes) -> List (Node insideInteractive insideP OutsideSpan insideHeading InsideList) -> Node insideInteractive insideP OutsideSpan insideHeading OutsideList
ul attrs =
    Ul (flowDefaultsComposedToAttrs attrs)


ol : List (FlowAttributes -> FlowAttributes) -> List (Node insideInteractive insideP OutsideSpan insideHeading InsideList) -> Node insideInteractive insideP OutsideSpan insideHeading OutsideList
ol attrs =
    Ol (flowDefaultsComposedToAttrs attrs)


li : List (FlowAttributes -> FlowAttributes) -> List (Node insideInteractive insideP OutsideSpan insideHeading OutsideList) -> Node insideInteractive insideP OutsideSpan insideHeading InsideList
li attrs =
    Li (flowDefaultsComposedToAttrs attrs)


p : List (FlowAttributes -> FlowAttributes) -> List (Node insideInteractive InsideP insideSpan insideHeading OutsideList) -> Node insideInteractive OutsideP insideSpan insideHeading OutsideList
p attrs =
    P (flowDefaultsComposedToAttrs attrs)


br : List (FlowAttributes -> FlowAttributes) -> Node insideInteractive InsideP insideSpan insideHeading OutsideList
br attrs =
    Br (flowDefaultsComposedToAttrs attrs)


span : List (FlowAttributes -> FlowAttributes) -> List (Node insideInteractive InsideP InsideSpan insideHeading OutsideList) -> Node insideInteractive insideP insideSpan insideHeading OutsideList
span attrs =
    Span (flowDefaultsComposedToAttrs attrs)


textarea : List (TextareaAttributes -> TextareaAttributes) -> Node OutsideInteractive insideP insideSpan insideHeading OutsideList
textarea attrs =
    Textarea (defaultsComposedToAttrs { value = Nothing, class = [], id = Nothing, style = [], hoverStyle = [] } attrs)


img : String -> String -> List (ImgAttributes -> ImgAttributes) -> Node insideInteractive insideP insideSpan insideHeading OutsideList
img alt src attrs =
    Img (defaultsComposedToAttrs { src = src, alt = alt, class = [], id = Nothing, style = [], hoverStyle = [] } attrs)


audio : List (AudioAttributes -> AudioAttributes) -> Node OutsideInteractive insideP insideSpan insideHeading OutsideList
audio attrs =
    Audio (defaultsComposedToAttrs { class = [], id = Nothing, style = [], hoverStyle = [] } attrs)


progress : List (ProgressAttributes -> ProgressAttributes) -> Node OutsideInteractive insideP insideSpan insideHeading OutsideList
progress attrs =
    Progress (defaultsComposedToAttrs { class = [], id = Nothing, style = [], hoverStyle = [] } attrs)


table :
    List (Node insideInteractive insideP insideSpan insideHeading OutsideList)
    -> List (List (Node insideInteractive insideP insideSpan insideHeading OutsideList))
    -> Node insideInteractive insideP insideSpan insideHeading OutsideList
table =
    Table


href : String -> HrefAttribute a -> HrefAttribute a
href val attrs =
    { attrs | href = Just val }


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


node :
    List (FlowAttributes -> FlowAttributes)
    -> List (Node insideInteractive insideP OutsideSpan insideHeading OutsideList)
    -> Node insideInteractive insideP OutsideSpan insideHeading OutsideList
node =
    div


leaf :
    List (FlowAttributes -> FlowAttributes)
    -> Node insideInteractive insideP OutsideSpan insideHeading OutsideList
leaf =
    flip node []


container :
    List (Node insideInteractive insideP OutsideSpan insideHeading OutsideList)
    -> Node insideInteractive insideP OutsideSpan insideHeading OutsideList
container =
    node []


mapLis :
    List (Node insideInteractive insideP OutsideSpan insideHeading OutsideList)
    -> List (Node insideInteractive insideP OutsideSpan insideHeading InsideList)
mapLis insideLis =
    insideLis |> List.map (\e -> li [] [ e ])


olLi :
    List (FlowAttributes -> FlowAttributes)
    -> List (Node insideInteractive insideP OutsideSpan insideHeading OutsideList)
    -> Node insideInteractive insideP OutsideSpan insideHeading OutsideList
olLi attributes insideLis =
    ol attributes (mapLis insideLis)


ulLi :
    List (FlowAttributes -> FlowAttributes)
    -> List (Node insideInteractive insideP OutsideSpan insideHeading OutsideList)
    -> Node insideInteractive insideP OutsideSpan insideHeading OutsideList
ulLi attributes insideLis =
    ul attributes (mapLis insideLis)


blah : Node OutsideInteractive OutsideP OutsideSpan OutsideHeading OutsideList
blah =
    container
        [ a [ style [], href "blah", class [ "toto" ], id "titi" ]
            [ container
                [ container
                    [ h1 []
                        [ span [] []
                        , span [] [ img "alt" "toto" [] ]
                        , table [ container [ span [] [] ] ] [ [ leaf [] ], [ leaf [] ] ]
                        ]
                    ]
                ]
            , olLi [] [ p [] [] ]
            , ulLi [] [ p [] [] ]
            ]
        ]


main : Html.Html msg
main =
    nodeToHtml blah


handleHref : HrefAttribute a -> List (Html.Attribute msg)
handleHref { href } =
    href
        |> Maybe.map (\e -> [ Html.Attributes.href e ])
        |> Maybe.withDefault []


handleSrc : SrcAttribute a -> List (Html.Attribute msg)
handleSrc { src } =
    [ Html.Attributes.src src ]


handleAlt : AltAttribute a -> List (Html.Attribute msg)
handleAlt { alt } =
    [ Html.Attributes.alt alt ]


handleStyle : StyleAttribute a -> List (Html.Attribute msg)
handleStyle { style, hoverStyle } =
    classes ((style |> compose) Elegant.defaultStyle)


classesToAttributes : (Style -> String) -> Style -> List (Html.Attribute msg)
classesToAttributes fun style =
    let
        classes_ =
            fun style
    in
        if String.isEmpty classes_ then
            []
        else
            [ Html.Attributes.class classes_ ]


classes : Style -> List (Html.Attribute msg)
classes =
    classesToAttributes Elegant.classes


hoverClasses : Style -> List (Html.Attribute msg)
hoverClasses =
    classesToAttributes Elegant.classesHover


applyAttributes : attributes -> List (attributes -> List (Html.Attribute msg)) -> List (Html.Attribute msg)
applyAttributes attributes listFun =
    List.concatMap (\fun -> fun attributes) listFun


parentToHtml :
    attributes
    -> List (Node insideInteractive insideP insideSpan insideHeading insideList)
    -> String
    -> List (attributes -> List (Html.Attribute msg))
    -> Html.Html msg
parentToHtml attributes children tag toHtmlAttributesList =
    Html.node tag (applyAttributes attributes toHtmlAttributesList) (List.map toHtml children)


childToHtml :
    attributes
    -> String
    -> List (attributes -> List (Html.Attribute msg))
    -> Html.Html msg
childToHtml attributes tag toHtmlAttributesList =
    Html.node tag (applyAttributes attributes toHtmlAttributesList) []


toHtml : Node insideInteractive insideP insideSpan insideHeading insideList -> Html.Html msg
toHtml node =
    let
        baseHandling =
            [ handleStyle ]
    in
        case node of
            A attributes children ->
                parentToHtml attributes children "a" (baseHandling |> List.append [ handleHref ])

            Ul attributes children ->
                parentToHtml attributes children "ul" baseHandling

            Li attributes children ->
                parentToHtml attributes children "li" baseHandling

            Div attributes children ->
                parentToHtml attributes children "div" baseHandling

            Span attributes children ->
                parentToHtml attributes children "span" baseHandling

            H1 attributes children ->
                parentToHtml attributes children "h1" baseHandling

            Img attributes ->
                childToHtml attributes "img" (baseHandling |> List.append [ handleSrc, handleAlt ])

            _ ->
                Html.div [] []



-- P _ _ ->
--     "p"
--
-- H1 _ _ ->
--     "h1"
--
-- Ul _ _ ->
--     "ul"
--
-- Ol _ _ ->
--     "ol"
--
-- Li _ _ ->
--     "li"
--
-- Table _ _ ->
--     "table"
--
-- Button _ ->
--     "button"
--
-- Progress _ ->
--     "progress"
--
-- Audio _ ->
--     "audio"
--
-- Video _ ->
--     "video"
--
-- Img _ ->
--     "img"
--
-- Canvas _ ->
--     "canvas"
--
-- Textarea _ ->
--     "textarea"
--
-- Br _ ->
--     "br"
--
-- InputHidden _ ->
--     "input"
--
-- InputText _ ->
--     "input"
--
-- InputNumber _ ->
--     "input"
--
-- InputSlider _ ->
--     "input"
--
-- InputColor _ ->
--     "input"
--
-- InputCheckbox _ ->
--     "input"
--
-- InputFile _ ->
--     "input"
--
-- InputPassword _ ->
--     "input"
--
-- InputRadio _ ->
--     "input"
--
-- InputRange _ ->
--     "input"
--
-- InputSubmit _ ->
--     "input"
--
-- InputUrl _ ->
--     "input"
--
-- Select _ ->
--     "select"


nodeToHtml : Node insideInteractive insideP insideSpan insideHeading insideList -> Html.Html msg
nodeToHtml node =
    node |> toHtml



-- notCompiling =
--     a [ input ]
--
-- notCompiling : Node OutsideInteractive insideP insideSpan
-- notCompiling =
--     a [ audio ]
--
-- notCompiling : Node OutsideInteractive insideP OutsideSpan
-- notCompiling =
--     button [ div [ span [ button [] ] ] ]
--
--
-- notCompilingBis =
--     span [ p [] ]
--
--
-- notCompilingBisbis =
--     span [ div [] ]
--
--
-- shouldWork =
--     a [ div [] ]
-- type alias Url =
--     String
--
-- type InsideA
--     = InsideA
--
--
-- type Node insideA
--     = A Url (List (Node InsideA))
--
--
-- nested : Node InsideA
-- nested =
--     A "toto" [ A "titi" [ A "titi" [] ] ]
-- | Button (List (Node InsideA))
-- | Div (List (Node insideA))
-- | Span (List (Node insideA))
-- | H Int (List (Node insideA))
-- | Audio (List Source)
-- | Video (List Source)
-- | Text String


type alias Body =
    { nodes : List Node
    }


type alias Caption =
    Node


type alias Thead =
    Node


type alias Tbody =
    Node


type alias Tfoot =
    Node


type alias TableNode =
    { caption : Maybe Caption
    , thead : Maybe Thead
    , tbody : Maybe Tbody
    , tfoot : Maybe Tfoot
    }



-- Html
--
--   ,   <meta name="description" content="Free Web tutorials">
--   <meta name="keywords" content="HTML,CSS,XML,JavaScript">
--   <meta name="author" content="John Doe">
-- }
--
--
--
-- <div>
--   <a>
--     <div>
--       <a>
--       </a>
--     </div>
--   </a>
-- </div>
--
--
-- type Node =
--   A (List InsideLink)
--
-- type InsideLink =
--   InsideDiv (List InsideLink)
--
--
-- type Html =
--   Html Head Body
--
-- type Head =
--   Head (List InsideHead)
--
--
--   <meta charset="UTF-8">
--   <meta name="description" content="Free Web tutorials">
--   <meta name="keywords" content="HTML,CSS,XML,JavaScript">
--   <meta name="author" content="John Doe">
--   <meta name="viewport" content="width=device-width, initial-scale=1.0">
--
-- type InsideHead =
--   Title String
--   | Meta
--   title> (this element is required in an HTML document)
--   <style>
--   <base>
--   <link>
--   <meta>
--   <script>
--   <noscript>
