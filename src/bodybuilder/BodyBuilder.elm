module BodyBuilder exposing (..)

import Html exposing (Html)
import Html.Attributes
import Elegant
import Maybe.Extra
import BodyBuilder.Attributes exposing (..)
import Function
import Helpers.Shared exposing (..)
import Dict exposing (Dict)


type Node msg
    = Node (NodeContent msg)


type alias Cache =
    Dict String String


type alias DomAndStyle msg =
    { styles : List Elegant.Style
    , dom : Html msg
    }


type alias NodeContent msg =
    Cache -> ( DomAndStyle msg, Cache )


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
    visibleNode
        BodyBuilder.Attributes.defaultButtonAttributes
        BodyBuilder.Attributes.buttonAttributesToHtmlAttributes
        "button"


{-| -}
a : Modifiers (AAttributes msg) -> List (Node msg) -> Node msg
a =
    visibleNode
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
    flip
        (visibleNode
            BodyBuilder.Attributes.defaultTextareaAttributes
            BodyBuilder.Attributes.textareaAttributesToHtmlAttributes
            "textarea"
        )
        []


{-| -}
img : String -> String -> Modifiers (ImgAttributes msg) -> Node msg
img alt src =
    flip
        (visibleNode
            (BodyBuilder.Attributes.defaultImgAttributes alt src)
            BodyBuilder.Attributes.imgAttributesToHtmlAttributes
            "img"
        )
        []


{-| -}
audio : Modifiers (AudioAttributes msg) -> Node msg
audio =
    flip
        (visibleNode
            BodyBuilder.Attributes.defaultAudioAttributes
            BodyBuilder.Attributes.audioAttributesToHtmlAttributes
            "audio"
        )
        []


{-| -}
progress : Modifiers (ProgressAttributes msg) -> Node msg
progress =
    flip
        (visibleNode
            BodyBuilder.Attributes.defaultProgressAttributes
            BodyBuilder.Attributes.progressAttributesToHtmlAttributes
            "progress"
        )
        []


{-| TODO
-}
table : List (Node msg) -> List (List (Node msg)) -> Node msg
table children table =
    visibleNode BodyBuilder.Attributes.defaultFlowAttributes (\_ -> []) "table" [] []


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


{-| TODO
-}
mapLis : List (Node msg) -> List (Node msg)
mapLis =
    List.map (\content -> li [] [ content ])


{-| TODO
-}
olLi : Modifiers (FlowAttributes msg) -> List (Node msg) -> Node msg
olLi attributes insideLis =
    ol attributes (mapLis insideLis)


{-| TODO
-}
ulLi : Modifiers (FlowAttributes msg) -> List (Node msg) -> Node msg
ulLi attributes insideLis =
    ul attributes (mapLis insideLis)


{-| -}
script : Modifiers (ScriptAttributes msg) -> Node msg
script =
    flip
        (visibleNode
            BodyBuilder.Attributes.defaultScriptAttributes
            BodyBuilder.Attributes.scriptAttributesToHtmlAttributes
            "script"
        )
        []


{-| -}
inputHidden : Modifiers InputHiddenAttributes -> Node msg
inputHidden =
    hiddenNode
        BodyBuilder.Attributes.defaultInputHiddenAttributes
        BodyBuilder.Attributes.inputHiddenAttributesToHtmlAttributes
        "input"


{-| -}
inputText : Modifiers (InputTextAttributes msg) -> Node msg
inputText =
    flip
        (visibleNode
            BodyBuilder.Attributes.defaultInputTextAttributes
            BodyBuilder.Attributes.inputTextAttributesToHtmlAttributes
            "input"
        )
        []


{-| -}
inputNumber : Modifiers (InputNumberAttributes msg) -> Node msg
inputNumber =
    flip
        (visibleNode
            BodyBuilder.Attributes.defaultInputNumberAttributes
            BodyBuilder.Attributes.inputNumberAttributesToHtmlAttributes
            "input"
        )
        []


{-| -}
inputColor : Modifiers (InputColorAttributes msg) -> Node msg
inputColor =
    flip
        (visibleNode
            BodyBuilder.Attributes.defaultInputColorAttributes
            BodyBuilder.Attributes.inputColorAttributesToHtmlAttributes
            "input"
        )
        []


{-| -}
inputCheckbox : Modifiers (InputCheckboxAttributes msg) -> Node msg
inputCheckbox =
    flip
        (visibleNode
            BodyBuilder.Attributes.defaultInputCheckboxAttributes
            BodyBuilder.Attributes.inputCheckboxAttributesToHtmlAttributes
            "input"
        )
        []


{-| -}
inputFile : Modifiers (InputFileAttributes msg) -> Node msg
inputFile =
    flip
        (visibleNode
            BodyBuilder.Attributes.defaultInputFileAttributes
            BodyBuilder.Attributes.inputFileAttributesToHtmlAttributes
            "input"
        )
        []


{-| -}
inputPassword : Modifiers (InputPasswordAttributes msg) -> Node msg
inputPassword =
    flip
        (visibleNode
            BodyBuilder.Attributes.defaultInputPasswordAttributes
            BodyBuilder.Attributes.inputPasswordAttributesToHtmlAttributes
            "input"
        )
        []


