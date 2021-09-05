//
//  CelebrityRecognition.swift
//  CelebrityRecognition
//
//  Created by Sam Obe on 8/23/21.
//

import Foundation
import AWSRekognition

class CelebrityRecognition : ObservableObject {
    private var rekognitionObject: AWSRekognition?
    @Published var picData = Data(count: 0)
    
    // MARK: - AWS Method
    func sendImageToRekognition(completion: @escaping (Set<RecognizedCelebrity>) -> Void)  {
        var celebList : Set<RecognizedCelebrity> = []
        
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
                let faces = result!.celebrityFaces
                if ((faces?.count)! > 0) {
                    for celeb in faces! {
                        // TODO: Figure out a way to extract faces and add to model, then present face in CelebrityCell
                        let recognizedCeleb = RecognizedCelebrity(name: celeb.name!, confidence: celeb.matchConfidence!, urls: celeb.urls ?? [])
                        celebList.insert(recognizedCeleb)
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
            completion(celebList)
            
        }
    }
    
}
