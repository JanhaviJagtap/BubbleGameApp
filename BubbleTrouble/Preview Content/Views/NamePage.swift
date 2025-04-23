//
//  SwiftUIView.swift
//  BubbleTrouble
//
//  Created by Janhavi Jagtap on 22/4/2025.
//

import SwiftUI

struct NamePage: View {
    @State var mytext: String = ""
    var body: some View {
        ZStack {
            Image("Bubble bg full")
                .resizable()
                .scaledToFill()
            
            VStack{
                Text("Enter your name")
                    .font(.title3)
                TextField("Name", text: $mytext)
                    .multilineTextAlignment(.center)
                    .padding(.all, 20)
                    .background(Color(red: 0.993, green: 0.943, blue: 0.918))
                    .padding(.horizontal, 100)
                    .autocorrectionDisabled()
                Spacer()

                Button{
                } label: {
                    Text("Lets Go!")
                        .fontWeight(.bold)
                        .font(.largeTitle)
                }
                Spacer()
            }.padding(.top, 100)
        }
    }
}

#Preview {
    NamePage()
}
