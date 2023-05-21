//
//  GameItself.swift
//  RPSGameFull
//
//  Created by Abylay Duzel on 13.04.2023.
//

import SwiftUI
//enum pick:String, CaseIterable{
//    case rock = "🗿"
//    case paper = "📃"
//    case scissors = "✂️"
//    case none
//
//}
//
//enum pickOpponent:String, CaseIterable{
//    case rock = "🗿"
//    case paper = "📃"
//    case scissors = "✂️"
//
//
//}
//enum screenState{
//    case takeYourPick
//    case yourPick
//    case opponentWait
//    case yourOpponentPick
//    case battle
//}

struct GameItselfPlayerTwo: View {
    @State var screenShow:screenState = .takeYourPick
    @State var youPicked:pick = .none
    @State var opponentChoice:pickOpponent = .rock
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
                        .frame(width: 200, height: 50)
                  
                    Text("I changed my mind")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 16))
                }
               
            }

        case .yourOpponentPick:
            
            opponentsPickPlayerTwo(screenShow: $screenShow, opponentChoice: $opponentChoice)
            
        case .opponentWait:
            
            opponentWaitPlayerTwo(screenShow: $screenShow)

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




//struct emojiBar:View{
//    let emoji:String
//    var body: some View{
//
//        ZStack{
//            Capsule()
//                .fill(.gray)
//                .frame(width: 342, height: 128)
//                Text(emoji)
//                .font(.system(size: 66))
//        }
//    }
//}
struct opponentWaitPlayerTwo:View{
    @Binding var screenShow:screenState

    var body: some View{
        VStack(spacing: 180){
            Text("Pass the phone player #2")
                .fontWeight(.semibold)
                .font(.system(size: 52))
                .multilineTextAlignment(.center)
                Spacer()
            Button {
                screenShow = .yourOpponentPick
            } label: {
                
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.blue)
                        .frame(width: 300, height: 50)
                        
                    Text("Ready to continue")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
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
struct opponentsPickPlayerTwo:View{
    @Binding var screenShow:screenState
    @Binding var opponentChoice:pickOpponent
    
    var body: some View{
        VStack{
            Text("Player #2 your pick")
                .fontWeight(.semibold)
                .font(.system(size: 52))
                .multilineTextAlignment(.center)
                    emojiBar(emoji: "✂️")
                        .onTapGesture {
                            screenShow = .battle
                            opponentChoice = .scissors
                        }
                    emojiBar(emoji: "🗿")
                        .onTapGesture {
                            screenShow = .yourOpponentPick
                            opponentChoice = .rock
                        }
                    emojiBar(emoji: "📃")
                        .onTapGesture {
                            screenShow = .battle
                            opponentChoice = .paper
                        }
                      
                
//
//            emojiBar(emoji: opponentChoice.rawValue)
//                .padding(.bottom, 274)
            
            
              
        }
      
        
    }
}



struct GameItselfPlayerTwo_Previews: PreviewProvider {
    static var previews: some View {
        GameItselfPlayerTwo( opponentChoice: .rock)
    }
}
