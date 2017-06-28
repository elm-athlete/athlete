module BodyBuilder
    exposing
        ( HtmlAttributes
        , view
        , style
        , hoverStyle
        , content
        , div
        , input
        , range
        , text
        , node
        , type_
        , max
        , min
        , defaultValue
        , onInput
        )

import Html
import Html.Attributes
import Html.Events
import Function exposing (compose)
import Elegant exposing (Style)
import Elegant.Helpers as Helpers


type alias Tree msg =
    { -- Html Attributes
      tag : Maybe String
    , type_ : Maybe String
    , max : Maybe String
    , min : Maybe String
    , defaultValue : Maybe String
    , style : Style
    , hoverStyle : Style

    -- Html Events
    , onInput : Maybe (String -> msg)

    -- Children
    , text : String
    , content : List (HtmlAttributes msg)
    }


type HtmlAttributes msg
    = HtmlAttributes (Tree msg)


base : HtmlAttributes msg
base =
    HtmlAttributes
        { -- Html Attributes
          tag = Nothing
        , type_ = Nothing
        , max = Nothing
        , min = Nothing
        , defaultValue = Nothing
        , style = Elegant.defaultStyle
        , hoverStyle = Elegant.defaultStyle

        -- Html Events
        , onInput = Nothing

        -- Children
        , text = ""
        , content = []
        }


classes : Style -> Html.Attribute msg
classes =
    Html.Attributes.class << Elegant.classes


hoverClasses : Style -> Html.Attribute msg
hoverClasses =
    Html.Attributes.class << Elegant.classesHover


fold : (Tree msg -> a -> a) -> a -> HtmlAttributes msg -> a
fold fun accumulator (HtmlAttributes tree) =
    List.foldr
        (flip (fold fun))
        (fun tree accumulator)
        tree.content


getAllStyles : HtmlAttributes msg -> List ( Style, Style )
getAllStyles =
    fold (\node accumulator -> ( node.style, node.hoverStyle ) :: accumulator) []


htmlAttributesToCss : HtmlAttributes msg -> Html.Html msg
htmlAttributesToCss val =
    Html.text (Elegant.stylesToCss (getAllStyles val))


htmlAttributesToHtml : HtmlAttributes msg -> Html.Html msg
htmlAttributesToHtml (HtmlAttributes val) =
    case val.tag of
        Nothing ->
            Html.text val.text

        Just tag_ ->
            Html.node tag_
                (List.concat
                    [ [ classes val.style ]
                    , [ hoverClasses val.hoverStyle ]
                    , Helpers.emptyListOrApply Html.Attributes.type_ val.type_
                    , Helpers.emptyListOrApply Html.Attributes.max val.max
                    , Helpers.emptyListOrApply Html.Attributes.min val.min
                    , Helpers.emptyListOrApply Html.Attributes.defaultValue val.defaultValue
                    , Helpers.emptyListOrApply Html.Events.onInput val.onInput
                    ]
                )
                (val.content |> List.map htmlAttributesToHtml)


view : HtmlAttributes msg -> Html.Html msg
view val =
    Html.div []
        [ Html.node "style"
            []
            [ htmlAttributesToCss val ]
        , htmlAttributesToHtml val
        ]


tag_ : String -> HtmlAttributes msg -> HtmlAttributes msg
tag_ val (HtmlAttributes attrs) =
    HtmlAttributes { attrs | tag = Just val }


type_ : String -> HtmlAttributes msg -> HtmlAttributes msg
type_ val (HtmlAttributes attrs) =
    HtmlAttributes { attrs | type_ = Just val }


text_ : String -> HtmlAttributes msg -> HtmlAttributes msg
text_ val (HtmlAttributes attrs) =
    HtmlAttributes { attrs | text = val }


max : String -> HtmlAttributes msg -> HtmlAttributes msg
max val (HtmlAttributes attrs) =
    HtmlAttributes { attrs | max = Just val }


min : String -> HtmlAttributes msg -> HtmlAttributes msg
min val (HtmlAttributes attrs) =
    HtmlAttributes { attrs | min = Just val }


defaultValue : String -> HtmlAttributes msg -> HtmlAttributes msg
defaultValue val (HtmlAttributes attrs) =
    HtmlAttributes { attrs | defaultValue = Just val }


onInput : (String -> msg) -> HtmlAttributes msg -> HtmlAttributes msg
onInput val (HtmlAttributes attrs) =
    HtmlAttributes { attrs | onInput = Just val }


style : List (Style -> Style) -> HtmlAttributes msg -> HtmlAttributes msg
style val (HtmlAttributes attrs) =
    HtmlAttributes { attrs | style = (compose val) attrs.style }


hoverStyle : List (Style -> Style) -> HtmlAttributes msg -> HtmlAttributes msg
hoverStyle val (HtmlAttributes attrs) =
    HtmlAttributes { attrs | hoverStyle = (compose val) attrs.hoverStyle }


content : List (HtmlAttributes msg) -> HtmlAttributes msg -> HtmlAttributes msg
content val (HtmlAttributes attrs) =
    HtmlAttributes { attrs | content = val }


div : List (HtmlAttributes msg -> HtmlAttributes msg) -> List (HtmlAttributes msg) -> HtmlAttributes msg
div =
    node "div"


input : List (HtmlAttributes msg -> HtmlAttributes msg) -> List (HtmlAttributes msg) -> HtmlAttributes msg
input =
    node "input"


range :
    { max : String
    , min : String
    , onInput : String -> msg
    }
    -> List (HtmlAttributes msg -> HtmlAttributes msg)
    -> HtmlAttributes msg
range values attrs =
    base
        |> tag_ "input"
        |> type_ "range"
        |> max values.max
        |> min values.min
        |> onInput values.onInput
        |> compose attrs


text : String -> HtmlAttributes msg
text value =
    text_ value base


node : String -> List (HtmlAttributes msg -> HtmlAttributes msg) -> List (HtmlAttributes msg) -> HtmlAttributes msg
node tag htmlAttributesTransformers children =
    base
        |> tag_ tag
        |> compose htmlAttributesTransformers
        >> content children
