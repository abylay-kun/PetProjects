//
//  SignUpPage.swift
//  FinalProject
//
//  Created by Abylay Duzel on 23.05.2023.
//

import SwiftUI

struct SignUpPage: View {
    var body: some View {
        NavigationView{
           
            VStack(spacing: 24){
                VStack{
                Image("SgnUpVector")
                    .resizable()
                    .frame(width: 390, height: 250)
                    
                    HStack{
                        Image("sgnUpShoeOne")
                            .resizable()
                            .frame(width: 228, height: 228)
                           
                           
                        Image("sgnUpShoeTwo")
                            .resizable()
                            .frame(width: 246, height: 246)
                            .padding(.bottom, 80)
                    }
               
                        
                       
                }
                    
                Text("Welcome to the biggest sneakers store app")
                    .foregroundColor(.black)
                    .font(.system(size: 28))
                    .frame(width: 380, height: 67, alignment: .center)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    
                    
                
                NavigationLink( destination: SignUp(userName: "", userPassword: "", userRepeatThePassword: "")){
                    
                    ZStack{
                        Capsule()
                            .frame(width: 358, height: 54)
                        Text("Sign up")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                        
                    }
                }.foregroundColor(.black)
                
                NavigationLink(destination: SignIn()){
                    Text("I already have an Account")
                        .font(.system(size: 17))
                        .padding(.bottom, 74)
                      
                }.foregroundColor(.black)
               
                    
                    
             
               
            }.ignoresSafeArea()
        }
        
       
    }
}





struct SignUpPage_Previews: PreviewProvider {
    static var previews: some View {
        SignUpPage()
    }
}
