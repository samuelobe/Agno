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
    @Published var output : AVCapturePhotoOutput!
    @Published var deviceInput : AVCaptureDeviceInput!
    @Published var preview : AVCaptureVideoPreviewLayer!
    @Published var imageData = Data(count: 0)
    @Published var state : CameraState = .unchecked {
        didSet {
            print(self.state)
        }
    }
    
    @Published var cameraPostion : AVCaptureDevice.Position = .back
        
    func check(){
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                setUp()
                return
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video, completionHandler: {
                    (status) in
                    if status {
                        self.setUp()
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
    
    func setUp(){
        do {
            
            self.session.beginConfiguration()
            self.session.sessionPreset = .high
            
            guard let backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back )
            else {
                DispatchQueue.main.async {
                    self.alert.toggle()
                }
                print("Unable to access back camera!")
                return
            }
            
            
            let input = try AVCaptureDeviceInput(device: backCamera)
            output = AVCapturePhotoOutput()
            
            if self.session.canAddInput(input) && self.session.canAddOutput(output) {
                self.deviceInput = input
                self.session.addInput(input)
                self.session.addOutput(output)
            }
            else {
                print("Cannot add input and output")
            }

            self.session.commitConfiguration()
            
            
        } catch  {
            DispatchQueue.main.async {
                self.alert.toggle()
            }
            print(error.localizedDescription)
        }
    }
    
//    func swapCamera() {
//        do {
//
//            self.session.beginConfiguration()
//            self.session.sessionPreset = .high
//
//            guard let backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back )
//            else {
//                DispatchQueue.main.async {
//                    self.alert.toggle()
//                }
//                print("Unable to access back camera!")
//                return
//            }
//
//
//            let input = try AVCaptureDeviceInput(device: backCamera)
//            output = AVCapturePhotoOutput()
//
//            if self.session.canAddInput(input) && self.session.canAddOutput(output) {
//                self.session.addInput(input)
//                self.session.addOutput(output)
//            }
//            else {
//                DispatchQueue.main.async {
//                    self.alert.toggle()
//                }
//                print("Cannot add input and output")
//            }
//
//            self.session.commitConfiguration()
//
//
//        } catch  {
//            DispatchQueue.main.async {
//                self.alert.toggle()
//            }
//            print(error.localizedDescription)
//        }
//    }
    
    
    func takePic(){
        if self.isFlashOn {
            self.toggleTorch(on: true)
            self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {self.toggleTorch(on: false)})
        }
        else {
            self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
        }
        
        self.isPhotoTaken = true
        
        
        print("photo captured")
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
    

    
    func toggleTorch(on: Bool) {
        guard let device = AVCaptureDevice.default(for: .video) else { return }

        if device.hasTorch {
            do {
                try device.lockForConfiguration()

                if on {
                    device.torchMode = .on
                } else {
                    device.torchMode = .off
                }

                device.unlockForConfiguration()
            } catch {
                print("Torch could not be used")
            }
        } else {
            print("Torch is not available")
        }
    }
    
    func set(zoom: CGFloat){
        let factor = zoom < 1 ? 1 : zoom
        let device = self.deviceInput.device
        
        do {
            try device.lockForConfiguration()
            device.videoZoomFactor = factor
            device.unlockForConfiguration()
        }
        catch {
            print(error.localizedDescription)
        }
    }
}

extension CameraViewModel : AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        self.stopCamera()
        
        if error != nil {
            print(error!)
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
