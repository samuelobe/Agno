//
//  SettingsButton.swift
//  Agno
//

//  Created by Samuel Obe on 9/26/21.
//

import SwiftUI

struct SettingsButton: View {
    let action : () -> Void
    var body: some View {
        Button(action: action){
            ZStack {
                Circle().fill(Color.black.opacity(0.33)).frame(width: 50, height: 50, alignment: .center)
                Image(systemName: "gearshape.fill").foregroundColor(.white).font(.system(size: 30)).padding(10)
            }
        }
    }
}

struct SettingsButton_Previews: PreviewProvider {
    static var previews: some View {
        SettingsButton(action: {})
    }
}
