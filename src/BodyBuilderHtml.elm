module BodyBuilderHtml
    exposing
        ( HtmlAttributes
        , view
        , style
        , hoverStyle
        , content
        , div
        , tag
        , input
        , range
        , text
        , node
        , leaf
        , container
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
    , checked : Bool
    , value : Maybe String

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
        , checked = False
        , value = Nothing

        -- Html Events
        , onInput = Nothing

        -- Children
        , text = ""
        , content = []
        }


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


fold : (Tree msg -> a -> a) -> a -> HtmlAttributes msg -> a
fold fun accumulator (HtmlAttributes tree) =
    List.foldr
        (flip (fold fun))
        (fun tree accumulator)
        tree.content


getAllStyles : HtmlAttributes msg -> List { style : Style, suffix : Maybe String, mediaQuery : Maybe ( Maybe Int, Maybe Int ) }
getAllStyles =
    fold
        (\node accumulator ->
            { style = node.style
            , suffix = Nothing
            , mediaQuery = Nothing
            }
                :: { style = node.hoverStyle
                   , suffix = Just "hover"
                   , mediaQuery = Nothing
                   }
                :: accumulator
        )
        []


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
                    [ classes val.style
                    , hoverClasses val.hoverStyle
                    , if val.checked then
                        []
                      else
                        [ Html.Attributes.checked True ]
                    , Helpers.emptyListOrApply Html.Attributes.type_ val.type_
                    , Helpers.emptyListOrApply Html.Attributes.max val.max
                    , Helpers.emptyListOrApply Html.Attributes.min val.min
                    , Helpers.emptyListOrApply Html.Attributes.defaultValue val.defaultValue
                    , Helpers.emptyListOrApply Html.Events.onInput val.onInput
                    , Helpers.emptyListOrApply Html.Attributes.value val.value
                    ]
                )
                (val.content |> List.map htmlAttributesToHtml)


view : HtmlAttributes msg -> Html.Html msg
view val =
    Html.div []
        [ Html.node "style" [] [ htmlAttributesToCss val ]
        , htmlAttributesToHtml val
        ]


tag : String -> HtmlAttributes msg -> HtmlAttributes msg
tag val (HtmlAttributes attrs) =
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


checked : Bool -> HtmlAttributes msg -> HtmlAttributes msg
checked val (HtmlAttributes attrs) =
    HtmlAttributes { attrs | checked = val }


div : HtmlAttributes msg -> HtmlAttributes msg
div =
    tag "div"


input : HtmlAttributes msg -> HtmlAttributes msg
input =
    tag "input"


range : Int -> Int -> (String -> msg) -> HtmlAttributes msg -> HtmlAttributes msg
range min_ max_ onInput_ =
    input
        >> type_ "range"
        >> max (toString max_)
        >> min (toString min_)
        >> onInput onInput_


button : HtmlAttributes msg -> HtmlAttributes msg
button =
    input
        >> type_ "button"


checkbox : Bool -> HtmlAttributes msg -> HtmlAttributes msg
checkbox checked_ =
    input
        >> type_ "checkbox"
        >> checked checked_


color : HtmlAttributes msg -> HtmlAttributes msg
color =
    input
        >> type_ "color"


date : HtmlAttributes msg -> HtmlAttributes msg
date =
    input
        >> type_ "date"


datetimeLocal : HtmlAttributes msg -> HtmlAttributes msg
datetimeLocal =
    input
        >> type_ "datetime-local"


email : HtmlAttributes msg -> HtmlAttributes msg
email =
    input
        >> type_ "email"


file : HtmlAttributes msg -> HtmlAttributes msg
file =
    input
        >> type_ "file"


hidden : HtmlAttributes msg -> HtmlAttributes msg
hidden =
    input
        >> type_ "hidden"


password : HtmlAttributes msg -> HtmlAttributes msg
password =
    input
        >> type_ "password"


radio : HtmlAttributes msg -> HtmlAttributes msg
radio =
    input
        >> type_ "radio"


submit : HtmlAttributes msg -> HtmlAttributes msg
submit =
    input
        >> type_ "submit"


textField : HtmlAttributes msg -> HtmlAttributes msg
textField =
    input
        >> type_ "text"


value : String -> HtmlAttributes msg -> HtmlAttributes msg
value val (HtmlAttributes attrs) =
    HtmlAttributes { attrs | value = Just val }


text : String -> HtmlAttributes msg
text value =
    text_ value base


node : List (HtmlAttributes msg -> HtmlAttributes msg) -> List (HtmlAttributes msg) -> HtmlAttributes msg
node htmlAttributesTransformers children =
    base
        |> div
        |> compose htmlAttributesTransformers
        |> content children


leaf : List (HtmlAttributes msg -> HtmlAttributes msg) -> HtmlAttributes msg
leaf =
    flip node []


container : List (HtmlAttributes msg) -> HtmlAttributes msg
container =
    node []
