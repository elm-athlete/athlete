module BodyBuilder exposing (..)

import Html
import Html.Attributes
import Function exposing (compose)
import Elegant exposing (Style)


type alias Tree =
    { tag : String
    , content : List HtmlAttributes
    , style : Maybe Style
    , hoverStyle : Maybe Style
    }


type HtmlAttributes
    = HtmlAttributes Tree


base : HtmlAttributes
base =
    HtmlAttributes
        { tag = "div"
        , content = []
        , style = Nothing
        , hoverStyle = Nothing
        }


classes : Maybe Style -> Html.Attribute msg
classes styles =
    Html.Attributes.class (Elegant.classes styles)


hoverClasses : Maybe Style -> Html.Attribute msg
hoverClasses styles =
    Html.Attributes.class (Elegant.classesHover styles)


fold : (Tree -> b -> b) -> b -> HtmlAttributes -> b
fold fun answerSoFar (HtmlAttributes tree) =
    List.foldr
        (\e accu -> fold fun accu e)
        (fun tree answerSoFar)
        tree.content


getAllStyles : HtmlAttributes -> List ( Maybe Style, Maybe Style )
getAllStyles tree =
    fold (\e acu -> ( e.style, e.hoverStyle ) :: acu) [] tree


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


style : List (Elegant.Style -> Elegant.Style) -> HtmlAttributes -> HtmlAttributes
style val (HtmlAttributes attrs) =
    HtmlAttributes { attrs | style = Just (Elegant.applyStyle val) }


hoverStyle : List (Elegant.Style -> Elegant.Style) -> HtmlAttributes -> HtmlAttributes
hoverStyle val (HtmlAttributes attrs) =
    HtmlAttributes { attrs | hoverStyle = Just (Elegant.applyStyle val) }


content : List HtmlAttributes -> HtmlAttributes -> HtmlAttributes
content val (HtmlAttributes attrs) =
    HtmlAttributes { attrs | content = val }


div : HtmlAttributes -> HtmlAttributes
div =
    tag "div"


node : List (HtmlAttributes -> HtmlAttributes) -> HtmlAttributes
node htmlAttributesModifiers =
    base
        |> compose htmlAttributesModifiers
