module BodyBuilder exposing (..)

import Elegant exposing (Style)
import Html
import Function exposing (..)
import BodyBuilderHtml exposing (HtmlAttributes)
import Color exposing (Color)
import Color.Convert as Color
import Maybe.Extra as Maybe


type alias Url =
    String


unwrap : (a -> b -> b) -> Maybe a -> b -> b
unwrap =
    Maybe.unwrap identity


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



{-
   ███████ ██    ██ ███████ ███    ██ ████████ ███████
   ██      ██    ██ ██      ████   ██    ██    ██
   █████   ██    ██ █████   ██ ██  ██    ██    ███████
   ██       ██  ██  ██      ██  ██ ██    ██         ██
   ███████   ████   ███████ ██   ████    ██    ███████
-}


type alias OnMouseEventsInside msg =
    { click : Maybe msg
    , doubleClick : Maybe msg
    , mouseDown : Maybe msg
    , mouseUp : Maybe msg
    , mouseEnter : Maybe msg
    , mouseLeave : Maybe msg
    , mouseOver : Maybe msg
    , mouseOut : Maybe msg
    }


defaultOnMouseEvents : OnMouseEventsInside msg
defaultOnMouseEvents =
    OnMouseEventsInside Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing


type alias OnMouseEvents msg a =
    { a | onMouseEvents : OnMouseEventsInside msg }



{-
    █████  ████████ ████████ ██████  ██ ██████  ██    ██ ████████ ███████ ███████
   ██   ██    ██       ██    ██   ██ ██ ██   ██ ██    ██    ██    ██      ██
   ███████    ██       ██    ██████  ██ ██████  ██    ██    ██    █████   ███████
   ██   ██    ██       ██    ██   ██ ██ ██   ██ ██    ██    ██    ██           ██
   ██   ██    ██       ██    ██   ██ ██ ██████   ██████     ██    ███████ ███████
-}


type alias IdAttribute a =
    { a | id : Maybe String }


type alias ClassAttribute a =
    { a | class : List String }


type alias TabindexAttribute a =
    { a | tabindex : Maybe Int }


type alias TitleAttribute a =
    { a | title : Maybe String }


type alias UniversalAttributes a =
    TitleAttribute (TabindexAttribute (IdAttribute (ClassAttribute a)))


defaultUniversalAttributes : UniversalAttributes {}
defaultUniversalAttributes =
    { class = []
    , id = Nothing
    , tabindex = Nothing
    , title = Nothing
    }


type alias StyleAttribute =
    { standard : List (Style -> Style)
    , hover : List (Style -> Style)
    }


defaultStyleAttribute : StyleAttribute
defaultStyleAttribute =
    { standard = []
    , hover = []
    }


type alias VisibleAttributes a =
    { a
        | style : StyleAttribute
        , universal : UniversalAttributes {}
    }


type alias VisibleAttributesAndEvents msg a =
    OnMouseEvents msg (VisibleAttributes a)


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


type alias StringValue a =
    ValueAttribute String a


type alias IntValue a =
    ValueAttribute Int a


type alias ColorValue a =
    ValueAttribute Color a


type alias NameAttribute a =
    { a | name : Maybe String }


type alias OptionsAttribute a =
    { a | options : List { value : String, label : String } }


type alias DisabledAttribute a =
    { a | disabled : Bool }


type alias WidthAttribute a =
    { a | width : Maybe Int }


type alias HeightAttribute a =
    { a | height : Maybe Int }



{-
   ███████ ██      ███████ ███    ███      █████  ████████ ████████ ██████  ███████
   ██      ██      ██      ████  ████     ██   ██    ██       ██    ██   ██ ██
   █████   ██      █████   ██ ████ ██     ███████    ██       ██    ██████  ███████
   ██      ██      ██      ██  ██  ██     ██   ██    ██       ██    ██   ██      ██
   ███████ ███████ ███████ ██      ██     ██   ██    ██       ██    ██   ██ ███████
-}


type alias AAttributes msg =
    TargetAttribute (HrefAttribute (VisibleAttributesAndEvents msg {}))


