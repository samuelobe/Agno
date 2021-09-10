//
//  ContentView.swift
//  Agno
//
//  Created by Sam Obe on 8/19/21.
//

import SwiftUI

struct StartScreen: View {
    @State private var action: Int? = 0
    @StateObject var camera = CameraViewModel()
    @StateObject var celeb = CelebrityListViewModel(recognitionAWS: CelebrityRecognition())

    var body: some View {
        NavigationView {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()
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
            }
        .preferredColorScheme(.dark).environmentObject(camera).environmentObject(celeb).navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartScreen()
    }
}
