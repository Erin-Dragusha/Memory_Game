//
//  SettingsView.swift
//  Memory_Game
//
//  Created by Erin Dragusha on 2023-10-03.
//

import SwiftUI

struct SettingsView: View {
    
    let minGroupSize = 2
    let maxGroupSize = 10
    let minNumGroupSize = 1
    let maxNumGroupSize = 10
    let minScrollViewSize = 800.0
    let minStepperViewSize = 450.0
    
    @EnvironmentObject var treasures: Treasures

    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ScrollView([.horizontal]) {
                    List {
                        ForEach($treasures.list) {
                            $treasure in
                            HStack {
                                TextField("Icon Name", text: $treasure.name)
                                    .autocapitalization(.none)
                                    .padding()
                                
                                Spacer()
                                
                                HStack {
                                    Text("\(treasure.groupSize)/group")
                                        .lineLimit(1)
                                    Stepper("Group Size", value: $treasure.groupSize, in: minGroupSize...maxGroupSize, step: 1)
                                        .labelsHidden()
                                        .padding()
                                    
                                    Text("\(treasure.numGroups) group\(treasure.numGroups == 1 ? "  ": "s")")
                                        .lineLimit(1)
                                    Stepper("Group Number", value: $treasure.numGroups, in: minNumGroupSize...maxNumGroupSize, step: 1)
                                        .labelsHidden()
                                        .padding()
                                }
                                .frame(minWidth: minStepperViewSize)
                            }
                        }
                        .onDelete {
                            if let index = $0.first {
                                treasures.list.remove(at: index)
                            }
                        }
                        .onMove {
                            treasures.list.move(fromOffsets: $0, toOffset: $1)
                        }
                    }
                    .frame(width: max(minScrollViewSize, geo.size.width), height: geo.size.height, alignment: .center)
                }
            }
            .navigationTitle("Treasures")
            .toolbar {
                HStack {
                    EditButton()
                    Button(
                        action: {
                        treasures.list.insert(Treasure(name: "", groupSize: minGroupSize, numGroups: minNumGroupSize), at: 0)
                    },
                        label: {
                            Image(systemName: "plus")
                        })
                }
            }
        }
        .navigationViewStyle(.stack)
        .onDisappear() {
            treasures.saveObjects()
        }
    }
}

#Preview {
    SettingsView().environmentObject(Treasures())
}