type alias FlowAttributes msg =
    VisibleAttributesAndEvents msg {}


type alias ImgAttributes msg =
    HeightAttribute (WidthAttribute (AltAttribute (SrcAttribute (VisibleAttributesAndEvents msg {}))))


type alias IframeAttributes msg =
    SrcAttribute (VisibleAttributesAndEvents msg {})


type alias InputAttributes a =
    NameAttribute { a | type_ : String }


type alias InputHiddenAttributes =
    InputAttributes
        (StringValue
            { universal : UniversalAttributes {}
            , type_ : String
            }
        )


type alias InputVisibleAttributes msg a =
    VisibleAttributesAndEvents msg (InputAttributes a)


type alias InputTextAttributes msg a =
    StringValue (InputVisibleAttributes msg a)


type alias TextareaAttributes msg =
    NameAttribute (StringValue (VisibleAttributesAndEvents msg {}))


type alias ButtonAttributes msg a =
    DisabledAttribute (VisibleAttributesAndEvents msg a)


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
    StringValue (OptionsAttribute (VisibleAttributesAndEvents msg {}))


type alias ProgressAttributes msg =
    VisibleAttributesAndEvents msg {}


type alias AudioAttributes msg =
    SrcAttribute (VisibleAttributesAndEvents msg {})


type alias VideoAttributes msg =
    VisibleAttributesAndEvents msg {}


type alias CanvasAttributes msg =
    HeightAttribute (WidthAttribute (VisibleAttributesAndEvents msg {}))



{-
   ██   ██ ████████ ███    ███ ██           █████  ███████ ████████
   ██   ██    ██    ████  ████ ██          ██   ██ ██         ██
   ███████    ██    ██ ████ ██ ██          ███████ ███████    ██
   ██   ██    ██    ██  ██  ██ ██          ██   ██      ██    ██
   ██   ██    ██    ██      ██ ███████     ██   ██ ███████    ██
-}


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


defaultsComposedToAttrs : a -> List (a -> a) -> a
defaultsComposedToAttrs defaults attrs =
    (defaults |> (attrs |> compose))


styleAttribute style =
    { standard = style
    , hover = []
    }


flowDefaultsComposedToAttrsWithStyle style =
    defaultsComposedToAttrs { style = styleAttribute style, universal = defaultUniversalAttributes, onMouseEvents = defaultOnMouseEvents }


flowDefaultsComposedToAttrs =
    flowDefaultsComposedToAttrsWithStyle []


flowDefaultsComposedToAttrsWithFontSize fontSize =
    flowDefaultsComposedToAttrsWithStyle [ Elegant.fontSize fontSize ]



{-
   ██   ██ ████████ ███    ███ ██           ██████  ██████  ███    ██ ███████ ████████ ██████  ██    ██  ██████ ████████
   ██   ██    ██    ████  ████ ██          ██      ██    ██ ████   ██ ██         ██    ██   ██ ██    ██ ██         ██
   ███████    ██    ██ ████ ██ ██          ██      ██    ██ ██ ██  ██ ███████    ██    ██████  ██    ██ ██         ██
   ██   ██    ██    ██  ██  ██ ██          ██      ██    ██ ██  ██ ██      ██    ██    ██   ██ ██    ██ ██         ██
   ██   ██    ██    ██      ██ ███████      ██████  ██████  ██   ████ ███████    ██    ██   ██  ██████   ██████    ██
-}


h1 :
    List (FlowAttributes msg -> FlowAttributes msg)
    -> List (Node interactiveContent Phrasing Spanning NotListElement msg)
    -> Node interactiveContent NotPhrasing Spanning NotListElement msg
h1 =
    H 1 << (flowDefaultsComposedToAttrsWithFontSize Elegant.alpha)


h2 :
    List (FlowAttributes msg -> FlowAttributes msg)
    -> List (Node interactiveContent Phrasing Spanning NotListElement msg)
    -> Node interactiveContent NotPhrasing Spanning NotListElement msg
