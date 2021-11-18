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
    @Published var lastZoomFactor: CGFloat = 1.0
    
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

    func selectCamera() -> AVCaptureDevice? {
        if let device = AVCaptureDevice.default(.builtInTripleCamera, for: .video, position: cameraPostion) {
            return device
        } else if let device = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: cameraPostion) {
            return device
        } else if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: cameraPostion) {
            return device
        }
        return nil
    }
    
    func setUp(isToggle: Bool){
        do {
            
            self.session.beginConfiguration()
            self.session.sessionPreset = .high
            
            if isToggle {
                self.session.removeInput(self.deviceInput)
            }
            
            guard let camera = selectCamera()
            else {
                DispatchQueue.main.async {
                    self.alert.toggle()
                }
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
            return
        }
        
        guard let data = photo.fileDataRepresentation() else {
            return
        }
        self.imageData = data
    }
}

/// Zoom Methods
extension CameraViewModel {
    
    /// Return zoom value between the minimum and maximum zoom values
    func minMaxZoom(_ factor: CGFloat) -> CGFloat {
        let minimumZoom: CGFloat = 1.0
        let maximumZoom: CGFloat = 3.0
        
        let device = self.deviceInput.device
        return min(min(max(factor, minimumZoom), maximumZoom), device.activeFormat.videoMaxZoomFactor)
    }
    
    func update(scale factor: CGFloat) {
        //print(factor)
        let device = self.deviceInput.device
        do {
            try device.lockForConfiguration()
            defer { device.unlockForConfiguration() }
            device.videoZoomFactor = factor
        } catch {
            print("\(error.localizedDescription)")
        }
    }
    
    func resetZoom() {
        self.lastZoomFactor = 1.0
        self.update(scale: 1.0)
    }
}

