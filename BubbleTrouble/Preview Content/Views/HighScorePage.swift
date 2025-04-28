//
//  HighScorePage.swift
//  BubbleTrouble
//
//  Created by Janhavi Jagtap on 23/4/2025.
//

import SwiftUI

struct HighScorePage: View {
    let highScores: [HighScoreEntry]
    var body: some View {
        VStack(alignment: .leading) {
            Text("High Scores").font(.headline)
            ForEach(highScores.prefix(10)) { entry in
                HStack {
                    Text(entry.playerName)
                    Spacer()
                    Text("\(entry.score)")
                }
            }
        }
        .padding()
    }
}
