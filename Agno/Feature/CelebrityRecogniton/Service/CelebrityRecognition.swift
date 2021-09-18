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
    private let celebImageAWS = AWSRekognitionImage()
    private let celebRequest = AWSRekognitionRecognizeCelebritiesRequest()
    @Published var picData = Data(count: 0)
    
    // MARK: - AWS Method
    func sendImageToRekognition(completionHandler: @escaping (Set<RecognizedCelebrity>, Bool) -> Void)  {
        var celebList : Set<RecognizedCelebrity> = []
        var alert = true
        
        rekognitionObject = AWSRekognition.default()
        
        celebImageAWS?.bytes = self.picData
        print("AWS pic data added")

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
                        var link = ""
                        let https = "https://"
                        
                        for url in celeb.urls! {
                            if url.contains("imdb") {
                                link = https+url
                            }
                            else if url.contains("wikidata") {
                                link = https+url
                            }
                        }
                        
                        
                        // TODO: Figure out a way to extract faces and add to model, then present face in CelebrityCell
                        let recognizedCeleb = RecognizedCelebrity(name: celeb.name!, confidence: celeb.matchConfidence!,  url: link)
                        celebList.insert(recognizedCeleb)
                        
                    }
                    alert = false
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
            completionHandler(celebList, alert)
            
        }
    }
    
}
