//
//  CameraButton.swift
//  CameraButton
//
//  Created by Sam Obe on 8/31/21.
//

import SwiftUI

struct CameraButton: View {
    //@EnvironmentObject var camera: CameraViewModel
    let action : () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            HStack{
                ZStack {
                    Button(action: action, label: {
                        Circle().fill(Color("ButtonColor")).frame(width: 70, height: 70, alignment: .center)
                    })
                    
                    Circle().stroke(Color.white, lineWidth: 5).frame(width: 85, height: 85, alignment: .center)
                }
                
            }.padding(.bottom, 40)
        }
    }
}

struct CameraButton_Previews: PreviewProvider {
    static var previews: some View {
        CameraButton(action: {})
    }
}
