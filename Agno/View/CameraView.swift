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
    var isPreview = Platform.isSimulator
    @State private var action: Int? = 0
    
    
    var body: some View {
        
        ZStack {
            
            if isPreview {
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
            }
            VStack {
                Spacer()
                HStack{
                    ZStack {
                        NavigationLink(destination: DetailView(), tag: 1, selection: $action) {
                            Button(action: {
                                camera.isPhotoTaken.toggle()
                                self.action = 1
                            }, label: {
                                Circle().fill(Color("ButtonColor")).frame(width: 70, height: 70, alignment: .center)
                            })
                        }.navigationBarBackButtonHidden(true)
                        
                        Circle().stroke(Color.white, lineWidth: 5).frame(width: 85, height: 85, alignment: .center)
                    }
                    
                }.padding(.bottom, 40)
            }
        }.onAppear(perform: {
            camera.check()
        }).ignoresSafeArea(.all ,edges: .all)
        
        
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
        CameraView(isPreview: true)
    }
}
