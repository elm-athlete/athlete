module Types exposing (..)

import Either exposing (Either(..))
import Elegant exposing (Modifiers)
import BodyBuilder exposing (Node)
import BodyBuilder.Attributes exposing (BlockAttributes)
import Color exposing (Color)


type alias Element msg =
    { id : Int
    , tree : Either (Tree msg) (GridItem msg)
    }


type GridItem msg
    = GridItem
        { attributes : { style : Elegant.CommonStyle }
        , children : List (Element msg)
        }


type Tree msg
    = Block
        { tag : String
        , constructor : Modifiers (BlockAttributes msg) -> List (Node msg) -> Node msg
        , attributes : { style : Elegant.CommonStyle }
        , children : List (Element msg)
        }
    | Grid
        { attributes : { style : Elegant.CommonStyle }
        , children : List (Element msg)
        }
    | Text String


type alias Model =
    { element : Element Msg
    , selectedId : Int
    , autoIncrement : Int
    }


type Msg
    = CreateP
    | CreateH1
    | CreateGrid
    | SelectEl Int
    | ChangeBoxColor Color
