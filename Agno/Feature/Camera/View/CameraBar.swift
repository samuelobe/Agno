//
//  CameraBar.swift
//  CameraBar
//
//  Created by Sam Obe on 9/3/21.
//

import SwiftUI

struct CameraBar: View {
    let leftButtonIcon : String
    let rightButtonIcon : String
    let leftButtonAction : () -> Void
    let rightButtonAction : () -> Void
    let isCheck : Bool
    
    var body: some View {
        ZStack {
            Color.black.frame(height: 85, alignment: .center).opacity(0.75)
            HStack{
                Button(action: leftButtonAction, label: {
                    Image(systemName: leftButtonIcon).font(.system(size: 27.0)).foregroundColor(.white)
                }).padding(.leading, 40)
                Spacer()
                if isCheck {
                    Text("Is this photo acceptable?").bold()
                    Spacer()
                }

                Button(action: rightButtonAction, label: {
                    Image(systemName: rightButtonIcon).font(.system(size: 27.0)).foregroundColor(.white)
                }).padding(.trailing, 40)
            }
        }
    }
}

struct CameraBar_Previews: PreviewProvider {
    static var previews: some View {
        CameraBar(leftButtonIcon: "photo", rightButtonIcon: "gearshape", leftButtonAction: {}, rightButtonAction: {}, isCheck: true).preferredColorScheme(.dark)
    }
}
