module Simplest exposing (..)

import BodyBuilder as Builder exposing (Node)


view : Node msg
view =
    Builder.node [] [ Builder.text "I'm a node and I like it!" ]


main : Node msg
main =
    view
