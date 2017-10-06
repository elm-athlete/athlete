module BodyBuilder
    exposing
        ( Interactive
        , NotInteractive
        , Phrasing
        , NotPhrasing
        , Spanning
        , NotSpanning
        , InsideHeading
        , OutsideHeading
        , ListElement
        , NotListElement
        , OnMouseEvents
        , OnStringInputEvent
        , OnIntInputEvent
        , OnColorInputEvent
        , OnCheckEvent
        , OnSubmitEvent
        , OnFocusEvent
        , OnBlurEvent
        , OnEvent
        , IdAttribute
        , ClassAttribute
        , TabindexAttribute
        , TitleAttribute
        , StyleAttribute
        , TargetAttribute
        , HrefAttribute
        , SrcAttribute
        , AltAttribute
        , StringValue
        , IntValue
        , ColorValue
        , NameAttribute
        , OptionsAttribute
        , DisabledAttribute
        , WidthAttribute
        , HeightAttribute
        , AAttributes
        , FlowAttributes
        , ImgAttributes
        , IframeAttributes
        , InputHiddenAttributes
        , InputTextAttributes
        , TextareaAttributes
        , ButtonAttributes
        , InputNumberAttributes
        , InputColorAttributes
        , InputCheckboxAttributes
        , InputFileAttributes
        , InputPasswordAttributes
        , InputRadioAttributes
        , InputRangeAttributes
        , InputSubmitAttributes
        , InputUrlAttributes
        , SelectAttributes
        , ProgressAttributes
        , AudioAttributes
        , VideoAttributes
        , CanvasAttributes
        , Node
        , Position(..)
        , h1
        , h2
        , h3
        , h4
        , h5
        , h6
        , a
        , button
        , div
        , ul
        , ol
        , li
        , p
        , br
        , span
        , textarea
        , img
        , audio
        , progress
        , text
        , node
        , leaf
        , container
        , olLi
        , ulLi
        , script
        , inputHidden
        , inputText
        , inputNumber
        , inputColor
        , inputCheckbox
        , inputFile
        , inputPassword
        , inputRadio
        , inputRange
        , inputSubmit
        , inputUrl
        , select
        , options
        , option
        , selectedOption
        , href
        , value
        , checked
        , title
        , tabindex
        , id
        , data
        , src
        , disabled
        , min
        , max
        , step
        , autocomplete
        , placeholder
        , label
        , position
        , onClick
        , onDoubleClick
        , onMouseUp
        , onMouseOut
        , onMouseOver
        , onMouseDown
        , onMouseLeave
        , onMouseEnter
        , onInput
        , onCheck
        , onSubmit
        , onFocus
        , onBlur
        , on
        , class
        , style
        , hoverStyle
        , focusStyle
        , target
        , name
        , width
        , height
        , toTree
        , BodyBuilderProgramArgs
        , toHtml
        , program
        )

{-|


# Type

@docs Interactive
@docs NotInteractive
@docs Phrasing
@docs NotPhrasing
@docs Spanning
@docs NotSpanning
@docs InsideHeading
@docs OutsideHeading
@docs ListElement
@docs NotListElement
@docs OnMouseEvents
@docs OnStringInputEvent
@docs OnIntInputEvent
@docs OnColorInputEvent
@docs OnCheckEvent
@docs OnSubmitEvent
@docs OnFocusEvent
@docs OnBlurEvent
@docs OnEvent
@docs IdAttribute
@docs ClassAttribute
@docs TabindexAttribute
@docs TitleAttribute
@docs StyleAttribute
@docs TargetAttribute
@docs HrefAttribute
@docs SrcAttribute
@docs AltAttribute
@docs StringValue
@docs IntValue
@docs ColorValue
@docs NameAttribute
@docs OptionsAttribute
@docs DisabledAttribute
@docs WidthAttribute
@docs HeightAttribute
@docs AAttributes
@docs FlowAttributes
@docs ImgAttributes
@docs IframeAttributes
@docs InputHiddenAttributes
@docs InputTextAttributes
@docs TextareaAttributes
@docs ButtonAttributes
@docs InputNumberAttributes
@docs InputColorAttributes
@docs InputCheckboxAttributes
@docs InputFileAttributes
@docs InputPasswordAttributes
@docs InputRadioAttributes
@docs InputRangeAttributes
@docs InputSubmitAttributes
@docs InputUrlAttributes
@docs SelectAttributes
@docs ProgressAttributes
@docs AudioAttributes
@docs VideoAttributes
@docs CanvasAttributes
@docs Node
@docs Position
@docs h1
@docs h2
@docs h3
@docs h4
@docs h5
@docs h6
@docs a
@docs button
@docs div
@docs ul
@docs ol
@docs li
@docs p
@docs br
@docs span
@docs textarea
@docs img
@docs audio
@docs progress
@docs text
@docs node
@docs leaf
@docs container
@docs olLi
@docs ulLi
@docs script
@docs data
@docs src
@docs inputHidden
@docs inputText
@docs inputNumber
@docs inputColor
@docs inputCheckbox
@docs inputFile
@docs inputPassword
@docs inputRadio
@docs inputRange
@docs inputSubmit
@docs inputUrl
@docs select
@docs options
@docs option
@docs selectedOption
@docs href
@docs value
@docs checked
@docs title
@docs tabindex
@docs id
@docs disabled
@docs min
@docs max
@docs step
@docs label
@docs position
@docs autocomplete
@docs placeholder
@docs onClick
@docs onDoubleClick
@docs onMouseUp
@docs onMouseOut
@docs onMouseOver
@docs onMouseDown
@docs onMouseLeave
@docs onMouseEnter
@docs onInput
@docs onCheck
@docs onSubmit
@docs onFocus
@docs onBlur
@docs on
@docs class
@docs style
@docs hoverStyle
@docs focusStyle
@docs target
@docs name
@docs width
@docs height
@docs toTree
@docs BodyBuilderProgramArgs
@docs toHtml
@docs program

-}

