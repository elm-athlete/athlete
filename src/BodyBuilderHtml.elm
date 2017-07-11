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
        , src
        , alt
        , defaultValue
        , onInput
        , href
        , none
        , id
        , class
        , hidden
        , tabindex
        , title
        , value
        , name
        , disabled
        , checked
        , selectOption
        , target
        , onClick
        , onDoubleClick
        , onMouseUp
        , onMouseOut
        , onMouseOver
        , onMouseDown
        , onMouseLeave
        , onMouseEnter
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
    , checked : Maybe Bool
    , value : Maybe String
    , href : Maybe String
    , src : Maybe String
    , alt : Maybe String
    , class : List String
    , id : Maybe String
    , name : Maybe String
    , selected : Maybe Bool
    , target : Maybe String
    , hidden : Bool
    , tabindex : Maybe Int
    , title : Maybe String
    , disabled : Maybe Bool

    -- Html Events
    , onInput : Maybe (String -> msg)
    , onClick : Maybe msg
    , onDoubleClick : Maybe msg
    , onMouseUp : Maybe msg
    , onMouseOut : Maybe msg
    , onMouseOver : Maybe msg
    , onMouseDown : Maybe msg
    , onMouseLeave : Maybe msg
    , onMouseEnter : Maybe msg

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
        , checked = Nothing
        , value = Nothing
        , href = Nothing
        , src = Nothing
        , alt = Nothing
        , class = []
        , id = Nothing
        , name = Nothing
        , selected = Nothing
        , target = Nothing
        , hidden = False
        , tabindex = Nothing
        , title = Nothing
        , disabled = Nothing

        -- Html Events
        , onInput = Nothing
        , onClick = Nothing
        , onDoubleClick = Nothing
        , onMouseUp = Nothing
        , onMouseOut = Nothing
        , onMouseOver = Nothing
        , onMouseDown = Nothing
        , onMouseLeave = Nothing
        , onMouseEnter = Nothing

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
    Html.text
        (Elegant.stylesToCss (getAllStyles val))


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
                    , [ Html.Attributes.hidden val.hidden ]
                    , Helpers.emptyListOrApply Html.Attributes.class
                        (if val.class |> List.isEmpty then
                            Nothing
                         else
                            Just (val.class |> String.join " ")
                        )
                    , Helpers.emptyListOrApply Html.Attributes.type_ val.type_
                    , Helpers.emptyListOrApply Html.Attributes.max val.max
                    , Helpers.emptyListOrApply Html.Attributes.min val.min
                    , Helpers.emptyListOrApply Html.Attributes.src val.src
                    , Helpers.emptyListOrApply Html.Attributes.alt val.alt
                    , Helpers.emptyListOrApply Html.Attributes.id val.id
                    , Helpers.emptyListOrApply Html.Attributes.tabindex val.tabindex
                    , Helpers.emptyListOrApply Html.Attributes.title val.title
                    , Helpers.emptyListOrApply Html.Attributes.defaultValue val.defaultValue
                    , Helpers.emptyListOrApply Html.Events.onInput val.onInput
                    , Helpers.emptyListOrApply Html.Attributes.value val.value
                    , Helpers.emptyListOrApply Html.Attributes.name val.name
                    , Helpers.emptyListOrApply Html.Attributes.checked val.checked
                    , Helpers.emptyListOrApply Html.Attributes.href val.href
                    , Helpers.emptyListOrApply Html.Attributes.selected val.selected
                    , Helpers.emptyListOrApply Html.Attributes.target val.target
                    , Helpers.emptyListOrApply Html.Attributes.disabled val.disabled
                    , Helpers.emptyListOrApply Html.Events.onClick val.onClick
                    , Helpers.emptyListOrApply Html.Events.onDoubleClick val.onDoubleClick
                    , Helpers.emptyListOrApply Html.Events.onMouseUp val.onMouseUp
                    , Helpers.emptyListOrApply Html.Events.onMouseOut val.onMouseOut
                    , Helpers.emptyListOrApply Html.Events.onMouseOver val.onMouseOver
                    , Helpers.emptyListOrApply Html.Events.onMouseDown val.onMouseDown
                    , Helpers.emptyListOrApply Html.Events.onMouseLeave val.onMouseLeave
                    , Helpers.emptyListOrApply Html.Events.onMouseEnter val.onMouseEnter
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


href : String -> HtmlAttributes msg -> HtmlAttributes msg
href val (HtmlAttributes attrs) =
    HtmlAttributes { attrs | href = Just val }


