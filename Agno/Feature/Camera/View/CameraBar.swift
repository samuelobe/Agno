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
    
    var body: some View {
        ZStack {
            Color.black.frame(height: 85, alignment: .center).opacity(0.75)
            HStack{
                Button(action: leftButtonAction, label: {
                    Image(systemName: leftButtonIcon).font(.system(size: 27.0)).foregroundColor(.white)
                }).padding(.leading, 40)
                Spacer()
                Button(action: rightButtonAction, label: {
                    Image(systemName: rightButtonIcon).font(.system(size: 27.0)).foregroundColor(.white)
                }).padding(.trailing, 40)
            }
        }
    }
}

struct CameraBar_Previews: PreviewProvider {
    static var previews: some View {
        CameraBar(leftButtonIcon: "photo", rightButtonIcon: "gearshape", leftButtonAction: {}, rightButtonAction: {}).preferredColorScheme(.dark)
    }
}