h2 =
    H 2 << (flowDefaultsComposedToAttrsWithFontSize Elegant.beta)


h3 :
    List (FlowAttributes msg -> FlowAttributes msg)
    -> List (Node interactiveContent Phrasing Spanning NotListElement msg)
    -> Node interactiveContent NotPhrasing Spanning NotListElement msg
h3 =
    H 3 << (flowDefaultsComposedToAttrsWithFontSize Elegant.gamma)


h4 :
    List (FlowAttributes msg -> FlowAttributes msg)
    -> List (Node interactiveContent Phrasing Spanning NotListElement msg)
    -> Node interactiveContent NotPhrasing Spanning NotListElement msg
h4 =
    H 4 << (flowDefaultsComposedToAttrsWithFontSize Elegant.delta)


h5 :
    List (FlowAttributes msg -> FlowAttributes msg)
    -> List (Node interactiveContent Phrasing Spanning NotListElement msg)
    -> Node interactiveContent NotPhrasing Spanning NotListElement msg
h5 =
    H 5 << (flowDefaultsComposedToAttrsWithFontSize Elegant.epsilon)


h6 :
    List (FlowAttributes msg -> FlowAttributes msg)
    -> List (Node interactiveContent Phrasing Spanning NotListElement msg)
    -> Node interactiveContent NotPhrasing Spanning NotListElement msg
h6 =
    H 6 << (flowDefaultsComposedToAttrsWithFontSize Elegant.zeta)


a :
    List (AAttributes msg -> AAttributes msg)
    -> List (Node NotInteractive phrasingContent spanningContent NotListElement msg)
    -> Node Interactive phrasingContent spanningContent NotListElement msg
a =
    A
        << defaultsComposedToAttrs
            { href = Nothing
            , target = Nothing
            , style = defaultStyleAttribute
            , universal = defaultUniversalAttributes
            , onMouseEvents = defaultOnMouseEvents
            }


button :
    List (ButtonAttributes msg {} -> ButtonAttributes msg {})
    -> List (Node NotInteractive phrasingContent spanningContent NotListElement msg)
    -> Node Interactive phrasingContent spanningContent NotListElement msg
button =
    Button
        << defaultsComposedToAttrs
            { universal = defaultUniversalAttributes
            , style = defaultStyleAttribute
            , onMouseEvents = defaultOnMouseEvents
            , disabled = False
            }


div :
    List (FlowAttributes msg -> FlowAttributes msg)
    -> List (Node interactiveContent phrasingContent Spanning NotListElement msg)
    -> Node interactiveContent phrasingContent Spanning NotListElement msg
div =
    Div << flowDefaultsComposedToAttrs


ul :
    List (FlowAttributes msg -> FlowAttributes msg)
    -> List (Node interactiveContent phrasingContent Spanning ListElement msg)
    -> Node interactiveContent phrasingContent Spanning NotListElement msg
ul =
    Ul << flowDefaultsComposedToAttrs


ol :
    List (FlowAttributes msg -> FlowAttributes msg)
    -> List (Node interactiveContent phrasingContent Spanning ListElement msg)
    -> Node interactiveContent phrasingContent Spanning NotListElement msg
ol =
    Ol << flowDefaultsComposedToAttrs


li :
    List (FlowAttributes msg -> FlowAttributes msg)
    -> List (Node interactiveContent phrasingContent Spanning NotListElement msg)
    -> Node interactiveContent phrasingContent Spanning ListElement msg
li =
    Li << flowDefaultsComposedToAttrs


p :
    List (FlowAttributes msg -> FlowAttributes msg)
    -> List (Node interactiveContent Phrasing Spanning NotListElement msg)
    -> Node interactiveContent NotPhrasing spanningContent NotListElement msg
p =
    P << flowDefaultsComposedToAttrs


br :
    List (FlowAttributes msg -> FlowAttributes msg)
    -> Node interactiveContent Phrasing spanningContent NotListElement msg
br =
    Br << flowDefaultsComposedToAttrs


