module Simplest exposing (..)

import BodyBuilder exposing (..)
import Elegant exposing (textCenter)


view : a -> Node interactiveContent phrasingContent Spanning NotListElement msg
view model =
    div [ style [ textCenter ] ] [ text "I'm Elegantly styled by css, but my style is set inline" ]


main : Program Basics.Never number msg
main =
    program
        { init = ( 0, Cmd.none )
        , update = (\msg model -> ( model, Cmd.none ))
        , subscriptions = always Sub.none
        , view = view
        }
