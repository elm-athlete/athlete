module BodyBuilder exposing (HtmlAttributes, toHtml, tag, style, hoverStyle, content, div, node)

import Html
import Html.Attributes
import Function exposing (compose)
import Elegant exposing (Style)


type alias Tree =
    { tag : String
    , content : List HtmlAttributes
    , style : Style
    , hoverStyle : Style
    }


type HtmlAttributes
    = HtmlAttributes Tree


base : HtmlAttributes
base =
    HtmlAttributes
        { tag = "div"
        , content = []
        , style = Elegant.defaultStyle
        , hoverStyle = Elegant.defaultStyle
        }


classes : Style -> Html.Attribute msg
classes =
    Html.Attributes.class << Elegant.classes


hoverClasses : Style -> Html.Attribute msg
hoverClasses =
    Html.Attributes.class << Elegant.classesHover


fold : (Tree -> a -> a) -> a -> HtmlAttributes -> a
fold fun accumulator (HtmlAttributes tree) =
    List.foldr
        (flip (fold fun))
        (fun tree accumulator)
        tree.content


getAllStyles : HtmlAttributes -> List ( Style, Style )
getAllStyles =
    fold (\node accumulator -> ( node.style, node.hoverStyle ) :: accumulator) []


htmlAttributesToCss : HtmlAttributes -> Html.Html msg
htmlAttributesToCss val =
    Html.text (Elegant.stylesToCss (getAllStyles val))


htmlAttributesToHtml : HtmlAttributes -> Html.Html msg
htmlAttributesToHtml (HtmlAttributes val) =
    Html.node val.tag
        [ classes val.style
        , hoverClasses val.hoverStyle
        ]
        (val.content |> List.map htmlAttributesToHtml)


toHtml : HtmlAttributes -> Html.Html msg
toHtml val =
    Html.div []
        [ Html.node "style"
            []
            [ htmlAttributesToCss val ]
        , htmlAttributesToHtml val
        ]


tag : String -> HtmlAttributes -> HtmlAttributes
tag val (HtmlAttributes attrs) =
    HtmlAttributes { attrs | tag = val }


style : List (Style -> Style) -> HtmlAttributes -> HtmlAttributes
style val (HtmlAttributes attrs) =
    HtmlAttributes { attrs | style = (compose val) attrs.style }


hoverStyle : List (Style -> Style) -> HtmlAttributes -> HtmlAttributes
hoverStyle val (HtmlAttributes attrs) =
    HtmlAttributes { attrs | hoverStyle = (compose val) attrs.hoverStyle }


content : List HtmlAttributes -> HtmlAttributes -> HtmlAttributes
content val (HtmlAttributes attrs) =
    HtmlAttributes { attrs | content = val }


div : List (HtmlAttributes -> HtmlAttributes) -> List HtmlAttributes -> HtmlAttributes
div =
    node << List.append [ tag "div" ]


node : List (HtmlAttributes -> HtmlAttributes) -> List HtmlAttributes -> HtmlAttributes
node htmlAttributesTransformers children =
    base |> compose htmlAttributesTransformers >> content children
