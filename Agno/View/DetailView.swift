//
//  DetailView.swift
//  Agno
//
//  Created by Sam Obe on 8/19/21.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
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
                    Text("Full Name").foregroundColor(Color("SectionColor")).bold().font(.title2)
                    Spacer()
                }.padding(EdgeInsets(top: 20, leading: 20, bottom: 5, trailing: 0))
                HStack {
                    Text("Master Chief Petty Officer John-117").foregroundColor(Color(.white)).font(.title2)
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
        DetailView()
    }
}
