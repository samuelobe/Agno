//
//  CelebrityListScreen.swift
//  CelebrityListScreen
//
//  Created by Sam Obe on 8/27/21.
//

import SwiftUI
import AppTrackingTransparency
import AdSupport

struct CelebrityListScreen: View {
    @EnvironmentObject var celebModel : CelebrityListViewModel
    @EnvironmentObject var cameraModel : CameraViewModel
    @State var loadAds: Bool = false

    private let gridItems = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            VStack{
                if !celebModel.celebs.isEmpty {
                    
                    switch celebModel.celebs.count {
                    
                    case 1:
                        LargeCelebrityCell(celeb: celebModel.celebs[0])
                        
                    default:
                        ScrollView(.vertical, showsIndicators: false) {
                            LazyVGrid(columns: gridItems, spacing: 20) {
                                ForEach(celebModel.celebs){ celeb in
                                    CelebrityCell(celeb: celeb)

                                }
                            }
                        }
                    }
                }
                else {
                    if !celebModel.alert {
                        LoadingIndicator()
                    }
                    else {
                        Text(LocalizedStringKey("noCeleb"))
                    }
                    
                }
            }
            
            VStack {
                Spacer()
                if loadAds {
                    AdView().frame(width: 150, height: 50, alignment: .bottom)
                }
                
            }
        }.onAppear(perform: {
            ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                self.loadAds.toggle()
              })
            if !Platform.isSimulator && !self.celebModel.didRecieveData {
                self.celebModel.imageData = self.cameraModel.imageData
                self.celebModel.getAWSData()
                self.celebModel.didRecieveData.toggle()
            }
        })
            .preferredColorScheme(.dark)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(LocalizedStringKey("celebrities"))
    }
}

struct CelebrityListScreen_Previews: PreviewProvider {
    
    static func previewModel() -> CelebrityListViewModel {
        let model = CelebrityListViewModel(recognitionAWS: CelebrityRecognition())
        model.celebs = dummyData
        return model
    }
    static var previews: some View {
        CelebrityListScreen().environmentObject(previewModel()).environmentObject(CameraViewModel()).environmentObject(SettingsViewModel())
            .onAppear(perform: {}).previewDevice(PreviewDevice(rawValue: "iPhone 8"))
            .previewDisplayName("iPhone 8")
        CelebrityListScreen().environmentObject(previewModel()).environmentObject(CameraViewModel()).environmentObject(SettingsViewModel())
            .onAppear(perform: {}).previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            .previewDisplayName("iPhone 12")
        CelebrityListScreen().environmentObject(previewModel()).environmentObject(CameraViewModel()).environmentObject(SettingsViewModel())
            .onAppear(perform: {}).previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
            .previewDisplayName("iPhone 12 Pro Max")
    }
}
