module Main exposing (main)

import BodyBuilder as B exposing (NodeWithStyle)
import Color
import Elegant.Constants as Constants
import Elegant.Extra exposing (..)


view : NodeWithStyle msg
view =
    B.div [ paddingAll Constants.medium, backgroundColor Color.blue ] [ B.text "Hello world" ]


main : Program () () msg
main =
    B.staticPage view
