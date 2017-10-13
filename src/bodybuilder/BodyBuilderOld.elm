module BodyBuilder exposing (..)

import Elegant exposing (Style)
import Html
import Function exposing (..)
import Color exposing (Color)
import Color.Convert as Color
import Maybe.Extra as Maybe
import ParseInt
import Json.Decode exposing (Decoder)
import VirtualDom


type alias Url =
    String


unwrap : (a -> b -> b) -> Maybe a -> b -> b
unwrap =
    Maybe.unwrap identity



{-
    █████  ████████ ████████ ██████  ██ ██████  ██    ██ ████████ ███████ ███████
   ██   ██    ██       ██    ██   ██ ██ ██   ██ ██    ██    ██    ██      ██
   ███████    ██       ██    ██████  ██ ██████  ██    ██    ██    █████   ███████
   ██   ██    ██       ██    ██   ██ ██ ██   ██ ██    ██    ██    ██           ██
   ██   ██    ██       ██    ██   ██ ██ ██████   ██████     ██    ███████ ███████
-}


{-| -}
type alias IdAttribute a =
    { a | id : Maybe String }


{-| -}
type alias ClassAttribute a =
    { a | class : List String }


{-| -}
type alias TabindexAttribute a =
    { a | tabindex : Maybe Int }


{-| -}
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


{-| -}
type alias StyleAttribute =
    { standard : Maybe Style
    , hover : Maybe Style
    , focus : Maybe Style
    }


type alias VisibleAttributes a =
    { a
        | style : Maybe StyleAttribute
        , universal : UniversalAttributes {}
    }


type alias VisibleAttributesAndEvents msg a =
    OnEvent msg (OnFocusEvent msg (OnBlurEvent msg (OnMouseEvents msg (VisibleAttributes a))))


{-| -}
type alias OptionsAttribute a =
    { a | options : List { value : String, label : String } }


{-| -}
type alias MinAttribute a =
    { a | min : Maybe Int }


{-| -}
type alias MaxAttribute a =
    { a | max : Maybe Int }


{-| -}
type alias StepAttribute a =
    { a | step : Maybe Int }



{-
   ███████ ██      ███████ ███    ███      █████  ████████ ████████ ██████  ███████
   ██      ██      ██      ████  ████     ██   ██    ██       ██    ██   ██ ██
   █████   ██      █████   ██ ████ ██     ███████    ██       ██    ██████  ███████
   ██      ██      ██      ██  ██  ██     ██   ██    ██       ██    ██   ██      ██
   ███████ ███████ ███████ ██      ██     ██   ██    ██       ██    ██   ██ ███████
-}


{-| -}
type alias IframeAttributes msg =
    SrcAttribute (VisibleAttributesAndEvents msg {})


{-| -}
type alias InputNumberAttributes msg =
    StepAttribute (MaxAttribute (MinAttribute (OnIntInputEvent msg (IntValue (InputVisibleAttributes msg {})))))


{-| -}
type alias InputColorAttributes msg =
    OnColorInputEvent msg (ColorValue (InputVisibleAttributes msg {}))


{-| -}
type alias InputCheckboxAttributes msg =
    OnCheckEvent msg (InputStringValueAttributes msg { checked : Bool })


{-| -}
type alias InputFileAttributes msg =
    InputVisibleAttributes msg {}


{-| -}
type alias InputPasswordAttributes msg =
    InputTextAttributes msg {}


{-| -}
type alias InputRadioAttributes msg =
    InputStringValueAttributes msg {}


{-| -}
type alias InputRangeAttributes msg =
    InputNumberAttributes msg


{-| -}
type alias InputSubmitAttributes msg =
    ValueAttribute String (OnSubmitEvent msg (ButtonAttributes msg { type_ : String }))


{-| -}
type alias InputUrlAttributes msg =
    InputTextAttributes msg {}


{-| -}
type alias SelectAttributes msg =
    StringValue (OptionsAttribute (VisibleAttributesAndEvents msg {}))


