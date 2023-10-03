//
//  ContentView.swift
//  Memory_Game
//
//  Created by Erin Dragusha on 2023-10-03.
//

import SwiftUI

enum TabSelection: Int {
    case Start
    case Settings
    case Game
}

struct ContentView: View {
    
    @State private var tabSelection: TabSelection = .Start
    
    @EnvironmentObject var treasures: Treasures
    
    var body: some View {
        VStack {
            TabView(selection: $tabSelection) {
                StartView()
                    .tabItem {
                        Text("Start")
                    }
                    .tag(TabSelection.Start)
                
                GameView()
                    .tabItem {
                        Text("Game")
                    }
                    .tag(TabSelection.Game)
                
                SettingsView()
                    .tabItem {
                        Text("Settings")
                    }
                    .tag(TabSelection.Settings)
            }
        }
    }
}

#Preview {
    ContentView().environmentObject(Treasures())
}
