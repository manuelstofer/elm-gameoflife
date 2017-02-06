module Game exposing (..)

import Matrix
import List


type Cell
    = Dead
    | Alive


type alias Board =
    Matrix.Matrix Cell


type alias Location =
    Matrix.Location


fromList : List (List Cell) -> Board
fromList =
    Matrix.fromList


parseCell : Char -> Maybe.Maybe Cell
parseCell c =
    case c of
        '-' ->
            Just Dead

        'x' ->
            Just Alive

        _ ->
            Nothing


parseColumn : String -> List Cell
parseColumn =
    (List.filterMap parseCell << (String.toList))


fromString : String -> Board
fromString s =
    String.split "\n" s
        |> List.map parseColumn
        |> List.filter ((/=) [])
        |> fromList


initialModel : Board
initialModel =
    fromString
        """
        ----------------------------------------
        --x-------------------------------------
        x-x-------------------------------------
        -xx-------------------------------------
        ----------------------------------------
        ----------------------------------------
        ----------------------------------------
        ----------------------------------------
        ----------------------------------------
        ----------------------------------------
        ----------------------------------------
        ----------------------------------------
        ----------------------------------------
        ----------------------------------------
        ----------------------------------------
        ----------------------------------------
        ----------------------------------------
        ----------------------------------------
        ----------------------------------------
        ----------------------------------------
        ----------------------------------------
        ----------------------------------------
        ----------------------------------------
        ----------------------------------------
        ----------------------------------------
        ----------------------------------------
        ----------------------------------------
        ----------------------------------------
        ----------------------------------------
        ----------------------------------------
        """


neighborsRelative : List ( Int, Int )
neighborsRelative =
    [ ( -1, -1 )
    , ( -1, 0 )
    , ( -1, 1 )
    , ( 0, -1 )
    , ( 0, 1 )
    , ( 1, -1 )
    , ( 1, 0 )
    , ( 1, 1 )
    ]


sumLocation : Location -> Location -> Location
sumLocation a b =
    let
        ( a1, a2 ) =
            a

        ( b1, b2 ) =
            b
    in
        ( a1 + b1, a2 + b2 )


aliveNeighbors : Location -> Board -> Int
aliveNeighbors location board =
    let
        health location =
            Matrix.get location board

        isAlive =
            (==) (Maybe.Just Alive)
    in
        neighborsRelative
            |> List.map (health << (sumLocation location))
            |> List.filter isAlive
            |> List.length


iterate : Board -> Board
iterate board =
    let
        iterateCell location cell =
            let
                n =
                    aliveNeighbors location board
            in
                case n of
                    3 ->
                        Alive

                    _ ->
                        if (n == 2 && cell == Alive) then
                            Alive
                        else
                            Dead
    in
        Matrix.mapWithLocation iterateCell board