{-| -}
type alias VideoAttributes msg =
    VisibleAttributesAndEvents msg {}


{-| -}
type alias CanvasAttributes msg =
    HeightAttribute (WidthAttribute (VisibleAttributesAndEvents msg {}))


positionToString : Position -> String
positionToString position =
    case position of
        Before ->
            "before"

        After ->
            "after"



{-
   ██   ██ ████████ ███    ███ ██           █████  ███████ ████████
   ██   ██    ██    ████  ████ ██          ██   ██ ██         ██
   ███████    ██    ██ ████ ██ ██          ███████ ███████    ██
   ██   ██    ██    ██  ██  ██ ██          ██   ██      ██    ██
   ██   ██    ██    ██      ██ ███████     ██   ██ ███████    ██
-}


{-| -}
type Node msg
    = A (AAttributes msg) (List (Node msg))
    | Div (FlowAttributes msg) (List (Node msg))
    | P (FlowAttributes msg) (List (Node msg))
    | Span (FlowAttributes msg) (List (Node msg))
    | H Int (FlowAttributes msg) (List (Node msg))
    | Ul (FlowAttributes msg) (List (Node msg))
    | Ol (FlowAttributes msg) (List (Node msg))
    | Li (FlowAttributes msg) (List (Node msg))
    | Br (FlowAttributes msg)
    | Table (List (Node msg)) (List (List (Node msg)))
    | Button (ButtonAttributes msg {}) (List (Node msg))
    | Progress (ProgressAttributes msg)
    | Audio (AudioAttributes msg)
    | Video (VideoAttributes msg)
    | Img (ImgAttributes msg)
    | Canvas (CanvasAttributes msg)
    | Textarea (TextareaAttributes msg)
    | Script (ScriptAttributes msg)
    | InputHidden InputHiddenAttributes
    | InputText (InputTextAttributes msg {})
    | InputNumber (InputNumberAttributes msg)
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


styleAttribute :
    Style
    -> StyleAttribute
styleAttribute style =
    StyleAttribute (Just style) Nothing Nothing


styleAttributeWithHover :
    Style
    -> Style
    -> StyleAttribute
styleAttributeWithHover style hover =
    { standard = Just style
    , hover = Just hover
    , focus = Nothing
    }


flowDefaultsComposedToAttrsWithStyle :
    Style
    -> List (FlowAttributes msg -> FlowAttributes msg)
    -> FlowAttributes msg
flowDefaultsComposedToAttrsWithStyle style =
    defaultsComposedToAttrs
        { style = styleAttribute style
        , universal = defaultUniversalAttributes
        , onMouseEvents = defaultOnMouseEvents
        , onEvent = Nothing
        , onBlurEvent = Nothing
        , onFocusEvent = Nothing
        }



{-
   ██   ██ ████████ ███    ███ ██           ██████  ██████  ███    ██ ███████ ████████ ██████  ██    ██  ██████ ████████
   ██   ██    ██    ████  ████ ██          ██      ██    ██ ████   ██ ██         ██    ██   ██ ██    ██ ██         ██
   ███████    ██    ██ ████ ██ ██          ██      ██    ██ ██ ██  ██ ███████    ██    ██████  ██    ██ ██         ██
   ██   ██    ██    ██  ██  ██ ██          ██      ██    ██ ██  ██ ██      ██    ██    ██   ██ ██    ██ ██         ██
   ██   ██    ██    ██      ██ ███████      ██████  ██████  ██   ████ ███████    ██    ██   ██  ██████   ██████    ██
-}
{-
    █████  ████████ ████████ ██████  ███████      ██████  ██████  ███    ██ ███████ ████████ ██████  ██    ██  ██████ ████████
   ██   ██    ██       ██    ██   ██ ██          ██      ██    ██ ████   ██ ██         ██    ██   ██ ██    ██ ██         ██
   ███████    ██       ██    ██████  ███████     ██      ██    ██ ██ ██  ██ ███████    ██    ██████  ██    ██ ██         ██
   ██   ██    ██       ██    ██   ██      ██     ██      ██    ██ ██  ██ ██      ██    ██    ██   ██ ██    ██ ██         ██
   ██   ██    ██       ██    ██   ██ ███████      ██████  ██████  ██   ████ ███████    ██    ██   ██  ██████   ██████    ██
-}


