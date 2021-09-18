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
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack {
                    ZStack {
                        Image("SteveCarell")
                            .resizable()
                            .scaledToFit()
                        ZStack {
                            VStack() {
                                Spacer()
                                Text("Steve Carell, 59").font(.title3).bold().padding() .frame(minWidth: 0, maxWidth: .infinity)
                                    .background(Blur(style: .systemUltraThinMaterialDark))

                            }
                        }
                    }.cornerRadius(15).padding()
                    
                    VStack(spacing: 10) {
                        
                        HStack {
                            Text("Birthday").foregroundColor(Color("SectionColor")).bold().font(.title3)
                            Spacer()
                        }
                        HStack {
                            Text("♍️ 16 August 1962").font(.title3)
                            Spacer()
                        }
                        HStack {
                            Text("Nationality").foregroundColor(Color("SectionColor")).bold().font(.title3)
                            Spacer()
                        }
                        HStack {
                            Text("🇺🇸 US").font(.title3)
                            Spacer()
                        }
                        HStack {
                            Text("Net Worth").foregroundColor(Color("SectionColor")).bold().font(.title3)
                            Spacer()
                        }
                        HStack {
                            Text("💵 2.2 million").font(.title3)
                            Spacer()
                        }
                        Spacer()
                    }.padding(.horizontal)
                }
            }.fixFlickering()
        }.preferredColorScheme(.dark)
    }
}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        CelebrityDetailScreen(celeb: RecognizedCelebrity(name: "Steve Carell", confidence: NSNumber.init(value: 99.99), url: ""))
    }
}
