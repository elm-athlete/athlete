module Grid
    exposing
        ( GridContainerDetails
        , GridItemDetails
          -- , Align
          -- , align
          -- , JustifyContent
          -- , justifyContent
          -- , spaceBetween
          -- , spaceAround
          -- , justifyContentCenter
          -- , grow
          -- , shrink
          -- , basisAuto
          -- , basis
          -- , alignSelf
        , gridItemDetailsToCouples
        , gridContainerDetailsToCouples
        , defaultGridContainerDetails
        , defaultGridItemDetails
        )

import Helpers.Shared exposing (..)


defaultGridContainerDetails =
    GridContainerDetails



-- {-| Flex handles everything related to the flex element.
--
--
-- @docs GridContainerDetails
-- @docs GridItemDetails
-- @docs FlexDirection
-- @docs FlexWrap
-- @docs Align
-- @docs JustifyContent
--
--
-- ## FlexWrap
--
-- @docs wrap
-- @docs noWrap
--
--
-- ## AlignItems / AlignSelf
--
-- @docs align
-- @docs baseline
-- @docs center
-- @docs flexStart
-- @docs flexEnd
-- @docs inherit
-- @docs initial
-- @docs stretch
--
--
-- ## JustifyContent
--
-- @docs justifyContent
-- @docs spaceBetween
-- @docs spaceAround
-- @docs justifyContentCenter
--
--
-- ## Grid
-- @docs defaultGridContainerDetails
-- @docs defaultGridItemDetails
-- @docs gridContainerDetailsToCouples
-- @docs gridItemDetailsToCouples
-- -}
--
-- import Either exposing (Either(..))
-- import Helpers.Shared exposing (..)
--
--
-- -- import Helpers.Vector exposing (..)
--
-- import Elegant.Setters exposing (..)
--
--
-- {-| Represents the alignment in grid.
-- Can be start, center, end and stretch
-- -}
-- type Align
--     = Start
--     | Center
--     | End
--     | Stretch
--
--
-- type Axe
--     = Horizontal
--     | Vertical
--
--
-- type ElementType
--     = Children
--     | Self
--
--
-- type Spacing
--     = Around
--     | Between
--     | Evenly
--
--
-- type ContentAlign
--     = AlignWrapper Align
--     | Space Spacing
--
--
--
-- -- align : Align -> Axe -> Modifier a
-- -- align alignValue axe  details =
-- --   let
-- --     details =
-- --     newAlignment =
-- --     (case Axe of
-- --       Horizontal -> {alignement | alignX = alignValue}
-- --   in
-- --     {details | alignment = }
-- --
-- -- {-| Accepts an Align, and modifies the flex container accordingly.
-- -- -}
-- -- alignHorizontal : Align -> Modifier GridContainerDetails
-- -- alignHorizontal =
-- --     setAlign << Just
-- --
-- --
-- -- {-| Accepts an Align, and modifies the flex container accordingly.
-- -- -}
-- -- alignVertical : Align -> Modifier GridContainerDetails
-- -- alignVertical =
-- --     setAlign << Just
-- --
-- --
--
--
-- {-| Represents the value of justify-content.
-- Can be space-between, space-around or center.
-- -}
-- type JustifyContent
--     = JustifyContentSpaceBetween
--     | JustifyContentSpaceAround
--     | JustifyContentCenter
--
--
-- {-| Accepts a justify-content and modifies the flex container accordingly.
-- -}
-- justifyContent : JustifyContent -> Modifier GridContainerDetails
-- justifyContent =
--     setJustifyContent << Just
--
--
-- {-| Defines the justify-content space-between.
-- -}
-- spaceBetween : JustifyContent
-- spaceBetween =
--     JustifyContentSpaceBetween
--
--
-- {-| Defines the justify-content space-around.
-- -}
-- spaceAround : JustifyContent
-- spaceAround =
--     JustifyContentSpaceAround
--
--
-- {-| Defines the justify-content center.
-- -}
-- justifyContentCenter : JustifyContent
-- justifyContentCenter =
--     JustifyContentCenter
--
--


{-| Contains all style which can be used on a flex item.
This contains flex-grow, flex-shrink, flex-basis and align-self.
-}
type alias GridItemDetails =
    GridItemStyle



--
--
-- {-| Accepts an int and sets the flex-grow accordingly.
-- -}
-- grow : Int -> Modifier GridItemDetails
-- grow =
--     setGrow << Just
--
--
-- {-| Accepts an int and sets the flex-shrink accordingly.
-- -}
-- shrink : Int -> Modifier GridItemDetails
-- shrink =
--     setShrink << Just
--
--
-- {-| Sets the flex-basis as auto.
-- -}
-- basisAuto : Modifier GridItemDetails
-- basisAuto =
--     setBasis <| Just <| Right Auto
--
--
-- {-| Accepts a size and sets the flex-basis accordingly.
-- -}
-- basis : SizeUnit -> Modifier GridItemDetails
-- basis =
--     setBasis << Just << Left
--
--
-- {-| Accepts an align and modifies the flex item accordingly.
-- -}
-- alignSelf : Align -> Modifier GridItemDetails
-- alignSelf =
--     setAlignSelf << Just
--
--
-- alignItemsToCouple : Align -> ( String, String )
-- alignItemsToCouple =
--     (,) "align-items" << alignToString
--
--
-- alignSelfToCouple : Align -> ( String, String )
-- alignSelfToCouple =
--     (,) "align-self" << alignToString
--
--
-- alignToString : Align -> String
-- alignToString align =
--     case align of
--         Start ->
--             "start"
--
--         Center ->
--             "center"
--
--         End ->
--             "end"
--
--         Stretch ->
--             "stretch"
--
--


{-|
-}
gridItemDetailsToCouples : GridItemDetails -> List ( String, String )
gridItemDetailsToCouples gridContainerDetails =
    []
        |> List.concatMap (callOn gridContainerDetails)



--
--


{-|
-}
gridContainerDetailsToCouples : GridContainerDetails -> List ( String, String )
gridContainerDetailsToCouples gridContainerDetails =
    []
        |> List.concatMap (callOn gridContainerDetails)



--
-- justifyContentToCouple : JustifyContent -> ( String, String )
-- justifyContentToCouple =
--     (,) "justify-content" << justifyContentToString
--
--
-- justifyContentToString : JustifyContent -> String
-- justifyContentToString val =
--     case val of
--         JustifyContentSpaceBetween ->
--             "space-between"
--
--         JustifyContentSpaceAround ->
--             "space-around"
--
--         JustifyContentCenter ->
--             "center"
--
--
--
-- --
-- -- grid-template-columns: repeat(auto-fit, 300px);
-- -- grid-template-columns: repeat(auto-fill, 10px 50% min-content max-content auto minmax(100px, 1fr) minmax(100px, max-content) fit-content(200px) fit-content(40%))
-- --
-- --
-- -- grid-template-columns: repeat(auto-fit, [px 300]);
-- -- grid-template-columns: repeat(auto-fill, [px 10, percent 50, MinContent, MaxContent, Auto, Minmax (px 100) (fr 1), Minmax (px 100) MaxContent, FitContent (px 200), FitContent (Percent 40)]
--
--


type ValType
    = SizeUnitVal SizeUnit
    | Fr Int
    | Vw Int
    | MinContent
    | MaxContent
    | SizeAuto


type Repeatable
    = Simple ValType
    | Minmax ValType ValType
    | FitContent ValType


type Template
    = RepeatAutoFill
    | RepeatAutoFit
    | NoRepeat


type GridTemplate
    = TemplateWrapper Template (List Repeatable)



--
--
-- noRepeat =
--     NoRepeat
--
--
-- simple =
--     Simple
--
--
-- sizeUnitVal =
--     SizeUnitVal
--
--
-- noRepeatGridTemplate =
--     gridTemplate noRepeat
--
--
-- fractionOfAvailableSpace =
--     Fr
--
--


type GridAlignment
    = SpaceAround
    | AlignAuto


type alias GridContainerCoordinate =
    { gutter : Maybe SizeUnit
    , align : Maybe GridAlignment
    , template : GridTemplate
    }


type alias GridContainerDetails =
    { x : GridContainerCoordinate
    , y : GridContainerCoordinate
    }



--
--
--
--
-- myGrid : GridContainerDetails
-- myGrid =
--     { x =
--         { gutter = Just (Px 2)
--         , align = Just SpaceAround
--         , template =
--             noRepeatGridTemplate
--                 [ simple (fractionOfAvailableSpace 1)
--                 , simple (sizeUnitVal (Px 200))
--                 ]
--         }
--     , y =
--         { gutter = Just (Px 20)
--         , align = Just AlignAuto
--         , template =
--             noRepeatGridTemplate
--                 [ simple (sizeUnitVal (Px 100))
--                 , simple (sizeUnitVal (Px 50))
--                 ]
--         }
--     }
--
--


type GridItemSize
    = UntilEndOfCoordinate
    | Span Int


type alias GridItemStyle =
    ( ( Int, Int ), ( GridItemSize, GridItemSize ) )



--
--
-- gridItemStyle : GridItemStyle -> GridItemStyle
-- gridItemStyle ( ( x, y ), ( width, height ) ) =
--     ( ( x, y )
--     , ( width, height )
--     )
--
--
-- exampleGridItemStyle : GridItemStyle
-- exampleGridItemStyle =
--     gridItemStyle
--         ( ( 0, 0 )
--         , ( UntilEndOfCoordinate, Span 2 )
--         )
--
--
-- defaultGridContainerDetails =
--     {}
--
--
-- flexGridDetailsModifiers =
--     {}
--
--


defaultGridItemDetails =
    {}



--
--
-- gridItemDetailsToString gridItemDetails =
--     []
--
--
-- gridContainerDetailsToString gridContainerDetails =
--     []
--
--
-- xyCoordinatesFromTemplate : GridTemplate -> GridContainerCoordinate
-- xyCoordinatesFromTemplate template =
--     defaultTemplate template template
--
--
-- defaultTemplate t1 t2 =
--     ( defaultCoordinate t1, defaultCoordinate t2 )
--
--
-- defaultCoordinate template =
--     GridContainerCoordinate Nothing Nothing template
--
--
-- rowCoordinate =
--     { gutter = Px 2
--     , align = Center
--     , template = two
--     }
--
--
-- two : GridTemplate
-- two =
--     noRepeatGridTemplate
--         [ simple
--         , simple
--         ]
--
--
-- columnCoordinate : GridContainerCoordinate
-- columnCoordinate =
--     { gutter = Px 20
--     , align = Auto
--     , template = two
--     }
