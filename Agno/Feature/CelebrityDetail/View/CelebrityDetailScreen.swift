//
//  DetailView.swift
//  Agno
//
//  Created by Sam Obe on 8/19/21.
//

import SwiftUI

struct CelebrityDetailScreen: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    //@EnvironmentObject var detail : DetailViewModel
    
    
    
    var btnBack: some View {
        Button(action: {self.presentationMode.wrappedValue.dismiss()}) {
            Image(systemName: "chevron.left").padding()
                .foregroundColor(.white).background(RoundedRectangle(cornerRadius: 12)
                                                        .accentColor(.black)).opacity(0.7)
        }
    }
    var body: some View {
        ZStack {
            Color("BackgroundColor")
            VStack {
                
                Image("MasterChief")
                    .resizable().aspectRatio(contentMode: .fit)
                HStack {
                    Text("Full Name").foregroundColor(Color("SectionColor")).bold().font(.title3)
                    Spacer()
                }.padding(EdgeInsets(top: 20, leading: 20, bottom: 1, trailing: 0))
                HStack {
                    Text("Master Chief Petty Officer John-117").foregroundColor(Color(.white)).font(.title3)
                    Spacer()
                }.padding(.leading, 20)
                HStack {
                    Text("Birthday").foregroundColor(Color("SectionColor")).bold().font(.title3)
                    Spacer()
                }.padding(EdgeInsets(top: 10, leading: 20, bottom: 1, trailing: 0))
                HStack {
                    Text("♍️ May 22, 1999").foregroundColor(Color(.white)).font(.title3)
                    Spacer()
                }.padding(.leading, 20)
                HStack {
                    Text("Nationality").foregroundColor(Color("SectionColor")).bold().font(.title3)
                    Spacer()
                }.padding(EdgeInsets(top: 10, leading: 20, bottom: 1, trailing: 0))
                HStack {
                    Text("🇺🇸 US").foregroundColor(Color(.white)).font(.title3)
                    Spacer()
                }.padding(.leading, 20)
                HStack {
                    Text("Net Worth").foregroundColor(Color("SectionColor")).bold().font(.title3)
                    Spacer()
                }.padding(EdgeInsets(top: 10, leading: 20, bottom: 1, trailing: 0))
                HStack {
                    Text("💵 2.2 million").foregroundColor(Color(.white)).font(.title3)
                    Spacer()
                }.padding(.leading, 20)
                Spacer()
            }
        }.ignoresSafeArea().navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        CelebrityDetailScreen()
    }
}
