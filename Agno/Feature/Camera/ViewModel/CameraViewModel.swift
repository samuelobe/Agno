//
//  CameraViewModel.swift
//  Agno
//
//  Created by Sam Obe on 8/19/21.
//

import AVFoundation
import SwiftUI
import UIKit

class CameraViewModel: NSObject, ObservableObject {
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
            
            guard let backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back )
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
        self.isPhotoTaken = true
        print("photo captured")
    }
    
    func resetCamera(){
        self.session.startRunning()
        self.isPhotoTaken = false
    }
    
    func startCamera(){
        self.session.startRunning()
    }
    
    func stopCamera(){
        self.session.stopRunning()
    }
}

extension CameraViewModel : AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        self.session.stopRunning()
        
        if error != nil {
            print("Photo output error")
            return
        }
        
        guard let data = photo.fileDataRepresentation() else {
            print("Data representation error")
            return}
        self.imageData = data
        
        print("image data captured")
    }
}
