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
                                CameraPreview(camera: camera)
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
                    if !camera.isPhotoTaken {
                        DispatchQueue.main.async {
                            self.camera.stopCamera()
                            self.isBackground = true
                        }
                    }
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification )) {
                    _ in
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
                
                if !self.isImagePicked && !self.camera.alert  {
                    if !self.camera.isPhotoTaken  {
                        VStack {
                            HStack {
                                Spacer()
                                FunctionButton(icon: "gearshape.fill", iconSize: 30 ){
                                    self.isSettings.toggle()
                                }.disabled(!launch.didLaunchBefore)
                            }.padding()
                            HStack {
                                Spacer()
                                FunctionButton(icon: "arrow.triangle.2.circlepath.camera.fill", iconSize: 25){
                                    self.camera.resetZoom()
                                    self.camera.swapCamera()
                                }.disabled(!launch.didLaunchBefore)
                            }.padding()
                            Spacer()
                        }
                    }
                    else {
                        VStack {
                            HStack {
                                Spacer()
                                FunctionButton(icon: "arrowshape.turn.up.forward.fill", iconSize: 25 ){
                                    self.shareSheet()
                                }.disabled(!launch.didLaunchBefore)
                            }.padding()
                            Spacer()
                        }
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
    
    
    func shareSheet() {
           guard let image = (UIImage(data: camera.imageData)?.jpegData(compressionQuality: 0.5)) else { return }
           let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
           UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
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
