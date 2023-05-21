//
//  ContentView.swift
//  RPSGameFull
//
//  Created by Abylay Duzel on 13.04.2023.
//

import SwiftUI

enum pick1:String, CaseIterable{
    case rock = "🗿"
    case paper = "📃"
    case scissors = "✂️"
    

}

struct ContentView: View {
    var body: some View {

        VStack {
   
                mainPage()
            
        }
    
        
    }
}

struct mainPage:View{
    
    var body: some View{
        NavigationView{
        ZStack{
                Image("BackgroundImage")
                    .resizable()
                    .ignoresSafeArea()
                    .aspectRatio(contentMode: .fill)
               
            VStack{
                
                Text("Welcome to the game!")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(.system(size: 54))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 450)
                    .padding(.top, 92)
                
                NavigationLink(destination: GameItself( opponentChoice: pickOpponent.allCases.randomElement()!)){
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 358, height: 50)
                            Text("Single player")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                
                        }
                    }
                    
                NavigationLink(destination: GameItselfPlayerTwo()){
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 358, height: 50)
                            Text("Multi player")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                        }
                      
                    }
             
                }
        
            }
            
        }.navigationTitle("round$1")
            
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
