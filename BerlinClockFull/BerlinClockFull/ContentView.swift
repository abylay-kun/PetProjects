//
//  ContentView.swift
//  BerlinClockFull
//
//  Created by Abylay Duzel on 11.04.2023.
//

import SwiftUI

struct ContentView: View {

    @State var date = Date()
    
    var body: some View {
        VStack {
   
            timeShow(date: $date)
            berlinClock(date: $date)
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(red:255,green: 255,blue: 255))
                    .frame(width: 358, height: 54)
           
                VStack{
                    DatePicker(
                        "Insert time",
                        selection: self.$date,
                        displayedComponents: [.hourAndMinute]
                    )
                    .padding(.leading, 44)
                    .padding(.trailing, 44)
                }
                
            }
                .environment(\.locale, Locale(identifier: "Ru_ru"))
            
        
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red:0, green: 0, blue: 0, opacity: 0.05))
        
    }
      
}




struct timeShow:View{
    @Binding var date:Date
       
    
    var body: some View{
        HStack{
            Text("Time is \(date, format: .dateTime.hour().minute())")
                    .environment(\.locale, Locale(identifier: "Ru_ru"))
           

        }
   
    }
}








struct berlinClock:View{
    @Binding var date:Date
    
  

    var body: some View{
     
        let components = Calendar.current.dateComponents([.hour, .minute], from: date)
             let hour = components.hour!
             let minute = components.minute!

        var fiveHoursRow = TimeConverter.getFiveHoursRow(hour)
        var singleHoursRow = TimeConverter.getSingleHoursRow(hour)
        var fiveMinutesRow = TimeConverter.getFiveMinutesRow(minute)
        var singleMinuesRow = TimeConverter.getSingleMinutesRow(minute)


        
        ZStack(){
            
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(red:255,green:  255,blue: 255))
                .frame(width: 358, height: 312)
            
            VStack(alignment: .center, spacing: 16){
                Circle()
                    .fill(.yellow)
                    .frame(width: 56, height: 56)
                
                
                HStack{
                    ForEach(fiveHoursRow, id:\.self){ fiveHoursRow in
                       if fiveHoursRow == true{
                           RoundedRectangle(cornerRadius:10)
                          .fill(.red)
                          .frame(width: 74, height: 32)
                        }
                        else{
                            RoundedRectangle(cornerRadius:10)
                            .fill(.yellow)
                            .frame(width: 74, height: 32)
                        }
                       
                        
                    }
                   
                    
                }
                HStack{
                    ForEach(singleHoursRow, id:\.self){ singleHoursRow in
                       if singleHoursRow == true{
                           RoundedRectangle(cornerRadius:10)
                          .fill(.red)
                          .frame(width: 74, height: 32)
                        }
                        else{
                            RoundedRectangle(cornerRadius:10)
                            .fill(.yellow)
                            .frame(width: 74, height: 32)
                        }
                       
                        
                    }
                   
                    
                }
                HStack{
                    ForEach(fiveMinutesRow, id:\.self){ fiveMinutesRow in
                       if fiveMinutesRow == true{
                           RoundedRectangle(cornerRadius:10)
                               .fill(.red)
                               .frame(width: 21, height: 32)
                        }
                        else{
                            RoundedRectangle(cornerRadius:10)
                                .fill(.yellow)
                                .frame(width: 21, height: 32)
                        }
                       
                        
                    }
                        
                      
                        
                    
                    
                }
                HStack{
                    ForEach(singleMinuesRow, id:\.self){ singleMinuesRow in
                       if singleMinuesRow == true{
                           RoundedRectangle(cornerRadius:10)
                               .fill(.yellow)
                               .frame(width: 74, height: 32)
                        }
                        else{
                            RoundedRectangle(cornerRadius:10)
                                .fill(.red)
                                .frame(width: 74, height: 32)
                        }
                       
                        
                    }

                    
                    
               
                    
                    
                }
                
                
            }
            
        }
      
    }
 

    
    
}
    
            












struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    
    }
}
