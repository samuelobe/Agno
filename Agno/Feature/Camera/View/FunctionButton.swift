//
//  FunctionButton.swift
//  Agno
//
//  Created by ELeetDev on 11/15/21.
//

import SwiftUI

struct FunctionButton: View {
    let icon : String
    let iconSize : CGFloat
    let action : () -> Void
    var body: some View {
        Button(action: action){
            ZStack {
                Circle().fill(Color.black.opacity(0.33)).frame(width: 50, height: 50, alignment: .center)
                Image(systemName: icon).foregroundColor(.white).font(.system(size: iconSize)).padding(10)
            }
        }
    }
}

struct FunctionButton_Previews: PreviewProvider {
    static var previews: some View {
        FunctionButton(icon: "arrow.triangle.2.circlepath.camera.fill", iconSize: 30, action: {}  )
    }
}
