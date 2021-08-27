//
//  ImageScreen.swift
//  ImageScreen
//
//  Created by Sam Obe on 8/23/21.
//

import SwiftUI

struct ImageScreen : View {
    @StateObject var camera = CameraViewModel()

    var body: some View {
        
        ZStack {
            // ADD IMAGE VIEW HERE
            VStack{
                Spacer()
                ZStack {
                    Color.black.frame(height: 85, alignment: .center).opacity(0.75)
                    HStack{
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Image(systemName: "checkmark.square.fill").font(.system(size: 27.0)).foregroundColor(.white)
                        }).padding(.leading, 40)
                        Spacer()
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Image(systemName: "clear.fill").font(.system(size: 27.0)).foregroundColor(.white)
                        }).padding(.trailing, 40)
                    }
                }
            }
            
        }.ignoresSafeArea(.all ,edges: .all)
        
        
    }
    
}

struct ImageScreen_Previews: PreviewProvider {
    static var previews: some View {
        ImageScreen()
    }
}
