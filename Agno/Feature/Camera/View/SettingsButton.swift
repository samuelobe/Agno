//
//  SettingsButton.swift
//  Agno
//

//  Created by ELeetDev on 9/26/21.
//

import SwiftUI

struct SettingsButton: View {
    let action : () -> Void
    var body: some View {
        Button(action: action){
            Image(systemName: "gearshape.fill").foregroundColor(.white).font(.title).padding(5).background(Circle().fill(Color.black.opacity(0.33))  )
        }
    }
}

struct SettingsButton_Previews: PreviewProvider {
    static var previews: some View {
        SettingsButton(action: {})
    }
}
