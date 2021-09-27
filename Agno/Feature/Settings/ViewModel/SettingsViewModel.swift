//
//  SettingsViewModel.swift
//  SettingsViewModel
//
//  Created by ELeetDev on 9/26/21.
//

import SwiftUI
import Combine

class SettingsViewModel : ObservableObject {
    let displayKey = "displayConfidence"
    let swapKey = "swapButtons"

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
    
    
    init() {
        self.displayConfidence = UserDefaults.standard.bool(forKey: displayKey)
        self.swapButtons = UserDefaults.standard.bool(forKey: swapKey)
    }
    
    
    
}