import Elegant exposing (Style)
import Html
import Function exposing (..)
import BodyBuilderHtml exposing (HtmlAttributes)
import Color exposing (Color)
import Color.Convert as Color
import Maybe.Extra as Maybe
import ParseInt
import Json.Decode exposing (Decoder)


type alias Url =
    String


unwrap : (a -> b -> b) -> Maybe a -> b -> b
unwrap =
    Maybe.unwrap identity


parseInt : String -> Int
parseInt =
    ParseInt.parseInt >> Result.withDefault 0


parseColor : String -> Color
parseColor =
    Color.hexToColor >> Result.withDefault Color.white


{-| -}
type Interactive
    = Interactive


{-| -}
type NotInteractive
    = NotInteractive


{-| -}
type Phrasing
    = Phrasing


{-| -}
type NotPhrasing
    = NotPhrasing


{-| -}
type Spanning
    = Spanning


{-| -}
type NotSpanning
    = NotSpanning


{-| -}
type InsideHeading
    = InsideHeading


{-| -}
type OutsideHeading
    = OutsideHeading


{-| -}
type ListElement
    = ListElement


{-| -}
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


{-| -}
type alias OnMouseEvents msg a =
    { a | onMouseEvents : OnMouseEventsInside msg }


type alias OnInputEvent b msg a =
    { a
        | onInputEvent : Maybe (b -> msg)
        , fromStringInput : String -> b
    }


{-| -}
type alias OnStringInputEvent msg a =
    OnInputEvent String msg a


{-| -}
type alias OnIntInputEvent msg a =
    OnInputEvent Int msg a


{-| -}
type alias OnColorInputEvent msg a =
    OnInputEvent Color msg a


{-| -}
type alias OnCheckEvent msg a =
    { a | onCheckEvent : Maybe (Bool -> msg) }


{-| -}
type alias OnSubmitEvent msg a =
    { a | onSubmitEvent : Maybe msg }


{-| -}
type alias OnFocusEvent msg a =
    { a | onFocusEvent : Maybe msg }


{-| -}
type alias OnBlurEvent msg a =
    { a | onBlurEvent : Maybe msg }


{-| -}
type alias OnEvent msg a =
    { a | onEvent : Maybe ( String, Decoder msg ) }



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
    { standard : List (Style -> Style)
    , hover : List (Style -> Style)
    , focus : List (Style -> Style)
    }


defaultStyleAttribute : StyleAttribute
defaultStyleAttribute =
    { standard = []
    , hover = []
    , focus = []
    }


type alias VisibleAttributes a =
    { a
        | style : StyleAttribute
        , universal : UniversalAttributes {}
    }


type alias VisibleAttributesAndEvents msg a =
    OnEvent msg (OnFocusEvent msg (OnBlurEvent msg (OnMouseEvents msg (VisibleAttributes a))))


{-| -}
type alias TargetAttribute a =
    { a | target : Maybe String }


{-| -}
type alias HrefAttribute a =
    { a | href : Maybe Url }


{-| -}
type alias SrcAttribute a =
    { a | src : String }