span :
    List (FlowAttributes msg -> FlowAttributes msg)
    -> List (Node interactiveContent Phrasing NotSpanning NotListElement msg)
    -> Node interactiveContent phrasingContent spanningContent NotListElement msg
span =
    Span << flowDefaultsComposedToAttrs


textarea :
    List (TextareaAttributes msg -> TextareaAttributes msg)
    -> Node Interactive phrasingContent spanningContent NotListElement msg
textarea =
    Textarea
        << defaultsComposedToAttrs
            { value = Nothing
            , name = Nothing
            , universal = defaultUniversalAttributes
            , style = defaultStyleAttribute
            , onMouseEvents = defaultOnMouseEvents
            }


img :
    String
    -> String
    -> List (ImgAttributes msg -> ImgAttributes msg)
    -> Node interactiveContent phrasingContent spanningContent NotListElement msg
img alt src =
    Img
        << defaultsComposedToAttrs
            { src = src
            , alt = alt
            , universal = defaultUniversalAttributes
            , style = defaultStyleAttribute
            , onMouseEvents = defaultOnMouseEvents
            , width = Nothing
            , height = Nothing
            }


audio :
    List (AudioAttributes msg -> AudioAttributes msg)
    -> Node Interactive phrasingContent spanningContent NotListElement msg
audio =
    Audio
        << defaultsComposedToAttrs
            { universal = defaultUniversalAttributes
            , style = defaultStyleAttribute
            , onMouseEvents = defaultOnMouseEvents
            , src = ""
            }


progress :
    List (ProgressAttributes msg -> ProgressAttributes msg)
    -> Node Interactive phrasingContent spanningContent NotListElement msg
progress =
    Progress
        << defaultsComposedToAttrs
            { universal = defaultUniversalAttributes
            , style = defaultStyleAttribute
            , onMouseEvents = defaultOnMouseEvents
            }


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
    InputHidden
        << defaultsComposedToAttrs
            { name = Nothing
            , universal = defaultUniversalAttributes
            , type_ = "hidden"
            , value = Nothing
            }


baseInputAttributes : String -> InputVisibleAttributes msg (ValueAttribute a {})
baseInputAttributes type_ =
    { universal = defaultUniversalAttributes
    , style = defaultStyleAttribute
    , name = Nothing
    , type_ = type_
    , value = Nothing
    , onMouseEvents = defaultOnMouseEvents
    }


inputText :
    List (InputTextAttributes msg {} -> InputTextAttributes msg {})
    -> Node Interactive phrasingContent spanningContent listContent msg
inputText =
    InputText << defaultsComposedToAttrs (baseInputAttributes "text")


inputNumber :
    List (InputNumberAttributes msg -> InputNumberAttributes msg)
    -> Node Interactive phrasingContent spanningContent listContent msg
inputNumber =
    InputNumber << defaultsComposedToAttrs (baseInputAttributes "number")


inputSlider :
    List (InputSliderAttributes msg -> InputSliderAttributes msg)
    -> Node Interactive phrasingContent spanningContent listContent msg
inputSlider =
    InputSlider << defaultsComposedToAttrs (baseInputAttributes "range")


inputColor :
    List (InputColorAttributes msg -> InputColorAttributes msg)
    -> Node Interactive phrasingContent spanningContent listContent msg
inputColor =
    InputColor << defaultsComposedToAttrs (baseInputAttributes "color")


inputCheckbox :
    List (InputCheckboxAttributes msg -> InputCheckboxAttributes msg)
    -> Node Interactive phrasingContent spanningContent listContent msg
inputCheckbox =
    InputCheckbox
        << defaultsComposedToAttrs
            { name = Nothing
            , type_ = "checkbox"
            , value = Nothing
            , checked = False
            , universal = defaultUniversalAttributes
            , style = defaultStyleAttribute
            , onMouseEvents = defaultOnMouseEvents
            }


inputFile :
    List (InputFileAttributes msg -> InputFileAttributes msg)
    -> Node Interactive phrasingContent spanningContent listContent msg
