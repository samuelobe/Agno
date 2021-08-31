////
////  DetailViewModel.swift
////  Agno
////
////  Created by Sam Obe on 8/20/21.
////
//
//import Foundation
//
//class CelebrityDetailViewModel: ObservableObject {
//    var celebName : String
//    
//    @Published var celebs = [Celebrity]()
//    
//    
//    init(celebName name  : String){
//        self.celebName = name
//    }
//    
//    func getCelebrity(){
//        let name = celebName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//        let url = URL(string: APIConstants.baseURL+name!)!
//        var request = URLRequest(url: url)
//        request.setValue(APIConstants.API_KEY, forHTTPHeaderField: "X-Api-Key")
//        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
//            guard let data = data else { return }
//            guard let celebsDecoded = try? JSONDecoder().decode([Celebrity].self, from: data) else {return}
//            
//            DispatchQueue.main.async {
//                self.celebs = celebsDecoded
//                print(self.celebs)
//            }
//        }
//        task.resume()
//    }
//    
//}
