//
//  GamePage.swift
//  BubbleTrouble
//
//  Created by Janhavi Jagtap on 31/3/2025.
//

import SwiftUI

struct GamePage: View {
    var myInt = Int.random(in: 10..<16)
    @StateObject private var viewModel = BubblePopViewModel()

    var body: some View {
        NavigationStack{
            VStack{
                Text("Current Score: \(viewModel.score)")
                Spacer()
                ZStack{
                    Image("Bubble (1)")
                        .resizable()
                        
                    ForEach(viewModel.bubbles) { bubble in
                        Image(bubble.color.color)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 130)
                            .position(bubble.position)
                            .onTapGesture {
                                viewModel.popBubble(bubble)
                            }
                        }
                }.toolbar{
                    ToolbarItem(placement:.navigationBarLeading){
                        Text("Highest\nScore:")
                    }
                    ToolbarItem(placement:.navigationBarTrailing){
                        Text("Timer:\n 00:\(viewModel.timeLeft)")
                    }
                    //ToolbarItem(placement: .bottomBar){
                      //  Text("Pop as many bubbles as you can in a minute!")
                        //    .fontWeight(.light)
                    //}
                }
            }
            .onAppear {
                viewModel.startGame()
            }
            .sheet(isPresented: .constant(viewModel.timeLeft <= 0)) {
                EndPage(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    GamePage()
}



//Image("greenbubble")
  //  .resizable()
    //.scaledToFit()
    //.frame(width:130)
    //.padding(.all, 30)