inputFile =
    InputFile
        << defaultsComposedToAttrs
            { name = Nothing
            , type_ = "file"
            , universal = defaultUniversalAttributes
            , style = defaultStyleAttribute
            , onMouseEvents = defaultOnMouseEvents
            }


inputPassword :
    List (InputPasswordAttributes msg -> InputPasswordAttributes msg)
    -> Node Interactive phrasingContent spanningContent listContent msg
inputPassword =
    InputPassword
        << defaultsComposedToAttrs
            { name = Nothing
            , type_ = "password"
            , value = Nothing
            , universal = defaultUniversalAttributes
            , style = defaultStyleAttribute
            , onMouseEvents = defaultOnMouseEvents
            }


inputRadio :
    List (InputRadioAttributes msg -> InputRadioAttributes msg)
    -> Node interactiveContent phrasingContent spanningContent listContent msg
inputRadio =
    InputRadio
        << defaultsComposedToAttrs
            { name = Nothing
            , type_ = "radio"
            , value = Nothing
            , universal = defaultUniversalAttributes
            , style = defaultStyleAttribute
            , onMouseEvents = defaultOnMouseEvents
            }


inputRange :
    List (InputRangeAttributes msg -> InputRangeAttributes msg)
    -> Node interactiveContent phrasingContent spanningContent listContent msg
inputRange =
    InputRange
        << defaultsComposedToAttrs
            { name = Nothing
            , type_ = "range"
            , value = Nothing
            , universal = defaultUniversalAttributes
            , style = defaultStyleAttribute
            , onMouseEvents = defaultOnMouseEvents
            }


inputSubmit :
    List (InputSubmitAttributes msg -> InputSubmitAttributes msg)
    -> Node Interactive phrasingContent spanningContent listContent msg
inputSubmit =
    InputSubmit
        << defaultsComposedToAttrs
            { type_ = "submit"
            , universal = defaultUniversalAttributes
            , style = defaultStyleAttribute
            , onMouseEvents = defaultOnMouseEvents
            , disabled = False
            }


inputUrl :
    List (InputUrlAttributes msg -> InputUrlAttributes msg)
    -> Node Interactive phrasingContent spanningContent listContent msg
inputUrl =
    InputUrl
        << defaultsComposedToAttrs
            { name = Nothing
            , value = Nothing
            , type_ = "url"
            , universal = defaultUniversalAttributes
            , style = defaultStyleAttribute
            , onMouseEvents = defaultOnMouseEvents
            }


select :
    List (SelectAttributes msg -> SelectAttributes msg)
    -> Node Interactive phrasingContent spanningContent listContent msg
select list =
    (Select
        << defaultsComposedToAttrs
            { value = Nothing
            , options = []
            , universal = defaultUniversalAttributes
            , style = defaultStyleAttribute
            , onMouseEvents = defaultOnMouseEvents
            }
    )
        list



{-
    █████  ████████ ████████ ██████  ███████      ██████  ██████  ███    ██ ███████ ████████ ██████  ██    ██  ██████ ████████
   ██   ██    ██       ██    ██   ██ ██          ██      ██    ██ ████   ██ ██         ██    ██   ██ ██    ██ ██         ██
   ███████    ██       ██    ██████  ███████     ██      ██    ██ ██ ██  ██ ███████    ██    ██████  ██    ██ ██         ██
   ██   ██    ██       ██    ██   ██      ██     ██      ██    ██ ██  ██ ██      ██    ██    ██   ██ ██    ██ ██         ██
   ██   ██    ██       ██    ██   ██ ███████      ██████  ██████  ██   ████ ███████    ██    ██   ██  ██████   ██████    ██
-}


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


title :
    String
    -> { d | universal : { c | title : Maybe String } }
    -> { d | universal : { c | title : Maybe String } }
title val ({ universal } as attrs) =
    let
        newUniversal =
            { universal | title = Just val }
    in
        { attrs | universal = newUniversal }


tabindex :
    Int
    -> { d | universal : { c | tabindex : Maybe Int } }
    -> { d | universal : { c | tabindex : Maybe Int } }