{-| -}
type alias AltAttribute a =
    { a | alt : String }


type alias ValueAttribute b a =
    { a | value : Maybe b }


{-| -}
type alias StringValue a =
    ValueAttribute String a


{-| -}
type alias IntValue a =
    ValueAttribute Int a


{-| -}
type alias ColorValue a =
    ValueAttribute Color a


{-| -}
type alias NameAttribute a =
    { a | name : Maybe String }


{-| -}
type alias OptionsAttribute a =
    { a | options : List { value : String, label : String } }


{-| -}
type alias DisabledAttribute a =
    { a | disabled : Bool }


{-| -}
type alias WidthAttribute a =
    { a | width : Maybe Int }


{-| -}
type alias HeightAttribute a =
    { a | height : Maybe Int }


{-| -}
type alias MinAttribute a =
    { a | min : Maybe Int }


{-| -}
type alias MaxAttribute a =
    { a | max : Maybe Int }


{-| -}
type alias StepAttribute a =
    { a | step : Maybe Int }


{-| -}
type alias AutocompleteAttribute a =
    { a | autocomplete : Bool }


{-| -}
type alias PlaceholderAttribute a =
    { a | placeholder : Maybe String }


type alias LabelAttribute msg a =
    { a
        | label :
            Maybe
                { attributes : LabelAttributes msg
                , content : Node msg
                }
    }


type alias PositionAttribute a =
    { a | position : Position }


type alias DataAttribute a =
    { a | data : List ( String, String ) }


{-| -}
type Position
    = Before
    | After



{-
   ███████ ██      ███████ ███    ███      █████  ████████ ████████ ██████  ███████
   ██      ██      ██      ████  ████     ██   ██    ██       ██    ██   ██ ██
   █████   ██      █████   ██ ████ ██     ███████    ██       ██    ██████  ███████
   ██      ██      ██      ██  ██  ██     ██   ██    ██       ██    ██   ██      ██
   ███████ ███████ ███████ ██      ██     ██   ██    ██       ██    ██   ██ ███████
-}


{-| -}
type alias AAttributes msg =
    TargetAttribute (HrefAttribute (VisibleAttributesAndEvents msg {}))


{-| -}
type alias FlowAttributes msg =
    VisibleAttributesAndEvents msg {}


type alias ScriptAttributes msg =
    DataAttribute (SrcAttribute (VisibleAttributesAndEvents msg {}))


{-| -}
type alias ImgAttributes msg =
    HeightAttribute (WidthAttribute (AltAttribute (SrcAttribute (VisibleAttributesAndEvents msg {}))))


{-| -}
type alias IframeAttributes msg =
    SrcAttribute (VisibleAttributesAndEvents msg {})


type alias InputAttributes a =
    NameAttribute { a | type_ : String }


{-| -}
type alias InputHiddenAttributes =
    InputAttributes
        (StringValue
            { universal : UniversalAttributes {}
            , type_ : String
            }
        )


type alias InputVisibleAttributes msg a =
    LabelAttribute msg (VisibleAttributesAndEvents msg (InputAttributes a))


type alias InputStringValueAttributes msg a =
    StringValue (InputVisibleAttributes msg a)


{-| -}
type alias InputTextAttributes msg a =
    AutocompleteAttribute (PlaceholderAttribute (OnStringInputEvent msg (InputStringValueAttributes msg a)))


{-| -}
type alias TextareaAttributes msg =
    OnStringInputEvent msg (NameAttribute (StringValue (VisibleAttributesAndEvents msg {})))


{-| -}
type alias ButtonAttributes msg a =
    DisabledAttribute (VisibleAttributesAndEvents msg a)


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
type alias ProgressAttributes msg =
    VisibleAttributesAndEvents msg {}


{-| -}
type alias AudioAttributes msg =
    SrcAttribute (VisibleAttributesAndEvents msg {})


{-| -}
type alias VideoAttributes msg =
    VisibleAttributesAndEvents msg {}


{-| -}
type alias CanvasAttributes msg =
    HeightAttribute (WidthAttribute (VisibleAttributesAndEvents msg {}))


type alias LabelAttributes msg =
    PositionAttribute (VisibleAttributesAndEvents msg {})


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


defaultsComposedToAttrs : a -> List (a -> a) -> a
defaultsComposedToAttrs defaults attrs =
    (defaults |> (attrs |> compose))


styleAttribute :
    List (Style -> Style)
    -> StyleAttribute
styleAttribute style =
    styleAttributeWithHover style []


