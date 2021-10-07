//
//  CelebrityCellViewModel.swift
//  CelebrityCellViewModel
//
//  Created by Samuel Obe on 9/22/21.
//

import Foundation
import UIKit

class CelebrityCellViewModel: ObservableObject {
    @Published var image: UIImage = UIImage()
    @Published var invalidImage = true
    @Published var isLoaded = false
    
    private var service : ImageLoaderService
    
    init(loaderService : ImageLoaderService){
        self.service = loaderService
    }
    
    func retrieveImage(for urlString: String){
        service.loadImage(urlString) { image in
            if image.size.height != 0 {
                self.image = image
                self.invalidImage = false
                
            }
            self.isLoaded = true
        }
        
    }
    
    
    
}
