module BodyBuilder exposing (..)

import Html exposing (Html)
import Html.Attributes
import Elegant
import Maybe.Extra
import BodyBuilder.Attributes exposing (..)
import Function
import Helpers.Shared exposing (..)


type alias Node msg =
    { styles : List Elegant.Style
    , dom : Html msg
    }


div : Modifiers (FlowAttributes msg) -> List (Node msg) -> Node msg
div =
    flow "div"


br : Modifiers (FlowAttributes msg) -> Node msg
br =
    flip (flow "br") []


h1 : Modifiers (FlowAttributes msg) -> List (Node msg) -> Node msg
h1 =
    flow "h1"


h2 : Modifiers (FlowAttributes msg) -> List (Node msg) -> Node msg
h2 =
    flow "h2"


h3 : Modifiers (FlowAttributes msg) -> List (Node msg) -> Node msg
h3 =
    flow "h3"


h4 : Modifiers (FlowAttributes msg) -> List (Node msg) -> Node msg
h4 =
    flow "h4"


h5 : Modifiers (FlowAttributes msg) -> List (Node msg) -> Node msg
h5 =
    flow "h5"


h6 : Modifiers (FlowAttributes msg) -> List (Node msg) -> Node msg
h6 =
    flow "h6"


button : Modifiers (ButtonAttributes msg) -> List (Node msg) -> Node msg
button =
    parentNode
        BodyBuilder.Attributes.defaultButtonAttributes
        BodyBuilder.Attributes.buttonAttributesToHtmlAttributes
        "button"


{-| -}
a : Modifiers (AAttributes msg) -> List (Node msg) -> Node msg
a =
    parentNode
        BodyBuilder.Attributes.defaultAattributes
        BodyBuilder.Attributes.aAttributesToHtmlAttributes
        "a"


{-| -}
ul : Modifiers (FlowAttributes msg) -> List (Node msg) -> Node msg
ul =
    flow "ul"


{-| -}
ol : Modifiers (FlowAttributes msg) -> List (Node msg) -> Node msg
ol =
    flow "ol"


{-| -}
li : Modifiers (FlowAttributes msg) -> List (Node msg) -> Node msg
li =
    flow "li"


{-| -}
p : Modifiers (FlowAttributes msg) -> List (Node msg) -> Node msg
p =
    flow "p"


{-| -}
span : Modifiers (FlowAttributes msg) -> List (Node msg) -> Node msg
span =
    flow "span"


{-| -}
textarea : Modifiers (TextareaAttributes msg) -> Node msg
textarea =
    parentNode
        BodyBuilder.Attributes.defaultTextareaAttributes
        BodyBuilder.Attributes.textareaAttributesToHtmlAttributes
        "textarea"


{-| -}
img : String -> String -> Modifiers (ImgAttributes msg) -> Node msg
img alt src =
    parentNode
        (BodyBuilder.Attributes.defaultImgAttributes alt src)
        BodyBuilder.Attributes.imgAttributesToHtmlAttributes
        "img"


{-| -}
audio : Modifiers (AudioAttributes msg) -> Node msg
audio =
    parentNode
        BodyBuilder.Attributes.defaultAudioAttributes
        BodyBuilder.Attributes.audioAttributesToHtmlAttributes
        "audio"


{-| -}
progress : Modifiers (ProgressAttributes msg) -> Node msg
progress =
    parentNode
        BodyBuilder.Attributes.defaultProgressAttributes
        BodyBuilder.Attributes.progressAttributesToHtmlAttributes
        "progress"


{-| TODO
-}
table : List (Node msg) -> List (List (Node msg)) -> Node msg
table =
    parentNode {} (\_ -> []) "table"


{-| -}
node : String -> Modifiers (FlowAttributes msg) -> List (Node msg) -> Node msg
node =
    flow


{-| -}
leaf : Modifiers (FlowAttributes msg) -> Node msg
leaf =
    flip div []


{-| -}
container : List (Node msg) -> Node msg
container =
    div []


mapLis : List (Node msg) -> List (Node msg)
mapLis =
    List.map (\content -> li [] [ content ])


{-| -}
olLi : Modifiers (FlowAttributes msg) -> List (Node msg) -> Node msg
olLi attributes insideLis =
    ol attributes (mapLis insideLis)