{-| -}
options :
    List { value : String, label : String }
    -> OptionsAttribute a
    -> OptionsAttribute a
options val attrs =
    { attrs | options = val }


{-| -}
option :
    String
    -> String
    -> { label : String, value : String }
option value label =
    { value = value
    , label = label
    }


{-| -}
selectedOption :
    String
    -> StringValue a
    -> StringValue a
selectedOption val attrs =
    { attrs | value = Just val }


{-| -}
href :
    String
    -> HrefAttribute a
    -> HrefAttribute a
href val attrs =
    { attrs | href = Just val }


{-| -}
value :
    a
    -> ValueAttribute a b
    -> ValueAttribute a b
value val attrs =
    { attrs | value = Just val }


{-| -}
checked :
    Bool
    -> { a | checked : Bool }
    -> { a | checked : Bool }
checked val attrs =
    { attrs | checked = val }


{-| -}
title :
    String
    -> { a | universal : UniversalAttributes b }
    -> { a | universal : UniversalAttributes b }
title val ({ universal } as attrs) =
    let
        newUniversal =
            { universal | title = Just val }
    in
        { attrs | universal = newUniversal }


{-| -}
tabindex :
    Int
    -> { a | universal : UniversalAttributes b }
    -> { a | universal : UniversalAttributes b }
tabindex val ({ universal } as attrs) =
    let
        newUniversal =
            { universal | tabindex = Just val }
    in
        { attrs | universal = newUniversal }


{-| -}
label :
    List (LabelAttributes msg -> LabelAttributes msg)
    -> Node msg
    -> LabelAttribute msg a
    -> LabelAttribute msg a
label attributes content attrs =
    { attrs
        | label =
            Just
                { attributes =
                    defaultsComposedToAttrs
                        { onBlurEvent = Nothing
                        , onEvent = Nothing
                        , onFocusEvent = Nothing
                        , onMouseEvents = defaultOnMouseEvents
                        , position = After
                        , style = defaultStyleAttribute
                        , universal = defaultUniversalAttributes
                        }
                        attributes
                , content = content
                }
    }


{-| -}
position :
    Position
    -> PositionAttribute a
    -> PositionAttribute a
position val attrs =
    { attrs | position = val }


{-| -}
id :
    String
    -> { a | universal : UniversalAttributes b }
    -> { a | universal : UniversalAttributes b }
id val ({ universal } as attrs) =
    let
        newId =
            { universal | id = Just val }
    in
        { attrs | universal = newId }


{-| -}
data : a -> { c | data : b } -> { c | data : a }
data newData attrs =
    { attrs | data = newData }


{-| -}
src : a -> { c | src : b } -> { c | src : a }
src newSrc attrs =
    { attrs | src = newSrc }


{-| -}
disabled :
    DisabledAttribute a
    -> DisabledAttribute a
disabled attrs =
    { attrs | disabled = True }


{-| -}
class :
    List String
    -> { a | universal : UniversalAttributes b }
    -> { a | universal : UniversalAttributes b }
class val ({ universal } as attrs) =
    let
        newClass =
            { universal | class = val }
    in
        { attrs | universal = newClass }


{-| -}
target :
    String
    -> TargetAttribute a
    -> TargetAttribute a
target val attrs =
    { attrs | target = Just val }


{-| -}
name :
    String
    -> NameAttribute a
    -> NameAttribute a
name val attrs =
    { attrs | name = Just val }


{-| -}
width :
    Int
    -> WidthAttribute a
    -> WidthAttribute a
width val attrs =
    { attrs | width = Just val }