styleAttributeWithHover :
    List (Style -> Style)
    -> List (Style -> Style)
    -> StyleAttribute
styleAttributeWithHover style hover =
    { standard = style
    , hover = hover
    , focus = []
    }


flowDefaultsComposedToAttrsWithStyle :
    List (Style -> Style)
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


flowDefaultsComposedToAttrs :
    List (FlowAttributes msg -> FlowAttributes msg)
    -> FlowAttributes msg
flowDefaultsComposedToAttrs =
    flowDefaultsComposedToAttrsWithStyle []



{-
   ██   ██ ████████ ███    ███ ██           ██████  ██████  ███    ██ ███████ ████████ ██████  ██    ██  ██████ ████████
   ██   ██    ██    ████  ████ ██          ██      ██    ██ ████   ██ ██         ██    ██   ██ ██    ██ ██         ██
   ███████    ██    ██ ████ ██ ██          ██      ██    ██ ██ ██  ██ ███████    ██    ██████  ██    ██ ██         ██
   ██   ██    ██    ██  ██  ██ ██          ██      ██    ██ ██  ██ ██      ██    ██    ██   ██ ██    ██ ██         ██
   ██   ██    ██    ██      ██ ███████      ██████  ██████  ██   ████ ███████    ██    ██   ██  ██████   ██████    ██
-}


{-| -}
h1 :
    List (FlowAttributes msg -> FlowAttributes msg)
    -> List (Node msg)
    -> Node msg
h1 =
    H 1 << (flowDefaultsComposedToAttrsWithStyle [ Elegant.h1S ])


{-| -}
h2 :
    List (FlowAttributes msg -> FlowAttributes msg)
    -> List (Node msg)
    -> Node msg
h2 =
    H 2 << (flowDefaultsComposedToAttrsWithStyle [ Elegant.h2S ])


{-| -}
h3 :
    List (FlowAttributes msg -> FlowAttributes msg)
    -> List (Node msg)
    -> Node msg
h3 =
    H 3 << (flowDefaultsComposedToAttrsWithStyle [ Elegant.h3S ])


{-| -}
h4 :
    List (FlowAttributes msg -> FlowAttributes msg)
    -> List (Node msg)
    -> Node msg
h4 =
    H 4 << (flowDefaultsComposedToAttrsWithStyle [ Elegant.h4S ])


{-| -}
h5 :
    List (FlowAttributes msg -> FlowAttributes msg)
    -> List (Node msg)
    -> Node msg
h5 =
    H 5 << (flowDefaultsComposedToAttrsWithStyle [ Elegant.h5S ])


{-| -}
h6 :
    List (FlowAttributes msg -> FlowAttributes msg)
    -> List (Node msg)
    -> Node msg
h6 =
    H 6 << (flowDefaultsComposedToAttrsWithStyle [ Elegant.h6S ])


{-| -}
a :
    List (AAttributes msg -> AAttributes msg)
    -> List (Node msg)
    -> Node msg
a =
    A
        << defaultsComposedToAttrs
            { href = Nothing
            , target = Nothing
            , style = defaultStyleAttribute
            , universal = defaultUniversalAttributes
            , onMouseEvents = defaultOnMouseEvents
            , onEvent = Nothing
            , onBlurEvent = Nothing
            , onFocusEvent = Nothing
            }


{-| -}
button :
    List (ButtonAttributes msg {} -> ButtonAttributes msg {})
    -> List (Node msg)
    -> Node msg
button =
    Button
        << defaultsComposedToAttrs
            { universal = defaultUniversalAttributes
            , style = defaultStyleAttribute
            , onMouseEvents = defaultOnMouseEvents
            , disabled = False
            , onEvent = Nothing
            , onBlurEvent = Nothing
            , onFocusEvent = Nothing
            }


{-| -}
div :
    List (FlowAttributes msg -> FlowAttributes msg)
    -> List (Node msg)
    -> Node msg
div =
    Div << flowDefaultsComposedToAttrs


{-| -}
ul :
    List (FlowAttributes msg -> FlowAttributes msg)
    -> List (Node msg)
    -> Node msg
ul =
    Ul << flowDefaultsComposedToAttrs


{-| -}
ol :
    List (FlowAttributes msg -> FlowAttributes msg)
    -> List (Node msg)
    -> Node msg
ol =
    Ol << flowDefaultsComposedToAttrs


{-| -}
li :
    List (FlowAttributes msg -> FlowAttributes msg)
    -> List (Node msg)
    -> Node msg
