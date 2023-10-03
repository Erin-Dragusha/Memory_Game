//
//  Tile.swift
//  Memory_Game
//
//  Created by Erin Dragusha on 2023-10-03.
//

import Foundation

let emptyTileName = "circle"

let unexploredTileName = "circle.fill"

struct Tile: Identifiable {
    static let empty = Treasure(name: emptyTileName, groupSize: 0, numGroups: 0)
    
    static let unexplored = Treasure(name: unexploredTileName, groupSize: 0, numGroups: 0)
    
    var id = UUID()
    
    var contents = empty
    
    var revealed = false
    
    var icon: Treasure {
        get {
            revealed ? contents : Tile.unexplored
        }
    }
}
