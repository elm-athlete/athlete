module Demo exposing (..)

import Elegant exposing (..)
import Elegant.Elements exposing (..)
import Color exposing (..)
import Html exposing (text, div, h1, h3)


type alias Model =
    { elegantState : Elegant.State
    , blueComponent : Int
    }


type Msg
    = ElegantMsg Elegant.Msg


init : ( Model, Cmd Msg )
init =
    ( Model Elegant.emptyState 240, Elegant.initialSize ElegantMsg )


view : Model -> Html.Html Msg
view model =
    let
        ( x, y ) =
            getWindowSize model.elegantState

        windowHoverStyle id =
            hoverStyle ( model.elegantState, id, ElegantMsg )
    in
        div (style [ maxWidth (Percent 100), width (Px 1024), marginAuto, padding medium ])
            [ h1
                (style
                    [ paddingBottom tiny
                    , textCenter
                    , fontSize alpha
                    ]
                )
                [ text "Elegant" ]
            , h3
                (style
                    [ paddingBottom tiny
                    ]
                )
                [ text "Responsive" ]
            , div
                (style
                    [ textCenter
                    , backgroundColor
                        (Color.rgb
                            ((255 * ((x |> toFloat) / 1024)) |> round)
                            ((255 * ((y |> toFloat) / 1024)) |> round)
                            255
                        )
                    , textColor
                        (if x > 612 && y > 612 then
                            black
                         else
                            white
                        )
                    ]
                )
                [ text "My color is responsive, it is function of the window size" ]
            , div
                (windowHoverStyle "first"
                    (\hover ->
                        [ textCenter
                        , backgroundColor
                            (if hover then
                                (Color.rgb 40 160 model.blueComponent)
                             else
                                (Color.rgb (255 - 40) (255 - 160) (255 - model.blueComponent))
                            )
                        ]
                    )
                )
                [ text <| "I'm changing color when hovering" ]
            , div
                (windowHoverStyle "second"
                    (\hover ->
                        [ textCenter
                        , backgroundColor
                            (if hover then
                                (Color.rgb 40 160 240)
                             else
                                (Color.rgb (255 - 40) (255 - 160) (255 - 240))
                            )
                        ]
                    )
                )
                [ text "I'm changing color when hovering" ]
            , h3
                (style
                    [ paddingBottom tiny
                    ]
                )
                [ text "Alignment" ]
            , div
                (style
                    [ width (Px 400)
                    , marginAuto
                    , border black
                    , padding medium
                    ]
                )
                [ text "I'm centered with auto margins and a width of 400px" ]
            , div
                (style
                    [ width (Px 600)
                    , marginAuto
                    , border black
                    , padding medium
                    ]
                )
                [ text "I'm centered with auto margins and a width of 600px" ]
            , div
                (style
                    [ textCenter
                    ]
                )
                [ text "I'm centered" ]
            , div
                (style
                    [ textRight
                    ]
                )
                [ text "I'm right aligned" ]
            , div
                (style
                    [ textLeft
                    ]
                )
                [ text "I'm left aligned" ]
            , div
                (style
                    [ backgroundColor (Color.rgb 40 160 240)
                    , textColor (Color.rgb (255 - 40) (255 - 160) (255 - 240))
                    , padding medium
                    ]
                )
                [ text "I'm colored" ]
            , div
                (style
                    [ border black
                    , borderWidth 3
                    ]
                )
                [ text "I have a big black border" ]
            , h3
                (style
                    [ paddingBottom tiny
                    ]
                )
                [ text "Flex" ]
            , div (style [ displayFlex, spaceBetween ])
                [ div (style [ padding medium ]) [ text "Some" ]
                , div (style [ padding medium ]) [ text "Flex" ]
                , div (style [ padding medium ]) [ text "Elements" ]
                , div (style [ padding medium ]) [ text "With" ]
                , div (style [ padding medium ]) [ text "Space" ]
                , div (style [ padding medium ]) [ text "Between" ]
                ]
            , div (style [ displayFlex, spaceAround ])
                [ div (style [ padding medium ]) [ text "Some" ]
                , div (style [ padding medium ]) [ text "Flex" ]
                , div (style [ padding medium ]) [ text "Elements" ]
                , div (style [ padding medium ]) [ text "With" ]
                , div (style [ padding medium ]) [ text "Space" ]
                , div (style [ padding medium ]) [ text "Around" ]
                ]
            , div (style [ displayFlex, spaceBetween, alignItemsCenter ])
                [ div (style [ padding medium ]) [ text "Some" ]
                , div (style [ padding medium ]) [ text "Flex" ]
                , div (style [ padding medium ]) [ text "Elements" ]
                , div (style [ padding medium ]) [ text "With" ]
                , div (style [ padding medium ]) [ text "Space" ]
                , div (style [ padding medium ]) [ text "Between" ]
                , div (style [ padding medium, flex 1, textRight ]) [ text "And one element taking the rest of the place" ]
                ]
            , div (style [ textCenter, padding medium, fontSize alpha ])
                [ text "I am the alpha" ]
            , div (style [ textCenter, padding medium, fontSize beta ])
                [ text "I am the beta" ]
            , div (style [ textCenter, padding medium, fontSize gamma ])
                [ text "I am the gamma" ]
            , div (style [ textCenter, padding medium, fontSize delta ])
                [ text "I am the delta" ]
            , div (style [ textCenter, padding medium, fontSize epsilon ])
                [ text "I am the epsilon" ]
            , div (style [ textCenter, padding medium, displayInlineBlock, roundCorner, strong, uppercase, border black, padding medium ])
                [ text "I am round, strong and uppercase" ]
            ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ElegantMsg msg_ ->
            ( updateElegantState msg_ model, Cmd.none )


updateElegantState : Elegant.Msg -> Model -> Model
updateElegantState msg model =
    { model | elegantState = Elegant.update msg model.elegantState }


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    Elegant.resizeWindow ElegantMsg
