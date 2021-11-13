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
        let testID = "ca-app-pub-3940256099942544/2934735716"
        //let realID = "ca-app-pub-7426293309772583/9584732121"
        banner.adUnitID = testID
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
