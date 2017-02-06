module Tests exposing (..)

import Test exposing (..)
import Expect
import Game exposing (Cell(..))


all : Test
all =
    describe "Sample Test Suite"
        [ describe "the Game Module"
            [ test "aliveNeighbors" <|
                \() ->
                    let
                        board =
                            (Game.fromString
                                """
                                ---
                                --x
                                -x-
                                """
                            )
                    in
                        Expect.equal 2 (Game.aliveNeighbors ( 1, 1 ) board)
            , test "aliveNeighbors bounds" <|
                \() ->
                    let
                        board =
                            (Game.fromString
                                """
                                ---
                                --x
                                -x-
                                """
                            )
                    in
                        Expect.equal 2 (Game.aliveNeighbors ( 2, 2 ) board)
            , test "fromString" <|
                \() ->
                    let
                        actual =
                            (Game.fromString
                                """
                                --x--x
                                -x---x
                                """
                            )

                        expected =
                            Game.fromList
                                [ [ Dead, Dead, Alive, Dead, Dead, Alive ]
                                , [ Dead, Alive, Dead, Dead, Dead, Alive ]
                                ]
                    in
                        Expect.equal actual expected
            , test "iteration" <|
                \() ->
                    let
                        prev =
                            (Game.fromString
                                """
                                ---
                                xxx
                                -x-
                                """
                            )

                        next =
                            (Game.fromString
                                """
                                -x-
                                xxx
                                xxx
                                """
                            )
                    in
                        Expect.equal (Game.iterate prev) next
            ]
        ]
