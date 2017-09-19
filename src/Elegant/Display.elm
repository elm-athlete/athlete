module Main exposing (..)


type InsideDisplay
    = DisplayFlow
    | DisplayFlowRoot VerticalAlign
    | DisplayFlexContainer FlexContainerDetails


type OutsideDisplay
    = DisplayInline
    | DisplayBlock (Maybe Size)
    | DisplayFlexItem FlexItemDetails


type alias DisplayContents =
    { layout : ( OutsideDisplay, Maybe Layout )
    , text : ( InsideDisplay, Maybe TextStyle )
    }


type Display
    = DisplayNone
    | DisplayContentsWrapper DisplayContents
