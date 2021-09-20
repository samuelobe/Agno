//
//  CelebrityListScreenViewModel.swift
//  CelebrityListScreenViewModel
//
//  Created by Sam Obe on 8/27/21.
//

import Foundation
import UIKit


class CelebrityListViewModel: ObservableObject {
    @Published var imageData = Data(count: 0)
    @Published var celebs : [RecognizedCelebrity] = []
    @Published var alert = false
    @Published var didRecieveData = false
    private var recognitionAWS : CelebrityRecognition
    
    init(recognitionAWS aws : CelebrityRecognition) {
        self.recognitionAWS = aws
    }
    
    func getAWSData() {
        recognitionAWS.picData = (UIImage(data: self.imageData)?.jpegData(compressionQuality: 0.2))!
        recognitionAWS.sendImageToRekognition() {
            (celebData, alertData) in
            DispatchQueue.main.async {
                self.alert = alertData
                self.celebs = celebData
                
            }
            
            //print(celebData)
        }
    }
    
    func resetCelebs(){
        self.alert = false
        self.celebs = []
    }
}