{-| -}
height :
    Int
    -> HeightAttribute a
    -> HeightAttribute a
height val attrs =
    { attrs | height = Just val }


{-| -}
min :
    Int
    -> MinAttribute a
    -> MinAttribute a
min val attrs =
    { attrs | min = Just val }


{-| -}
max :
    Int
    -> MaxAttribute a
    -> MaxAttribute a
max val attrs =
    { attrs | max = Just val }


{-| -}
step :
    Int
    -> StepAttribute a
    -> StepAttribute a
step val attrs =
    { attrs | step = Just val }


{-| -}
autocomplete :
    Bool
    -> AutocompleteAttribute a
    -> AutocompleteAttribute a
autocomplete val attrs =
    { attrs | autocomplete = val }


{-| -}
placeholder :
    String
    -> PlaceholderAttribute a
    -> PlaceholderAttribute a
placeholder val attrs =
    { attrs | placeholder = Just val }



{-
   ██   ██  █████  ███    ██ ██████  ██      ███████ ██████  ███████
   ██   ██ ██   ██ ████   ██ ██   ██ ██      ██      ██   ██ ██
   ███████ ███████ ██ ██  ██ ██   ██ ██      █████   ██████  ███████
   ██   ██ ██   ██ ██  ██ ██ ██   ██ ██      ██      ██   ██      ██
   ██   ██ ██   ██ ██   ████ ██████  ███████ ███████ ██   ██ ███████
-}


handleHref :
    HrefAttribute a
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleHref { href } =
    href |> Maybe.unwrap identity BodyBuilderHtml.href


handleData : DataAttribute a -> HtmlAttributes msg -> HtmlAttributes msg
handleData { data } =
    BodyBuilderHtml.data data


handleOnInputEvent :
    OnInputEvent a msg b
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleOnInputEvent { onInputEvent, fromStringInput } =
    unwrap
        (\val ->
            BodyBuilderHtml.onInput (fromStringInput >> val)
        )
        onInputEvent


handleOnCheckEvent :
    OnCheckEvent msg a
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleOnCheckEvent { onCheckEvent } =
    unwrap BodyBuilderHtml.onCheck onCheckEvent


handleOnSubmitEvent :
    OnSubmitEvent msg a
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleOnSubmitEvent { onSubmitEvent } =
    unwrap BodyBuilderHtml.onSubmit onSubmitEvent


handleSrc :
    SrcAttribute a
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleSrc { src } =
    BodyBuilderHtml.src src


handleAlt :
    AltAttribute a
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleAlt { alt } =
    BodyBuilderHtml.alt alt


handleType :
    { a | type_ : String }
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleType { type_ } =
    BodyBuilderHtml.type_ type_


handleStringValue :
    ValueAttribute String a
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleStringValue { value } =
    BodyBuilderHtml.value value


handleIntValue :
    ValueAttribute Int a
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleIntValue { value } =
    value
        |> Maybe.map toString
        |> BodyBuilderHtml.value


handleColorValue :
    ValueAttribute Color a
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleColorValue { value } =
    value
        |> Maybe.map Color.colorToHex
        |> BodyBuilderHtml.value


handleName :
    NameAttribute a
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleName { name } =
    unwrap BodyBuilderHtml.name name


handleWidth :
    WidthAttribute a
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleWidth { width } =
    unwrap BodyBuilderHtml.width width


handleHeight :
    HeightAttribute a
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
    TargetAttribute a
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleTarget { target } =
    unwrap BodyBuilderHtml.target target


handleContent :
    ValueAttribute String a
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


handleMin :
    MinAttribute a
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleMin { min } =
    unwrap (BodyBuilderHtml.min << toString) min


handleMax :
    MaxAttribute a
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleMax { max } =
    unwrap (BodyBuilderHtml.max << toString) max


handleStep :
    StepAttribute a
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleStep { step } =
    unwrap (BodyBuilderHtml.step << toString) step


