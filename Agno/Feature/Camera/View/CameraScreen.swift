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
    @EnvironmentObject var celeb : CelebrityListViewModel
    @ObservedObject var launch : LaunchSettings
    
    @State private var action: Int? = 0
    
    var isSim = Platform.isSimulator
    
    var body: some View {
        ZStack {
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
                            CameraBar(leftButtonIcon: "photo", rightButtonIcon: "gearshape", leftButtonAction: {}, rightButtonAction: {})
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
                else {
                    self.celeb.resetCelebs()
                    self.camera.resetCamera()
                    self.celeb.didRecieveData = false
                }
                
            })
                .navigationBarBackButtonHidden(true)
                .ignoresSafeArea(.all ,edges: .all)
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification )) {
                    _ in
                    print("moving to background")
                    if !camera.isPhotoTaken {
                        DispatchQueue.main.async {
                            self.camera.stopCamera()
                        }
                        
                    }
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification )) {
                    _ in
                    print("user returned to app")
                    if !camera.isPhotoTaken {
                        DispatchQueue.main.async {
                            self.camera.startCamera()
                        }
                    }
                }
            if !launch.didLaunchBefore {
                WelcomeCard(action: {launch.didLaunchBefore.toggle()})
            }
            
        }
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



struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraScreen(launch: LaunchSettings(), isSim: true ).environmentObject(CameraViewModel()).environmentObject(CelebrityListViewModel(recognitionAWS: CelebrityRecognition()))
    }
}
