//
//  SolveRouteCollection.swift
//  SudokuAPI
//
//  Created by Christopher Shipstone on 30/03/2026.
//

import Sudoku
import Vapor

internal struct SolveRouteCollection : RouteCollection {
    func boot(routes: any Vapor.RoutesBuilder) throws {
        let solve = routes.grouped("api")
            .grouped("solve")
        
        solve.get("recursion", use: self.recursion)
        solve.get("strategy", use: self.strategy)
    }
    
    private func recursion(request: Request) throws -> Result {
        try self.retrieve(request: request, for: RecursiveSudokuSolver.self)
    }
    
    private func retrieve<Solver>(
        request: Request,
        for solverType: Solver.Type
    ) throws -> Result where Solver : SudokuSolver, Solver.Sudoku == ArraySudoku {
        guard let string = request.query[String.self, at: "sudoku"],
              let sudoku = ArraySudoku(string) else {
            throw Abort(.badRequest)
        }
        
        var solver = solverType.init(sudoku)
        var generator = SystemRandomNumberGenerator()
        let isSolved = solver.solve(using: &generator)
        return .init(solver.sudoku, solver.moves, isSolved)
    }
    
    private func strategy(request: Request) throws -> Result {
        try self.retrieve(request: request, for: StrategicSudokuSolver.self)
    }
    
    private struct Result : Content {
        private let isSolved: Bool
        private let moves: [Move]
        private let sudoku: String
        
        fileprivate init(
            _ sudoku: ArraySudoku,
            _ moves: [SudokuSolverMove],
            _ isSolved: Bool
        ) {
            self.isSolved = isSolved
            
            self.moves = moves.map {
                .init($0.strategy?.description, $0.locations)
            }
            
            self.sudoku = sudoku.description
        }
        
        private struct Move : Content {
            private let locations: Set<SudokuSolverMove.Location>
            private let strategy: String?
            
            internal init(
                _ strategy: String?,
                _ locations: Set<SudokuSolverMove.Location>
            ) {
                self.locations = locations
                self.strategy = strategy
            }
        }
    }
}
