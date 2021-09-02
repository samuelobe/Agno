//
//  CameraView.swift
//  Agno
//
//  Created by Sam Obe on 8/19/21.
//

import SwiftUI
import AVFoundation

struct CameraScreen : View {
    @EnvironmentObject var camera: CameraViewModel
    @EnvironmentObject var celeb: CelebrityListViewModel
    
    @State private var showModal = false
    @State private var action: Int? = 0
    
    var isSim = Platform.isSimulator
    
    var body: some View {
        
        ZStack {
            
            if isSim {
                Color.gray
                Text("Camera View").foregroundColor(.white)
            }
            else{
                CameraPreview(camera: camera)
            }
            VStack{
                Spacer()
                ZStack {
                    Color.black.frame(height: 85, alignment: .center).opacity(0.75)
                    if self.camera.isPhotoTaken {
                        HStack{
                            
                            NavigationLink(destination: CelebrityListScreen(),
                                           tag: 1, selection: $action) {
                                Button(action: {
                                    self.celeb.imageData = self.camera.imageData
                                    self.celeb.getAWSData()
                                    self.action = 1
                                },
                                       label: {
                                    Image(systemName: "checkmark.square.fill").font(.system(size: 27.0)).foregroundColor(.white)
                                }).padding(.leading, 40)
                                
                            }
                            
                            Spacer()
                            Button(action: {
                                self.camera.resetCamera()
                            }, label: {
                                Image(systemName: "clear.fill").font(.system(size: 27.0)).foregroundColor(.white)
                            }).padding(.trailing, 40)
                        }
                    }
                    else {
                        HStack{
                            Button(action: {
                                
                            }, label: {
                                Image(systemName: "photo").font(.system(size: 27.0)).foregroundColor(.white)
                            }).padding(.leading, 40)
                            Spacer()
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                Image(systemName: "gearshape").font(.system(size: 27.0)).foregroundColor(.white)
                            }).padding(.trailing, 40)
                        }
                    }
                    
                }
            }
            if !self.camera.isPhotoTaken {
                CameraButton()
            }
        }.onAppear(perform: {
            if !self.camera.isChecked {
                self.camera.check()
                self.camera.isChecked.toggle()
            }
            
        }).ignoresSafeArea(.all ,edges: .all)
            .navigationBarHidden(true)
        
        
    }
    
}




struct Platform {
    static let isSimulator: Bool = {
        var isSim = false
#if targetEnvironment(simulator)
        isSim = true
#endif
        return isSim
    }()
}



//struct CameraView_Previews: PreviewProvider {
//    static var previews: some View {
//        CameraScreen(isSim: true)
//    }
//}
