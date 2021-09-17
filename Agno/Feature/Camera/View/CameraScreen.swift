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
    @State private var isFlashOn = false
    
    var isSim = Platform.isSimulator
    
    var body: some View {
        ZStack {
            ZStack {
                NavigationLink(destination: CelebrityListScreen(),
                               tag: 1, selection: $action){}
                if isSim {
                    Color.gray
                    Text("Camera View").foregroundColor(.white)
                }
                else{
                    CameraPreview(camera: camera)
                }
                VStack{
                    Spacer()
                    if self.camera.isPhotoTaken {
                        CameraBar(leftButtonIcon: "checkmark.square.fill", rightButtonIcon: "clear.fill", leftButtonAction: {self.action = 1}, rightButtonAction: {self.camera.resetCamera()})
                    }
                    else {
                        CameraBar(leftButtonIcon: "photo.fill", rightButtonIcon: isFlashOn ? "bolt.slash.fill" : "bolt.fill", leftButtonAction: {}, rightButtonAction: {
                                isFlashOn.toggle()
                                self.camera.toggleTorch(on: isFlashOn)
                        })
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
