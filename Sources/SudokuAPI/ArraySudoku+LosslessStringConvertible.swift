//
//  ArraySudoku+LosslessStringConvertible.swift
//  SudokuAPI
//
//  Created by Christopher Shipstone on 30/03/2026.
//

import Sudoku

extension ArraySudoku : LosslessStringConvertible {
    public var description: String {
        var description = ""
        
        for row in 0..<9 {
            for column in 0..<9 {
                description += .init(self[row, column])
            }
        }
        
        return description
    }
    
    public init?(_ description: String) {
        self.init()
        
        guard description.count == 81 else {
            return nil
        }
        
        var index = description.startIndex
        
        for row in 0..<9 {
            for column in 0..<9 {
                guard let value = description[index].wholeNumberValue else {
                    return nil
                }
                
                self[row, column] = value
                index = description.index(after: index)
            }
        }
    }
}
