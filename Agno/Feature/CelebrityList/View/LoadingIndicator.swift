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
            ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .white))
        }.frame(width: 200 , height: 200).background(Color("SectionColor"))
            .cornerRadius(15)
        .shadow(radius: 10)
    }
}

struct LoadingIndicator_Previews: PreviewProvider {
    static var previews: some View {
        LoadingIndicator()
    }
}