li =
    Li << flowDefaultsComposedToAttrs


{-| -}
p :
    List (FlowAttributes msg -> FlowAttributes msg)
    -> List (Node msg)
    -> Node msg
p =
    P << flowDefaultsComposedToAttrs


{-| -}
br :
    List (FlowAttributes msg -> FlowAttributes msg)
    -> Node msg
br =
    Br << flowDefaultsComposedToAttrs


{-| -}
span :
    List (FlowAttributes msg -> FlowAttributes msg)
    -> List (Node msg)
    -> Node msg
span =
    Span << flowDefaultsComposedToAttrs


{-| -}
textarea :
    List (TextareaAttributes msg -> TextareaAttributes msg)
    -> Node msg
textarea =
    Textarea
        << defaultsComposedToAttrs
            { value = Nothing
            , name = Nothing
            , universal = defaultUniversalAttributes
            , style = defaultStyleAttribute
            , onMouseEvents = defaultOnMouseEvents
            , onInputEvent = Nothing
            , fromStringInput = identity
            , onEvent = Nothing
            , onBlurEvent = Nothing
            , onFocusEvent = Nothing
            }


{-| -}
img :
    String
    -> String
    -> List (ImgAttributes msg -> ImgAttributes msg)
    -> Node msg
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
            , onEvent = Nothing
            , onBlurEvent = Nothing
            , onFocusEvent = Nothing
            }


{-| -}
audio :
    List (AudioAttributes msg -> AudioAttributes msg)
    -> Node msg
audio =
    Audio
        << defaultsComposedToAttrs
            { universal = defaultUniversalAttributes
            , style = defaultStyleAttribute
            , onMouseEvents = defaultOnMouseEvents
            , src = ""
            , onEvent = Nothing
            , onBlurEvent = Nothing
            , onFocusEvent = Nothing
            }


{-| -}
progress :
    List (ProgressAttributes msg -> ProgressAttributes msg)
    -> Node msg
progress =
    Progress
        << defaultsComposedToAttrs
            { universal = defaultUniversalAttributes
            , style = defaultStyleAttribute
            , onMouseEvents = defaultOnMouseEvents
            , onEvent = Nothing
            , onBlurEvent = Nothing
            , onFocusEvent = Nothing
            }


{-| -}
table :
    List (Node msg)
    -> List (List (Node msg))
    -> Node msg
table =
    Table


{-| -}
text : String -> Node msg
text =
    Text


{-| -}
node :
    List (FlowAttributes msg -> FlowAttributes msg)
    -> List (Node msg)
    -> Node msg
node =
    div


{-| -}
leaf :
    List (FlowAttributes msg -> FlowAttributes msg)
    -> Node msg
leaf =
    flip node []


{-| -}
container :
    List (Node msg)
    -> Node msg
container =
    node []


mapLis :
    List (Node msg)
    -> List (Node msg)
mapLis =
    List.map (\content -> li [] [ content ])


{-| -}
olLi :
    List (FlowAttributes msg -> FlowAttributes msg)
    -> List (Node msg)
    -> Node msg
olLi attributes insideLis =
    ol attributes (mapLis insideLis)


{-| -}
ulLi :
    List (FlowAttributes msg -> FlowAttributes msg)
    -> List (Node msg)
    -> Node msg
ulLi attributes insideLis =
    ul attributes (mapLis insideLis)


{-| -}
script :
    List (ScriptAttributes msg -> ScriptAttributes msg)
    -> Node msg
script =
    Script
        << defaultsComposedToAttrs
            { universal = defaultUniversalAttributes
            , src = ""
            , style = defaultStyleAttribute
            , onMouseEvents = defaultOnMouseEvents
            , onEvent = Nothing
            , onBlurEvent = Nothing
            , onFocusEvent = Nothing
            , data = []
            }


{-| -}
inputHidden :
    List (InputHiddenAttributes -> InputHiddenAttributes)
    -> Node msg
inputHidden =
    InputHidden
        << defaultsComposedToAttrs
            { name = Nothing
            , universal = defaultUniversalAttributes
            , type_ = "hidden"
            , value = Nothing
            }


{-| -}
inputText :
    List (InputTextAttributes msg {} -> InputTextAttributes msg {})
    -> Node msg
inputText =
    InputText
        << defaultsComposedToAttrs
            { universal = defaultUniversalAttributes
            , style = defaultStyleAttribute
            , name = Nothing
            , type_ = "text"
            , value = Nothing
            , onMouseEvents = defaultOnMouseEvents
            , onInputEvent = Nothing
            , fromStringInput = identity
            , onEvent = Nothing
            , onBlurEvent = Nothing
            , onFocusEvent = Nothing
            , placeholder = Nothing
            , autocomplete = True
            , label = Nothing
            }


