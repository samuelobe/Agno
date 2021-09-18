//
//  CelebrityCell.swift
//  CelebrityCell
//
//  Created by Sam Obe on 9/1/21.
//

import SwiftUI
import BetterSafariView

struct CelebrityCell: View {
    let celeb : RecognizedCelebrity
    @State private var presentingSafariView = false
    
    var body: some View {
        Button(action: {
            
            self.presentingSafariView = true
            
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
            .if(celeb.url != "") {
                view in view.safariView(isPresented: $presentingSafariView) {
                    SafariView(
                        url: URL(string: celeb.url)!,
                        configuration: SafariView.Configuration(
                            entersReaderIfAvailable: false,
                            barCollapsingEnabled: true
                        )
                    )
                        .preferredBarAccentColor(.clear)
                        .preferredControlAccentColor(.accentColor)
                        .dismissButtonStyle(.done)
                }
            }
        
    }
}

struct CelebrityCell_Previews: PreviewProvider {
    static var previews: some View {
        CelebrityCell(celeb: RecognizedCelebrity(name: "Samuel Obe", confidence: NSNumber.init(value: 99.99999), url: ""))
    }
}
