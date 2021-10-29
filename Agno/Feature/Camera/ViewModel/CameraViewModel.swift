//
//  CameraViewModel.swift
//  Agno
//
//  Created by Sam Obe on 8/19/21.
//

import AVFoundation
import SwiftUI
import UIKit

enum CameraState {
    case unchecked
    case running
    case stopped
}

class CameraViewModel: NSObject, ObservableObject {
    @Published var isPhotoTaken = false
    @Published var isFlashOn = false
    @Published var alert = false
    @Published var isChecked = false
    @Published var session = AVCaptureSession()
    @Published var output = AVCapturePhotoOutput()
    @Published var deviceInput : AVCaptureDeviceInput!
    @Published var preview : AVCaptureVideoPreviewLayer!
    @Published var imageData = Data(count: 0)
    @Published var state : CameraState = .unchecked
    @Published var cameraPostion : AVCaptureDevice.Position = .back
    
    override init() {
        super.init()
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            setUp(isToggle: false)
            return
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video, completionHandler: {
                (status) in
                if status {
                    self.setUp(isToggle: false)
                }
                else {
                    DispatchQueue.main.async {
                        self.alert.toggle()
                    }
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
    
    func setUp(isToggle: Bool){
        do {
            
            self.session.beginConfiguration()
            self.session.sessionPreset = .high
            
            if isToggle {
                self.session.removeInput(self.deviceInput)
            }
            
            guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: cameraPostion )
            else {
                DispatchQueue.main.async {
                    self.alert.toggle()
                }
                //print("Unable to access back camera!")
                return
            }
            
            
            let input = try AVCaptureDeviceInput(device: camera)
            
            if self.session.canAddInput(input)  {
                self.deviceInput = input
                self.session.addInput(input)
                
            }
            else{
                DispatchQueue.main.async {
                    self.alert.toggle()
                }
            }
            
            if !isToggle {
                if self.session.canAddOutput(output) {
                    self.session.addOutput(output)
                }
                else{
                    DispatchQueue.main.async {
                        self.alert.toggle()
                    }
                }
            }
            
            
            self.session.commitConfiguration()
            
            
        } catch  {
            DispatchQueue.main.async {
                self.alert.toggle()
            }
            //print(error.localizedDescription)
        }
    }
    
    func swapCamera() {
        let newPosition : AVCaptureDevice.Position = self.cameraPostion == .front ? .back : .front
        self.cameraPostion = newPosition
        self.setUp(isToggle: true)
    }
    
    
    func takePic(){
        let settings = AVCapturePhotoSettings()
        
        if self.isFlashOn {
            settings.flashMode = .on
        }
        else {
            settings.flashMode = .off
        }
        
        self.output.capturePhoto(with: settings, delegate: self)
        self.isPhotoTaken = true
    }
    
    func resetCamera(){
        if self.state == .stopped {
            self.session.startRunning()
            self.isPhotoTaken = false
            self.state = .running
        }
    }
    
    func startCamera(){
        if self.state == .stopped {
            self.session.startRunning()
            self.state = .running
        }
    }
    
    func stopCamera(){
        if self.state == .running {
            self.session.stopRunning()
            self.state = .stopped
        }
        
    }
    
}

/// Photo callback
extension CameraViewModel : AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        self.stopCamera()
        
        if error != nil {
            //print(error!)
            //print("Photo output error")
            return
        }
        
        guard let data = photo.fileDataRepresentation() else {
            return
        }
        self.imageData = data
        
        //print("image data captured")
    }
}

