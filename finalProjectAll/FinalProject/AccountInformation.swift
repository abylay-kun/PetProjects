//
//  AccountInformation.swift
//  FinalProject
//
//  Created by Abylay Duzel on 30.05.2023.
//

import SwiftUI

struct AccountInformation: View {
    @State var userName:String
    @State var  userPassword:String
    var body: some View {
        
        VStack{
            TextField("user name", text: $userName)
                .frame(width: 358, height: 48)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                .background(.gray)
                .cornerRadius(10)
            TextField("password", text: $userPassword)
                .frame(width: 358, height: 48)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                .background(.gray)
                .cornerRadius(10)
            TextField("confirm password", text: $userPassword)
                .frame(width: 358, height: 48)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                .background(.gray)
                .cornerRadius(10)
            Spacer()
            costomBtn(text: "Save changes").onTapGesture {
                //
            }
        }.padding(.top, 50)
    }
}


