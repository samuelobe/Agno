//
//  CelebrityListScreen.swift
//  CelebrityListScreen
//
//  Created by Sam Obe on 8/27/21.
//

import SwiftUI

struct CelebrityListScreen: View {
    @EnvironmentObject var celebModel : CelebrityListViewModel
    @EnvironmentObject var cameraModel : CameraViewModel
    
    
    private let gridItems = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            VStack{
                if !celebModel.celebs.isEmpty {
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns: gridItems, spacing: 20) {
                            ForEach(celebModel.celebs){ celeb in
                                CelebrityCell(celeb: celeb)

                            }
                        }
                    }.fixFlickering()
                }
                else {
                    if !celebModel.alert {
                        LoadingIndicator()
                    }
                    else {
                        Text("No celebrity faces found in picture")
                    }
                    
                }
            }
        }.onAppear(perform: {
            if !Platform.isSimulator && !self.celebModel.didRecieveData {
                self.celebModel.imageData = self.cameraModel.imageData
                self.celebModel.getAWSData()
                self.celebModel.didRecieveData.toggle()
            }
        })
            .preferredColorScheme(.dark)
        
    }
}

struct CelebrityListScreen_Previews: PreviewProvider {
    
    static func previewModel() -> CelebrityListViewModel {
        let model = CelebrityListViewModel(recognitionAWS: CelebrityRecognition())
        model.celebs = dummyData
        return model
    }
    static var previews: some View {
        CelebrityListScreen().environmentObject(previewModel()).environmentObject(CameraViewModel())
            .onAppear(perform: {})
    }
}
