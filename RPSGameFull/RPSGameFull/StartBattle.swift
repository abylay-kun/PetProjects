//
//  StartBattle.swift
//  RPSGameFull
//
//  Created by Abylay Duzel on 15.04.2023.
//

import SwiftUI

enum result:String{
    case win = "WIN!"
    case lose = "LOSE"
    case tie = "TIE!"
}

struct StartBattle: View {
    @Binding var opponentChoice:pickOpponent
    @Binding var youPicked:pick
    @Binding var screenShow:screenState
   
   
   
    @State var rounds = 0
    
    @Binding var scorePlayerOne:Int
    @Binding var scorePlayerTwo:Int
    
    var body: some View {
        
        
        let resultat:result = whoGetTheRound(p1: youPicked, p2: opponentChoice)
        
        
   
        VStack{
            
            
            
            Text(resultat.rawValue)
                .font(.system(size: 54))
                .foregroundColor(Color(red:255/255,green: 204/255, blue:0/255))
                .onAppear{
                    if resultat == .win{
                        scorePlayerOne += 1
                    }else if resultat == .lose{
                        scorePlayerTwo += 1
                    }
                }
            Text("**Player One:** \(scorePlayerOne)  **Player Two:** \(scorePlayerTwo)")
            
            Spacer()
            
            emojiBattleBar(opponentChoice: $opponentChoice, youPicked: $youPicked)
            Spacer()
            anotherRoundButton(screenShow: $screenShow)
            
        }

      
        
    }
//    func scoreCount(){
//
//        if resultat == .win{
//            scorePlayerOne += 1
//        }else if resultat == .lose{
//            scorePlayerTwo += 1
//        }
//
//    }
    
}

func whoGetTheRound(p1:pick, p2:pickOpponent)-> result{
    
    if p1.rawValue == p2.rawValue{
        return .tie
    }else if p1.rawValue == "🗿", p2.rawValue == "📃"{

        return .lose
    }
    else if p1.rawValue == "✂️", p2.rawValue == "🗿"{
        
        return .lose
    }else if p1.rawValue == "📃", p2.rawValue == "✂️"{
        
        return .lose
    }
    else{
        return .win
    }
}



struct emojiBattleBar:View{
    @Binding var opponentChoice:pickOpponent
    @Binding var youPicked:pick

    var body: some View{
        
        
        ZStack{
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 170, height: 128)
                    .opacity(0.5)
                    Text(youPicked.rawValue)
                        .font(.system(size: 66))
             
            }.padding(.leading, 170)
                .padding(.bottom, 40)
            
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 170, height: 128)
                    .opacity(0.5)
                    Text(opponentChoice.rawValue)
                        .font(.system(size: 66))
             
            }.padding(.trailing, 170 )
            .padding(.top, 40)
            Spacer()
            
            
        }
      
        
    }
}
struct anotherRoundButton:View{
    @Binding var screenShow:screenState
    var body: some View{
        Button {
            screenShow = .takeYourPick
        } label: {
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .fill(.blue)
                    .frame(width: 358, height: 50)
                Text("Another round")
                    .foregroundColor(.white)
            }
        
        }

    }
}

//struct StartBattle_Previews: PreviewProvider {
//    static var previews: some View {
//        StartBattle(opponentChoice: .constant(.paper), youPicked: .constant(.scissors))
//    }
//}
