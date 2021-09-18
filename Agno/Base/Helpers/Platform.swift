//
//  Platform.swift
//  Platform
//
//  Created by ELeetDev on 9/18/21.
//

import Foundation

struct Platform {
    static let isSimulator: Bool = {
        var isSim = false
#if targetEnvironment(simulator)
        isSim = true
#endif
        return isSim
    }()
}
