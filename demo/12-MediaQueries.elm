module Main exposing (main, theFontSize, view)

import BodyBuilder as Builder exposing (NodeWithStyle)
import BodyBuilder.Attributes as Attributes
import BodyBuilder.Style as Style
import Elegant exposing (Style, px)
import Elegant.Block as Block
import Elegant.Box as Box
import Elegant.Typography as Typography


theFontSize : number
theFontSize =
    15


view : a -> NodeWithStyle msg
view model =
    Builder.p
        [ Attributes.style
            [ Style.box
                [ Box.typography
                    [ Typography.size (px theFontSize) ]
                ]
            , Style.box
                [ Box.typography
                    [ Typography.size (px (theFontSize + 5)) ]
                ]
                |> Style.media
                    (Style.between 500 800
                     -- could be lesser or greater
                    )
            ]
        ]
        [ Builder.text "Go Hover Me ! My style is set in my node, so it's parametrizable, but the result is a good old css node (look at the dom Luke)" ]


main : Program () Int msg
main =
    Builder.element
        { init = \_ -> ( 0, Cmd.none )
        , update = \msg model -> ( model, Cmd.none )
        , subscriptions = always Sub.none
        , view = view
        }
