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
    let urls : [String]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    static func == (lhs: RecognizedCelebrity , rhs: RecognizedCelebrity) -> Bool {
        return lhs.name == rhs.name
    }
}

let dummyData = [
    RecognizedCelebrity(name: "Samuel Obe", confidence: NSNumber.init(value: 99.999), urls: []),
    RecognizedCelebrity(name: "Bob Jomama", confidence: NSNumber.init(value: 99.999), urls: []),
    RecognizedCelebrity(name: "Derek Jeter", confidence: NSNumber.init(value: 99.999), urls: []),
    RecognizedCelebrity(name: "Han Solo", confidence: NSNumber.init(value: 99.999), urls: [])
]
