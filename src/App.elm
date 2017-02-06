module App exposing (..)

import Time exposing (Time, second)
import Board
import Html exposing (Html, div, text, program)


-- MODEL


type alias Model =
    { boardModel : Board.Model
    }


initialModel : Model
initialModel =
    { boardModel = Board.initialModel }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )



-- MESSAGES


type Msg
    = BoardMsg Board.Msg



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ Html.map BoardMsg (Board.view model.boardModel) ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        BoardMsg boardMsg ->
            let
                updatedBoardModel =
                    Board.update boardMsg model.boardModel
            in
                ( { model | boardModel = updatedBoardModel }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every (second / 10) (\t -> (BoardMsg Board.Iteration))



-- MAIN


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
