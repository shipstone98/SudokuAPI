//
//  main.swift
//  SudokuAPI
//
//  Created by Christopher Shipstone on 30/03/2026.
//

import Vapor

fileprivate func main() async throws {
    let app = try await Application.make()
    let solve = SolveRouteCollection()
    try app.register(collection: solve)
    
    defer {
        Task {
            try await app.asyncShutdown()
        }
    }
    
    try await app.execute()
}

try await main()
