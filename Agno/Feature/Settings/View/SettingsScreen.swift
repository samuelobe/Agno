//
//  SettingsScreen.swift
//  SettingsScreen
//
//  Created by ELeetDev on 9/24/21.
//

import SwiftUI

struct SettingsScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var settings : SettingsViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("BackgroundColor")
                Form {
//                    Section(header: Text("Display"), footer: Text("System settings will override dark mode and use the current device theme")) {
//                        Toggle(isOn: .constant(true), label: {Text("Dark Mode")})
//                        Toggle(isOn: .constant(true), label: {Text("Use System settings")})
//                    }
                    Section(header: Text("CELEBRITY"), footer: Text("Confidence values represent the accuracy of each celebrity result")) {
                        Toggle(isOn: $settings.displayConfidence, label: {Text("Display confidence values")})
                    }
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
        SettingsScreen().preferredColorScheme(.dark)
    }
}
