//
//  ZoomView.swift
//  Agno
//
//  Created by ELeetDev on 10/25/21.
//

import Foundation
import UIKit

class ZoomView: UIView {
    
    var minimumZoom: CGFloat = 1.0
    var maximumZoom: CGFloat = 3.0
    var lastZoomFactor: CGFloat = 1.0
    var camera : CameraViewModel
    
    init(camera : CameraViewModel){
        self.camera = camera
        super.init(frame: UIScreen.main.bounds)
        let pinchRecognizer = UIPinchGestureRecognizer(target: self, action:#selector(pinch(_:)))
        addGestureRecognizer(pinchRecognizer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Return zoom value between the minimum and maximum zoom values
    func minMaxZoom(_ factor: CGFloat) -> CGFloat {
        let device = camera.deviceInput.device
        return min(min(max(factor, minimumZoom), maximumZoom), device.activeFormat.videoMaxZoomFactor)
    }

    func update(scale factor: CGFloat) {
        let device = camera.deviceInput.device
        do {
            try device.lockForConfiguration()
            defer { device.unlockForConfiguration() }
            device.videoZoomFactor = factor
        } catch {
            print("\(error.localizedDescription)")
        }
    }
    
    @objc func pinch(_ pinch: UIPinchGestureRecognizer) {
        
        let newScaleFactor = minMaxZoom(pinch.scale * lastZoomFactor)

        switch pinch.state {
        case .began: fallthrough
        case .changed: update(scale: newScaleFactor)
        case .ended:
            lastZoomFactor = minMaxZoom(newScaleFactor)
            update(scale: lastZoomFactor)
        default: break
        }
    }
}
