module Main exposing (..)

import BodyBuilder exposing (..)
import Elegant exposing (textCenter, padding, SizeUnit(..), fontSize)


theFontSize : number
theFontSize =
    15


view : a -> Node msg
view model =
    div [ style [ textCenter ] ]
        [ h1 [] [ text "I'm Elegantly styled by css" ]
        , p
            [ style [ fontSize (Px theFontSize) ]
            , hoverStyle [ fontSize (Px (theFontSize + 5)) ]
            ]
            [ text "Go Hover Me ! My style is set in my node, so it's parametrizable, but the result is a good old css node (look at the dom Luke)" ]
        ]


main : Program Basics.Never Int msg
main =
    program
        { init = ( 0, Cmd.none )
        , update = (\msg model -> ( model, Cmd.none ))
        , subscriptions = always Sub.none
        , view = view
        }
