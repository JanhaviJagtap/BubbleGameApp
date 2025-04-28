//
//  ContentView.swift
//  BubbleTrouble
//
//  Created by Janhavi Jagtap on 31/3/2025.
//

import SwiftUI

struct HomePage: View {
    @StateObject var viewModel = BubblePopViewModel()
    @State private var navigateToNamePage = false
    var body: some View {
        if viewModel.gameState == .menu {
            NavigationStack{
                ZStack {
                    Image("Bubble bg full")
                        .resizable()
                        .scaledToFill()
                    VStack{
                    Image("Title")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 210)
                        
                        NavigationLink(destination: NamePage()){
                        Image("startButton")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 210)
                            .ignoresSafeArea()
                    }
                }
                .padding(.top, 100)
            }
        }
            //HighScorePage(highScores: viewModel.highScores)
        } else if viewModel.gameState == .playing {
            GamePage(viewModel: viewModel)
        } else if viewModel.gameState == .gameOver {
            EndPage(viewModel: viewModel)
        }
    }
}

#Preview {
    HomePage()
}
