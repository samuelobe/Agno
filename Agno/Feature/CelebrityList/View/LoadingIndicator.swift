//
//  LoadingIndicator.swift
//  LoadingIndicator
//
//  Created by ELeetDev on 9/16/21.
//

import SwiftUI

struct LoadingIndicator: View {
    @State private var isLoading = false
    
    var body: some View {
        VStack {
            Text("Analyzing Image...").foregroundColor(.white).padding()
            ZStack {
                Circle()
                    .stroke(Color(.systemGray5), lineWidth: 16)
                Circle()
                    .trim(from: 0, to: 0.2)
                    .stroke(style: StrokeStyle(lineWidth: 8.0, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color("SectionColor"))
                    .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
            }
            .padding()
            .frame(width: 125, height: 125, alignment: .center)
                .drawingGroup()
                .onAppear() {
                    withAnimation(.linear(duration: 0.75).repeatForever(autoreverses: false)) {
                        self.isLoading.toggle()
                    }
            }
        }
    }
}

struct LoadingIndicator_Previews: PreviewProvider {
    static var previews: some View {
        LoadingIndicator().preferredColorScheme(.dark)
    }
}