handleAutocomplete :
    AutocompleteAttribute a
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleAutocomplete { autocomplete } =
    BodyBuilderHtml.autocomplete autocomplete


handlePlaceholder :
    PlaceholderAttribute a
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handlePlaceholder { placeholder } =
    unwrap BodyBuilderHtml.placeholder placeholder


handleLabel :
    LabelAttribute msg a
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleLabel { label } =
    unwrap
        (\label_ ->
            BodyBuilderHtml.label
                { attributes =
                    baseHandling
                        |> List.map (\fun -> fun label_.attributes)
                        |> compose
                , position = positionToString label_.attributes.position
                , content_ = toTree label_.content
                }
        )
        label



{-
   ████████  ██████      ██   ██ ████████ ███    ███ ██
      ██    ██    ██     ██   ██    ██    ████  ████ ██
      ██    ██    ██     ███████    ██    ██ ████ ██ ██
      ██    ██    ██     ██   ██    ██    ██  ██  ██ ██
      ██     ██████      ██   ██    ██    ██      ██ ███████
-}


buildNode :
    List (Node msg)
    -> attributes
    -> String
    -> List (attributes -> HtmlAttributes msg -> HtmlAttributes msg)
    -> HtmlAttributes msg
buildNode children attributes tag usedBodyToBodyHtmlFunctions =
    let
        newAttrs =
            usedBodyToBodyHtmlFunctions |> List.map (\fun -> fun attributes)
    in
        BodyBuilderHtml.node
            ([ BodyBuilderHtml.tag tag ] |> List.append newAttrs)
            (List.map toTree children)


parentToHtml :
    List (Node msg)
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
    [ handleStyle
    , handleClass
    , handleId
    , handleMouseEvents
    , handleTabindex
    , handleTitle
    , handleOnFocusEvent
    , handleOnBlurEvent
    , handleOnEvent
    ]


inputAttributesHandling :
    List
        (LabelAttribute msg (NameAttribute (VisibleAttributesAndEvents msg { a | type_ : String }))
         -> HtmlAttributes msg
         -> HtmlAttributes msg
        )
inputAttributesHandling =
    List.append
        baseHandling
        [ handleType
        , handleName
        , handleLabel
        ]


type alias StyledDom msg =
    { styles : List Style
    , dom : VirtualDom.Node msg
    }


toTree : Node msg -> StyledDom msg
toTree node =
    case node of
        A attributes children ->
            VirtualDom.node "a" attributes


{-| -}
toTree :
    Node msg
    -> BodyBuilderHtml.HtmlAttributes msg
