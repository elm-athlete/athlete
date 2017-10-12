module BodyBuilder exposing (..)

import VirtualDom
import Elegant
import Maybe.Extra
import BodyBuilder.Attributes exposing (FlowAttributes, ButtonAttributes)
import Function


type alias Node msg =
    { styles : List Elegant.Style
    , dom : VirtualDom.Node msg
    }


toVirtualDomClassName : Elegant.Style -> VirtualDom.Property msg
toVirtualDomClassName =
    Elegant.classes
        >> VirtualDom.attribute "class"


type alias AttributesWithStyle a =
    { a | style : Maybe BodyBuilder.Attributes.StyleAttribute }


parentNode :
    AttributesWithStyle a
    -> (AttributesWithStyle a -> List (VirtualDom.Property msg))
    -> String
    -> List (AttributesWithStyle a -> AttributesWithStyle a)
    -> List (Node msg)
    -> Node msg
parentNode defaultAttributes attributesToVirtualDomAttributes tag attributesModifiers content =
    let
        computedAttributes =
            (Function.compose attributesModifiers) defaultAttributes

        styledDomWithStyle ( style, classesNamesProperty ) =
            Node
                (style ++ (List.foldl extractStyles [] content))
                (VirtualDom.node tag
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


flow :
    String
    -> List (FlowAttributes msg -> FlowAttributes msg)
    -> List (Node msg)
    -> Node msg
flow =
    parentNode BodyBuilder.Attributes.defaultFlowAttributes BodyBuilder.Attributes.flowAttributesToVirtualDom


div :
    List (FlowAttributes msg -> FlowAttributes msg)
    -> List (Node msg)
    -> Node msg
div =
    flow "div"


{-| -}
br :
    List (FlowAttributes msg -> FlowAttributes msg)
    -> Node msg
br =
    flip (flow "br") []


h1 :
    List (FlowAttributes msg -> FlowAttributes msg)
    -> List (Node msg)
    -> Node msg
h1 =
    flow "h1"


{-| -}
button :
    List (ButtonAttributes msg {} -> ButtonAttributes msg {})
    -> List (Node msg)
    -> Node msg
button =
    parentNode BodyBuilder.Attributes.defaultButtonAttributes BodyBuilder.Attributes.buttonAttributesToVirtualDom "button"


text : String -> Node msg
text =
    Node [] << VirtualDom.text


toVirtualDom : Node msg -> VirtualDom.Node msg
toVirtualDom { styles, dom } =
    VirtualDom.node "div"
        []
        [ VirtualDom.node "style" [] [putStyle styles]
        , dom
        ]


putStyle : List Elegant.Style -> VirtualDom.Node msg
putStyle styles =
    styles
        |> Elegant.stylesToCss
        |> String.join "\n"
        |> VirtualDom.text


extractStyles : Node msg -> List Elegant.Style -> List Elegant.Style
extractStyles { styles } accumulator =
    styles ++ accumulator


extractDomNodes : Node msg -> VirtualDom.Node msg
extractDomNodes { dom } =
    dom


program :
    { init : ( model, Cmd msg )
    , subscriptions : model -> Sub msg
    , update : msg -> model -> ( model, Cmd msg )
    , view : model -> Node msg
    }
    -> Program Never model msg
program { init, update, subscriptions, view } =
    VirtualDom.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = toVirtualDom << view
        }