tabindex val ({ universal } as attrs) =
    let
        newUniversal =
            { universal | tabindex = Just val }
    in
        { attrs | universal = newUniversal }


id :
    String
    -> { a | universal : { b | id : Maybe String } }
    -> { a | universal : { b | id : Maybe String } }
id val ({ universal } as attrs) =
    let
        newId =
            { universal | id = Just val }
    in
        { attrs | universal = newId }


disabled :
    { a | disabled : Bool }
    -> { a | disabled : Bool }
disabled attrs =
    { attrs | disabled = True }


onClick :
    msg
    -> { a | onMouseEvents : OnMouseEventsInside msg }
    -> { a | onMouseEvents : OnMouseEventsInside msg }
onClick val ({ onMouseEvents } as attrs) =
    let
        newOnClick =
            { onMouseEvents | click = Just val }
    in
        { attrs | onMouseEvents = newOnClick }


class :
    List String
    -> { a | universal : { b | class : List String } }
    -> { a | universal : { b | class : List String } }
class val ({ universal } as attrs) =
    let
        newClass =
            { universal | class = val }
    in
        { attrs | universal = newClass }


style :
    List (Style -> Style)
    -> { a | style : { b | standard : List (Style -> Style) } }
    -> { a | style : { b | standard : List (Style -> Style) } }
style val ({ style } as attrs) =
    let
        newStyle =
            { style | standard = val }
    in
        { attrs | style = newStyle }


hoverStyle :
    List (Style -> Style)
    -> { a | style : { b | hover : List (Style -> Style) } }
    -> { a | style : { b | hover : List (Style -> Style) } }
hoverStyle val ({ style } as attrs) =
    let
        newHoverStyle =
            { style | hover = val }
    in
        { attrs | style = newHoverStyle }


target : String -> TargetAttribute a -> TargetAttribute a
target val attrs =
    { attrs | target = Just val }


name : String -> NameAttribute a -> NameAttribute a
name val attrs =
    { attrs | name = Just val }


width : Int -> WidthAttribute a -> WidthAttribute a
width val attrs =
    { attrs | width = Just val }


height : Int -> HeightAttribute a -> HeightAttribute a
height val attrs =
    { attrs | height = Just val }



{-
   ██   ██  █████  ███    ██ ██████  ██      ███████ ██████  ███████
   ██   ██ ██   ██ ████   ██ ██   ██ ██      ██      ██   ██ ██
   ███████ ███████ ██ ██  ██ ██   ██ ██      █████   ██████  ███████
   ██   ██ ██   ██ ██  ██ ██ ██   ██ ██      ██      ██   ██      ██
   ██   ██ ██   ██ ██   ████ ██████  ███████ ███████ ██   ██ ███████
-}


handleHref :
    { a | href : Maybe String }
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleHref { href } =
    href |> Maybe.unwrap identity BodyBuilderHtml.href


handleStyle :
    { a | style : StyleAttribute }
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleStyle { style } =
    let
        { standard, hover } =
            style
    in
        BodyBuilderHtml.style standard
            << BodyBuilderHtml.hoverStyle hover


handleMouseEvents :
    { a | onMouseEvents : OnMouseEventsInside msg }
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleMouseEvents { onMouseEvents } =
    let
        { click, doubleClick, mouseUp, mouseOut, mouseOver, mouseDown, mouseLeave, mouseEnter } =
            onMouseEvents
    in
        unwrap BodyBuilderHtml.onClick click
            >> unwrap BodyBuilderHtml.onDoubleClick doubleClick
            >> unwrap BodyBuilderHtml.onMouseUp mouseUp
            >> unwrap BodyBuilderHtml.onMouseOut mouseOut
            >> unwrap BodyBuilderHtml.onMouseOver mouseOver
            >> unwrap BodyBuilderHtml.onMouseDown mouseDown
            >> unwrap BodyBuilderHtml.onMouseLeave mouseLeave
            >> unwrap BodyBuilderHtml.onMouseEnter mouseEnter


handleSrc :
    { a | src : String }
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleSrc { src } =
    BodyBuilderHtml.src src


