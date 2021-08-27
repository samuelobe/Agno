//
//  CelebrityRecognition.swift
//  CelebrityRecognition
//
//  Created by Sam Obe on 8/23/21.
//

import Foundation
import AWSRekognition

class CelebrityRecognition {
    private var rekognitionObject: AWSRekognition?
    @Published var picData = Data(count: 0)
    
    // MARK: - AWS Method
    func sendImageToRekognition(){
        rekognitionObject = AWSRekognition.default()
        let celebImageAWS = AWSRekognitionImage()
        celebImageAWS?.bytes = self.picData
        print("AWS Image Created")
        let celebRequest = AWSRekognitionRecognizeCelebritiesRequest()
        celebRequest?.image = celebImageAWS
        print("Request Created")
        rekognitionObject?.recognizeCelebrities(celebRequest!){
            (result, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            if result != nil {
                //print(result!)
                let faces = result!.celebrityFaces
                if ((faces?.count)! > 0) {
                    for celeb in faces! {
                        print(celeb.name! )
                        print(celeb.matchConfidence!)
                        print(celeb.urls!)
                    }

                    print("Celebs found")
                }
                else if ((result!.unrecognizedFaces?.count)! > 0) {
                    print("Other faces found")
                }
                else {
                    print("No faces found in picture")
                }
            }
            else {
                print("No result")
            }
        }
    }
    
}
