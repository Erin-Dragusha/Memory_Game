//
//  Tiles.swift
//  Memory_Game
//
//  Created by Erin Dragusha on 2023-10-03.
//

import Foundation

class Tiles: ObservableObject {
    @Published var board: [[Tile]] = [[Tile()]]
    
    @Published var numCols: Int = 1
    
    @Published var numRows: Int = 1
    
    @Published var numReveals = 0
    
    private var currentStreakTiles = [(Int, Int)]()
    
    private var currentTileType = ""
    
    private var requiredRemaining = 0
    
    @Published var totalRemaining = 0
    
    @Published var updating = false
    
    func setupBoard(treasureList: [Treasure]) {
        numReveals = 0
        
        totalRemaining = treasureList.reduce(0) { partialResult, currentTreasure in
            return partialResult + currentTreasure.groupSize * currentTreasure.numGroups
        }
        
        let dimension = Int(ceil(sqrt(Double(totalRemaining))))
        numRows = dimension
        numCols = dimension
        
        board = [[Tile]]()
        board = Array(repeating: Array(repeating: Tile(), count: dimension), count: dimension)
        
        var tmpArray = [Treasure]()
        for treasure in treasureList {
            tmpArray += Array(repeating: treasure, count: treasure.groupSize * treasure.numGroups)
        }
        
        let remnant = dimension * dimension - tmpArray.count
        if remnant > 0 {
            tmpArray += Array(repeating: Treasure(name: emptyTileName, groupSize: 1, numGroups: 1), count: remnant)
        }
        
        tmpArray.shuffle()
        
        for row in 0..<dimension {
            for col in 0..<dimension {
                board[row][col].contents = tmpArray.popLast()!
            }
        }
    }
    
    func showTreasuresAt(row: Int, column: Int) -> String {
        if (row < 0) || (numRows <= row) || (column < 0) || (numCols < column) {
            return Tile.empty.name
        }
        return board[row][column].icon.name
    }
    
    func revealTreasureAt(row: Int, column: Int) {
        if updating {
            return
        }
        
        updating = true
        
        if (row < 0) || (numRows <= row) || (column < 0) || (numCols < column) || (totalRemaining == 0) {
            updating = false
            return
        }
        
        numReveals += 1
        if board[row][column].revealed {
            updating = false
            return
        }
        
        board[row][column].revealed = true
        
        if currentTileType == "" && board[row][column].contents.name != Tile.empty.name {
            currentStreakTiles = [(row, column)]
            currentTileType = board[row][column].contents.name
            requiredRemaining = board[row][column].contents.groupSize - 1
            updating = false
            return
        }
        
        if currentTileType == board[row][column].contents.name && board[row][column].contents.name != Tile.empty.name {
            currentStreakTiles.append((row, column))
            requiredRemaining -= 1
            if requiredRemaining != 0 {
                updating = false
            }
            else {
                self.currentTileType = ""
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    for (r, c) in self.currentStreakTiles {
                        self.board[r][c].contents = Tile.empty
                        self.totalRemaining -= 1
                    }
                    self.currentStreakTiles = [(Int, Int)]()
                    self.updating = false
                }
            }
            return
        }
        
        self.currentTileType = ""
        self.requiredRemaining = 0
        
        if self.board[row][column].contents.name != Tile.empty.name {
            self.currentStreakTiles.append((row, column))
        }
        
        if currentStreakTiles.isEmpty {
            updating = false
        }
        else {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                for (r, c) in self.currentStreakTiles {
                    self.board[r][c].revealed = false
                }
                self.currentStreakTiles = [(Int, Int)]()
                self.updating = false
            }
        }
        
    }
    
}
