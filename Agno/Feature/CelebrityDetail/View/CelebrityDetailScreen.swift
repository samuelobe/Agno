//
//  DetailView.swift
//  Agno
//
//  Created by Sam Obe on 8/19/21.
//

import SwiftUI

struct CelebrityDetailScreen: View {
    var celeb : RecognizedCelebrity

    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
                            Image("SteveCarell")
                .resizable().aspectRatio(contentMode: .fill).ignoresSafeArea()
            
            
//            VStack {
//                ScrollView {
//                    HStack {
//                        Text("Full Name").foregroundColor(Color("SectionColor")).bold().font(.title3)
//                        Spacer()
//                    }.padding(EdgeInsets(top: 20, leading: 20, bottom: 1, trailing: 0))
//                    HStack {
//                        Text("Steve Carell").foregroundColor(Color(.white)).font(.title3)
//                        Spacer()
//                    }.padding(.leading, 20)
//                    HStack {
//                        Text("Birthday").foregroundColor(Color("SectionColor")).bold().font(.title3)
//                        Spacer()
//                    }.padding(EdgeInsets(top: 10, leading: 20, bottom: 1, trailing: 0))
//                    HStack {
//                        Text("♍️ 16 August 1962").foregroundColor(Color(.white)).font(.title3)
//                        Spacer()
//                    }.padding(.leading, 20)
//                    HStack {
//                        Text("Nationality").foregroundColor(Color("SectionColor")).bold().font(.title3)
//                        Spacer()
//                    }.padding(EdgeInsets(top: 10, leading: 20, bottom: 1, trailing: 0))
//                    HStack {
//                        Text("🇺🇸 US").foregroundColor(Color(.white)).font(.title3)
//                        Spacer()
//                    }.padding(.leading, 20)
//                    HStack {
//                        Text("Net Worth").foregroundColor(Color("SectionColor")).bold().font(.title3)
//                        Spacer()
//                    }.padding(EdgeInsets(top: 10, leading: 20, bottom: 1, trailing: 0))
//                    HStack {
//                        Text("💵 2.2 million").foregroundColor(Color(.white)).font(.title3)
//                        Spacer()
//                    }.padding(.leading, 20)
//                    Spacer()
//                }
//
//            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        CelebrityDetailScreen(celeb: RecognizedCelebrity(name: "Steve Carell", confidence: NSNumber.init(value: 99.99), urls: []))
    }
}
