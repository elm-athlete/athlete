module Main exposing (main)

import BodyBuilder as Builder exposing (NodeWithStyle)


view : NodeWithStyle msg
view =
    Builder.node [] [ Builder.text "I'm a node and I like it!" ]


main : Program () () msg
main =
    Builder.staticPage view
