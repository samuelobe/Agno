//
//  Celebrity.swift
//  Agno
//
//  Created by Sam Obe on 8/19/21.
//

import Foundation
import SwiftUI

struct Celebrity : Decodable {
    let name: String
    let net_worth: Int
    let nationality: String
    let height: Float
    let birthdy: String?
    let gender: String?
    let occupation : [String]
    let imageUrl: String?
}

extension Celebrity {
    static let dummyData = Celebrity(name: "Master Chief", net_worth: 100000, nationality: "US", height: 1.89, birthdy: "05/22/1999", gender: nil, occupation: ["Solider"], imageUrl: nil)
}

