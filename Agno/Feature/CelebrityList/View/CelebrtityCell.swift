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
            Image(systemName: "person.crop.square").resizable().frame(width: 75, height: 75).padding()
            VStack(alignment: .leading, spacing: 10) {
                Text(celeb.name).font(.system(size: 26, weight: .bold, design: .default))
                    .foregroundColor(.white)
                Text("Confidence: "+celeb.confidence.stringValue.prefix(5)).foregroundColor(.white)
            }.padding(EdgeInsets(top: 20, leading: 40, bottom: 20, trailing: 40))
            
        }.frame(maxWidth: .infinity,  alignment: .center).background(Color.gray).cornerRadius(20).padding(10)
    }
    

}

struct CelebrityCell_Previews: PreviewProvider {
    static var previews: some View {
        CelebrityCell(celeb: RecognizedCelebrity(name: "Samuel Obe", confidence: NSNumber.init(value: 99.99999), urls: []))
    }
}
