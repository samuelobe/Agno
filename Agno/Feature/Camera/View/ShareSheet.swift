//
//  ShareSheet.swift
//  Agno
//
//  Created by ELeetDev on 11/15/21.
//

import SwiftUI

struct ShareSheet: UIViewControllerRepresentable {
    var items : [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        
    }
}

//struct ShareSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        ShareSheet()
//    }
//}
