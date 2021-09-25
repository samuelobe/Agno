//
//  SettingsScreen.swift
//  SettingsScreen
//
//  Created by ELeetDev on 9/24/21.
//

import SwiftUI

struct SettingsScreen: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("BackgroundColor")
                VStack{
                    Text("Content in Settings")
                }
                .navigationBarTitle("Settings", displayMode: .inline )
                .navigationBarItems(trailing: Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                    
                }) {
                    Text("Done").bold()
                })
            }.ignoresSafeArea()
            
        }
    }
}

struct SettingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingsScreen()
    }
}
