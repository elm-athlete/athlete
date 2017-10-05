module Main exposing (..)

import Html exposing (Html)
import Html.Attributes
import Elegant exposing (px)
import Typography
import Typography.Character
import BoxShadow
import Border
import Color exposing (Color)


main : Html msg
main =
    Html.div
        [ Html.Attributes.style <|
            Elegant.toInlineStyles <|
                flip Elegant.style [] <|
                    Just <|
                        Elegant.displayBlock []
                            [ Elegant.typography
                                [ Elegant.color Color.blue
                                , Typography.character
                                    [ Typography.Character.weight 900
                                    , Typography.Character.size (px 200)
                                    , Typography.Character.italic
                                    ]
                                ]
                            , Elegant.padding (px 30)
                            , Elegant.boxShadow
                                [ BoxShadow.standard (px 30) Color.black ( px 3, px 3 )
                                , BoxShadow.inset True
                                ]
                            , Elegant.border
                                [ Border.top
                                    [ Elegant.color Color.blue
                                    , Border.solid
                                    ]
                                , Border.horizontal
                                    [ Elegant.color Color.black ]
                                ]

                            -- , Elegant.margin
                            --   [ Margin.width (px 30)
                            --   , Margin.bottom Margin.default
                            --     [ Margin.Side.width (px 200) ]
                            --   ]
                            ]
        ]
        [ Html.text "Just a text." ]
