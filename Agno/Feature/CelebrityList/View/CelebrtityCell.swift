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
                            .overlay(
                                CelebrityText(text: celeb.name, confidence: celeb.confidence), alignment: .bottom
                            )
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
                            .overlay(
                                CelebrityText(text: celeb.name, confidence: celeb.confidence), alignment: .bottom
                            )
                    } else {
                        Image(systemName: "person.fill")
                            .resizable()
                            .foregroundColor(.white)
                            .scaledToFit()
                            .frame(width: 150, height: 225)
                            .background(Color.gray)
                            .overlay(CelebrityText(text: celeb.name, confidence: celeb.confidence), alignment: .bottom
                            )
                    }
                }
                
                
            }.cornerRadius(15).padding(.top, 15)
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

struct CelebrityText: View {
    var text : String
    var confidence : NSNumber
    @EnvironmentObject var settingsModel : SettingsViewModel
    
    var body: some View {
        VStack {
            Text(text).bold()
                .lineLimit(1)
                .foregroundColor(.white)
                .font(.caption)
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding(.bottom, 1)
            if settingsModel.displayConfidence {
                Text("Confidence: \(confidence.intValue)%")
                    .foregroundColor(.white)
                    .font(.caption2)
            }
        }
        .padding(12)
        .background(
            Blur(style: .systemUltraThinMaterialDark))
    }
}

struct CelebrityCell_Previews: PreviewProvider {
    static var previews: some View {
        CelebrityCell(celeb: RecognizedCelebrity(name: "Steve Carell", confidence: NSNumber.init(value: 99.99999), url: "", imageURL: ""), cellViewModel: CelebrityCellViewModel(loaderService: ImageLoaderService())).preferredColorScheme(.dark).environmentObject(SettingsViewModel())
    }
}
