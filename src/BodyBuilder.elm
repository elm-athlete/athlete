module BodyBuilder exposing (..)

import Elegant exposing (Style)
import Html
import Function exposing (..)
import BodyBuilderHtml exposing (..)
import Color
import Maybe.Extra as Maybe


type OutsideInteractive
    = OutsideInteractive


type InsideInteractive
    = InsideInteractive


type InsidePhrasing
    = InsidePhrasing


type OutsidePhrasing
    = OutsidePhrasing


type OutsideSpan
    = OutsideSpan


type InsideSpan
    = InsideSpan


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


type alias Url =
    String


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


type alias ButtonAttributes =
    VisibleAttributes {}


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


type Node insideInteractive insidePhrasing insideSpan insideList
    = A AAttributes (List (Node InsideInteractive insidePhrasing insideSpan insideList))
    | Div FlowAttributes (List (Node insideInteractive insidePhrasing OutsideSpan insideList))
    | P FlowAttributes (List (Node insideInteractive InsidePhrasing OutsideSpan insideList))
    | Span FlowAttributes (List (Node insideInteractive InsidePhrasing InsideSpan insideList))
    | H Int FlowAttributes (List (Node insideInteractive InsidePhrasing OutsideSpan insideList))
    | Ul FlowAttributes (List (Node insideInteractive insidePhrasing insideSpan InsideList))
    | Ol FlowAttributes (List (Node insideInteractive insidePhrasing insideSpan InsideList))
    | Li FlowAttributes (List (Node insideInteractive insidePhrasing insideSpan OutsideList))
    | Br FlowAttributes
    | Table (List (Node insideInteractive insidePhrasing insideSpan insideList)) (List (List (Node insideInteractive insidePhrasing insideSpan insideList)))
    | Button ButtonAttributes (List (Node InsideInteractive insidePhrasing insideSpan insideList))
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
    | Text String


blah : Node OutsideInteractive OutsidePhrasing OutsideSpan OutsideList
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
            , olLi [] [ p [] [ text "1" ], p [] [ text "2" ] ]
            , ulLi [] [ p [] [ text "blahblah" ], text "toto" ]
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


h1 : List (FlowAttributes -> FlowAttributes) -> List (Node insideInteractive InsidePhrasing OutsideSpan OutsideList) -> Node insideInteractive OutsidePhrasing OutsideSpan OutsideList
h1 =
    H 1 << flowDefaultsComposedToAttrs


h2 : List (FlowAttributes -> FlowAttributes) -> List (Node insideInteractive InsidePhrasing OutsideSpan OutsideList) -> Node insideInteractive OutsidePhrasing OutsideSpan OutsideList
h2 =
    H 2 << flowDefaultsComposedToAttrs


h3 : List (FlowAttributes -> FlowAttributes) -> List (Node insideInteractive InsidePhrasing OutsideSpan OutsideList) -> Node insideInteractive OutsidePhrasing OutsideSpan OutsideList
h3 =
    H 3 << flowDefaultsComposedToAttrs


h4 : List (FlowAttributes -> FlowAttributes) -> List (Node insideInteractive InsidePhrasing OutsideSpan OutsideList) -> Node insideInteractive OutsidePhrasing OutsideSpan OutsideList
h4 =
    H 4 << flowDefaultsComposedToAttrs


h5 : List (FlowAttributes -> FlowAttributes) -> List (Node insideInteractive InsidePhrasing OutsideSpan OutsideList) -> Node insideInteractive OutsidePhrasing OutsideSpan OutsideList
h5 =
    H 5 << flowDefaultsComposedToAttrs


h6 : List (FlowAttributes -> FlowAttributes) -> List (Node insideInteractive InsidePhrasing OutsideSpan OutsideList) -> Node insideInteractive OutsidePhrasing OutsideSpan OutsideList
h6 =
    H 6 << flowDefaultsComposedToAttrs


a : List (AAttributes -> AAttributes) -> List (Node InsideInteractive insidePhrasing insideSpan OutsideList) -> Node OutsideInteractive insidePhrasing insideSpan OutsideList
a =
    A << defaultsComposedToAttrs { href = Nothing, class = [], id = Nothing, target = Nothing, style = [], hoverStyle = [] }


button : List (ButtonAttributes -> ButtonAttributes) -> List (Node InsideInteractive insidePhrasing insideSpan OutsideList) -> Node OutsideInteractive insidePhrasing insideSpan OutsideList
button =
    Button << defaultsComposedToAttrs { class = [], id = Nothing, style = [], hoverStyle = [] }


div : List (FlowAttributes -> FlowAttributes) -> List (Node insideInteractive insidePhrasing OutsideSpan OutsideList) -> Node insideInteractive insidePhrasing OutsideSpan OutsideList
div =
    Div << flowDefaultsComposedToAttrs


ul : List (FlowAttributes -> FlowAttributes) -> List (Node insideInteractive insidePhrasing OutsideSpan InsideList) -> Node insideInteractive insidePhrasing OutsideSpan OutsideList
ul =
    Ul << flowDefaultsComposedToAttrs


ol : List (FlowAttributes -> FlowAttributes) -> List (Node insideInteractive insidePhrasing OutsideSpan InsideList) -> Node insideInteractive insidePhrasing OutsideSpan OutsideList
ol =
    Ol << flowDefaultsComposedToAttrs


li : List (FlowAttributes -> FlowAttributes) -> List (Node insideInteractive insidePhrasing OutsideSpan OutsideList) -> Node insideInteractive insidePhrasing OutsideSpan InsideList
li =
    Li << flowDefaultsComposedToAttrs


