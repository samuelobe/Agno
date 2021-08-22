//
//  CameraViewModel.swift
//  Agno
//
//  Created by Sam Obe on 8/19/21.
//

import AVFoundation

class CameraViewModel: ObservableObject {
    @Published var isPhotoTaken = false
    @Published var alert = false
    @Published var session = AVCaptureSession()
    @Published var output = AVCapturePhotoOutput()
    @Published var preview : AVCaptureVideoPreviewLayer!
    
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
        self.session.beginConfiguration()
        self.session.sessionPreset = .high
        
        guard let backCamera = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back )
        else {
            print("Unable to access back camera!")
            return
        }
        
        do {
            
            let input = try AVCaptureDeviceInput(device: backCamera)
            
            if self.session.canAddInput(input) && self.session.canAddOutput(output){
                self.session.addInput(input)
                self.session.addOutput(output)
            }
            self.session.commitConfiguration()
            
        } catch  {
            print(error.localizedDescription)
        }
        
        
        
    }
}
