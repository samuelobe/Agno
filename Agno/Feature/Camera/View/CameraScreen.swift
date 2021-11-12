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
    @State private var isBackground = false
    
    var isSim = Platform.isSimulator
    
    var body: some View {
        
        let cameraPreview = CameraPreview(camera: camera)
        
        GeometryReader { reader in
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
                                cameraPreview
                                    .disabled(!launch.didLaunchBefore)
                            }
                            else {
                                CameraPermission()
                            }
                            
                            if self.isImagePicked {
                                Color("BackgroundColor")
                                image?.resizable().scaledToFit().cornerRadius(15).padding(50)
                            }
                            
                            
                        }
                    }
                    
                    VStack{
                        Rectangle()
                            .fill(Color.black)
                            .frame(width: UIScreen.main.bounds.width, height: reader.safeAreaInsets.top)
                            .opacity(0.25)
                        Spacer()
                        if self.camera.isPhotoTaken || self.isImagePicked  {
                            
                            if self.settings.swapButtons {
                                CameraBar(leftButtonIcon: "checkmark.square.fill", rightButtonIcon: "clear.fill", leftButtonAction: {
                                    self.camera.resetZoom()
                                    self.isImagePicked = false
                                    self.action = 1
                                }, rightButtonAction: {
                                    self.camera.resetZoom()
                                    self.isImagePicked = false
                                    self.camera.resetCamera()
                                }, isCheck: true).disabled(!launch.didLaunchBefore)
                            }
                            else {
                                CameraBar(leftButtonIcon: "clear.fill", rightButtonIcon: "checkmark.square.fill", leftButtonAction: {
                                    self.camera.resetZoom()
                                    self.isImagePicked = false
                                    self.camera.resetCamera()
                                }, rightButtonAction: {
                                    self.camera.resetZoom()
                                    self.isImagePicked = false
                                    self.action = 1
                                }, isCheck: true).disabled(!launch.didLaunchBefore)
                            }
                        }
                        else {
                            CameraBar(leftButtonIcon: "photo.fill", rightButtonIcon: self.camera.isFlashOn ? "bolt.fill" : "bolt.slash.fill", leftButtonAction: {
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
                    self.celeb.resetCelebs()
                    self.camera.resetCamera()
                    self.celeb.didRecieveData = false
                })
                .navigationBarHidden(true)
                .ignoresSafeArea(.all ,edges: .all)
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification )) {
                    _ in
                    //print("moving to background")
                    if !camera.isPhotoTaken {
                        DispatchQueue.main.async {
                            self.camera.stopCamera()
                            self.isBackground = true
                        }
                        
                    }
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification )) {
                    _ in
                    //print("user returned to app")
                    if !camera.isPhotoTaken {
                        DispatchQueue.main.async {
                            self.isBackground = false
                            self.camera.startCamera()
                            
                        }
                    }
                }
                if !launch.didLaunchBefore {
                    WelcomeCard(action: {launch.didLaunchBefore.toggle()})
                }
                if !self.camera.isPhotoTaken && !self.isImagePicked && !self.camera.alert  {
                    VStack {
                        HStack {
                            Spacer()
                            SettingsButton(){
                                self.isSettings.toggle()
                            }.disabled(!launch.didLaunchBefore)
                            
                        }.padding()
                        HStack {
                            Spacer()
                            SwapCameraButton(){
                                self.camera.resetZoom()
                                self.camera.swapCamera()
                            }.disabled(!launch.didLaunchBefore)
                            
                        }.padding()
                        Spacer()
                    }
                }

                
            }.sheet(isPresented: $isShowPhotoLibrary) {
                ImagePicker(sourceType: .photoLibrary, onImagePicked: {
                    pickedImage in
                    self.image = Image(uiImage: pickedImage)
                    self.camera.imageData = pickedImage.pngData()!
                    self.isImagePicked = true
                })
            }
            .sheet(isPresented: $isSettings) {
                SettingsScreen()
            }
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
