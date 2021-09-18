//
//  CelebrityCell.swift
//  CelebrityCell
//
//  Created by Sam Obe on 9/1/21.
//

import SwiftUI

struct CelebrityCell: View {
    let celeb : RecognizedCelebrity
    
    func openURL(_ urlString: String) {
        var urlString = urlString
        
        let https = "https://"
        if !urlString.contains(https) {
            urlString = https + urlString
        }
        guard let url = URL(string: urlString) else {
            return
        }
        UIApplication.shared.open(url, completionHandler: { success in
            if success {
                print("opened")
            } else {
                print("failed")
                // showInvalidUrlAlert()
            }
        })
    }
    
    var body: some View {
        Button(action: {
            if !celeb.urls.isEmpty{
                if celeb.imdbLink != "" {
                    openURL(celeb.imdbLink)
                }
                else if celeb.wikidataLink != "" {
                    openURL(celeb.wikidataLink)
                }
            }
            
        }){
            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(celeb.name).font(.system(size: 26, weight: .bold, design: .default))
                        .foregroundColor(.white)
                        .lineLimit(1)
                    Text("Confidence: "+celeb.confidence.stringValue.prefix(5)).foregroundColor(.white)
                }.padding()
                Spacer()
                Image(systemName: "chevron.right").foregroundColor(.white).font(.system(size: 25)).padding()
                
            }
        }.frame(maxWidth: .infinity,  alignment: .center).background(Color("SectionColor")).cornerRadius(20).padding(EdgeInsets(top: 15, leading: 10, bottom: 15, trailing: 10))
    }
}

struct CelebrityCell_Previews: PreviewProvider {
    static var previews: some View {
        CelebrityCell(celeb: RecognizedCelebrity(name: "Samuel Obe", confidence: NSNumber.init(value: 99.99999), imdbLink: "", wikidataLink: "", urls: []))
    }
}
