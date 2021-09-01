//
//  ContentView.swift
//  Agno
//
//  Created by Sam Obe on 8/19/21.
//

import SwiftUI

struct StartScreen: View {
    @State private var action: Int? = 0

    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                VStack{
                    Text("AGNO" ).foregroundColor(.white).font(Font.custom("CustomFont", size: 50)).padding()
                    Text("AGNO is a celebrity-image recognition app which detects faces of celebrities with a single click..." ).foregroundColor(.white).font(Font.custom("CustomFont", size: 15)).multilineTextAlignment(.center).padding()
                    Spacer()
                    NavigationLink(
                        destination: CameraScreen(),
                        tag: 1, selection: $action
                    ) {
                        Button(action: {self.action = 1}, label: {
                            Text("Get Started").fontWeight(.bold)
                                .font(.body)
                                .padding(EdgeInsets(top: 20, leading: 100, bottom: 20, trailing: 100))
                                .background(Color("ButtonColor"))
                                .cornerRadius(40)
                                .foregroundColor(.white)
                        }).padding()
                    }.navigationBarHidden(true)
                    
                }
            }
            
            
        }.preferredColorScheme(.dark)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartScreen()
    }
}
