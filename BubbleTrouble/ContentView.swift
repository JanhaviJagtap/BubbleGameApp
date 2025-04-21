//
//  ContentView.swift
//  BubbleTrouble
//
//  Created by Janhavi Jagtap on 31/3/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Image("Bubble bg full")
                .resizable()
                .scaledToFill()
            
            VStack{
                Image("Title")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 210)
                Button{
                } label: {
                    Image("startButton")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 210)
                }
            }.padding(.top, 100)
        }
    }
}

#Preview {
    ContentView()
}
