//
//  Treasures.swift
//  Memory_Game
//
//  Created by Erin Dragusha on 2023-10-03.
//

import Foundation
import os

class Treasures: ObservableObject {
    static let listUrl = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("entries")
    
    @Published var list = [Treasure]()
    
    init() {
        loadObjects()
    }
    
    func loadObjects() {
        do {
            let data = try Data(contentsOf: Treasures.listUrl)
            list = try JSONDecoder().decode([Treasure].self, from: data)
        } catch {
            os_log("Cannot load due to %@", log: OSLog.default, type: .debug, error.localizedDescription)
        }
    }
    
    func saveObjects() {
        do {
            let data = try JSONEncoder().encode(list)
            try data.write(to: Treasures.listUrl)
        } catch {
            os_log("Cannot save due to %@", log: OSLog.default, type: .debug, error.localizedDescription)
        }
    }
    
}
