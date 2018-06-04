module Elegant.Cursor exposing (..)

{-| Cursor contains everything about cursors rendering.


# Types

@docs Cursor


# Cursor types

@docs default
@docs auto
@docs cell
@docs contextMenu
@docs crosshair
@docs grab
@docs grabbing
@docs help
@docs move
@docs noDrop
@docs none
@docs notAllowed
@docs pointer
@docs progress
@docs text
@docs verticalText
@docs wait
@docs zoomIn
@docs zoomOut


# Compilation

@docs cursorToCouple

-}


{-| The `Cursor` record contains everything about cursor.
You probably won't use it as is, but instead using `Elegant.cursor`.
You can provide one cursor type. They can be found [here](https://developer.mozilla.org/en/docs/Web/CSS/cursor).

    Elegant.cursor Cursor.default

-}
type Cursor
    = Auto
    | Default
    | None
    | Pointer
    | ContextMenu
    | Help
    | Progress
    | Wait
    | Cell
    | Crosshair
    | Text
    | VerticalText
    | Move
    | NoDrop
    | NotAllowed
    | ZoomIn
    | ZoomOut
    | Grab
    | Grabbing


{-| -}
default : Cursor
default =
    Default


{-| -}
auto : Cursor
auto =
    Auto


{-| -}
none : Cursor
none =
    None


{-| -}
pointer : Cursor
pointer =
    Pointer


{-| -}
contextMenu : Cursor
contextMenu =
    ContextMenu


{-| -}
help : Cursor
help =
    Help


{-| -}
progress : Cursor
progress =
    Progress


{-| -}
wait : Cursor
wait =
    Wait


{-| -}
cell : Cursor
cell =
    Cell


{-| -}
crosshair : Cursor
crosshair =
    Crosshair


{-| -}
text : Cursor
text =
    Text


{-| -}
verticalText : Cursor
verticalText =
    VerticalText


{-| -}
move : Cursor
move =
    Move


{-| -}
noDrop : Cursor
noDrop =
    NoDrop


{-| -}
notAllowed : Cursor
notAllowed =
    NotAllowed


{-| -}
zoomIn : Cursor
zoomIn =
    ZoomIn


{-| -}
zoomOut : Cursor
zoomOut =
    ZoomOut


{-| -}
grab : Cursor
grab =
    Grab


{-| -}
grabbing : Cursor
grabbing =
    Grabbing


{-| Compiles a `Cursor` to the corresponding CSS tuple.
-}
cursorToCouple : Cursor -> ( String, String )
cursorToCouple cursor =
    ( "cursor"
    , case cursor of
        Auto ->
            "auto"

        Default ->
            "default"

        None ->
            "none"

        Pointer ->
            "pointer"

        ContextMenu ->
            "context-menu"

        Help ->
            "help"

        Progress ->
            "progress"

        Wait ->
            "wait"

        Cell ->
            "cell"

        Crosshair ->
            "crosshair"

        Text ->
            "text"

        VerticalText ->
            "vertical-text"

        Move ->
            "move"

        NoDrop ->
            "no-drop"

        NotAllowed ->
            "not-allowed"

        ZoomIn ->
            "zoom-in"

        ZoomOut ->
            "zoom-out"

        Grab ->
            "grab"

        Grabbing ->
            "grabbing"
    )
