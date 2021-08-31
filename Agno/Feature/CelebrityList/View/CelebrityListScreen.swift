//
//  CelebrityListScreen.swift
//  CelebrityListScreen
//
//  Created by Sam Obe on 8/27/21.
//

import SwiftUI

struct CelebrityListScreen: View {
    @EnvironmentObject var celebModel : CelebrityListViewModel
    //@EnvironmentObject var cameraModel : CameraViewModel
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        VStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }.navigationBarTitle(Text("Detail View"), displayMode: .inline)
            .edgesIgnoringSafeArea(.bottom)
            // Hide the system back button
            .navigationBarBackButtonHidden(true)
            // Add your custom back button here
            .navigationBarItems(leading:
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                    //self.cameraModel.resetCamera()
                }) {
                    HStack {
                        Image(systemName: "arrow.left.circle")
                        Text("Go Back")
                    }
            })
        
    }
}

struct CelebrityListScreen_Previews: PreviewProvider {
    static var previews: some View {
        CelebrityListScreen()
    }
}
