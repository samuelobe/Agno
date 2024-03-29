//
//  ImageLoaderService.swift
//  ImageLoaderService
//
//  Created by Samuel Obe on 9/19/21.
//

import Foundation
import SwiftUI

class ImageLoaderService {
    
    func loadImage(_ urlString: String, completionHandler: @escaping (UIImage) -> Void ) {
        guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else {
            completionHandler(UIImage())
            return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                return
            }
            guard let data = data else {
                completionHandler(UIImage())
                return }
            DispatchQueue.main.async {
                
                completionHandler(UIImage(data: data) ?? UIImage())
            }
        }
        task.resume()
    }
    
}
