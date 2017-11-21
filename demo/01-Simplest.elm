module Simplest exposing (..)

import BodyBuilder as Builder exposing (Node)


view : Node msg
view =
    Builder.node [] [ Builder.text "I'm a node and I like it!" ]


main : Node msg
main =
    view



-- -rw-r--r--   1 thibautassus  staff    15M Nov 17 17:22 BodyBuilder.elmi
-- -rw-r--r--   1 thibautassus  staff   7.5M Nov 17 17:22 BodyBuilder-Attributes.elmi
-- -rw-r--r--   1 thibautassus  staff   1.6M Nov 15 11:42 Box.elmi