{-| -}
inputRadio : Modifiers (InputRadioAttributes msg) -> Node msg
inputRadio =
    flip
        (visibleNode
            BodyBuilder.Attributes.defaultInputRadioAttributes
            BodyBuilder.Attributes.inputRadioAttributesToHtmlAttributes
            "input"
        )
        []


{-| -}
inputRange : Modifiers (InputRangeAttributes msg) -> Node msg
inputRange =
    flip
        (visibleNode
            BodyBuilder.Attributes.defaultInputRangeAttributes
            BodyBuilder.Attributes.inputRangeAttributesToHtmlAttributes
            "input"
        )
        []


{-| -}
inputSubmit : Modifiers (InputSubmitAttributes msg) -> Node msg
inputSubmit =
    flip
        (visibleNode
            BodyBuilder.Attributes.defaultInputSubmitAttributes
            BodyBuilder.Attributes.inputSubmitAttributesToHtmlAttributes
            "input"
        )
        []


{-| -}
inputUrl : Modifiers (InputUrlAttributes msg) -> Node msg
inputUrl =
    flip
        (visibleNode
            BodyBuilder.Attributes.defaultInputUrlAttributes
            BodyBuilder.Attributes.inputUrlAttributesToHtmlAttributes
            "input"
        )
        []


{-| -}
select : Modifiers (SelectAttributes msg) -> Node msg
select =
    flip
        (visibleNode
            BodyBuilder.Attributes.defaultSelectAttributes
            BodyBuilder.Attributes.selectAttributesToHtmlAttributes
            "select"
        )
        []


text : String -> Node msg
text content =
    Node (\cache -> ( DomAndStyle [] (Html.text content), cache ))


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


toVirtualDomClassName : Elegant.Style -> ( List (Html.Attribute msg), Cache ) -> ( List (Html.Attribute msg), Cache )
toVirtualDomClassName style ( attributes, cache ) =
    let
        hash =
            toString style
    in
        case Dict.get hash cache of
            Nothing ->
                let
                    classes =
                        Elegant.classes style
                in
                    ( (Html.Attributes.class classes) :: attributes, (Dict.insert hash classes cache) )

            Just classes ->
                ( (classes |> Html.Attributes.class) :: attributes, cache )


visibleNode :
    BodyBuilder.Attributes.VisibleAttributes a
    -> (BodyBuilder.Attributes.VisibleAttributes a -> List (Html.Attribute msg))
    -> String
    -> Modifiers (BodyBuilder.Attributes.VisibleAttributes a)
    -> List (Node msg)
    -> Node msg
visibleNode defaultAttributes attributesToVirtualDomAttributes tag attributesModifiers content =
    Node <|
        \cache ->
            let
                computedAttributes =
                    Function.compose attributesModifiers <| defaultAttributes

                -- debug =
                --   Debug.log "cache" cache
                ( cacheNew, nodesResults ) =
                    content
                        |> List.map extractNodeContent
                        |> List.foldr extractStylesCache ( cache, [] )

                styledDomWithStyle ( style, ( classesNamesProperty, cacheNewNew ) ) =
                    ( DomAndStyle
                        (style ++ (List.foldr extractStyles [] nodesResults))
                        (Html.node tag
                            (classesNamesProperty ++ (attributesToVirtualDomAttributes computedAttributes))
                            (List.map extractDomNodes nodesResults)
                        )
                    , cacheNewNew
                    )
            in
                styledDomWithStyle <|
                    case computedAttributes.style of
                        Nothing ->
                            ( [], ( [], cache ) )

                        Just { standard, focus, hover } ->
                            ( [ standard, focus, hover ]
                                |> Maybe.Extra.values
                            , [ standard
                              , focus
                              , hover
                              ]
                                |> Maybe.Extra.values
                                |> List.foldr toVirtualDomClassName ( [], cache )
                            )


extractNodeContent : Node msg -> NodeContent msg
extractNodeContent (Node content) =
    content


extractStylesCache : (Cache -> ( DomAndStyle msg, Cache )) -> ( Cache, List (DomAndStyle msg) ) -> ( Cache, List (DomAndStyle msg) )
extractStylesCache nodeCreation ( cache, nodesRes ) =
    let
        ( resNode, cacheNew ) =
            nodeCreation cache
    in
        ( cacheNew, resNode :: nodesRes )


hiddenNode : a -> (a -> List (Html.Attribute msg)) -> String -> List (a -> a) -> Node msg
hiddenNode defaultAttributes attributesToVirtualDomAttributes tag attributesModifiers =
    Node <|
        \cache ->
            ( defaultAttributes
                |> (Function.compose attributesModifiers)
                |> attributesToVirtualDomAttributes
                |> flip (Html.node tag) []
                |> DomAndStyle []
            , cache
            )


extractStyles : DomAndStyle msg -> List Elegant.Style -> List Elegant.Style
extractStyles { styles } accumulator =
    styles ++ accumulator


extractDomNodes : DomAndStyle msg -> Html msg
extractDomNodes { dom } =
    dom


flow :
    String
    -> Modifiers (FlowAttributes msg)
    -> List (Node msg)
    -> Node msg
flow =
    visibleNode
        BodyBuilder.Attributes.defaultFlowAttributes
        BodyBuilder.Attributes.flowAttributesToHtmlAttributes


toVirtualDom : Node msg -> Html msg
toVirtualDom (Node tree) =
    let
        { styles, dom } =
            Dict.empty
                |> tree
                |> Tuple.first
    in
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
