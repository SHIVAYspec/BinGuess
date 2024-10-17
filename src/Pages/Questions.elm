module Pages.Questions exposing (Actions, State, update, view)

import Html exposing (Html, button, div, p, text)
import Html.Events exposing (onClick)


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
        div [] [ p [] [ text ("Result : " ++ String.fromInt state.lower) ] ]

    else
        div []
            [ p [] [ text (String.fromInt (getMid state)) ]
            , p [] [ text (String.fromInt state.lower ++ " : " ++ String.fromInt state.upper) ]
            , div []
                [ if not (state.lower == getMid state) then
                    button [ onClick LessThan ] [ text "Less Than" ]

                  else
                    text ""
                , button [ onClick Equal ] [ text "Equal To" ]
                , button [ onClick GreaterThan ] [ text "Greater Than" ]
                ]
            ]
