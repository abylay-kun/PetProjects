//
//  SignIn.swift
//  FinalProject
//
//  Created by Abylay Duzel on 23.05.2023.
//

import SwiftUI




struct SignIn: View {
    @State var userLoggedIn = false
    
    var body: some View {
        if userLoggedIn{
            SneakerCollection()
        }
        else{
            mainLoginPage(userLoggedIn: $userLoggedIn)
        }
       
    }
}

struct mainLoginPage:View{
    @State var userNameAuth:String = ""
    @State var userPasswordAuth:String = ""
    @Binding var userLoggedIn:Bool
    @State var newText = ""
    var body: some View{
            VStack{
                TextField("user name", text: $userNameAuth)
                    .autocapitalization(.none)
                    .autocorrectionDisabled(false)
                    .frame(width: 358, height: 48)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                    .background(.gray)
                    .cornerRadius(10)
                TextField("user password", text: $userPasswordAuth)
                    .autocapitalization(.none)
                    .autocorrectionDisabled(false)
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
                    getNameAndPasswordFromDb(userNameAuth: userNameAuth, userPasswordAuth: userPasswordAuth){ (returnedData) in
                        userLoggedIn = returnedData
                        
                    }
                    
                }.padding(.bottom, 20)
            }.padding(.top, 64)
            .navigationTitle("Welcome back!")
                .navigationBarTitleDisplayMode(.inline)
    }
}

func getNameAndPasswordFromDb(userNameAuth:String, userPasswordAuth:String,  completionHandler: @escaping (_ data: Bool) -> Void){
    @Binding var userLoggedIn:Bool
    guard let url = URL(string: "http://127.0.0.1:8080/users/login") else {return}

    var request = URLRequest(url: url)
    
    request.httpMethod = "POST"

    let authData = (userNameAuth + ":" + userPasswordAuth).data(using: .utf8)!.base64EncodedString()
    request.addValue("Basic \(authData)", forHTTPHeaderField: "Authorization")


    
    URLSession.shared.dataTask(with: request) { (data, response, error)  in
        do{
            if let errors = error{
                print(errors)
            }
            if let responses = response{
                
                print(responses)
            }
            if let data = data{
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
                let user = jsonObject?["user"] as? [String:Any]
                
                // name, id, token
                let userId = user?["id"] as? String
                let userName = user?["username"] as? String
                let token = jsonObject?["token"] as? String
                
                let defaults = UserDefaults.standard
                defaults.set(token, forKey: "\(userId), \(userName)")
                completionHandler(true)
                print(token)

                
            }
        }
        catch{
            print(error)
        }
    }.resume()
    
    
    
}

struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignIn()
    }
}
