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
    
    let minimumZoom: CGFloat = 1.0
    let maximumZoom: CGFloat = 3.0
    var lastZoomFactor: CGFloat = 1.0
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        
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