toTree node =
    case node of
        A attributes children ->
            parentToHtml children
                attributes
                "a"
                (baseHandling
                    |> List.append
                        [ handleHref
                        , handleTarget
                        ]
                )

        Ul attributes children ->
            parentToHtml children
                attributes
                "ul"
                baseHandling

        Ol attributes children ->
            parentToHtml children
                attributes
                "ol"
                baseHandling

        Li attributes children ->
            parentToHtml children
                attributes
                "li"
                baseHandling

        Div attributes children ->
            parentToHtml children
                attributes
                "div"
                baseHandling

        P attributes children ->
            parentToHtml children
                attributes
                "p"
                baseHandling

        Span attributes children ->
            parentToHtml children
                attributes
                "span"
                baseHandling

        H number attributes children ->
            parentToHtml children
                attributes
                ("h" ++ (number |> toString))
                baseHandling

        Img attributes ->
            childToHtml attributes
                "img"
                (baseHandling
                    |> List.append
                        [ handleSrc
                        , handleAlt
                        , handleWidth
                        , handleHeight
                        ]
                )

        Button attributes children ->
            parentToHtml children
                attributes
                "button"
                (baseHandling
                    |> List.append
                        [ handleDisabled ]
                )

        Text str ->
            BodyBuilderHtml.text str

        Br attributes ->
            childToHtml attributes
                "br"
                baseHandling

        Table _ _ ->
            -- TODO
            BodyBuilderHtml.none

        Progress attributes ->
            childToHtml attributes
                "progress"
                baseHandling

        Audio attributes ->
            childToHtml attributes
                "audio"
                (baseHandling
                    |> List.append
                        [ handleSrc ]
                )

        Video attributes ->
            childToHtml attributes
                "video"
                baseHandling

        Canvas attributes ->
            childToHtml attributes
                "canvas"
                (baseHandling
                    |> List.append
                        [ handleWidth
                        , handleHeight
                        ]
                )

        Script attributes ->
            childToHtml attributes
                "script"
                (baseHandling
                    |> List.append
                        [ handleData
                        , handleSrc
                        ]
                )

        InputHidden attributes ->
            childToHtml attributes
                "input"
                [ handleStringValue
                , handleName
                , handleClass
                , handleId
                , handleType
                ]

        Textarea attributes ->
            childToHtml attributes
                "textarea"
                (baseHandling
                    |> List.append
                        [ handleName
                        , handleContent
                        , handleOnInputEvent
                        ]
                )

        InputText attributes ->
            childToHtml attributes
                "input"
                (inputAttributesHandling
                    |> List.append
                        [ handleStringValue
                        , handleOnInputEvent
                        , handleAutocomplete
                        , handlePlaceholder
                        ]
                )

        InputNumber attributes ->
            childToHtml attributes
                "input"
                (inputAttributesHandling
                    |> List.append
                        [ handleIntValue
                        , handleOnInputEvent
                        , handleMin
                        , handleMax
                        , handleStep
                        ]
                )

        InputColor attributes ->
            childToHtml attributes
                "input"
                (inputAttributesHandling
                    |> List.append
                        [ handleColorValue
                        , handleOnInputEvent
                        ]
                )

        InputCheckbox attributes ->
            childToHtml attributes
                "input"
                (inputAttributesHandling
                    |> List.append
                        [ handleChecked
                        , handleOnCheckEvent
                        ]
                )

        InputFile attributes ->
            childToHtml attributes
                "input"
                inputAttributesHandling

        InputPassword attributes ->
            childToHtml attributes
                "input"
                (inputAttributesHandling
                    |> List.append
                        [ handleStringValue
                        , handleOnInputEvent
                        , handleAutocomplete
                        , handlePlaceholder
                        ]
                )

        InputRadio attributes ->
            childToHtml attributes
                "input"
                (inputAttributesHandling
                    |> List.append
                        [ handleStringValue ]
                )

        InputRange attributes ->
            childToHtml attributes
                "input"
                (inputAttributesHandling
                    |> List.append
                        [ handleIntValue
                        , handleOnInputEvent
                        , handleMin
                        , handleMax
                        , handleStep
                        ]
                )

        InputSubmit attributes ->
            childToHtml attributes
                "input"
                (baseHandling
                    |> List.append
                        [ handleType
                        , handleDisabled
                        , handleOnSubmitEvent
                        , handleStringValue
                        ]
                )

        InputUrl attributes ->
            childToHtml attributes
                "input"
                (inputAttributesHandling
                    |> List.append
                        [ handleStringValue
                        , handleOnInputEvent
                        , handleAutocomplete
                        , handlePlaceholder
                        ]
                )

        Select attributes ->
            childToHtml attributes
                "select"
                (baseHandling
                    |> List.append
                        [ handleOptions
                        , handleSelectedOptions
                        ]
                )


{-| -}
toHtml :
    Node msg
    -> Html.Html msg
toHtml node =
    node
        |> toTree
        |> BodyBuilderHtml.view


{-| -}
type alias BodyBuilderProgramArgs model msg =
    { init : ( model, Cmd msg )
    , subscriptions : model -> Sub msg
    , update : msg -> model -> ( model, Cmd msg )
    , view : model -> Node msg
    }


{-| -}
program : BodyBuilderProgramArgs model msg -> Program Basics.Never model msg
program { init, update, subscriptions, view } =
    Html.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = toHtml << view
        }
