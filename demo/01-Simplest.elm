module Simplest exposing (..)

import BodyBuilder exposing (..)
import BodyBuilder.Attributes as Attrs
import Elegant
import Color


view : a -> Node msg
view model =
    -- div
    --     [ style [ textColor Color.blue ]
    --     , hoverStyle [ textColor Color.red ]
    --     ]
    --     [ text "I'm Elegantly styled by css, but my style is set inline" ]
    -- node [ Attrs.block [] ] []
    text "Bonjour"


main : Program Basics.Never number msg
main =
    program
        { init = ( 0, Cmd.none )
        , update = (\msg model -> ( model, Cmd.none ))
        , subscriptions = always Sub.none
        , view = view
        }
