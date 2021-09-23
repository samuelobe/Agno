//
//  Extensions.swift
//  Extensions
//
//  Created by ELeetDev on 9/10/21.
//

import SwiftUI


//extension ScrollView {
//    
//    public func fixFlickering() -> some View {
//        
//        return self.fixFlickering { (scrollView) in
//            
//            return scrollView
//        }
//    }
//    
//    public func fixFlickering<T: View>(@ViewBuilder configurator: @escaping (ScrollView<AnyView>) -> T) -> some View {
//        
//        GeometryReader { geometryWithSafeArea in
//            GeometryReader { geometry in
//                configurator(
//                ScrollView<AnyView>(self.axes, showsIndicators: self.showsIndicators) {
//                    AnyView(
//                    VStack {
//                        self.content
//                    }
//                    .padding(.top, geometryWithSafeArea.safeAreaInsets.top)
//                    .padding(.bottom, geometryWithSafeArea.safeAreaInsets.bottom)
//                    .padding(.leading, geometryWithSafeArea.safeAreaInsets.leading)
//                    .padding(.trailing, geometryWithSafeArea.safeAreaInsets.trailing)
//                    )
//                }
//                )
//            }
//            .edgesIgnoringSafeArea(.all)
//        }
//    }
//}

extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}



extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
