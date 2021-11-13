//
//  CameraPermission.swift
//  CameraPermission
//
//  Created by Samuel Obe on 9/18/21.
//

import SwiftUI

struct CameraPermission: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text(LocalizedStringKey("cameraAccess")).foregroundColor(.white).bold().padding().multilineTextAlignment(.center)
                Button(action: {
                    if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                       UIApplication.shared.open(settingsUrl)
                     }
                }, label: {
                    Text(LocalizedStringKey("cameraSettings"))
                        .font(.body)
                        .bold()
                        .padding(EdgeInsets(top: 15, leading: 50, bottom: 15, trailing: 50))
                        .background(Color("ButtonColor"))
                        .cornerRadius(15)
                        .foregroundColor(.white)
                    
                }).padding()
                
            }.padding()
                .frame(width: geometry.size.width * 0.8 ).background(Color.gray)
            .cornerRadius(15)
            .progressViewStyle(CircularProgressViewStyle(tint: .white))
            .shadow(radius: 10)
            .position(x: geometry.size.width/2, y: geometry.size.height/2)
        }
    }
}

struct CameraPermission_Previews: PreviewProvider {
    static var previews: some View {
        CameraPermission()
    }
}
