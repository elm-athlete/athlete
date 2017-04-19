module Demo exposing (..)

import Elegant exposing (..)
import Elegant.Elements exposing (..)
import Color exposing (..)
import Html


type alias Model =
    Int


init : ( Model, Cmd msg )
init =
    ( 0, Cmd.none )


view : Model -> Html.Html msg
view model =
    Html.div (simpleStyle [ width (Px 1024), marginAuto, padding medium ])
        [ Html.h3
            (simpleStyle
                [ paddingBottom tiny
                ]
            )
            [ Html.text "Alignment" ]
        , Html.div
            (simpleStyle
                [ width (Px 400)
                , marginAuto
                , border black
                , padding medium
                ]
            )
            [ Html.text "I'm centered with auto margins and a width of 400px" ]
        , Html.div
            (simpleStyle
                [ width (Px 600)
                , marginAuto
                , border black
                , padding medium
                ]
            )
            [ Html.text "I'm centered with auto margins and a width of 600px" ]
        , Html.div
            (simpleStyle
                [ textCenter
                ]
            )
            [ Html.text "I'm centered" ]
        , Html.div
            (simpleStyle
                [ textRight
                ]
            )
            [ Html.text "I'm right aligned" ]
        , Html.div
            (simpleStyle
                [ textLeft
                ]
            )
            [ Html.text "I'm left aligned" ]
        , Html.div
            (simpleStyle
                [ backgroundColor (Color.rgb 40 160 240)
                , textColor (Color.rgb (255 - 40) (255 - 160) (255 - 240))
                , padding medium
                ]
            )
            [ Html.text "I'm colored" ]
        , Html.div
            (simpleStyle
                [ border black
                , borderWidth 3
                ]
            )
            [ Html.text "I have a big black border" ]
        , Html.h3
            (simpleStyle
                [ paddingBottom tiny
                ]
            )
            [ Html.text "Flex" ]
        , Html.div (simpleStyle [ displayFlex, spaceBetween ]) []
        ]


update : msg -> Model -> ( Model, Cmd msg )
update msg model =
    ( model, Cmd.none )


main : Program Never Model msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = (\e -> Sub.none)
        }
