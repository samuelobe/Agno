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
            Image(systemName: "arrow.triangle.2.circlepath.camera.fill").foregroundColor(.white).font(.system(size: 30)).padding(10).background(Circle().fill(Color.black.opacity(0.33))  )
        }
    }
}

struct SwapCameraButton_Previews: PreviewProvider {
    static var previews: some View {
        SwapCameraButton(action: {})
    }
}
