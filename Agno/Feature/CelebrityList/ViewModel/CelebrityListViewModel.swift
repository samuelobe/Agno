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
    private var recognitionAWS = CelebrityRecognition()
    
    func getAWSData() {
        recognitionAWS.picData = (UIImage(data: self.imageData)?.jpegData(compressionQuality: 0.2))!
        recognitionAWS.sendImageToRekognition()
    }
}
