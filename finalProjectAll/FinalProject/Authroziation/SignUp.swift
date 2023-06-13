//
//  SignUp.swift
//  FinalProject
//
//  Created by Abylay Duzel on 23.05.2023.
//

import SwiftUI

struct SignUp: View {
    @State var userName:String
    @State var userPassword:String
    @State var userRepeatThePassword:String
    
    var body: some View {
    
            VStack{
                TextField("user name", text: $userName)
                    .frame(width: 358, height: 48)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                    .background(.gray)
                    .cornerRadius(10)
                TextField("user password", text: $userPassword)
                    .frame(width: 358, height: 48)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                    .background(.gray)
                    .cornerRadius(10)
                TextField("repeat password", text: $userRepeatThePassword)
                    .frame(width: 358, height: 48)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                    .background(.gray)
                    .cornerRadius(10)
                Spacer()
                ZStack{
                    Capsule()
                        .frame(width: 358, height: 54)
                    Text("Sign up")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    
                }.onTapGesture {
                    signUpSetPasswordAndUsername(userName: userName, UserPassword: userPassword)
                }.padding(.bottom, 20)
                
            }.padding(.top, 64)
            .navigationTitle("New User")
                .navigationBarTitleDisplayMode(.inline)
                
                
        
        
    

        }
}

func signUpSetPasswordAndUsername(userName:String, UserPassword:String){
   
    
    guard let url = URL(string: "http://127.0.0.1:8080/users/signup") else {return}
    
//    guard let formatUrl = URL(string: url) else {return}
    var request = URLRequest(url: url)
    
    let parameters:[String:String] = [
        "username" : userName,
        "password" : UserPassword
    ]
    
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    guard let postBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {return};
    request.httpBody = postBody

    
//    var request = URLRequest(url: url )
//
//    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//    request.setValue("application/json", forHTTPHeaderField: "Accept")
    
   
        
    //print("postbody = \(postBody)")
    
    URLSession.shared.dataTask(with: request) { (data, response, error) in
        guard let data = data,
               let response = response as? HTTPURLResponse,
               error == nil
           else {                                                               // check for fundamental networking error
               print("error", error ?? URLError(.badServerResponse))
               return
           }
           
           guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
               print("statusCode should be 2xx, but is \(response.statusCode)")
               print("response = \(response)")
               return
           }
        
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
//            let json = jsonObject?["token"] as? String
//
//            print(json!)
            print("User registered correctly")
                }
        catch{
            print(error)
        }
        
            
    }.resume()
}


struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp(userName: "someString", userPassword: "", userRepeatThePassword: "")
    }
}
