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
    
    @StateObject var cellViewModel = CelebrityCellViewModel(loaderService: ImageLoaderService())
    
    var body: some View {
        Button(action: {
            self.presentingSafariView = true
            
        }){
            ZStack {
                if !self.cellViewModel.isLoaded {
                    ZStack {
                        Color.gray
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .frame(width: 150, height: 225)
                            .overlay(Text(celeb.name)
                                .foregroundColor(.white)
                                .font(.caption2)
                                .bold()
                                .padding()
                                .lineLimit(1)
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .background(
                                Blur(style: .systemUltraThinMaterialDark)), alignment: .bottom)
                    }.frame(width: 150, height: 225)
                }
                else {
                    if !self.cellViewModel.invalidImage {
                        Image(uiImage: self.cellViewModel.image)
                            .resizable()
                            .scaledToFill()
                            .foregroundColor(.white)
                            .frame(width: 150, height: 225)
                            .clipped()
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
                            .scaledToFit()
                            .frame(width: 150, height: 225)
//                            .overlay(RoundedRectangle(cornerRadius: 15)
//                                .stroke(.gray, lineWidth: 3)
//                            )
                            .background(Color.gray)
                            .overlay(Text(celeb.name)
                            .foregroundColor(.white)
                            .font(.caption2)
                            .bold()
                            .padding()
                            .lineLimit(1)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(
                            Blur(style: .systemUltraThinMaterialDark)), alignment: .bottom)
                    }
                }
                
                
            }.cornerRadius(15)
        }
        .onAppear {
            cellViewModel.retrieveImage(for: celeb.imageURL)
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
        CelebrityCell(celeb: RecognizedCelebrity(name: "Steve Carell", confidence: NSNumber.init(value: 99.99999), url: "", imageURL: ""), cellViewModel: CelebrityCellViewModel(loaderService: ImageLoaderService())).preferredColorScheme(.dark)
    }
}
