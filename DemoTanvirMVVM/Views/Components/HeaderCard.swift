//
//  HeaderCard.swift
//  DemoTanvirMVVM
//
//  Created by Tanvir Alam on 27/4/22.
//

import SwiftUI

struct HeaderCard: View {
    @Binding var largeHeader : Bool
    @State var gotoUser = false
    var body: some View {
        HStack(alignment:.bottom){
            VStack(alignment:.leading,spacing: 8){
                Text("Expert iOS Developer, tanvirgeek(skype)")
                    .font(.callout)
                    .foregroundColor(AppColors.green)
                    .bold()
                Text("Hire ME, Click the Cards Below")
                    .animation(.easeInOut(duration: 0.5), value: largeHeader)
                    .font(largeHeader ? .largeTitle.bold() : .callout.bold())
            }.frame(maxWidth:.infinity,alignment: .leading)
            
            Button {
                gotoUser = true
            } label: {
                Image(systemName: "person.circle.fill")
                    .font(.largeTitle)
                    .tint(.green)
            }
            NavigationLink(isActive: $gotoUser) {
                UserlistView()
            } label: {
                EmptyView()
            }


        }.padding(.horizontal)
        .animation(.easeInOut(duration: 0.5), value: largeHeader)
    }
}

struct HeaderCard_Previews: PreviewProvider {
    static var previews: some View {
        HeaderCard(largeHeader: .constant(false))
    }
}
