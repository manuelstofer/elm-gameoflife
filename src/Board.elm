module Board exposing (..)

import Html exposing (Html, div, text, program)
import Html.Attributes
import Css exposing (..)
import Matrix exposing (..)
import Array
import Game exposing (Cell(..))


type alias Model =
    Matrix Cell


initialModel : Model
initialModel =
    Game.initialModel



-- MESSAGES


type Msg
    = Iteration



-- STYLE


styles : List Mixin -> Html.Attribute msg
styles =
    Css.asPairs >> Html.Attributes.style


cellStyle : List Mixin
cellStyle =
    [ width (px 10)
    , height (px 10)
    , float left
    ]


rowStyle : List Mixin
rowStyle =
    [ overflow hidden
    ]



-- VIEW


cellView : Cell -> Html Msg
cellView model =
    let
        cellColor =
            case model of
                Alive ->
                    (rgb 255 255 255)

                Dead ->
                    (rgb 0 0 0)
    in
        div
            [ styles (cellStyle ++ [ backgroundColor cellColor ])
            ]
            []


rowView : Array.Array Cell -> Html Msg
rowView row =
    div [ styles rowStyle ]
        (Array.toList
            (Array.map cellView row)
        )


view : Model -> Html Msg
view model =
    div []
        (Array.toList
            (Array.map rowView model)
        )



-- UPDATE


update : Msg -> Model -> Model
update msg model =
    case msg of
        Iteration ->
            (Game.iterate model)
