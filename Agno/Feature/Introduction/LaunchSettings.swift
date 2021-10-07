//
//  LaunchSettings.swift
//  LaunchSettings
//
//  Created by Samuel Obe on 9/17/21.
//

import Foundation
import Combine

class LaunchSettings: ObservableObject {
    @Published var didLaunchBefore: Bool {
        didSet {
            UserDefaults.standard.set(didLaunchBefore, forKey: "didLaunchBefore")
        }
    }
    
    init() {
        self.didLaunchBefore = UserDefaults.standard.bool(forKey: "didLaunchBefore")
    }
}
