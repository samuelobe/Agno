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
    @StateObject var settings = SettingsViewModel()
    
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
        
        .preferredColorScheme(.dark).environmentObject(camera).environmentObject(celeb).environmentObject(settings).edgesIgnoringSafeArea(.all).navigationViewStyle(.stack)
    }
}
