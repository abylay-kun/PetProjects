//
//  UserProfile.swift
//  FinalProject
//
//  Created by Abylay Duzel on 29.05.2023.
//

import SwiftUI

struct UserProfile: View {
    var body: some View {
        NavigationView{
            
            VStack{
                
                List{
                    Section{
                        NavigationLink(destination: AccountInformation(userName: "", userPassword: "")){
                            Text("Account Information")
                        }
                    }
                    Section{
                        NavigationLink(destination: OrderHistory()){
                            Text("Order History")
                        }.navigationBarHidden(true)
                    }
                    Section{
                        NavigationLink(destination: ShoeSizeEdit(shoeSize: "")){
                            Text("Shoe Size")
                        }
                    }
                    Section{
                        NavigationLink(destination: SneakerCollection()){
                            Text("How do you know your shoe size?")
                            
                        }
                        NavigationLink(destination: SneakerCollection()){
                            Text("How to check the authenticity of the shoe?")
                                .frame(width: 300, height: .infinity, alignment: .leading)
                            
                        }
                       
                    }
                    
                    
                    
                    
                
                }.listStyle(GroupedListStyle())
                Spacer()
                costomBtn(text: "Sign Out")
                    .onTapGesture {
                        //
                    }.padding(.bottom, 20)
            }
        
        }
    }
}
struct ShoeSizeEdit:View{
    @State var shoeSize:String
    
    var body: some View{
        VStack{
            TextField("41,5", text: $shoeSize)
                .frame(width: 360, height: 60)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                .border(.black)
                
            Spacer()
            costomBtn(text: "Save Changes")
            
        }.padding(.top, 29)
    
        
    }
}
//struct Sneaker
struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
