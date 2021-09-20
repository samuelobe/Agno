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
    @State var image: UIImage = UIImage()
    @StateObject var imageLoader = ImageLoaderService()
    
    var body: some View {
        Button(action: {
            
            self.presentingSafariView = true
            
        }){
            Group {
                ZStack {
                    if celeb.imageURL != "" {
                        Image(uiImage: self.image)
                            .resizable()
                            .scaledToFit()
                            .onReceive(imageLoader.$image) { image in
                                self.image = image
                            }
                            .onAppear {
                                imageLoader.loadImage(for: celeb.imageURL)
                            }
                            .frame(width: 150)
                            .overlay(Text(celeb.name)
                            .foregroundColor(.white)
                            .font(.caption2)
                            .bold()
                            .padding()
                            .lineLimit(1)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(
                            Blur(style: .systemUltraThinMaterialDark)), alignment: .bottom)
                    } else {
                        Image(systemName: "person.fill")
                            .resizable()
                            .foregroundColor(.white)
                            .scaledToFit().frame(width: 150).overlay(Text(celeb.name)
                            .foregroundColor(.white)
                            .font(.caption2)
                            .bold()
                            .padding()
                            .lineLimit(1)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(
                            Blur(style: .systemUltraThinMaterialDark)), alignment: .bottom)
                    }
                    
                }.cornerRadius(15)
            }
        }
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
        CelebrityCell(celeb: RecognizedCelebrity(name: "Steve Carell", confidence: NSNumber.init(value: 99.99999), url: "", imageURL: "")).preferredColorScheme(.dark)
    }
}
