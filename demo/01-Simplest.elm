module Simplest exposing (..)

import BodyBuilder as Builder exposing (Node)
import BodyBuilder.Attributes as Attributes
import Elegant exposing (px, percent)
import Display
import Box
import Padding
import Color


view : a -> Node msg
view model =
    Builder.node
        [ Attributes.block [ Display.alignCenter ]
        , Attributes.box [ Box.background [ Elegant.color Color.lightPurple ] ]
        ]
        [ Builder.node [] [ Builder.text "I'm inline!" ]
        , Builder.node
            [ Attributes.box [ Box.padding [ Padding.vertical (px 30) ] ] ]
            [ Builder.text "I'm inline too!" ]
        , Builder.node
            [ Attributes.block [] ]
            [ Builder.text "But I'm a block!" ]
        , Builder.node [] [ Builder.text "I'm still inline for me!" ]
        , Builder.flex
            []
            [ Attributes.block [] ]
            [ Builder.text "I'm a flex element" ]
        ]


main : Program Basics.Never number msg
main =
    Builder.program
        { init = ( 0, Cmd.none )
        , update = (\msg model -> ( model, Cmd.none ))
        , subscriptions = always Sub.none
        , view = view
        }
