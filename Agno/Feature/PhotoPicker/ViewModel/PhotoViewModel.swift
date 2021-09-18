//
//  PhotoViewModel.swift
//  PhotoViewModel
//
//  Created by ELeetDev on 9/17/21.
//

import Foundation
import UIKit

class PhotoViewModel: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ObservableObject {
    @Published var selectedImage = UIImage()
    @Published var selectedImageData = Data(count: 0)
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.selectedImage = image
            self.selectedImageData = image.pngData()!
            
            print("photo selected")
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }
    
    
}
