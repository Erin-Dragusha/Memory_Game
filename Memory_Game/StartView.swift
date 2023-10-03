//
//  StartView.swift
//  Memory_Game
//
//  Created by Erin Dragusha on 2023-10-03.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        ScrollView {
            VStack {
                Spacer()
                Text("Welcome to the ICS 224 Memory Game!")
                Spacer()
                Text("The aim is to uncover identical images, without uncovering a mismatching image in the process. If a certain number of identical images have been revealed, they are removed from the game. (The exact number of identical images that must be uncovered before they are removed depends on the image, and can be set from the Settings tab.) If a mismatched image is selected, all revealed images are hidden again. The game ends when all images have been removed from the game.")
            }
        }
        .padding()
    }
}

#Preview {
    StartView()
}