{-| -}
ulLi : Modifiers (FlowAttributes msg) -> List (Node msg) -> Node msg
ulLi attributes insideLis =
    ul attributes (mapLis insideLis)


{-| -}
script : Modifiers (ScriptAttributes msg) -> Node msg
script =
    parentNode
        BodyBuilder.Attributes.defaultScriptAttributes
        BodyBuilder.Attributes.scriptAttributesToHtmlAttributes
        "script"


{-| -}
inputHidden : Modifiers InputHiddenAttributes -> Node msg
inputHidden =
    parentNode
        BodyBuilder.Attributes.defaultInputHiddenAttributes
        BodyBuilder.Attributes.inputHiddenAttributesToHtmlAttributes
        "input"


{-| -}
inputText : Modifiers (InputTextAttributes msg) -> Node msg
inputText =
    parentNode
        BodyBuilder.Attributes.defaultInputTextAttributes
        BodyBuilder.Attributes.inputTextAttributesToHtmlAttributes
        "input"


{-| -}
inputNumber : Modifiers (InputNumberAttributes msg) -> Node msg
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
inputColor : Modifiers (InputColorAttributes msg) -> Node msg
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
inputCheckbox : Modifiers (InputCheckboxAttributes msg) -> Node msg
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
inputFile : Modifiers (InputFileAttributes msg) -> Node msg
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
inputPassword : Modifiers (InputPasswordAttributes msg) -> Node msg
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
inputRadio : Modifiers (InputRadioAttributes msg) -> Node msg
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
inputRange : Modifiers (InputRangeAttributes msg) -> Node msg
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
inputSubmit : Modifiers (InputSubmitAttributes msg) -> Node msg
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
inputUrl : Modifiers (InputUrlAttributes msg) -> Node msg
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
select : Modifiers (SelectAttributes msg) -> Node msg
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


text : String -> Node msg
text =
    Node [] << Html.text


program :
    { init : ( model, Cmd msg )
    , subscriptions : model -> Sub msg
    , update : msg -> model -> ( model, Cmd msg )
    , view : model -> Node msg
    }
    -> Program Never model msg
program { init, update, subscriptions, view } =
    Html.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = toVirtualDom << view
        }



-- Internals


toVirtualDomClassName : Elegant.Style -> Html.Attribute msg
toVirtualDomClassName =
    Elegant.classes >> Html.Attributes.class


parentNode :
    BodyBuilder.Attributes.VisibleAttributes a
    -> (BodyBuilder.Attributes.VisibleAttributes a -> List (Html.Attribute msg))
    -> String
    -> Modifiers (BodyBuilder.Attributes.VisibleAttributes a)
    -> List (Node msg)
    -> Node msg
parentNode defaultAttributes attributesToVirtualDomAttributes tag attributesModifiers content =
    let
        computedAttributes =
            Function.compose attributesModifiers <| defaultAttributes

        styledDomWithStyle ( style, classesNamesProperty ) =
            Node
                (style ++ (List.foldr extractStyles [] content))
                (Html.node tag
                    (classesNamesProperty ++ (attributesToVirtualDomAttributes computedAttributes))
                    (List.map extractDomNodes content)
                )
    in
        styledDomWithStyle <|
            case computedAttributes.style of
                Nothing ->
                    ( [], [] )

                Just { standard, focus, hover } ->
                    ( [ standard, focus, hover ]
                        |> Maybe.Extra.values
                    , [ standard
                      , focus
                      , hover
                      ]
                        |> List.map (Maybe.map toVirtualDomClassName)
                        |> Maybe.Extra.values
                    )


extractStyles : Node msg -> List Elegant.Style -> List Elegant.Style
extractStyles { styles } accumulator =
    styles ++ accumulator


extractDomNodes : Node msg -> Html msg
extractDomNodes { dom } =
    dom


flow : String -> Modifiers (FlowAttributes msg) -> List (Node msg) -> Node msg
flow =
    parentNode
        BodyBuilder.Attributes.defaultFlowAttributes
        BodyBuilder.Attributes.flowAttributesToHtmlAttributes


toVirtualDom : Node msg -> Html msg
toVirtualDom { styles, dom } =
    Html.div []
        [ Html.node "style" [] [ computeStyles styles ]
        , dom
        ]


computeStyles : List Elegant.Style -> Html msg
computeStyles styles =
    styles
        |> Elegant.stylesToCss
        |> String.join "\n"
        |> Html.text
