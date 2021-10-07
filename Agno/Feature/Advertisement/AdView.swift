//
//  AdView.swift
//  Agno
//
//  Created by Samuel Obe on 9/26/21.
//

import SwiftUI
import GoogleMobileAds

struct AdView: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let banner = GADBannerView(adSize: kGADAdSizeBanner)
        banner.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        banner.rootViewController = UIApplication.shared.windows.first?.rootViewController
       
        banner.load(GADRequest())
        
        return banner
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
}

//struct AdView_Previews: PreviewProvider {
//    static var previews: some View {
//        AdView().preferredColorScheme(.dark)
//    }
//}
