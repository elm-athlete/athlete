module Simplest exposing (..)

import BodyBuilder as Builder exposing (Node)
import BodyBuilder.Attributes as Attributes
import BodyBuilder.Events as Events
import Elegant exposing (px, percent)
import Display
import Box
import Padding
import Color


type Msg
    = None


view : a -> Node Msg
view model =
    Builder.node
        [ Attributes.style
            [ Attributes.block [ Display.alignCenter ]
            , Attributes.block []
                |> Attributes.media (Attributes.between 300 600)
                |> Attributes.hover
            , Attributes.box
                [ Box.background [ Elegant.color Color.blue ] ]
            , Attributes.box
                [ Box.background [ Elegant.color Color.lightPurple ] ]
                |> Attributes.media (Attributes.between 300 600)
                |> Attributes.hover
            ]
        , Events.onClick None
        ]
        [ Builder.node [] [ Builder.text "I'm inline!" ]
        , Builder.node
            [ Attributes.style [ Attributes.box [ Box.padding [ Padding.vertical (px 30) ] ] ] ]
            [ Builder.text "I'm inline too!" ]
        , Builder.node
            [ Attributes.style [ Attributes.block [] ] ]
            [ Builder.text "But I'm a block!" ]
        , Builder.node [] [ Builder.text "I'm still inline for me!" ]
        , Builder.flex
            [ Attributes.style
                [ Attributes.block [] -- Base
                , Attributes.block [] -- |> media (greater (px 700)) -- When x > 700px

                -- , Attributes.flexContainerProperties []
                -- , Attributes.flexContainerProperties [] -- |> media (less (px 700))
                -- , Attributes.flexContainerProperties [] -- |> media (greater (px 700))
                ]
            ]
            [ Builder.flexItem
                [ Attributes.style
                    [ -- Attributes.flexItemProperties
                      -- [ Display.alignSelf Display.center
                      -- , Display.basis (px 30)
                      -- ]
                      Attributes.block []
                    ]

                -- , Events.onClick None
                ]
                [ Builder.node
                    [ Attributes.style [ Attributes.block [] ] ]
                    [ Builder.text "I'm inside a flexItem" ]
                ]
            ]
        , Builder.br

        -- , Builder.grid
        --     [ Attributes.gridContainerProperties [] ]
        --     [ Builder.gridItem [ Attributes.gridItemProperties [] ] [] ]
        -- , Builder.ul [] [ Builder.li [] [] ]
        -- Modifiers (ListAttributes msg) -> List (ListItem msg) -> Node msg
        -- List (ListItem)
        -- , Builder.ol [] [ Builder.li [] [] ]
        -- Modifiers (ListAttributes msg) -> List (ListItem msg) -> Node msg
        -- List (ListItem)
        -- Default to block
        , Builder.h1 [] [ Builder.text "I'm a h1!" ]
        , Builder.h2 [] [ Builder.text "I'm a h2!" ]
        , Builder.h3 [] [ Builder.text "I'm a h3!" ]
        , Builder.h4 [] [ Builder.text "I'm a h4!" ]
        , Builder.h5 [] [ Builder.text "I'm a h5!" ]
        , Builder.h6 [] [ Builder.text "I'm a h6!" ]
        , Builder.p [] [ Builder.text "I'm a paragraph. I don't display like a heading." ]

        -- [ Builder.a []
        --   [ Builder.text "I'm a title." ]
        -- ]
        -- , Builder.input []
        -- , Builder.iframe [ Attributes.width 120 ]
        -- , Builder.a [] []
        ]


main : Program Basics.Never Int Msg
main =
    Builder.program
        { init = ( 0, Cmd.none )
        , update = (\msg model -> ( model, Cmd.none ))
        , subscriptions = always Sub.none
        , view = view
        }
