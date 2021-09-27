//
//  SettingsScreen.swift
//  SettingsScreen
//
//  Created by ELeetDev on 9/24/21.
//

import SwiftUI
import BetterSafariView

struct SettingsScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var settings : SettingsViewModel
    @State private var presentingSafariView = false
    
    let privacyPolicyLink = "https://ayosoftware.com/privacy-policy"
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("CELEBRITY"), footer: Text("Confidence values represent the accuracy of each celebrity result")) {
                        Toggle(isOn: $settings.displayConfidence, label: {Text("Display confidence values")})
                    }
                    Section(header: Text("accessibility"), footer: Text("Swaps the positioning of the \"accept\" and \"deny\" buttons to cater towards left-handed users")) {
                        Toggle(isOn: $settings.displayConfidence, label: {Text("Left-handed mode")})
                    }
                    Section(header: Text("ABOUT")) {
                        Button(action: {
                            self.presentingSafariView.toggle()
                        }) {
                            HStack {
                                Text("Privacy Policy").foregroundColor(Color("SectionColor"))
                                Spacer()
                                Image(systemName: "chevron.right").foregroundColor(Color("SectionColor"))
                            }
                        }
                        HStack {
                            Text("Version")
                            Spacer()
                            Text(appVersion!)
                        }
                    }
                }.background(Color("BackgroundColor"))
                
            }
            .ignoresSafeArea(.all, edges: .top)
            .navigationBarTitle("Settings", displayMode: .inline )
            .navigationBarItems(trailing: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
                
            }) {Text("Done").bold().foregroundColor(Color("SectionColor"))})
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
