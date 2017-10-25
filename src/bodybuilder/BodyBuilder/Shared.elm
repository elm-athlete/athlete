module BodyBuilder.Shared exposing (..)

import Html exposing (Html)


type Label msg
    = Label (Html msg -> Html msg)


extractLabel : Label msg -> Html msg -> Html msg
extractLabel (Label label) =
    label


label : (Html msg -> Html msg) -> Label msg
label =
    Label
