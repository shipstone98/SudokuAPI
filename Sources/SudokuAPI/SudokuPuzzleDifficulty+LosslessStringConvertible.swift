//
//  SudokuPuzzleDifficulty+LosslessStringConvertible.swift
//  SudokuAPI
//
//  Created by Christopher Shipstone on 31/03/2026.
//

import Sudoku

extension SudokuPuzzleDifficulty : LosslessStringConvertible {
    public var description: String {
        switch self {
        case .cadet:
            return "Cadet"
        case .lieutenant:
            return "Lieutenant"
        case .captain:
            return "Captain"
        case .commodore:
            return "Commodore"
        case .admiral:
            return "Admiral"
        }
    }
    
    public init?(_ description: String) {
        switch description.lowercased() {
        case "cadet":
            self = .cadet
        case "lieutenant":
            self = .lieutenant
        case "captain":
            self = .captain
        case "commodore":
            self = .commodore
        case "admiral":
            self = .admiral
        default:
            return nil
        }
    }
}
