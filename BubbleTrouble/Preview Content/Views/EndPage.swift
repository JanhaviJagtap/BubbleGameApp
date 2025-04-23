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
        ZStack {
            Image("Bubble bg full")
                .resizable()
                .scaledToFill()
            
            VStack{
                Text("Game Over!")
                Text("Your Score:")
                Button{} label: {
                    Text("HighScores")
                }
                Button{viewModel.startGame()} label:{
                    Text("Play Again")
                }
            }
        }
    }
}

#Preview {
    //EndPage(viewModel: <#BubblePopViewModel#>)
}
