//
//  DailyIntake.swift
//  WaterBalance
//
//  Created by Abylay Duzel on 09.04.2023.
//

import SwiftUI
//
//          struct DailyIntake: View {
struct DailyIntake:View{
    @Binding var firstElement:waterIntake
    
    @State var amountOfWater:Float = 2400
   
    var body: some View {
    
        
            VStack(){
                VStack{
                    Spacer()
                    logo
                    waterDosation(amountOfWater: $amountOfWater)
                    Spacer()
                }
                Spacer()
                if firstElement.pickedOnce == false{
                    NavigationLink(destination:WaterIntakeProgress(firstElement: $firstElement)){
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.blue)
                                .frame(width: 358, height: 60)
                            Text("Save")
                                .foregroundColor(.white)
                            
                            
                        }
                        
                    }
                    .simultaneousGesture(TapGesture().onEnded{
                        
                          firstElement.dailyIntake = amountOfWater
                    
                        print("\(firstElement.dailyIntake)")
//
//
                    })
                }else{
                    NavigationLink(destination:ContentView()){
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.blue)
                                .frame(width: 358, height: 60)
                            Text("Next")
                                .foregroundColor(.white)
                            
                        }
                    }
                    .simultaneousGesture(TapGesture().onEnded{
                        firstElement.dailyIntake = amountOfWater
                        print("\(firstElement.dailyIntake)")

                    })
                }
              
                    
            }
        
    }
    var logo: some View{
        
        VStack(spacing: 30){
            
            
            Text("WATER BALANCE")
                .font(Font.system(size: 24))
                .italic()
                .fontWeight(.heavy)
                .foregroundColor(.blue)
            Text("Daily Intake?")
                .font(Font.system(size: 36))
        }
        
        
        
    }
}



struct waterDosation:View{
    @State private var formatter = NumberFormatter()
    @Binding var amountOfWater:Float
    var body: some View{
        
        ZStack{
            
            RoundedRectangle(cornerRadius: 30)
                .fill(Color(red:83/255, green: 136/255,blue: 231/255, opacity: 0.3))
                .frame(width: 350, height: 108)
            
            HStack{
                
                ZStack{
                    
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
                        .frame(width: 250, height: 60)
                    TextField("mililiters", value: $amountOfWater, formatter: formatter )
                        .foregroundColor(.blue)
                        .fontWeight(.bold)
                        .frame(width: 120, height: 5)
                        .padding(.leading, 90)
                    
                }
                
                Text("ML")
                
                
            }
            
            
        }
    
        
    }
}


//struct DailyIntake_Previews: PreviewProvider {
//    static var previews: some View {
//        DailyIntake(firstElement: .constant(<#waterIntake#>))
//    }
//}
