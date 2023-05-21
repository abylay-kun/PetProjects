//
//  ContentView.swift
//  WaterBalance
//
//  Created by Abylay Duzel on 08.04.2023.
//

import SwiftUI


//extension Float{
//    var mlm: Float{return (self * 10000)/1000}
//}

class waterIntake:ObservableObject, Identifiable {
    
    @Published var id:Date = Date.now
    @Published var goal:String = "One"
    @Published var reminder:String = "15 minutes"
    @Published var dailyIntake: Float = 2400
    @Published var pickedOnce = false
    
    @Published var waterIntake:Float = 400
    
    @Published var percentage:Float = 0
    @Published var drinkedWater:Float = 0
    @Published var historyList = [String:String]()
    
}





struct ContentView: View {
    @State var firstElement = waterIntake()
    @State var RadioNumber:String = "One"
  
   
    
    var body: some View {
        NavigationView{
            VStack (){
                Spacer()
                
                waterBalaceLogo
                    .ignoresSafeArea()
                
                Spacer()
                whatIsYourGoal
                Spacer()
                FrameFourFour(RadioNumber: $RadioNumber)
                Spacer()
                
                    NavigationLink(destination: RemidMeEach(firstElement: $firstElement)){
                        ZStack{
                            
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.blue)
                                .frame(width: 358, height: 60)
                            
                            Text("Next")
                                .foregroundColor(.white)
                        }
                        
                    } .simultaneousGesture(TapGesture().onEnded{
                        
                        firstElement.id = Date.now
                        firstElement.goal = "\(RadioNumber)"
           
                        print("\(firstElement.goal), firsy")
                        
                        
                    })
                
                
            }
            
            
        }
        
    }
    var waterBalaceLogo:some View{
        Text("WATER BALANCE")
            .font(Font.system(size: 24))
            .italic()
            .fontWeight(.heavy)
            .foregroundColor(.blue)
        
    }
    var whatIsYourGoal: some View{
        Text("What is your goal?")
            .font(Font.system(size: 36))
        
        
    }
}
struct FrameFourFour:View{
    @State private var selected:Int = 1
    var ArrayOfButtons = ["One","Two", "Three", "Four"]
    @Binding var RadioNumber:String
    
    
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 30)
                .fill(Color(red:83/255, green: 136/255,blue: 231/255, opacity: 0.3))
                .frame(width: 350, height: 350)
            
            VStack(alignment: .trailing, spacing: 14){
                ForEach(ArrayOfButtons, id: \.self){ value in
                    
                    ReusableContentRadioButtons(numberOfGoals: value, RadioNumber: $RadioNumber)
                }
                
                
            }
            
            
        }
        
        
    }
    
}
struct ReusableContentRadioButtons: View{
    @State var numberOfGoals: String
    @Binding var RadioNumber:String
    
    
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(red:255/255, green: 255/255,blue: 255/255))
                .frame(width: 290, height: 60)
            HStack(){
                
                Text("Goal number \(numberOfGoals)" )
                
                    .frame(width: 234, height: 16, alignment: .leading)
                
                Button {
                    //radioPressed = true
                    RadioNumber = numberOfGoals
                    
                } label: {
                    ZStack{
                        Circle()
                            .stroke(.blue , lineWidth: 2)
                            .frame(width: 12, height: 12)
                            .foregroundColor(.blue)
                        if  RadioNumber == numberOfGoals {
                            Circle()
                                .frame(width: 8, height: 8)
                                .foregroundColor(.blue)
                        }
                        
                    }
                }
                
                
            }
            
            
            
            
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