{-| -}
inputNumber :
    List (InputNumberAttributes msg -> InputNumberAttributes msg)
    -> Node msg
inputNumber =
    InputNumber
        << defaultsComposedToAttrs
            { universal = defaultUniversalAttributes
            , style = defaultStyleAttribute
            , name = Nothing
            , type_ = "number"
            , value = Nothing
            , onMouseEvents = defaultOnMouseEvents
            , onInputEvent = Nothing
            , fromStringInput = parseInt
            , onEvent = Nothing
            , onBlurEvent = Nothing
            , onFocusEvent = Nothing
            , min = Nothing
            , max = Nothing
            , step = Nothing
            , label = Nothing
            }


{-| -}
inputColor :
    List (InputColorAttributes msg -> InputColorAttributes msg)
    -> Node msg
inputColor =
    InputColor
        << defaultsComposedToAttrs
            { universal = defaultUniversalAttributes
            , style = defaultStyleAttribute
            , name = Nothing
            , type_ = "color"
            , value = Nothing
            , onMouseEvents = defaultOnMouseEvents
            , onInputEvent = Nothing
            , fromStringInput = parseColor
            , onEvent = Nothing
            , onBlurEvent = Nothing
            , onFocusEvent = Nothing
            , label = Nothing
            }


{-| -}
inputCheckbox :
    List (InputCheckboxAttributes msg -> InputCheckboxAttributes msg)
    -> Node msg
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
            , onCheckEvent = Nothing
            , onEvent = Nothing
            , onBlurEvent = Nothing
            , onFocusEvent = Nothing
            , label = Nothing
            }


{-| -}
inputFile :
    List (InputFileAttributes msg -> InputFileAttributes msg)
    -> Node msg
inputFile =
    InputFile
        << defaultsComposedToAttrs
            { name = Nothing
            , type_ = "file"
            , universal = defaultUniversalAttributes
            , style = defaultStyleAttribute
            , onMouseEvents = defaultOnMouseEvents
            , onEvent = Nothing
            , onBlurEvent = Nothing
            , onFocusEvent = Nothing
            , label = Nothing
            }


{-| -}
inputPassword :
    List (InputPasswordAttributes msg -> InputPasswordAttributes msg)
    -> Node msg
inputPassword =
    InputPassword
        << defaultsComposedToAttrs
            { name = Nothing
            , type_ = "password"
            , value = Nothing
            , universal = defaultUniversalAttributes
            , style = defaultStyleAttribute
            , onMouseEvents = defaultOnMouseEvents
            , onInputEvent = Nothing
            , fromStringInput = identity
            , onEvent = Nothing
            , onBlurEvent = Nothing
            , onFocusEvent = Nothing
            , placeholder = Nothing
            , autocomplete = True
            , label = Nothing
            }


{-| -}
inputRadio :
    List (InputRadioAttributes msg -> InputRadioAttributes msg)
    -> Node msg
inputRadio =
    InputRadio
        << defaultsComposedToAttrs
            { name = Nothing
            , type_ = "radio"
            , value = Nothing
            , universal = defaultUniversalAttributes
            , style = defaultStyleAttribute
            , onMouseEvents = defaultOnMouseEvents
            , onEvent = Nothing
            , onBlurEvent = Nothing
            , onFocusEvent = Nothing
            , label = Nothing
            }


{-| -}
inputRange :
    List (InputRangeAttributes msg -> InputRangeAttributes msg)
    -> Node msg
inputRange =
    InputRange
        << defaultsComposedToAttrs
            { universal = defaultUniversalAttributes
            , style = defaultStyleAttribute
            , name = Nothing
            , type_ = "range"
            , value = Nothing
            , onMouseEvents = defaultOnMouseEvents
            , onInputEvent = Nothing
            , fromStringInput = parseInt
            , onEvent = Nothing
            , onBlurEvent = Nothing
            , onFocusEvent = Nothing
            , min = Nothing
            , max = Nothing
            , step = Nothing
            , label = Nothing
            }


{-| -}
inputSubmit :
    List (InputSubmitAttributes msg -> InputSubmitAttributes msg)
    -> Node msg
