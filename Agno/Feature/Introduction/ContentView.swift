//
//  ContentView.swift
//  Agno
//
//  Created by Sam Obe on 8/19/21.
//

import SwiftUI

struct ContentView: View {
    @State private var action: Int? = 0
    @StateObject var camera = CameraViewModel()
    @StateObject var celeb = CelebrityListViewModel(recognitionAWS: CelebrityRecognition())
    @StateObject var launch = LaunchSettings()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.black).ignoresSafeArea()
                NavigationLink(
                    destination: CameraScreen(launch: launch),
                    tag: 1, selection: $action
                ) {}
            }
        }.onAppear(perform: {
            self.action = 1
        }).onAppear {
            AppDelegate.orientationLock = UIInterfaceOrientationMask.portrait
            UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
            UINavigationController.attemptRotationToDeviceOrientation()
        }
        
        .preferredColorScheme(.dark).environmentObject(camera).environmentObject(celeb).edgesIgnoringSafeArea(.all).navigationViewStyle(.stack)
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
