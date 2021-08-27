//
//  CameraViewModel.swift
//  Agno
//
//  Created by Sam Obe on 8/19/21.
//

import AVFoundation
import SwiftUI
import UIKit
import AWSRekognition

class CameraViewModel: NSObject,ObservableObject, AVCapturePhotoCaptureDelegate {
    @Published var isPhotoTaken = false
    @Published var alert = false
    @Published var session = AVCaptureSession()
    @Published var output : AVCapturePhotoOutput!
    @Published var preview : AVCaptureVideoPreviewLayer!
    @Published var picData = Data(count: 0)
    private var rekognitionObject: AWSRekognition?
    
    func check(){
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                setUp()
                return
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video, completionHandler: {
                    (status) in if status {
                        self.setUp()
                    }
                })
                return
            case .denied:
                self.alert.toggle()
                return
            default:
                return
            }
    }
    
    func setUp(){
        do {
            self.session.beginConfiguration()
            self.session.sessionPreset = .high
            
            guard let backCamera = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back )
            else {
                print("Unable to access back camera!")
                return
            }
            
            let input = try AVCaptureDeviceInput(device: backCamera)
            output = AVCapturePhotoOutput()
            if self.session.canAddInput(input) && self.session.canAddOutput(output){
                self.session.addInput(input)
                self.session.addOutput(output)
                
            }
            
            self.session.commitConfiguration()
            
        } catch  {
            print(error.localizedDescription)
        }
        
       
    }
    
    func takePic(){
        self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
        
        DispatchQueue.global(qos: .background).async {
            self.session.stopRunning()

            DispatchQueue.main.async {
                self.isPhotoTaken.toggle()
            }
        }
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        if error != nil {
            print(error?.localizedDescription ?? "Camera Output Error")
            return
        }
        
        guard let imageData = photo.fileDataRepresentation() else {return}
        self.picData = (UIImage(data: imageData)?.jpegData(compressionQuality: 0.2))!
        
        //sendImageToRekognition()
        
        print("photo taken")
        
    }
    
    
    // MARK: - AWS Methods
    
    func sendImageToRekognition(){
        rekognitionObject = AWSRekognition.default()
        let celebImageAWS = AWSRekognitionImage()
        celebImageAWS?.bytes = self.picData
        let celebRequest = AWSRekognitionRecognizeCelebritiesRequest()
        celebRequest?.image = celebImageAWS
        
        rekognitionObject?.recognizeCelebrities(celebRequest!){
            (result, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            if result != nil {
                print(result!)
                if ((result!.celebrityFaces?.count)! > 0) {
                    for (_, celebFace) in result!.celebrityFaces!.enumerated() {
                        if celebFace.matchConfidence!.intValue > 50 {
                            print(celebFace.name!)
                        }
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
