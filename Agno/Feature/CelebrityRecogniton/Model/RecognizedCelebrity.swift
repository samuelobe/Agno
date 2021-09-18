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
    let imdbLink : String
    let wikidataLink : String
    let urls : [String]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    static func == (lhs: RecognizedCelebrity , rhs: RecognizedCelebrity) -> Bool {
        return lhs.name == rhs.name && lhs.urls == rhs.urls
    }
}

let dummyData = [
    RecognizedCelebrity(name: "Samuel Obe", confidence: NSNumber.init(value: 99.999), imdbLink: "", wikidataLink: "", urls: []),
    RecognizedCelebrity(name: "Bob Jomama", confidence: NSNumber.init(value: 99.999), imdbLink: "", wikidataLink: "", urls: []),
    RecognizedCelebrity(name: "Derek Jeter", confidence: NSNumber.init(value: 99.999), imdbLink: "", wikidataLink: "", urls: []),
    RecognizedCelebrity(name: "Han Solo", confidence: NSNumber.init(value: 99.999), imdbLink: "", wikidataLink: "", urls: [])
]
