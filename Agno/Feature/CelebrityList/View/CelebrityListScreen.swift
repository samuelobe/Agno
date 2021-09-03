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
                ScrollView{
                    LazyVStack{
                        ForEach(celebModel.celebs){
                            celeb in
                                CelebrityCell(celeb: celeb)
                        }
                    }
                }
            }
            else {
                ProgressView()
            }
        }.preferredColorScheme(.dark).onDisappear(perform: {
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
    }
}
