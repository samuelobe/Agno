//
//  LoadingIndicator.swift
//  LoadingIndicator
//
//  Created by ELeetDev on 9/16/21.
//

import SwiftUI

struct LoadingIndicator: View {
    var body: some View {
        VStack {
            Text("Analyzing Image...").foregroundColor(.white)
            ProgressView()
        }.frame(width: 200 , height: 200).background(Color("BackgroundColor"))
            .cornerRadius(15)
            .progressViewStyle(CircularProgressViewStyle(tint: .white))
        .shadow(radius: 10)
    }
}

struct LoadingIndicator_Previews: PreviewProvider {
    static var previews: some View {
        LoadingIndicator()
    }
}
