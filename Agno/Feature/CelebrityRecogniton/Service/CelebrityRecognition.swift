//
//  CelebrityRecognition.swift
//  CelebrityRecognition
//
//  Created by Sam Obe on 8/23/21.
//

import Foundation
import Combine
import AWSRekognition

typealias JSONDictionary = [String:Any]


class CelebrityRecognition : ObservableObject {
    private var rekognitionObject: AWSRekognition?
    private let celebImageAWS = AWSRekognitionImage()
    private let celebRequest = AWSRekognitionRecognizeCelebritiesRequest()
    @Published var picData = Data(count: 0)
    
    // MARK: - AWS Method
    func sendImageToRekognition(completionHandler: @escaping ([RecognizedCelebrity], Bool) -> Void)  {
        var celebList : [RecognizedCelebrity] = []
        var alert = true
        let semaphore = DispatchSemaphore(value: 0)
        
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
                        var wikidataLink = ""
                        let https = "https://"
                        
                        if celebList.contains(where: {celebInList in celebInList.name == celeb.name}) {
                            continue
                        }
                        
                        for url in celeb.urls! {
                            if url.contains("imdb") {
                                link = url
                            }
                            else if url.contains("wikidata") {
                                link = url
                                wikidataLink = url
                            }
                        }
                        
                        if !link.contains(https){
                            link = https+link
                        }
                        
                        self.retrieveImageURL(wikidataLink) {
                            urlLink in
                            let recognizedCeleb = RecognizedCelebrity(name: celeb.name!, confidence: celeb.matchConfidence!,  url: link, imageURL: urlLink)
                            print(recognizedCeleb)
                            celebList.append(recognizedCeleb)
                            semaphore.signal()
                                
                        }
                        semaphore.wait()
                        
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
    
    func retrieveImageURL(_ link: String, imageURLCompletion: @escaping (String) -> Void){
        var finalURL = ""
        
        if let range = link.range(of: "Q") {
            let qCode = "Q"+link[range.upperBound...]
            
            let urlStr = "https://www.wikidata.org/w/api.php?action=wbgetclaims&property=P18&entity=\(qCode)&format=json"
            guard let url = URL(string: urlStr) else {
                imageURLCompletion(finalURL)
                return
            }

            let task = URLSession.shared.dataTask(with: url) {
                (data, response, error) in
                guard let safeData = data else {
                    imageURLCompletion(finalURL)
                    print(error!)
                    return
                    
                }
                do{
                    let json = try JSONSerialization.jsonObject(with: safeData, options: [])
                    guard let dictionary = json as? [String:Any] else {
                        imageURLCompletion(finalURL)
                        return}
                    guard let claims = dictionary["claims"] as? JSONDictionary else {
                        imageURLCompletion(finalURL)
                        return}
                    guard let p18 = claims["P18"] as? NSArray else {
                        imageURLCompletion(finalURL)
                        return}
                    guard let dictId = p18[0] as? JSONDictionary else {
                        imageURLCompletion(finalURL)
                        return}
                    guard let mainsnak = dictId["mainsnak"] as? JSONDictionary else {
                        imageURLCompletion(finalURL)
                        return}
                    guard let dataValue = mainsnak["datavalue"] as? JSONDictionary else {
                        imageURLCompletion(finalURL)
                        return}
                    guard let initialString = dataValue["value"] as? String else {
                        imageURLCompletion(finalURL)
                        return}
                    
                    let replacedString = initialString.replacingOccurrences(of: " ", with: "_")
                    let md5Data = MD5(string: replacedString)
                    let md5Hex =  md5Data.map { String(format: "%02hhx", $0) }.joined()
                    finalURL = "https://upload.wikimedia.org/wikipedia/commons/\(md5Hex[0])/\(md5Hex[0])\(md5Hex[1])/\(replacedString)"
                    
                    
                    // How can I make sure that this completion handler always return something even if there is an error
                    imageURLCompletion(finalURL)
                }
                catch{
                    imageURLCompletion(finalURL)
                    return
                }
                
            }
            
            task.resume()
        }
        else {
            imageURLCompletion(finalURL)
        }
        
    }
    
    
}
