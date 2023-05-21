//
//  WaterIntakeProgress.swift
//  WaterBalance
//
//  Created by Abylay Duzel on 09.04.2023.
//

import SwiftUI

struct WaterIntakeProgress: View {
    enum pageTypes{
        case main
        case settings
        case history
    }
    @State private var currentPage:pageTypes = .main
    @State private var showDetails = false
    @Binding var firstElement:waterIntake
    
    
    //    init(){
    //        UITabBar.appearance().unselectedItemTintColor = .white
    //    }
    var body: some View {
        
        TabView(selection: $currentPage){
            mainPage(firstElement: $firstElement)
                .tabItem(){
                    Label("main", systemImage: "house")
                }.tag(".main")
            settingsPage(firstItem: $firstElement)
                .tabItem(){
                    Label("settings", systemImage:"slider.horizontal.3")
                }.tag("settings")
            historysPage(firstElement: $firstElement)
                .tabItem(){
                    Label("history", systemImage: "doc.fill")
                }
            
        }.tint(.blue)
            .navigationBarHidden(true)
        
    }
    
    
    
    
}

// main page all conf-s
struct mainPage:View{
    @Binding var firstElement:waterIntake

    var body: some View{
        VStack{
            
            Spacer()
            reusablePercentageBar(firstElement: $firstElement)
           
          
            
            
            
        }
        
    }
}

func forTrailingZero(temp: Float) -> String {
       var tempVar = String(format: "%g", temp)
       return tempVar
   }

struct reusablePercentageBar:View{
    @State var firstDrink:Bool = false
    
   
    @Binding var firstElement:waterIntake
    
    static let gradientStart = Color(red: 212 / 255, green: 120.0 / 255, blue: 248 / 255)
    static let gradientEnd = Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255)
    
   
    
    
    var body: some View{
        VStack{
            
            Spacer()
            ZStack{
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(LinearGradient(colors: [Self.gradientStart, Self.gradientEnd],  startPoint: .init(x: 0.5, y: 0), endPoint: .init(x: 0.5, y: 0.6)))
                    .frame(width: 358, height: 332)
                Circle()
                    .fill(Color(red: 212 / 255, green: 120.0 / 255, blue: 248 / 255, opacity: 0.3))
                    .frame(width: 180, height: 180 )
                Circle()
                    .stroke(.white , lineWidth: 3 )
                    .frame(width: 182, height: 182 )
                VStack(spacing: 2){
                    Text("\(forTrailingZero(temp: firstElement.percentage))")
                        .font(.system(size: 36))
                        .fontWeight(.bold)
                    Text("\(forTrailingZero(temp: firstElement.drinkedWater)) of \(forTrailingZero(temp: firstElement.dailyIntake)) ")
                    
                    
                }
                Text("\(firstElement.id.formatted(.dateTime.day().month().year()))")
                    .padding(.top, 250)
            }
            Spacer()
            Text(firstDrink ? "Great Job" : "Add your first drink for today" )
              
            
                .frame(width: 358, height: 92)
                .font(.system(size:36, weight: .medium))
                .multilineTextAlignment(.center)
        
            addButton(firstDrink: $firstDrink, firstElement: $firstElement)
            Spacer()
        }.onAppear{
            firstElement.pickedOnce = true
        }
        
        
    }
    
}
struct addButton:View{
    @Binding var firstDrink:Bool
    @Binding var firstElement:waterIntake
 
   
    
    var body: some View{
        NavigationLink(destination: waterIntakeAmount(firstElement: $firstElement)){
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 358, height: 60)
                Text("Add")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                
            }       .navigationBarHidden(true)
            
        }
            
            
      
    }
}



struct waterIntakeAmount:View{
    @Binding var firstElement:waterIntake
    
