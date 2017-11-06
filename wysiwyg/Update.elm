module Update exposing (..)


identity : a -> ( a, Cmd msg )
identity =
    flip (!) []
