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
    
    private let privacyPolicyLink = "https://ayosoftware.com/agno-privacy-policy"
    private let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text(LocalizedStringKey("celeb")), footer: Text(LocalizedStringKey("confidenceSetting"))) {
                        Toggle(isOn: $settings.displayConfidence, label: {Text(LocalizedStringKey("display"))})
                    }
                    Section(header: Text(LocalizedStringKey("access")), footer: Text(LocalizedStringKey("swap"))) {
                        Toggle(isOn: $settings.swapButtons, label: {Text(LocalizedStringKey("mode"))})
                    }
                    Section(header: Text(LocalizedStringKey("about"))) {
                        Button(action: {
                            self.presentingSafariView.toggle()
                        }) {
                            HStack {
                                Text(LocalizedStringKey("policy"))
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                        }
                        HStack {
                            Text(LocalizedStringKey("version"))
                            Spacer()
                            Text(appVersion!)
                        }
                    }
                }
                
            }
            .ignoresSafeArea(.all, edges: .top)
            .navigationBarTitle(LocalizedStringKey("settings"), displayMode: .inline )
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                    
                }) {Text(LocalizedStringKey("done"))
                        .bold()
                    
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
