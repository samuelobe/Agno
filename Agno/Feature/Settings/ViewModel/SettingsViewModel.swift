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

    @Published var displayConfidence : Bool  {
        didSet {
            UserDefaults.standard.set(displayConfidence, forKey: displayKey)
        }
    }
    
    
    init() {
        self.displayConfidence = UserDefaults.standard.bool(forKey: displayKey)
    }
    
    
    
}
