module Pages.Style exposing (layoutStyle, textStyle)

import Html exposing (Attribute)
import Html.Attributes exposing (style)


textStyle : List (Attribute msg)
textStyle =
    [ style "margin" "0"
    , style "padding" "24px"
    , style "font-weight" "bold"
    , style "font-size" "xxx-large"
    , style "font-family" "monospace"
    , style "border-radius" "8px"
    ]


layoutStyle : List (Attribute msg)
layoutStyle =
    [ style "display" "flex"
    , style "flex-direction" "column"
    ]