id : String -> HtmlAttributes msg -> HtmlAttributes msg
id val (HtmlAttributes attrs) =
    HtmlAttributes { attrs | id = Just val }


class : List String -> HtmlAttributes msg -> HtmlAttributes msg
class val (HtmlAttributes attrs) =
    HtmlAttributes { attrs | class = val }


tabindex : Int -> HtmlAttributes msg -> HtmlAttributes msg
tabindex val (HtmlAttributes attrs) =
    HtmlAttributes { attrs | tabindex = Just val }


title : String -> HtmlAttributes msg -> HtmlAttributes msg
title val (HtmlAttributes attrs) =
    HtmlAttributes { attrs | title = Just val }


disabled : HtmlAttributes msg -> HtmlAttributes msg
disabled (HtmlAttributes attrs) =
    HtmlAttributes { attrs | disabled = Just True }


min : String -> HtmlAttributes msg -> HtmlAttributes msg
min val (HtmlAttributes attrs) =
    HtmlAttributes { attrs | min = Just val }


src : String -> HtmlAttributes msg -> HtmlAttributes msg
src val (HtmlAttributes attrs) =
    HtmlAttributes { attrs | src = Just val }


target : String -> HtmlAttributes msg -> HtmlAttributes msg
target val (HtmlAttributes attrs) =
    HtmlAttributes { attrs | target = Just val }


name : String -> HtmlAttributes msg -> HtmlAttributes msg
name val (HtmlAttributes attrs) =
    HtmlAttributes { attrs | name = Just val }


alt : String -> HtmlAttributes msg -> HtmlAttributes msg
alt val (HtmlAttributes attrs) =
    HtmlAttributes { attrs | alt = Just val }


hidden : HtmlAttributes msg -> HtmlAttributes msg
hidden (HtmlAttributes attrs) =
    (HtmlAttributes { attrs | hidden = True })


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
    HtmlAttributes { attrs | content = List.append attrs.content val }


checked : Bool -> HtmlAttributes msg -> HtmlAttributes msg
checked val (HtmlAttributes attrs) =
    HtmlAttributes { attrs | checked = Just val }


selectOption : Maybe String -> HtmlAttributes msg -> HtmlAttributes msg
selectOption value (HtmlAttributes attrs) =
    HtmlAttributes { attrs | content = List.map (selected value) attrs.content }


selected : Maybe String -> HtmlAttributes msg -> HtmlAttributes msg
selected value (HtmlAttributes attrs) =
    HtmlAttributes
        { attrs
            | selected =
                if attrs.value == value then
                    Just True
                else
                    Nothing
        }


onClick : msg -> HtmlAttributes msg -> HtmlAttributes msg
onClick value (HtmlAttributes attrs) =
    HtmlAttributes { attrs | onClick = Just value }


onDoubleClick : msg -> HtmlAttributes msg -> HtmlAttributes msg
onDoubleClick value (HtmlAttributes attrs) =
    HtmlAttributes { attrs | onDoubleClick = Just value }


onMouseUp : msg -> HtmlAttributes msg -> HtmlAttributes msg
onMouseUp value (HtmlAttributes attrs) =
    HtmlAttributes { attrs | onMouseUp = Just value }


onMouseOut : msg -> HtmlAttributes msg -> HtmlAttributes msg
onMouseOut value (HtmlAttributes attrs) =
    HtmlAttributes { attrs | onMouseOut = Just value }


onMouseOver : msg -> HtmlAttributes msg -> HtmlAttributes msg
onMouseOver value (HtmlAttributes attrs) =
    HtmlAttributes { attrs | onMouseOver = Just value }


onMouseDown : msg -> HtmlAttributes msg -> HtmlAttributes msg
onMouseDown value (HtmlAttributes attrs) =
    HtmlAttributes { attrs | onMouseDown = Just value }


onMouseLeave : msg -> HtmlAttributes msg -> HtmlAttributes msg
onMouseLeave value (HtmlAttributes attrs) =
    HtmlAttributes { attrs | onMouseLeave = Just value }


onMouseEnter : msg -> HtmlAttributes msg -> HtmlAttributes msg
onMouseEnter value (HtmlAttributes attrs) =
    HtmlAttributes { attrs | onMouseEnter = Just value }


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


hiddenInput : HtmlAttributes msg -> HtmlAttributes msg
hiddenInput =
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


value : Maybe String -> HtmlAttributes msg -> HtmlAttributes msg
value val (HtmlAttributes attrs) =
    HtmlAttributes { attrs | value = val }


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


none : HtmlAttributes msg
none =
    text ""
