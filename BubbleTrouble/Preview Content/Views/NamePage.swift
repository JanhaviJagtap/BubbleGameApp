//
//  SwiftUIView.swift
//  BubbleTrouble
//
//  Created by Janhavi Jagtap on 22/4/2025.
//

import SwiftUI

struct NamePage: View {
    @ObservedObject var viewModel = BubblePopViewModel()
    @State private var myNameInput: String = ""
    var body: some View {
        ZStack {
            Image("Bubble bg full")
                .resizable()
                .scaledToFill()
            
            VStack{
                Text("Enter your name")
                    .font(.title3)
                TextField("Name", text: $myNameInput)
                    .multilineTextAlignment(.center)
                    .padding(.all, 10)
                    .foregroundColor(.black)
                    .background(Color(red: 0.993, green: 0.943, blue: 0.918))
                    .padding(.vertical, 20)
                    .padding(.horizontal, 100)
                    .autocorrectionDisabled()
                Spacer()
                
                Button{
                    viewModel.playerName = myNameInput
                    viewModel.startGame()
                } label: {
                    Text("Lets Go!")
                        .fontWeight(.bold)
                        .font(.largeTitle)
                }
                Spacer()
            }.toolbar{
                ToolbarItem(placement:.navigationBarTrailing){
                    Image(systemName: "gearshape")
                }
            }
            .padding(.top, 100)
        }
        
    }
}


#Preview {
    NamePage()
}
