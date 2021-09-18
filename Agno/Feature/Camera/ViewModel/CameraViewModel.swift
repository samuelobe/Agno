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
    @Published var alert = false
    @Published var isChecked = false
    @Published var session = AVCaptureSession()
    @Published var output : AVCapturePhotoOutput!
    @Published var preview : AVCaptureVideoPreviewLayer!
    @Published var imageData = Data(count: 0)
    @Published var state : CameraState = .unchecked {
        didSet {
            print(self.state)
        }
    }
        
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
}

extension CameraViewModel : AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        self.stopCamera()
        
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
