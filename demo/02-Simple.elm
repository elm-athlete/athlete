module Main exposing (..)

import BodyBuilder as Builder exposing (NodeWithStyle)
import BodyBuilder.Attributes as Attributes
import BodyBuilder.Style
import Elegant exposing (Style, px)
import Elegant.Block
import Elegant.Box
import Elegant.Typography


theFontSize : number
theFontSize =
    15


view : a -> NodeWithStyle msg
view model =
    Builder.node
        [ Attributes.style
            [ Style.block
                [ Block.alignCenter ]
            ]
        ]
        [ Builder.h1 []
            [ Builder.text "I'm Elegantly styled by css" ]
        , Builder.p
            [ Attributes.style
                [ Style.box
                    [ Box.typography
                        [ Typography.size (px theFontSize) ]
                    ]
                , Style.box
                    [ Box.typography
                        [ Typography.size (px (theFontSize + 5)) ]
                    ]
                    |> Style.pseudoClass "hover"
                ]
            ]
            [ Builder.text "Go Hover Me ! My style is set in my node, so it's parametrizable, but the result is a good old css node (look at the dom Luke)" ]
        ]


main : Program () Int msg
main =
    Builder.embed
        { init = \_ -> ( 0, Cmd.none )
        , update = \msg model -> ( model, Cmd.none )
        , subscriptions = always Sub.none
        , view = view
        }
