module Main exposing (..)

import BodyBuilder exposing (Node)
import BodyBuilder.Attributes
import Elegant exposing (px, Style)
import Display
import Box
import Typography
import Typography.Character as Character


theFontSize : number
theFontSize =
    15


block blockModifiers content =
    BodyBuilder.div
        [ BodyBuilder.Attributes.style
            [ Display.block
                blockModifiers
                []
                |> Elegant.style
            ]
        ]
        content


type FlexItem
    = FlexItem


type NotFlexItem
    = NotFlexItem


type alias Img flexItem =
    { flex : flexItem }



-- img : Img flexItem


img =
    { flex = NotFlexItem }


img2 =
    { img | flex = FlexItem }


view : a -> Node msg
view model =
    -- Builder.block
    --   [ Block.style
    --     [ Display.alignCenter ]
    --     [ Box.dimensions [] ]
    --   ]
    --   [ -- Content
    --     Builder.img [Img.style Img.inline [] [] Inline.style]
    --   ]
    BodyBuilder.div
        [ BodyBuilder.Attributes.style
            [ Display.block
                [ Display.alignCenter ]
                []
                |> Elegant.style
            ]
        ]
        [ BodyBuilder.h1 []
            [ BodyBuilder.text "I'm Elegantly styled by css" ]
        , BodyBuilder.p
            [ BodyBuilder.Attributes.style
                [ Display.block []
                    [ Box.typography
                        [ Typography.character
                            [ Character.size (px theFontSize) ]
                        ]
                    ]
                    |> Elegant.style
                , Display.block []
                    [ Box.typography
                        [ Typography.character
                            [ Character.size (px (theFontSize + 5)) ]
                        ]
                    ]
                    |> Elegant.style
                    |> Elegant.setSuffix "hover"
                ]
            ]
            [ BodyBuilder.text "Go Hover Me ! My style is set in my node, so it's parametrizable, but the result is a good old css node (look at the dom Luke)" ]
        ]


main : Program Basics.Never Int msg
main =
    BodyBuilder.program
        { init = ( 0, Cmd.none )
        , update = (\msg model -> ( model, Cmd.none ))
        , subscriptions = always Sub.none
        , view = view
        }
