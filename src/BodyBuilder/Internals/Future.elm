module Main exposing (..)


type Language
    = English
    | French


type Country
    = Us
    | Uk
    | France


type Charset
    = UTF8


type alias Lang =
    ( Language, Country )


type alias Html =
    { head : Maybe Head
    , body : Maybe Body
    , lang : Lang
    }


type alias Head =
    { title : Maybe String
    , charset : Maybe Charset
    , description : Maybe String
    , keywords : List String
    , author : String
    , otherMeta : List ( String, String )
    }


type alias MimeType =
    String


type alias Source =
    { mime : MimeType
    , src : Url
    }


type alias Body =
    { nodes : List Node
    }


type alias Node =
    {}


type alias Caption =
    Node


type alias Thead =
    Node


type alias Tbody =
    Node


type alias Tfoot =
    Node


type alias TableNode =
    { caption : Maybe Caption
    , thead : Maybe Thead
    , tbody : Maybe Tbody
    , tfoot : Maybe Tfoot
    }


type alias Url =
    String



-- Html
--
--   ,   <meta name="description" content="Free Web tutorials">
--   <meta name="keywords" content="HTML,CSS,XML,JavaScript">
--   <meta name="author" content="John Doe">
-- }
--
--
--
-- <div>
--   <a>
--     <div>
--       <a>
--       </a>
--     </div>
--   </a>
-- </div>
--
--
-- type Node =
--   A (List InsideLink)
--
-- type InsideLink =
--   InsideDiv (List InsideLink)
--
--
-- type Html =
--   Html Head Body
--
-- type Head =
--   Head (List InsideHead)
--
--
--   <meta charset="UTF-8">
--   <meta name="description" content="Free Web tutorials">
--   <meta name="keywords" content="HTML,CSS,XML,JavaScript">
--   <meta name="author" content="John Doe">
--   <meta name="viewport" content="width=device-width, initial-scale=1.0">
--
-- type InsideHead =
--   Title String
--   | Meta
--   title> (this element is required in an HTML document)
--   <style>
--   <base>
--   <link>
--   <meta>
--   <script>
--   <noscript>
