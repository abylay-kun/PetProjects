//
//  GameItself.swift
//  RPSGameFull
//
//  Created by Abylay Duzel on 13.04.2023.
//

import SwiftUI
enum pick:String, CaseIterable{
    case rock = "🗿"
    case paper = "📃"
    case scissors = "✂️"
    case none

}

enum pickOpponent:String, CaseIterable{
    case rock = "🗿"
    case paper = "📃"
    case scissors = "✂️"
   

}
enum screenState{
    case takeYourPick
    case yourPick
    case opponentWait
    case yourOpponentPick
    case battle
}

struct GameItself: View {
    @State var screenShow:screenState = .takeYourPick
    @State var youPicked:pick = .none
    @State var opponentChoice:pickOpponent
    @State var scorePlayerOne = 0
    @State var scorePlayerTwo = 0
    
    
   
    
    
    var body: some View {
        
        switch screenShow {
            
        case .takeYourPick:
            VStack{
                Text("Choose your Pick")
                    .fontWeight(.semibold)
                    .font(.system(size: 52))
                    .multilineTextAlignment(.center)
              
            
//                ZStack{
//                    Capsule()
//                        .fill(.gray)
//                        .frame(width: 342, height: 128)
//                        Text("✂️")
//                        .font(.system(size: 66))
//                }
                
                
                emojiBar(emoji: "✂️")
                    .onTapGesture {
                        screenShow = .yourPick
                        youPicked = .scissors
                    }
                emojiBar(emoji: "🗿")
                    .onTapGesture {
                        screenShow = .yourPick
                        youPicked = .rock
                    }
                emojiBar(emoji: "📃")
                    .onTapGesture {
                        screenShow = .yourPick
                        youPicked = .paper
                    }
            }
            
            
        case .yourPick:
            
            Text("You pick")
                .fontWeight(.semibold)
                .font(.system(size: 52))
                .multilineTextAlignment(.center)
            Spacer()
            emojiBar(emoji: youPicked.rawValue)
                .onTapGesture {
                    screenShow = .opponentWait
                }
            Spacer()
            
            Button {
                screenShow = .takeYourPick
                youPicked = .none
            } label: {
                //emojiBar(emoji: )
                
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 300, height: 50)
                  
                    Text("I changed my mind")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 16))
                }
               
            }

        case .yourOpponentPick:
            
            opponentsPick(screenShow: $screenShow, opponentChoice: $opponentChoice)
            
        case .opponentWait:
            
            opponentWait(screenShow: $screenShow)

        case .battle:
               
            StartBattle(opponentChoice: $opponentChoice, youPicked: $youPicked, screenShow: $screenShow, scorePlayerOne:$scorePlayerOne, scorePlayerTwo: $scorePlayerTwo)
          
            
        }
        
       
          
//            VStack{
//                Text(text)
//                    .fontWeight(.semibold)
//                    .font(.system(size: 52))
//                    .multilineTextAlignment(.center)
//                Button {
//
//                    scissors = true
//                    rock = false
//                    paper = false
//                    abilityToChoose = false
//                    text = "Your pick"
//
//
//                } label: {
//
//                    emojiBar(emoji: "✂️")
//                        .opacity(scissors == false ? 0 : 1)
//
//                }
//                Button {
//
//                    scissors = false
//                    rock = true
//                    paper = false
//                    abilityToChoose = false
//                    text = "Your pick"
//
//                } label: {
//
//                    emojiBar(emoji: "🗿")
//                        .opacity(rock == false  ? 0 : 1)
//                }
//                Button {
//
//                    scissors = false
//                    rock = false
//                    paper = true
//                    abilityToChoose = false
//                    text = "Your pick"
//
//
//                } label: {
//
//                    emojiBar(emoji: "📃")
//                        .opacity(paper == false ? 0 : 1)
//
//                }
//
//                Button {
//
//                    scissors = true
//                    rock = true
//                    paper = true
//                    abilityToChoose = true
//                    text = "Take your pick"
//
//
//                } label: {
//                    ZStack{
//                        RoundedRectangle(cornerRadius: 10)
//                             .frame(width: 300, height: 50)
//                         Text("I changed my decision")
//                            .foregroundColor(.white)
//                            .fontWeight(.black)
//                    }.opacity(abilityToChoose == false ? 1 : 0)
//
//
//                }
//
//
//            }

        
        }
    }




struct emojiBar:View{
    let emoji:String
    var body: some View{
    
        ZStack{
            Capsule()
                .fill(.gray)
                .frame(width: 342, height: 128)
                Text(emoji)
                .font(.system(size: 66))
        }
    }
}
struct opponentWait:View{
    @Binding var screenShow:screenState
    
    var body: some View{
        VStack(spacing: 180){
            Text("Your\n opponent is \nthinking")
                .fontWeight(.semibold)
                .font(.system(size: 52))
                .multilineTextAlignment(.center)
                
            Image("Frame")
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                        screenShow = .yourOpponentPick
                    }
                    
                }
            Spacer()
            
//                onAppear{
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
//
//                        screenShow = .takeYourPick
//
//                    }
//
//                }
        }
    }
}
struct opponentsPick:View{
    @Binding var screenShow:screenState
    @Binding var opponentChoice:pickOpponent
    
    var body: some View{
        VStack{
            Text("Your opponent's choice")
                .fontWeight(.semibold)
                .font(.system(size: 52))
                .multilineTextAlignment(.center)
                Spacer()
            emojiBar(emoji: opponentChoice.rawValue)
                .padding(.bottom, 274)
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now()+2.0){
                        screenShow = .battle
                    }
                }
              
        }
      
        
    }
}
//struct battleNavigation:View{
//    var body: some View{
//      
//           
//
//        
//
//    }
//}



struct GameItself_Previews: PreviewProvider {
    static var previews: some View {
        GameItself( opponentChoice: .rock)
    }
}
