//
//  GameView.swift
//  Memory_Game
//
//  Created by Erin Dragusha on 2023-10-03.
//

import SwiftUI

struct GameView: View {
    
    static let fullyVisible = 1.0
    
    static let somewhatVisible = 0.5
    
    static let tileSize = 20.0
    
    @StateObject private var tiles = Tiles()
    
    @EnvironmentObject var treasures: Treasures

    
    var body: some View {
        VStack {
            ScrollView([.horizontal, .vertical], showsIndicators: true) {
                VStack {
                    ForEach(0..<tiles.numRows, id: \.self) { i in
                        HStack {
                            ForEach(0..<tiles.numCols, id: \.self) { j in
                                Image(systemName: tiles.showTreasuresAt(row: i, column: j))
                                    .disabled(tiles.updating)
                                    .frame(width: GameView.tileSize, height: GameView.tileSize, alignment: .center)
                                    .onTapGesture {
                                        tiles.revealTreasureAt(row: i, column: j)
                                    }
                                    .opacity(tiles.updating ? GameView.somewhatVisible : GameView.fullyVisible)
                            }
                        }
                    }
                    Spacer()
                    Text("Attempts: \(tiles.numReveals)")
                    if tiles.totalRemaining > 0 {
                        Text("Total Remaining: \(tiles.totalRemaining)")
                    }
                    else {
                        Text("Game Over!")
                    }
                }
                .padding()
                .onAppear() {
                    tiles.setupBoard(treasureList: treasures.list)
                }
            }
        }
    }
}

#Preview {
    GameView().environmentObject(Treasures())
}
