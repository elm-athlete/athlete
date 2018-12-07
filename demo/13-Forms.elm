module Main exposing (main)

import BodyBuilder as B exposing (..)
import BodyBuilder.Attributes as Attributes exposing (..)
import BodyBuilder.Elements.Form as Form
import BodyBuilder.Events as Events exposing (..)
import BodyBuilder.Extra
import BodyBuilder.Style as Style
import Color
import Elegant exposing (percent, px, vh)
import Elegant.Border as Border
import Elegant.Box as Box
import Elegant.Color.Extra as Color
import Elegant.Constants as Constants
import Elegant.Dimensions as Dimensions
import Elegant.Display as Display
import Elegant.Extra
import Elegant.Flex as Flex
import Elegant.Padding as Padding
import Elegant.Typography as Typography


type Msg
    = UpdateEmail String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateEmail email ->
            ( email, Cmd.none )


type alias Model =
    String


view : Model -> NodeWithStyle Msg
view model =
    B.div [ Elegant.Extra.paddingAll Constants.large ]
        [ BodyBuilder.Extra.rawStyle "body {margin: 0px; height: 100%}\n body>div{height:100%}\n*{box-sizing: border-box;}\nhtml {height: 100%}"
        , Form.buildInput
            (Form.inputField
                (Form.inputLabel "Email")
                (Form.Email model UpdateEmail)
            )
        ]


main : Program () Model Msg
main =
    element
        { init = \_ -> ( "tot@titi.com", Cmd.none )
        , update = update
        , subscriptions = always Sub.none
        , view = view
        }
