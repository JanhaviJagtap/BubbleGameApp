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
                Text("Current Score:")
                Spacer()
                ZStack{
                    Image("Bubble (1)")
                        .resizable()
                        
                    ForEach(viewModel.bubbles) { bubble in
                        Circle()
                            .fill(bubble.color.color)
                            .frame(width: 60, height: 60)
                            .position(bubble.position)
                            .scaleEffect(scaleEffect)
                            .opacity(scaleEffect == 0 ? 0 : 1)
                            .animation(.easeInOut(duration: 0.2), value: scaleEffect)
                            .onTapGesture {
                                withAnimation {
                                    scaleEffect = 0
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                        viewModel.popBubble(bubble)
                                        scaleEffect = 1
                                    }
                                }
                            }
                        }
                        VStack {
                            HStack {
                                Text("Score: \(viewModel.score)")
                                Spacer()
                                Text("Time: \(viewModel.timeLeft)")
                            }
                            .padding()
                            Spacer()
                        }
                }.toolbar{
                    ToolbarItem(placement:.navigationBarLeading){
                        Text("Highest\nScore:")
                    }
                    ToolbarItem(placement:.navigationBarTrailing){
                        Text("Timer\n")
                    }
                    //ToolbarItem(placement: .bottomBar){
                      //  Text("Pop as many bubbles as you can in a minute!")
                        //    .fontWeight(.light)
                    //}
                }
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
