//
//  CelebrityCell.swift
//  CelebrityCell
//
//  Created by Sam Obe on 9/1/21.
//

import SwiftUI

struct CelebrityCell: View {
    let celeb : RecognizedCelebrity
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 10) {
                Text(celeb.name).font(.system(size: 26, weight: .bold, design: .default))
                    .foregroundColor(.white)
                    .lineLimit(1)
                Text("Confidence: "+celeb.confidence.stringValue.prefix(5)).foregroundColor(.white)
            }.padding()
            Spacer()
            Image(systemName: "chevron.right").foregroundColor(.white).font(.system(size: 25)).padding()
            
        }.frame(maxWidth: .infinity,  alignment: .center).background(Color("SectionColor")).cornerRadius(20).padding(EdgeInsets(top: 15, leading: 10, bottom: 15, trailing: 10))
        
        
    }
    
    
}

struct CelebrityCell_Previews: PreviewProvider {
    static var previews: some View {
        CelebrityCell(celeb: RecognizedCelebrity(name: "Samuel Obe", confidence: NSNumber.init(value: 99.99999), urls: []))
    }
}
