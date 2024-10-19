module Pages.Style exposing (headingStyle, layoutStyle, textStyle)

import Html exposing (Attribute)
import Html.Attributes exposing (style)


textStyle : List (Attribute msg)
textStyle =
    [ style "margin" "0"
    , style "padding" "24px"
    , style "border-radius" "8px"
    , style "font-size" "xxx-large"
    , style "font-weight" "bold"
    , style "font-family" "monospace"
    ]


headingStyle : List (Attribute msg)
headingStyle =
    [ style "text-align" "center"
    , style "font-size" "xxx-large"
    , style "font-weight" "bold"
    , style "font-family" "monospace"
    ]


layoutStyle : List (Attribute msg)
layoutStyle =
    [ style "display" "flex"
    , style "flex-direction" "column"
    ]
