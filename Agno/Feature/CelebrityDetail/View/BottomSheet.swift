//
//  BottomSheet.swift
//  BottomSheet
//
//  Created by ELeetDev on 9/10/21.
//

import SwiftUI

struct BottomSheet: UIViewRepresentable {
    var style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
}

