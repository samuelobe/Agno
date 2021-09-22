//
//  ImageLoaderService.swift
//  ImageLoaderService
//
//  Created by ELeetDev on 9/19/21.
//

import Foundation
import SwiftUI

class ImageLoaderService: ObservableObject {
    @Published var image: UIImage = UIImage()
    @Published var invalidImage = true
    
    func loadImage(for urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data) ?? UIImage()
                self.invalidImage = false
            }
        }
        task.resume()
    }
    
}
