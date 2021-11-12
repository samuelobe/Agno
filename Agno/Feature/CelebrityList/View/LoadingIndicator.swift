//
//  LoadingIndicator.swift
//  LoadingIndicator
//
//  Created by Samuel Obe on 9/16/21.
//

import SwiftUI

struct LoadingIndicator: View {
    @State private var isLoading = false
    
    var body: some View {
        VStack {
            ProgressView().scaleEffect(1.25)
            Text("Analyzing Photo...").foregroundColor(.white).padding()
        }
    }
}

struct LoadingIndicator_Previews: PreviewProvider {
    static var previews: some View {
        LoadingIndicator().preferredColorScheme(.dark)
    }
}
