//
//  ZoomView.swift
//  Agno
//
//  Created by ELeetDev on 10/25/21.
//

import Foundation
import UIKit

class ZoomView: UIView {
    
    var camera : CameraViewModel
    
    init(camera : CameraViewModel){
        self.camera = camera
        super.init(frame: UIScreen.main.bounds)
        let pinchRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinch(_:)))
        addGestureRecognizer(pinchRecognizer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func pinch(_ pinch: UIPinchGestureRecognizer) {
        let newScaleFactor = camera.minMaxZoom(pinch.scale * camera.lastZoomFactor)
        switch pinch.state {
            case .began: fallthrough
        case .changed: camera.update(scale: newScaleFactor)
            case .ended:
            camera.lastZoomFactor = camera.minMaxZoom(newScaleFactor)
            camera.update(scale: camera.lastZoomFactor)
            default: break
        }
    }
}

