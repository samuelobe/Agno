//
//  DetailViewModel.swift
//  Agno
//
//  Created by Sam Obe on 8/20/21.
//

import Foundation

class DetailViewModel: ObservableObject {
    var celebName : String
    
    @Published var celebs = [Celebrity]()
    
    private let API_KEY : String = "+aXdEaffVLmUnA1cFqEDjw==sTCEKkhasEI9lXYe"
    
    init(celebName name  : String){
        self.celebName = name
    }
    
    func getCelebrity(){
        let name = celebName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: "https://api.api-ninjas.com/v1/celebrity?name="+name!)!
        var request = URLRequest(url: url)
        request.setValue(API_KEY, forHTTPHeaderField: "X-Api-Key")
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data else { return }
            guard let celebsDecoded = try? JSONDecoder().decode([Celebrity].self, from: data) else {return}
            
            DispatchQueue.main.async {
                self.celebs = celebsDecoded
            }
            
            //print(celebsDecoded)
        }
        task.resume()
    }
    
}
