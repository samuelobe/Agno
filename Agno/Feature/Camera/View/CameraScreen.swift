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
    @EnvironmentObject var settings : SettingsViewModel
    @ObservedObject var launch : LaunchSettings
    
    @State private var action: Int? = 0
    @State private var image: Image? = nil
    

    @State private var isImagePicked = false
    @State private var isShowPhotoLibrary = false
    @State private var isSettings = false

    
    
    var isSim = Platform.isSimulator
    
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
                        if !self.camera.alert {
                            CameraPreview(camera: camera)
                        }
                        else {
                            CameraPermission()
                        }
                        
                        if self.isImagePicked {
                            Color("BackgroundColor")
                            image?.resizable().scaledToFit().cornerRadius(15).padding(25)
                        }
                    }
                }
                
                VStack{
                    HStack {
                        Spacer()
                        SettingsButton(){
                            self.camera.stopCamera()
                            self.isSettings.toggle()
                        }.disabled(!launch.didLaunchBefore)
                        
                    }.padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 20))
                    Spacer()
                    if self.camera.isPhotoTaken || self.isImagePicked  {
                        
                        if self.settings.swapButtons {
                            CameraBar(leftButtonIcon: "checkmark.square.fill", rightButtonIcon: "clear.fill", leftButtonAction: {
                                self.isImagePicked = false
                                self.action = 1
                            }, rightButtonAction: {
                                self.isImagePicked = false
                                self.camera.resetCamera()
                            }, isCheck: true).disabled(!launch.didLaunchBefore)
                        }
                        else {
                            CameraBar(leftButtonIcon: "clear.fill", rightButtonIcon: "checkmark.square.fill", leftButtonAction: {
                                self.isImagePicked = false
                                self.camera.resetCamera()
                            }, rightButtonAction: {
                                self.isImagePicked = false
                                self.action = 1
                            }, isCheck: true).disabled(!launch.didLaunchBefore)
                        }
                    }
                    else {
                        CameraBar(leftButtonIcon: "photo.fill", rightButtonIcon: self.camera.isFlashOn ? "bolt.fill" : "bolt.slash.fill", leftButtonAction: {
                            self.camera.stopCamera()
                            self.isShowPhotoLibrary = true
                            
                        }, rightButtonAction: {
                            self.camera.isFlashOn.toggle()
                        }, isCheck: false).disabled(!launch.didLaunchBefore)
                    }
                }
                
                
                
                if !self.camera.isPhotoTaken && !self.isImagePicked && !self.camera.alert  {
                    CameraButton(){
                        self.camera.takePic()
                    }.disabled(!launch.didLaunchBefore)
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
            .navigationBarHidden(true)
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
            
        }.sheet(isPresented: $isShowPhotoLibrary, onDismiss: {
            if !self.isImagePicked {
                self.camera.startCamera()
            }
            
        }) {
            ImagePicker(sourceType: .photoLibrary, onImagePicked: {
                pickedImage in
                self.image = Image(uiImage: pickedImage)
                self.camera.imageData = pickedImage.pngData()!
                self.isImagePicked = true
                self.camera.stopCamera()
            })
        }
        .sheet(isPresented: $isSettings, onDismiss: {
            self.camera.startCamera()
        } ) {
            SettingsScreen()
        }
    }
    
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraScreen(launch: LaunchSettings(), isSim: true ).environmentObject(CameraViewModel()).environmentObject(CelebrityListViewModel(recognitionAWS: CelebrityRecognition()))
            .environmentObject(SettingsViewModel())
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
            .previewDisplayName("iPhone 8")
        CameraScreen(launch: LaunchSettings(), isSim: true ).environmentObject(CameraViewModel()).environmentObject(CelebrityListViewModel(recognitionAWS: CelebrityRecognition()))
            .environmentObject(SettingsViewModel())
                    .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
                    .previewDisplayName("iPhone 12")
        CameraScreen(launch: LaunchSettings(), isSim: true ).environmentObject(CameraViewModel()).environmentObject(CelebrityListViewModel(recognitionAWS: CelebrityRecognition()))
            .environmentObject(SettingsViewModel())
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
            .previewDisplayName("iPhone 12 Pro Max")
    }
}
