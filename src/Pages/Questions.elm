module Pages.Questions exposing (Actions, State, getInit, update, view)

import Html exposing (Html, button, div, p, text)
import Html.Events exposing (onClick)


type alias QuestionsState =
    { lower : Int, upper : Int }


type State
    = Questions QuestionsState
    | Result Int


getInit : QuestionsState -> State
getInit questionsState =
    Questions questionsState


type Actions
    = LessThan
    | Equal
    | GreaterThan


getMid : QuestionsState -> Int
getMid state =
    state.lower + (state.upper - state.lower) // 2


checkOver : QuestionsState -> State
checkOver state =
    if state.lower >= state.upper then
        Result state.lower

    else
        Questions state


update : Actions -> State -> State
update action state =
    case action of
        LessThan ->
            case state of
                Questions q ->
                    checkOver { q | upper = getMid q - 1 }

                Result _ ->
                    state

        GreaterThan ->
            case state of
                Questions q ->
                    checkOver { q | lower = getMid q + 1 }

                Result _ ->
                    state

        Equal ->
            case state of
                Questions q ->
                    Result (getMid q)

                Result r ->
                    Result r


view : State -> Html Actions
view state =
    case state of
        Questions e ->
            div []
                [ p [] [ text (String.fromInt (getMid e)) ]
                , p [] [ text (String.fromInt e.lower ++ " : " ++ String.fromInt e.upper) ]
                , div []
                    [ if not (e.lower == getMid e) then
                        button [ onClick LessThan ] [ text "Less Than" ]

                      else
                        text ""
                    , button [ onClick Equal ] [ text "Equal To" ]
                    , button [ onClick GreaterThan ] [ text "Greater Than" ]
                    ]
                ]

        Result r ->
            p [] [ text ("Result : " ++ String.fromInt r) ]
