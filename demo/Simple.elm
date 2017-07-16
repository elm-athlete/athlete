module Main exposing (..)

import BodyBuilder exposing (..)
import Elegant exposing (textCenter, padding, SizeUnit(..), fontSize)


theFontSize : number
theFontSize =
    15


view : a -> Node Interactive NotPhrasing Spanning NotListElement msg
view model =
    div [ style [ textCenter ] ]
        [ h1 [] [ text "I'm Elegantly styled by css" ]
        , p
            [ style [ fontSize (Px theFontSize) ]
            , hoverStyle [ fontSize (Px (theFontSize + 5)) ]
            ]
            [ text "Go Hover Me ! My style is set in my node, so it's parametrizable, but the result is a good old css node (look at the dom Luke)" ]
        , div []
            [ span []
                [ text "Try to put a div next to me (uncomment next line in the source)"

                -- , div [] []
                ]
            ]
        , div []
            [ a []
                [ text "Try to put an a next to me (uncomment next line in the source)"

                -- , a[] []
                ]
            ]
        ]


main : Program Basics.Never Int msg
main =
    program
        { init = ( 0, Cmd.none )
        , update = (\msg model -> ( model, Cmd.none ))
        , subscriptions = always Sub.none
        , view = view
        }