inputSubmit =
    InputSubmit
        << defaultsComposedToAttrs
            { type_ = "submit"
            , universal = defaultUniversalAttributes
            , style = defaultStyleAttribute
            , onMouseEvents = defaultOnMouseEvents
            , disabled = False
            , onSubmitEvent = Nothing
            , onEvent = Nothing
            , onBlurEvent = Nothing
            , onFocusEvent = Nothing
            , value = Nothing
            }


{-| -}
inputUrl :
    List (InputUrlAttributes msg -> InputUrlAttributes msg)
    -> Node msg
inputUrl =
    InputUrl
        << defaultsComposedToAttrs
            { name = Nothing
            , value = Nothing
            , type_ = "url"
            , universal = defaultUniversalAttributes
            , style = defaultStyleAttribute
            , onMouseEvents = defaultOnMouseEvents
            , onInputEvent = Nothing
            , fromStringInput = identity
            , onEvent = Nothing
            , onBlurEvent = Nothing
            , onFocusEvent = Nothing
            , placeholder = Nothing
            , autocomplete = True
            , label = Nothing
            }


{-| -}
select :
    List (SelectAttributes msg -> SelectAttributes msg)
    -> Node msg
select =
    Select
        << defaultsComposedToAttrs
            { value = Nothing
            , options = []
            , universal = defaultUniversalAttributes
            , style = defaultStyleAttribute
            , onMouseEvents = defaultOnMouseEvents
            , onEvent = Nothing
            , onBlurEvent = Nothing
            , onFocusEvent = Nothing
            }



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
                        , style = styleAttribute []
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
onClick :
    msg
    -> OnMouseEvents msg a
    -> OnMouseEvents msg a
onClick val ({ onMouseEvents } as attrs) =
    let
        newOnClick =
            { onMouseEvents | click = Just val }
    in
        { attrs | onMouseEvents = newOnClick }


{-| -}
onDoubleClick :
    msg
    -> OnMouseEvents msg a
    -> OnMouseEvents msg a
onDoubleClick val ({ onMouseEvents } as attrs) =
    let
        newOnDoubleClick =
            { onMouseEvents | doubleClick = Just val }
    in
        { attrs | onMouseEvents = newOnDoubleClick }


{-| -}
onMouseUp :
    msg
    -> OnMouseEvents msg a
    -> OnMouseEvents msg a
onMouseUp val ({ onMouseEvents } as attrs) =
    let
        newOnMouseUp =
            { onMouseEvents | mouseUp = Just val }
    in
        { attrs | onMouseEvents = newOnMouseUp }


{-| -}
onMouseOut :
    msg
    -> OnMouseEvents msg a
    -> OnMouseEvents msg a
onMouseOut val ({ onMouseEvents } as attrs) =
    let
        newOnMouseOut =
            { onMouseEvents | mouseOut = Just val }
    in
        { attrs | onMouseEvents = newOnMouseOut }


{-| -}
onMouseOver :
    msg
    -> OnMouseEvents msg a
    -> OnMouseEvents msg a
onMouseOver val ({ onMouseEvents } as attrs) =
    let
        newOnMouseUp =
            { onMouseEvents | mouseOver = Just val }
    in
        { attrs | onMouseEvents = newOnMouseUp }


{-| -}
onMouseDown :
    msg
    -> OnMouseEvents msg a
    -> OnMouseEvents msg a
onMouseDown val ({ onMouseEvents } as attrs) =
    let
        newOnMouseDown =
            { onMouseEvents | mouseDown = Just val }
    in
        { attrs | onMouseEvents = newOnMouseDown }


{-| -}
onMouseLeave :
    msg
    -> OnMouseEvents msg a
    -> OnMouseEvents msg a
onMouseLeave val ({ onMouseEvents } as attrs) =
    let
        newOnMouseLeave =
            { onMouseEvents | mouseLeave = Just val }
    in
        { attrs | onMouseEvents = newOnMouseLeave }


{-| -}
onMouseEnter :
    msg
    -> OnMouseEvents msg a
    -> OnMouseEvents msg a
onMouseEnter val ({ onMouseEvents } as attrs) =
    let
        newOnMouseEnter =
            { onMouseEvents | mouseEnter = Just val }
    in
        { attrs | onMouseEvents = newOnMouseEnter }


{-| -}
onInput :
    (a -> msg)
    -> OnInputEvent a msg b
    -> OnInputEvent a msg b
onInput val attrs =
    { attrs | onInputEvent = Just val }


{-| -}
onCheck :
    (Bool -> msg)
    -> OnCheckEvent msg a
    -> OnCheckEvent msg a
onCheck val attrs =
    { attrs | onCheckEvent = Just val }