    @State var amountOfWater:Float = 200
  
    
    var body: some View {
    
        
            VStack(){
                VStack{
                    Spacer()
                    logo
                    waterDosation(amountOfWater: $amountOfWater)
                    Spacer()
                }
                Spacer()
     
                    NavigationLink(destination:WaterIntakeProgress(firstElement: $firstElement)){
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.blue)
                                .frame(width: 358, height: 60)
                            Text("Add")
                                .foregroundColor(.white)
                            
                        }
                        
                    }
                    .simultaneousGesture(TapGesture().onEnded{
                        // all shit should happen here!!! attention
                        
                          firstElement.waterIntake = amountOfWater
                          firstElement.drinkedWater += (firstElement.waterIntake)/1000
                          firstElement.percentage = (firstElement.drinkedWater * 100)/(firstElement.dailyIntake/1000)
                        firstElement.historyList[String(firstElement.drinkedWater)] = Date.now.formatted(.dateTime.minute().second())
                    
//
//
                    })
                
              
                    
            }
        
    }
    var logo: some View{
        
        VStack(spacing: 30){
            
            
            Text("WATER BALANCE")
                .font(Font.system(size: 24))
                .italic()
                .fontWeight(.heavy)
                .foregroundColor(.blue)
            Text("Water Intake")
                .font(Font.system(size: 36))
        }
        
        
        
    }
}

struct addWaterDosation:View{
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





struct settingsPage:View{
    @Binding var firstItem:waterIntake
    
    var body: some View{
        
        VStack(spacing: 30){
            Text("EDIT")
                .foregroundColor(.blue)
                .fontWeight(.black)
                .italic()
            
            List{
                
                
                HStack(){
                    
                    Text("Daily Intake")
                        .frame(width: 260,alignment: .leading)
                    
                    
               
                    Text("\(forTrailingZero(temp: firstItem.dailyIntake))")
                    
                    NavigationLink(destination: DailyIntake(firstElement: $firstItem)){
                        
                    }
                    
                }
                HStack(){


                    
                    Text("Your Goal")
                        .frame(width: 310,alignment: .leading)
//                    NavigationLink(destination: ContentView()){
//
//                    }

                }
                HStack(){
                    
                    Text("Reminder")
                        .frame(width: 310,alignment: .leading)
                    
//                    NavigationLink(destination: RemidMeEach(firstElement: $firstItem)){
//                        
//                    }
                    
                }
                
                
                
                
                
            }.listStyle(.plain)
            
        }
        
        
    }
}




struct historysPage:View{
    @Binding var firstElement:waterIntake
    
    var body: some View{
        VStack(spacing: 30){
            Text("History")
                .foregroundColor(.blue)
                .fontWeight(.black)
                .italic()
            
            List{
                Text("\(firstElement.id.formatted(.dateTime.day().month().year()))")
                    .font(.system(size: 20, weight: .bold))
                
                    VStack(alignment: .leading, spacing: 12){
                        ForEach(firstElement.historyList.sorted(by: >), id: \.key) { key, val in
                            HStack(){
                                
                                Text("\(key)")
                                    .frame(width: 290, alignment: .leading)
                                
                                Text("\(val)")
                                
                            }
                        }
                        //DateFormatter
                       
                        
                      
                    }
                    
                

                
//                VStack(alignment: .leading,spacing: 12){
//                    Text("22.22.22")
//                        .font(.system(size: 20,weight: .bold))
//
//                    HStack(){
//
//                        Text("250 ml")
//                            .frame(width: 290, alignment: .leading)
//
//                        Text("12:03")
//
//                    }
//                }
//                VStack(alignment: .leading, spacing: 12){
//                    Text("62.88.11")
//                        .font(.system(size: 20,weight: .bold))
//
//                    HStack(){
//
//                        Text("250 ml")
//                            .frame(width: 290, alignment: .leading)
//
//                        Text("12:03")
//
//                    }
//                }
                
                
            }.listStyle(.plain)
            
        }
        
        
    }
}

//struct WaterIntakeProgress_Previews: PreviewProvider {
//    static var previews: some View {
//        WaterIntakeProgress()
//
//    }
//}