handleDisabled :
    { a | disabled : Bool }
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleDisabled { disabled } =
    if disabled then
        BodyBuilderHtml.disabled
    else
        identity


handleAlt :
    { a | alt : String }
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleAlt { alt } =
    BodyBuilderHtml.alt alt


handleClass :
    { a | universal : { b | class : List String } }
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleClass { universal } =
    BodyBuilderHtml.class universal.class


handleId :
    { a | universal : { b | id : Maybe String } }
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleId { universal } =
    unwrap BodyBuilderHtml.id universal.id


handleTabindex :
    { b | universal : { a | tabindex : Maybe Int } }
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleTabindex { universal } =
    unwrap BodyBuilderHtml.tabindex universal.tabindex


handleTitle :
    { b | universal : { a | title : Maybe String } }
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleTitle { universal } =
    unwrap BodyBuilderHtml.title universal.title


handleType :
    { a | type_ : String }
    -> HtmlAttributes msg
    -> HtmlAttributes msg
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


handleName :
    { a | name : Maybe String }
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleName { name } =
    unwrap BodyBuilderHtml.name name


handleWidth :
    { a | width : Maybe Int }
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleWidth { width } =
    unwrap BodyBuilderHtml.width width


handleHeight :
    { a | height : Maybe Int }
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleHeight { height } =
    unwrap BodyBuilderHtml.height height


handleOptions :
    OptionsAttribute a
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleOptions { options } =
    BodyBuilderHtml.content (List.map optionsToBodyBuilderHtml options)


optionsToBodyBuilderHtml :
    { label : String, value : String }
    -> HtmlAttributes msg
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
handleTarget { target } =
    unwrap BodyBuilderHtml.target target


handleContent :
    { a | value : Maybe String }
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleContent { value } =
    unwrap setTextareaValue value


setTextareaValue :
    String
    -> HtmlAttributes msg
    -> HtmlAttributes msg
setTextareaValue value =
    BodyBuilderHtml.value (Just value)
        >> BodyBuilderHtml.content [ BodyBuilderHtml.text value ]



{-
   ████████  ██████      ██   ██ ████████ ███    ███ ██
      ██    ██    ██     ██   ██    ██    ████  ████ ██
      ██    ██    ██     ███████    ██    ██ ████ ██ ██
      ██    ██    ██     ██   ██    ██    ██  ██  ██ ██
      ██     ██████      ██   ██    ██    ██      ██ ███████
-}


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


baseHandling :
    List
        (VisibleAttributesAndEvents msg a
         -> HtmlAttributes msg
         -> HtmlAttributes msg
        )
baseHandling =
    [ handleStyle, handleClass, handleId, handleMouseEvents, handleTabindex, handleTitle ]


inputAttributesHandling :
    List
        (NameAttribute (VisibleAttributesAndEvents msg { a | type_ : String })
         -> HtmlAttributes msg
         -> HtmlAttributes msg
        )
inputAttributesHandling =
    List.append baseHandling [ handleType, handleName ]


toTree :
    Node interactiveContent phrasingContent spanningContent listContent msg
    -> BodyBuilderHtml.HtmlAttributes msg
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
            childToHtml attributes "img" (baseHandling |> List.append [ handleSrc, handleAlt, handleWidth, handleHeight ])

        Button attributes children ->
            parentToHtml children attributes "button" (List.append baseHandling [ handleDisabled ])

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
            childToHtml attributes "audio" (List.append baseHandling [ handleSrc ])

        Video attributes ->
            childToHtml attributes "video" baseHandling

        Canvas attributes ->
            childToHtml attributes "canvas" (List.append baseHandling [ handleWidth, handleHeight ])

        InputHidden attributes ->
            childToHtml attributes "input" [ handleStringValue, handleName, handleClass, handleId, handleType ]

        Textarea attributes ->
            childToHtml attributes "textarea" (baseHandling |> List.append [ handleName, handleContent ])

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
            childToHtml attributes "button" (baseHandling |> List.append [ handleType, handleDisabled ])

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
