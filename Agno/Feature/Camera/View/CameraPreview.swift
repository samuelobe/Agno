//
//  CameraPreview.swift
//  Agno
//
//  Created by Sam Obe on 8/19/21.
//

import AVFoundation
import SwiftUI

struct CameraPreview : UIViewRepresentable {
    @ObservedObject var camera : CameraViewModel
    
    func makeUIView(context: Context) -> UIView {
        let view = ZoomView(camera: camera)

        camera.preview = AVCaptureVideoPreviewLayer(session: camera.session)
        camera.preview.frame = view.frame
        camera.preview.videoGravity = .resizeAspectFill
        camera.preview.connection?.videoOrientation = .portrait
        
        view.layer.addSublayer(camera.preview)
        
        // Start camera session
        camera.session.startRunning()
        camera.state = .running
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    
    
    
}
