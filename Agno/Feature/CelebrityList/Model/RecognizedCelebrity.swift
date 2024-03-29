//
//  RecognizedCelebrity.swift
//  RecognizedCelebrity
//
//  Created by Sam Obe on 8/26/21.
//

import Foundation

struct RecognizedCelebrity: Identifiable, Hashable {
    var id = UUID()
    let name : String
    let confidence : NSNumber
    let url : String
    let imageURL : String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    static func == (lhs: RecognizedCelebrity , rhs: RecognizedCelebrity) -> Bool {
        return lhs.name == rhs.name && lhs.url == rhs.url
    }
}

let dummyData = [
    RecognizedCelebrity(name: "Samuel Obe", confidence: NSNumber.init(value: 99.999), url: "", imageURL: ""),
]
