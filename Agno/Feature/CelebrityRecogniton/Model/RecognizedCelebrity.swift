//
//  RecognizedCelebrity.swift
//  RecognizedCelebrity
//
//  Created by Sam Obe on 8/26/21.
//

import Foundation

struct RecognizedCelebrity: Identifiable {
    var id = UUID()
    let name : String
    let confidence : NSNumber
    let urls : [String]
}

let dummyData = [
    RecognizedCelebrity(name: "Samuel Obe", confidence: NSNumber.init(value: 99.999), urls: []),
    RecognizedCelebrity(name: "Samuel Obe", confidence: NSNumber.init(value: 99.999), urls: []),
    RecognizedCelebrity(name: "Samuel Obe", confidence: NSNumber.init(value: 99.999), urls: []),
    RecognizedCelebrity(name: "Samuel Obe", confidence: NSNumber.init(value: 99.999), urls: [])
]
