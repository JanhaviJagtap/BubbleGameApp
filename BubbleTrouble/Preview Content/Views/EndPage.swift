//
//  EndPage.swift
//  BubbleTrouble
//
//  Created by Janhavi Jagtap on 23/4/2025.
//

import SwiftUI

struct EndPage: View {
    @ObservedObject var viewModel: BubblePopViewModel

    var body: some View {
        VStack {
            Text("Game Over!").font(.largeTitle)
            Text("Score: \(viewModel.score)").font(.title)
            Button("Play Again") {
                viewModel.resetGame()
            }
            .padding()
            HighScorePage(highScores: viewModel.highScores)
        }
    }
}
