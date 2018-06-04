module BodyBuilder.Internals.Shared exposing (..)

import Html exposing (Html)


type Label msg
    = Label (Html msg -> Html msg)


extractLabel : Label msg -> Html msg -> Html msg
extractLabel (Label l) =
    l


label : (Html msg -> Html msg) -> Label msg
label =
    Label
