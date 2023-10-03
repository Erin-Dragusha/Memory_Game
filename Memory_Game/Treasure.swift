//
//  Treasure.swift
//  Memory_Game
//
//  Created by Erin Dragusha on 2023-10-03.
//

import Foundation

struct Treasure: Codable, Hashable, Identifiable {
    var id = UUID()
    var name: String
    var groupSize: Int
    var numGroups: Int
}
