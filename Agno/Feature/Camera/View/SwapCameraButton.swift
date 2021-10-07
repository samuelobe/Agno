//
//  SwapCameraButton.swift
//  Agno
//
//  Created by ELeetDev on 9/30/21.
//

import SwiftUI

struct SwapCameraButton: View {
    let action : () -> Void
    var body: some View {
        Button(action: action){
            ZStack {
                Circle().fill(Color.black.opacity(0.33)).frame(width: 50, height: 50, alignment: .center)
                Image(systemName: "arrow.triangle.2.circlepath.camera.fill").foregroundColor(.white).font(.system(size: 25)).padding(10)
            }
        }
    }
}

struct SwapCameraButton_Previews: PreviewProvider {
    static var previews: some View {
        SwapCameraButton(action: {})
    }
}
