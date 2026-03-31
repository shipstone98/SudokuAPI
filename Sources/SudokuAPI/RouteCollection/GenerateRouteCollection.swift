//
//  GenerateRouteCollection.swift
//  SudokuAPI
//
//  Created by Christopher Shipstone on 31/03/2026.
//

import Sudoku
import Vapor

internal struct GenerateRouteCollection : RouteCollection {
    func boot(routes: any Vapor.RoutesBuilder) throws {
        let api = routes.grouped("api")
        api.get("generate", use: self.retrieve)
    }
    
    private func retrieve(request: Request) throws -> RetrieveResult {
        guard let string = request.query[String.self, at: "difficulty"],
              let difficulty = SudokuPuzzleDifficulty(string) else {
            throw Abort(.badRequest)
        }
        
        var generator = SystemRandomNumberGenerator()
        let seed = ArraySudokuPuzzleSeed(for: difficulty, using: &generator)
        
        return .init(
            seed.values.description,
            seed.solutions.description,
            for: difficulty.description
        )
    }
    
    private struct RetrieveResult : Content {
        private let difficulty: String
        private let solutions: String
        private let values: String
        
        fileprivate init(
            _ values: String,
            _ solutions: String,
            for difficulty: String
        ) {
            self.difficulty = difficulty
            self.solutions = solutions
            self.values = values
        }
    }
}
