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
        let api = routes.grouped("api")
        let solve = api.grouped("solve")
        solve.get("recursion", use: self.recursion)
        solve.get("strategy", use: self.strategy)
    }
    
    private func recursion(request: Request) throws -> Result {
        guard let string = request.query[String.self, at: "sudoku"],
              let sudoku = ArraySudoku(string) else {
            throw Abort(.badRequest)
        }
        
        var solver = RecursiveSudokuSolver(sudoku)
        var generator = SystemRandomNumberGenerator()
        let isSolved = solver.solve(using: &generator)
        return .init(solver.sudoku, solver.moves, isSolved)
    }
    
    private func strategy(request: Request) throws -> Result {
        guard let string = request.query[String.self, at: "sudoku"],
              let sudoku = ArraySudoku(string) else {
            throw Abort(.badRequest)
        }
        
        var solver = StrategicSudokuSolver(sudoku)
        var generator = SystemRandomNumberGenerator()
        let isSolved = solver.solve(using: &generator)
        return .init(solver.sudoku, solver.moves, isSolved)
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
