//
//  SettingsScreen.swift
//  SettingsScreen
//
//  Created by Samuel Obe on 9/24/21.
//

import SwiftUI
import BetterSafariView

struct SettingsScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var settings : SettingsViewModel
    @State private var presentingSafariView = false
    
    let privacyPolicyLink = "https://ayosoftware.com/privacy-policy"
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    
    @State private var languageIndex = 0
    var languageOptions = ["English", "Español", "Français", "中文"]

    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("CELEBRITY"), footer: Text("Confidence values represent the accuracy of each celebrity result")) {
                        Toggle(isOn: $settings.displayConfidence, label: {Text("Display confidence values")})
                    }
                    Section(header: Text("accessibility"), footer: Text("Swaps the positioning of the \"check\" and \"cross\" buttons to cater towards left-handed users")) {
                        Toggle(isOn: $settings.swapButtons, label: {Text("Left-handed mode")})
                    }
//                    Section(header: Text("IN-APP LANGUAGE"), footer: Text("Change Agno to your language of choice")) {
//                        Toggle(isOn: $settings.useDefaultLanguage, label: {Text("Use device language settings")})
//                        Picker(selection: $languageIndex, label: Text("Change language")) {
//                            ForEach(0 ..< languageOptions.count) {
//                                Text(self.languageOptions[$0])
//                            }
//                        }
//
//                    }
                    Section(header: Text("ABOUT")) {
                        Button(action: {
                            self.presentingSafariView.toggle()
                        }) {
                            HStack {
                                Text("Privacy Policy").foregroundColor(Color("ButtonColor"))
                                Spacer()
                                Image(systemName: "chevron.right").foregroundColor(Color("ButtonColor"))
                            }
                        }
                        HStack {
                            Text("Version")
                            Spacer()
                            Text(appVersion!)
                        }
                    }
                }
                
            }
            .ignoresSafeArea(.all, edges: .top)
            .navigationBarTitle("Settings", displayMode: .inline )
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                    
                }) {Text("Done")
                    .bold()
                    .foregroundColor(Color("SectionColor"))
                    
                }
                }
            }
            
        }.safariView(isPresented: $presentingSafariView) {
            SafariView(
                url: URL(string: privacyPolicyLink)!,
                configuration: SafariView.Configuration(
                    entersReaderIfAvailable: false,
                    barCollapsingEnabled: true
                )
            )
                .preferredBarAccentColor(.clear)
                .preferredControlAccentColor(.accentColor)
                .dismissButtonStyle(.done)
        }
    }
}

struct SettingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingsScreen().preferredColorScheme(.dark).environmentObject(SettingsViewModel())
    }
}
