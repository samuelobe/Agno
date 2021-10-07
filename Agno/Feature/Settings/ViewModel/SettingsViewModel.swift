//
//  SettingsViewModel.swift
//  SettingsViewModel
//
//  Created by Samuel Obe on 9/26/21.
//

import SwiftUI
import Combine

class SettingsViewModel : ObservableObject {
    let displayKey = "displayConfidence"
    let swapKey = "swapButtons"
    let useDefaultLanguageKey = "useDefaultLanguageKey"
    let languageKey = "currentLanguage"

    @Published var displayConfidence : Bool  {
        didSet {
            UserDefaults.standard.set(displayConfidence, forKey: displayKey)
        }
    }
    
    @Published var swapButtons : Bool {
        didSet {
            UserDefaults.standard.set(swapButtons, forKey: swapKey)
        }
    }
    
    @Published var useDefaultLanguage : Bool {
        didSet {
            UserDefaults.standard.set(useDefaultLanguage, forKey: useDefaultLanguageKey)
        }
    }
    
    
    
    
    init() {
        self.displayConfidence = UserDefaults.standard.bool(forKey: displayKey)
        self.swapButtons = UserDefaults.standard.bool(forKey: swapKey)
        self.useDefaultLanguage = true
    }
    
    
    
}
