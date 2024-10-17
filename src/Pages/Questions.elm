module Pages.Questions exposing (Actions, State, update, view)

import Html exposing (Html, button, div, p, text)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Pages.Style exposing (layoutStyle, textStyle)


type alias State =
    { lower : Int, upper : Int }


type Actions
    = LessThan
    | Equal
    | GreaterThan


getMid : State -> Int
getMid state =
    state.lower + (state.upper - state.lower) // 2


update : Actions -> State -> State
update action state =
    case action of
        LessThan ->
            { state | upper = getMid state - 1 }

        GreaterThan ->
            { state | lower = getMid state + 1 }

        Equal ->
            { lower = getMid state, upper = getMid state }


view : State -> Html Actions
view state =
    if state.lower >= state.upper then
        div []
            [ p textStyle [ text "The number that you picked was " ]
            , p
                [ style "font-size" "48px"
                , style "text-align" "center"
                ]
                [ text (String.fromInt state.lower) ]
            ]

    else
        div layoutStyle
            [ p textStyle [ text ("Is " ++ String.fromInt (getMid state)) ]

            -- , p textStyle [ text (String.fromInt state.lower ++ " : " ++ String.fromInt state.upper) ]
            , if not (state.lower == getMid state) then
                button (textStyle ++ [ style "background-color" "yellow", onClick LessThan ]) [ text "Less Than" ]

              else
                text ""
            , button (textStyle ++ [ onClick Equal ]) [ text "Equal" ]
            , button (textStyle ++ [ style "background-color" "#3498DB", onClick GreaterThan ]) [ text "Greater Than" ]
            , p textStyle [ text "to your choosen number?" ]
            ]
