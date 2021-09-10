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
    
    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            VStack{
                if !celebModel.celebs.isEmpty {
                    if #available(iOS 15.0, *) {
                        List{
                            ForEach(celebModel.celebs){ celeb in
                                ZStack {
                                    CelebrityCell(celeb: celeb)
                                    NavigationLink(destination: CelebrityDetailScreen(celeb: celeb)) {
                                        EmptyView()
                                    }.buttonStyle(.plain).hidden()
                                }.listRowInsets(EdgeInsets()).listRowBackground(Color("BackgroundColor"))
                                    .listRowSeparator(.hidden)
                                
                            }
                        }.listStyle(.plain)
                    }
                    else {
                        ScrollView {
                            LazyVStack {
                                ForEach(celebModel.celebs){ celeb in
                                    NavigationLink(destination: CelebrityDetailScreen(celeb: celeb)) {
                                            CelebrityCell(celeb: celeb)
                                    }
                                }
                            }
                        }.fixFlickering()
                    }
                    
                    
                }
                else {
                    if !celebModel.alert {
                        ProgressView()
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
