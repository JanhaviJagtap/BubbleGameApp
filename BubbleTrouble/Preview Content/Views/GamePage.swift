//
//  GamePage.swift
//  BubbleTrouble
//
//  Created by Janhavi Jagtap on 31/3/2025.
//

import SwiftUI

struct GamePage: View {
    var myInt = Int.random(in: 10..<16)
    
    var body: some View {
        NavigationStack{
            VStack{
                Text("Current Score:")
                Spacer()
                ZStack{
                    Image("Bubble (1)")
                        .resizable()
                        .toolbar{
                            ToolbarItem(placement:.navigationBarLeading){
                                Text("Highest\nScore:")
                            }
                            ToolbarItem(placement:.navigationBarTrailing){
                                Text("Timer\n")
                            }
                            ToolbarItem(placement: .bottomBar){
                                Text("Pop as many bubbles as you can in a minute!")
                                    .fontWeight(.light)
                            }
                        }
                    VStack{
                        Image("GreenBubble")
                            .resizable()
                            .scaledToFit()
                            .frame(width:120)
                            .padding(.all, 30)
                        Image("GreenBubble")
                            .resizable()
                            .scaledToFit()
                            .frame(width:120)
                            .padding(.all, 30)
                    }
                }
            }
        }
    }
}

#Preview {
    GamePage()
}
