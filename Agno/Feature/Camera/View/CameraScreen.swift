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
    @State private var image: Image? = nil
    @State private var isFlashOn = false
    @State private var isImagePicked = false
    @State private var isShowPhotoLibrary = false
    
    var isSim = Platform.isSimulator
    
    func turnOffTorch()  {
        self.isFlashOn = false
        self.camera.toggleTorch(on: self.isFlashOn)
    }
    
    func toggleTorch() {
        self.isFlashOn.toggle()
        self.camera.toggleTorch(on: self.isFlashOn)
    }
    
    var body: some View {
        ZStack {
            ZStack {
                NavigationLink(destination: CelebrityListScreen(),
                               tag: 1, selection: $action){}
                if isSim {
                    Color.gray
                    Text("Camera View").foregroundColor(.white)
                    image?.resizable().scaledToFit()
                }
                else{
                    ZStack {
                        CameraPreview(camera: camera)
                        if self.isImagePicked {
                            Color.black
                            image?.resizable().scaledToFit()
                        }
                    }
                }
                VStack{
                    Spacer()
                    if self.camera.isPhotoTaken || self.isImagePicked  {
                        CameraBar(leftButtonIcon: "checkmark.square.fill", rightButtonIcon: "clear.fill", leftButtonAction: {
                            self.isImagePicked = false
                            self.action = 1
                        }, rightButtonAction: {
                            self.isImagePicked = false
                            self.camera.resetCamera()
                            
                        }, isCheck: true)
                    }
                    else {
                        CameraBar(leftButtonIcon: "photo.fill", rightButtonIcon: self.isFlashOn ? "bolt.slash.fill" : "bolt.fill", leftButtonAction: {
                            self.camera.stopCamera()
                            self.turnOffTorch()
                            self.isShowPhotoLibrary = true
                            
                        }, rightButtonAction: {
                            self.toggleTorch()
                        }, isCheck: false)
                    }
                }
                if !self.camera.isPhotoTaken && !self.isImagePicked  {
                    CameraButton(action: {
                        self.camera.takePic()
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                            self.turnOffTorch()
                        })
                    })
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
                            self.turnOffTorch()
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
            
        }.sheet(isPresented: $isShowPhotoLibrary, onDismiss: {
            self.camera.startCamera()
        }) {
            ImagePicker(sourceType: .photoLibrary, onImagePicked: {
                pickedImage in
                self.image = Image(uiImage: pickedImage)
                self.camera.imageData = pickedImage.pngData()!
                self.isImagePicked = true
                self.camera.stopCamera()
            })
        }
    }
    
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraScreen(launch: LaunchSettings(), isSim: true ).environmentObject(CameraViewModel()).environmentObject(CelebrityListViewModel(recognitionAWS: CelebrityRecognition()))
    }
}
