//
//  Memory_GameApp.swift
//  Memory_Game
//
//  Created by Erin Dragusha on 2023-10-03.
//

import SwiftUI

@main
struct Memory_GameApp: App {
    
    @Environment(\.scenePhase) var scenePhase
    
    @StateObject private var treasures = Treasures()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(treasures)
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .background:
                treasures.saveObjects()
            default:
                break
            }
        }
    }
}
