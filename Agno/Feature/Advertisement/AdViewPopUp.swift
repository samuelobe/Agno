//
//  AdViewPopUp.swift
//  Agno
//
//  Created by ELeetDev on 10/15/21.
//

import SwiftUI
import GoogleMobileAds

struct AdViewPopUp: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let banner = GADBannerView(adSize: kGADAdSizeFluid)
        banner.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        banner.rootViewController = UIApplication.shared.windows.first?.rootViewController
       
        banner.load(GADRequest())
        
        return banner
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

struct AdViewPopUp_Previews: PreviewProvider {
    static var previews: some View {
        AdViewPopUp()
    }
}
