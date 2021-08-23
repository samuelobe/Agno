//
//  CameraView.swift
//  Agno
//
//  Created by Sam Obe on 8/19/21.
//

import SwiftUI
import AVFoundation

struct CameraScreen : View {
    @StateObject var camera = CameraViewModel()
//    @StateObject var detail = CelebrityDetailViewModel(celebName: "Michael Jordan")
    
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
                        NavigationLink(destination: CelebrityDetailScreen(), tag: 1, selection: $action) {
                            Button(action: {
                                camera.isPhotoTaken.toggle()
                                self.action = 1
                                
                                
                            }, label: {
                                Circle().fill(Color("ButtonColor")).frame(width: 70, height: 70, alignment: .center)
                            }).sheet(isPresented: $showModal) {
                                ModalView(showModal: self.$showModal)
                            }
                        }.navigationBarBackButtonHidden(true)
                        
                        Circle().stroke(Color.white, lineWidth: 5).frame(width: 85, height: 85, alignment: .center)
                    }
                    
                }.padding(.bottom, 40)
            }
        }.onAppear(perform: {
            camera.check()
        }).ignoresSafeArea(.all ,edges: .all)
            //.environmentObject(detail)
        
        
    }
    
}

struct ModalView: View {
    @Binding var showModal: Bool
    
    var body: some View {
        Text("Modal view")
        Button("Dismiss") {
            self.showModal.toggle()
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
        CameraScreen(isSim: true)
    }
}
