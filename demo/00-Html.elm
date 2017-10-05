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
                                    , Typography.Character.size (px 100)
                                    , Typography.Character.italic
                                    ]
                                ]
                            , Elegant.padding (px 30)
                            , Elegant.boxShadow
                                [ BoxShadow.standard (px 30) Color.black ( px 3, px 3 )
                                , BoxShadow.inset True
                                ]
                            , Elegant.border
                                [ Border.all
                                    [ Elegant.color Color.blue
                                    , Border.solid
                                    , Border.thickness (px 200)
                                    ]
                                , Border.horizontal
                                    [ Elegant.color Color.black ]
                                , Border.right
                                    [ Elegant.color Color.lightOrange ]
                                ]

                            -- , Elegant.margin
                            --   [ Margin.width (px 30)
                            --   , Margin.bottom Margin.default
                            --     [ Margin.Side.width (px 200) ]
                            --   ]
                            ]
        ]
        [ Html.text "Just a text." ]
