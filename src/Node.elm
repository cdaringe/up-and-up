module Node exposing (Edge, Node)

type alias Edge =
    { text : String
    , to : String
    }


type alias Node =
    { key : String
    , text : String
    , options : List Edge
    }



-- type alias Step =
--     { bg_color : String
--     , from : String
--     , id : String
--     , options : List StepLink
--     , text : String
--     , text_color : String
--     }
-- ready =
--     Step "orange" "ready to roll?" "" "" "" []
