//
//  Celebrity.swift
//  Agno
//
//  Created by Sam Obe on 8/19/21.
//

import Foundation
import SwiftUI

struct Celebrity : Identifiable, Decodable {
    let id: Int
    let name: String
    let imageUrl: String
}

let MOCK_CELEB = Celebrity.init(id: 0, name: "Master Chief", imageUrl: "")
