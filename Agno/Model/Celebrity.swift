//
//  Celebrity.swift
//  Agno
//
//  Created by Sam Obe on 8/19/21.
//

import Foundation
import SwiftUI

struct Celebrity : Codable {
    var name: String
    var net_worth: Int
    var nationality: String
    var height: Float
    var birthdy: String?
    var gender: String?
    var occupation : [String]
    var imageUrl: String?
}

