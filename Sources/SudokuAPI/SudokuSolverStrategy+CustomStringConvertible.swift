//
//  SudokuSolverStrategy+CustomStringConvertible.swift
//  SudokuAPI
//
//  Created by Christopher Shipstone on 31/03/2026.
//

import Sudoku

extension SudokuSolverStrategy : CustomStringConvertible {
    public var description: String {
        switch self {
        case .fullHouse:
            return "Full House"
        case .nakedSingle:
            return "Naked Single"
        case .hiddenSingle:
            return "Hidden Single"
        case .pointingCandidate:
            return "Pointing Candidate"
        case .claimingCandidate:
            return "Claiming Candidate"
        case .nakedPair:
            return "Naked Pair"
        case .hiddenPair:
            return "Hidden Pair"
        case .xWing:
            return "X-wing"
        case .bugPlus1:
            return "BUG+1"
        case .xYWing:
            return "XY-wing"
        }
    }
}