{-| -}
onSubmit :
    msg
    -> OnSubmitEvent msg a
    -> OnSubmitEvent msg a
onSubmit val attrs =
    { attrs | onSubmitEvent = Just val }


{-| -}
onFocus :
    msg
    -> OnFocusEvent msg a
    -> OnFocusEvent msg a
onFocus val attrs =
    { attrs | onFocusEvent = Just val }


{-| -}
onBlur :
    msg
    -> OnBlurEvent msg a
    -> OnBlurEvent msg a
onBlur val attrs =
    { attrs | onBlurEvent = Just val }


{-| -}
on :
    String
    -> Decoder msg
    -> OnEvent msg a
    -> OnEvent msg a
on event decoder attrs =
    { attrs | onEvent = Just ( event, decoder ) }


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
style :
    List (Style -> Style)
    -> { a | style : StyleAttribute }
    -> { a | style : StyleAttribute }
style val ({ style } as attrs) =
    let
        newStyle =
            { style | standard = style.standard ++ val }
    in
        { attrs | style = newStyle }


{-| -}
hoverStyle :
    List (Style -> Style)
    -> { a | style : StyleAttribute }
    -> { a | style : StyleAttribute }
hoverStyle val ({ style } as attrs) =
    let
        newHoverStyle =
            { style | hover = style.hover ++ val }
    in
        { attrs | style = newHoverStyle }


{-| -}
focusStyle :
    List (Style -> Style)
    -> { a | style : StyleAttribute }
    -> { a | style : StyleAttribute }
focusStyle val ({ style } as attrs) =
    let
        newStyle =
            { style | focus = style.focus ++ val }
    in
        { attrs | style = newStyle }


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


handleStyle :
    { a | style : StyleAttribute }
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleStyle { style } =
    let
        { standard, hover, focus } =
            style
    in
        [ BodyBuilderHtml.style standard
        , BodyBuilderHtml.hoverStyle hover
        , BodyBuilderHtml.focusStyle focus
        ]
            |> compose


handleData : DataAttribute a -> HtmlAttributes msg -> HtmlAttributes msg
handleData { data } =
    BodyBuilderHtml.data data


handleMouseEvents :
    OnMouseEvents msg a
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleMouseEvents { onMouseEvents } =
    let
        { click, doubleClick, mouseUp, mouseOut, mouseOver, mouseDown, mouseLeave, mouseEnter } =
            onMouseEvents
    in
        [ unwrap BodyBuilderHtml.onClick click
        , unwrap BodyBuilderHtml.onDoubleClick doubleClick
        , unwrap BodyBuilderHtml.onMouseUp mouseUp
        , unwrap BodyBuilderHtml.onMouseOut mouseOut
        , unwrap BodyBuilderHtml.onMouseOver mouseOver
        , unwrap BodyBuilderHtml.onMouseDown mouseDown
        , unwrap BodyBuilderHtml.onMouseLeave mouseLeave
        , unwrap BodyBuilderHtml.onMouseEnter mouseEnter
        ]
            |> compose


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


handleOnBlurEvent :
    OnBlurEvent msg a
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleOnBlurEvent { onBlurEvent } =
    unwrap BodyBuilderHtml.onBlur onBlurEvent


handleOnFocusEvent :
    OnFocusEvent msg a
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleOnFocusEvent { onFocusEvent } =
    unwrap BodyBuilderHtml.onFocus onFocusEvent


handleOnEvent :
    OnEvent msg a
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleOnEvent { onEvent } =
    unwrap (\( event, decoder ) -> BodyBuilderHtml.on event decoder) onEvent


handleSrc :
    SrcAttribute a
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleSrc { src } =
    BodyBuilderHtml.src src


handleDisabled :
    DisabledAttribute a
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleDisabled { disabled } =
    if disabled then
        BodyBuilderHtml.disabled
    else
        identity


handleAlt :
    AltAttribute a
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleAlt { alt } =
    BodyBuilderHtml.alt alt


handleClass :
    { a | universal : UniversalAttributes b }
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleClass { universal } =
    BodyBuilderHtml.class universal.class


handleId :
    { a | universal : UniversalAttributes b }
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleId { universal } =
    unwrap BodyBuilderHtml.id universal.id


handleTabindex :
    { a | universal : UniversalAttributes b }
    -> HtmlAttributes msg
    -> HtmlAttributes msg
handleTabindex { universal } =
    unwrap BodyBuilderHtml.tabindex universal.tabindex


handleTitle :
    { a | universal : UniversalAttributes b }
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
