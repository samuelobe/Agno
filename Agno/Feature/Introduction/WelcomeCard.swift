//
//  WelcomeCard.swift
//  WelcomeCard
//
//  Created by Samuel Obe on 9/17/21.
//

import SwiftUI

struct WelcomeCard: View {
    let action : () -> Void
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Welcome to Agno").foregroundColor(.white).bold().font(.title2).padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
                Text("Agno is a celebrity-image recognition app which detects faces of celebrities with a single click...").foregroundColor(.white).padding().multilineTextAlignment(.center)
                Button(action: self.action, label: {
                    Text("Get Started")
                        .font(.body)
                        .bold()
                        .padding(EdgeInsets(top: 15, leading: 50, bottom: 15, trailing: 50))
                        .background(Color("ButtonColor"))
                        .cornerRadius(15)
                        .foregroundColor(.white)
                        
                    
                }).padding()
                
            }.padding()
            .frame(width: geometry.size.width * 0.8 ).background(Color("BackgroundColor"))
            .cornerRadius(15)
            .progressViewStyle(CircularProgressViewStyle(tint: .white))
            .shadow(radius: 10)
            .position(x: geometry.size.width/2, y: geometry.size.height/2)
        }
    }
}

struct WelcomeCard_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeCard(action: {})
    }
}