p : List (FlowAttributes -> FlowAttributes) -> List (Node insideInteractive InsidePhrasing OutsideSpan OutsideList) -> Node insideInteractive OutsidePhrasing insideSpan OutsideList
p =
    P << flowDefaultsComposedToAttrs


br : List (FlowAttributes -> FlowAttributes) -> Node insideInteractive InsidePhrasing insideSpan OutsideList
br =
    Br << flowDefaultsComposedToAttrs


span : List (FlowAttributes -> FlowAttributes) -> List (Node insideInteractive InsidePhrasing InsideSpan OutsideList) -> Node insideInteractive insidePhrasing insideSpan OutsideList
span =
    Span << flowDefaultsComposedToAttrs


textarea : List (TextareaAttributes -> TextareaAttributes) -> Node OutsideInteractive insidePhrasing insideSpan OutsideList
textarea =
    Textarea << defaultsComposedToAttrs { value = Nothing, class = [], id = Nothing, style = [], hoverStyle = [] }


img : String -> String -> List (ImgAttributes -> ImgAttributes) -> Node insideInteractive insidePhrasing insideSpan OutsideList
img alt src =
    Img << defaultsComposedToAttrs { src = src, alt = alt, class = [], id = Nothing, style = [], hoverStyle = [] }


audio : List (AudioAttributes -> AudioAttributes) -> Node OutsideInteractive insidePhrasing insideSpan OutsideList
audio =
    Audio << defaultsComposedToAttrs { class = [], id = Nothing, style = [], hoverStyle = [] }


progress : List (ProgressAttributes -> ProgressAttributes) -> Node OutsideInteractive insidePhrasing insideSpan OutsideList
progress =
    Progress << defaultsComposedToAttrs { class = [], id = Nothing, style = [], hoverStyle = [] }


table :
    List (Node insideInteractive insidePhrasing insideSpan OutsideList)
    -> List (List (Node insideInteractive insidePhrasing insideSpan OutsideList))
    -> Node insideInteractive insidePhrasing insideSpan OutsideList
table =
    Table


text : String -> Node insideInteractive insidePhrasing insideSpan OutsideList
text =
    Text


node :
    List (FlowAttributes -> FlowAttributes)
    -> List (Node insideInteractive insidePhrasing OutsideSpan OutsideList)
    -> Node insideInteractive insidePhrasing OutsideSpan OutsideList
node =
    div


leaf :
    List (FlowAttributes -> FlowAttributes)
    -> Node insideInteractive insidePhrasing OutsideSpan OutsideList
leaf =
    flip node []


container :
    List (Node insideInteractive insidePhrasing OutsideSpan OutsideList)
    -> Node insideInteractive insidePhrasing OutsideSpan OutsideList
container =
    node []


mapLis :
    List (Node insideInteractive insidePhrasing OutsideSpan OutsideList)
    -> List (Node insideInteractive insidePhrasing OutsideSpan InsideList)
mapLis =
    List.map (\content -> li [] [ content ])


olLi :
    List (FlowAttributes -> FlowAttributes)
    -> List (Node insideInteractive insidePhrasing OutsideSpan OutsideList)
    -> Node insideInteractive insidePhrasing OutsideSpan OutsideList
olLi attributes insideLis =
    ol attributes (mapLis insideLis)


ulLi :
    List (FlowAttributes -> FlowAttributes)
    -> List (Node insideInteractive insidePhrasing OutsideSpan OutsideList)
    -> Node insideInteractive insidePhrasing OutsideSpan OutsideList
ulLi attributes insideLis =
    ul attributes (mapLis insideLis)


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


main : Html.Html msg
main =
    nodeToHtml blah


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


buildNode :
    List (Node insideInteractive insidePhrasing insideSpan insideList)
    -> a
    -> String
    -> List (a -> HtmlAttributes msg -> HtmlAttributes msg)
    -> HtmlAttributes msg
buildNode children attributes tag usedBodyToBodyHtmlFunctions =
    let
        newAttrs =
            usedBodyToBodyHtmlFunctions |> List.map (\fun -> fun attributes)
    in
        BodyBuilderHtml.node ([ BodyBuilderHtml.tag tag ] |> List.append newAttrs) (List.map (\x -> toTree x) children)


parentToHtml :
    List (Node insideInteractive insidePhrasing insideSpan insideList)
    -> a
    -> String
    -> List (a -> HtmlAttributes msg -> HtmlAttributes msg)
    -> HtmlAttributes msg
parentToHtml =
    buildNode


childToHtml :
    a
    -> String
    -> List (a -> HtmlAttributes msg -> HtmlAttributes msg)
    -> HtmlAttributes msg
childToHtml attributes =
    buildNode [] attributes


baseHandling =
    [ handleStyle, handleClass, handleId ]


toTree : Node insideInteractive insidePhrasing insideSpan insideList -> BodyBuilderHtml.HtmlAttributes msg
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

        _ ->
            BodyBuilderHtml.none



-- Table _ _ ->
--     "table"
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


nodeToHtml : Node insideInteractive insidePhrasing insideSpan insideList -> Html.Html msg
nodeToHtml node =
    node |> toTree |> BodyBuilderHtml.view



-- notCompiling =
--     a [ input ]
--
-- notCompiling : Node OutsideInteractive insidePhrasing insideSpan
-- notCompiling =
--     a [ audio ]
--
-- notCompiling : Node OutsideInteractive insidePhrasing OutsideSpan
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
