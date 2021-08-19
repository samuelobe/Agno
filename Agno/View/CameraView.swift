//
//  CameraView.swift
//  Agno
//
//  Created by Sam Obe on 8/19/21.
//

import SwiftUI
import AVFoundation

struct CameraView : View {
    @StateObject var camera = CameraViewModel()
    
    var body: some View {
        ZStack {
            CameraPreview(camera: camera).ignoresSafeArea(.all ,edges: .all)
            VStack{
                Spacer()
                ZStack {
                    Color.black.frame(height: 100, alignment: .center).opacity(0.5)
                    HStack{
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Image(systemName: "photo").font(.system(size: 27.0)).foregroundColor(.white)
                        }).padding(.leading, 40)
                        Spacer()
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Image(systemName: "gearshape").font(.system(size: 27.0)).foregroundColor(.white)
                        }).padding(.trailing, 40)
                    }
                }
            }.ignoresSafeArea()
            VStack {
                Spacer()
                HStack{
                    ZStack {
                        Button(action: {
                            camera.isPhotoTaken.toggle()
                            print(camera.isPhotoTaken)
                        }, label: {
                            Circle().fill(Color("ButtonColor")).frame(width: 70, height: 70, alignment: .center)
                        })
                        Circle().stroke(Color.white, lineWidth: 5).frame(width: 85, height: 85, alignment: .center)
                    }
                    
                }.padding()
            }
        }.onAppear(perform: {
            camera.check()
        })
    }
}

struct CameraPreview : UIViewRepresentable {
    @ObservedObject var camera : CameraViewModel
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        
        camera.preview = AVCaptureVideoPreviewLayer(session: camera.session)
        camera.preview.frame = view.frame
        camera.preview.videoGravity = .resizeAspect
        camera.preview.connection?.videoOrientation = .portrait
        
        view.layer.addSublayer(camera.preview)
        
        // Start camera session
        camera.session.startRunning()
        
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
