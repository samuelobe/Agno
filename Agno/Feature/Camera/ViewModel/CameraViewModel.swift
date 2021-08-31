//
//  CameraViewModel.swift
//  Agno
//
//  Created by Sam Obe on 8/19/21.
//

import AVFoundation
import SwiftUI
import UIKit

class CameraViewModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {
    @Published var isPhotoTaken = false
    @Published var alert = false
    @Published var isChecked = false
    @Published var session = AVCaptureSession()
    @Published var output : AVCapturePhotoOutput!
    @Published var preview : AVCaptureVideoPreviewLayer!
    @Published var imageData = Data(count: 0)
    
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
                self.alert.toggle()
                print("Unable to access back camera!")
                return
            }
            
            let input = try AVCaptureDeviceInput(device: backCamera)
            output = AVCapturePhotoOutput()
            
            if self.session.canAddInput(input) && self.session.canAddOutput(output) {
                self.session.addInput(input)
                self.session.addOutput(output)
            }
            else {
                print("Cannot add input and output")
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
                self.isPhotoTaken = true
            }
        }
    }
    
    func resetCamera(){
        DispatchQueue.global(qos: .background).async {
            self.session.startRunning()

            DispatchQueue.main.async {
                self.isPhotoTaken = false
            }
        }
    }
    
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        if error != nil {
            print(error?.localizedDescription ?? "Camera Output Error")
            return
        }
        print("photo taken")
        
        guard let data = photo.fileDataRepresentation() else {return}
        self.imageData = data
        
        print("image data captured")
    }
    
    
    
    

}
