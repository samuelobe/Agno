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
                    Image(systemName: leftButtonIcon).font(.title).foregroundColor(.white)
                }).padding(.leading, 40)
                Spacer()
                if isCheck {
                    Text(LocalizedStringKey("scan")).font(.caption).bold()
                    Spacer()
                }

                Button(action: rightButtonAction, label: {
                    Image(systemName: rightButtonIcon).font(.title).foregroundColor(.white)
                }).padding(.trailing, 40)
            }
        }
    }
}

struct CameraBar_Previews: PreviewProvider {
    static var previews: some View {
        CameraBar(leftButtonIcon: "photo", rightButtonIcon: "gearshape", leftButtonAction: {}, rightButtonAction: {}, isCheck: true).preferredColorScheme(.dark).previewDevice(PreviewDevice(rawValue: "iPhone 8"))
            .previewDisplayName("iPhone 8")
        
        CameraBar(leftButtonIcon: "photo", rightButtonIcon: "gearshape", leftButtonAction: {}, rightButtonAction: {}, isCheck: true).preferredColorScheme(.dark).previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            .previewDisplayName("iPhone 12")
        
        CameraBar(leftButtonIcon: "photo", rightButtonIcon: "gearshape", leftButtonAction: {}, rightButtonAction: {}, isCheck: true).preferredColorScheme(.dark).previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro"))
            .previewDisplayName("iPhone 12 Pro")
    }
}
