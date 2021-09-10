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
        VStack{
            if !celebModel.celebs.isEmpty {
                List{
                    ForEach(celebModel.celebs){ celeb in
                        ZStack {
                            CelebrityCell(celeb: celeb)
                            NavigationLink(destination: CelebrityDetailScreen(celeb: celeb)) {
                                    EmptyView()
                            }.buttonStyle(.plain)
                        }.listRowInsets(EdgeInsets())
                    }
                }.listStyle(.plain)
            }
            else {
                if !celebModel.alert {
                    ProgressView()
                }
                else {
                    Text("No celebrity faces found in picture")
                }
                
            }
        }.preferredColorScheme(.dark)
            .onAppear(perform: {
                if !Platform.isSimulator {
                    self.celebModel.imageData = self.cameraModel.imageData
                    self.celebModel.getAWSData()
                }

            })
            .onDisappear(perform: {
                self.celebModel.resetCelebs()
                self.cameraModel.resetCamera()
            })
    }
}

struct CelebrityListScreen_Previews: PreviewProvider {

    static func previewModel() -> CelebrityListViewModel {
        let model = CelebrityListViewModel()
        model.celebs = dummyData
        return model
    }
    static var previews: some View {
        CelebrityListScreen().environmentObject(previewModel()).environmentObject(CameraViewModel())
                    .onAppear(perform: {})
    }
}
