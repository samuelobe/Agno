//
//  DetailView.swift
//  Agno
//
//  Created by Sam Obe on 8/19/21.
//

import SwiftUI

struct CelebrityDetailScreen: View {
    var celeb : RecognizedCelebrity
    
    @State var offset: CGFloat = 0
    @State var lastOffset: CGFloat = 0
    @GestureState var gestureEffect: CGFloat = 0
    
    var body: some View {
        ZStack {
            
            //            GeometryReader{proxy in
            //                let frame = proxy.frame(in: .global)
            //
            //                Image("SteveCarell")
            //                    .resizable()
            //                    .aspectRatio(contentMode: .fill)
            //                    .frame(width: frame.width, height: frame.height)
            //            }.ignoresSafeArea()
            
            Image("SteveCarell")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            
            GeometryReader{ proxy -> AnyView in
                let height = proxy.frame(in: .global).height
                return AnyView(
                    ZStack{
                        BottomSheet(style: .systemThinMaterialDark)
                            .clipShape(CustomCorner(corners: [.topLeft, .topRight], radius: 30))
                        VStack {
                            Capsule()
                                .fill(Color.white)
                                .frame(width: 40, height: 4)
                                .padding(.top, 20)
                            HStack {
                                Text("Steve Carell").foregroundColor(Color(.white)).font(.title).bold().padding(.leading, 10)
                                Spacer()
                            }.padding(.leading)
                            ScrollView {
                                HStack {
                                    Text("Birthday").foregroundColor(Color("SectionColor")).bold().font(.title3)
                                    Spacer()
                                }.padding(EdgeInsets(top: 10, leading: 10, bottom: 1, trailing: 0))
                                HStack {
                                    Text("♍️ 16 August 1962").foregroundColor(Color(.white)).font(.title3)
                                    Spacer()
                                }.padding(.leading, 10)
                                HStack {
                                    Text("Nationality").foregroundColor(Color("SectionColor")).bold().font(.title3)
                                    Spacer()
                                }.padding(EdgeInsets(top: 10, leading: 10, bottom: 1, trailing: 0))
                                HStack {
                                    Text("🇺🇸 US").foregroundColor(Color(.white)).font(.title3)
                                    Spacer()
                                }.padding(.leading, 10)
                                HStack {
                                    Text("Net Worth").foregroundColor(Color("SectionColor")).bold().font(.title3)
                                    Spacer()
                                }.padding(EdgeInsets(top: 10, leading: 10, bottom: 1, trailing: 0))
                                HStack {
                                    Text("💵 2.2 million").foregroundColor(Color(.white)).font(.title3)
                                    Spacer()
                                }.padding(.leading, 10)
                                Spacer()
                            }.padding(.horizontal)
                            
                            
                        }
                        .frame(maxHeight: .infinity, alignment: .top)
                        .padding(.horizontal)
                        
                    }
                        .offset(y: height - 100)
                        .offset(y: -offset > 0 ? -offset <= (height - 100) ? offset : -(height - 100) : 0)
                        .gesture(DragGesture().updating($gestureEffect, body: {
                            value, out, _ in
                            
                            out = value.translation.height
                            onChange()
                        }).onEnded({ value in
                            let maxHeight = height - 100
                            
                            withAnimation{
                                if -offset > 100 && -offset < maxHeight / 2{
                                    
                                    offset = -(maxHeight / 3)
                                }
                                else if -offset > maxHeight / 2 {
                                    offset = -maxHeight
                                }
                                else {
                                    offset = 0
                                }
                                
                            }
                            
                            lastOffset = offset
                        })
                                )
                    
                )
            }.ignoresSafeArea(.all, edges: [.horizontal, .bottom])
            
            
        }
    }
    
    func onChange() {
        DispatchQueue.main.async {
            self.offset = gestureEffect + lastOffset
        }
    }
}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        CelebrityDetailScreen(celeb: RecognizedCelebrity(name: "Steve Carell", confidence: NSNumber.init(value: 99.99), urls: []))
    }
}
