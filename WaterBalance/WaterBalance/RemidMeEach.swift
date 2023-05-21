//
//  RemidMeEach.swift
//  WaterBalance
//
//  Created by Abylay Duzel on 09.04.2023.
//

import SwiftUI

struct RemidMeEach: View {

    @State var ChoosedBtn = "15 minutes"
    @Binding var firstElement:waterIntake
    var body: some View {
    
            VStack (){
                
                waterBalaceLogo
                    .padding(.bottom, 62)
                    .padding(.top, 40)
           
                whatIsYourGoal
        
                    
                FrameTimeSetter(ChoosedBtn: $ChoosedBtn)
                    .padding(.bottom, 100)
                
                
                NavigationLink(destination: DailyIntake(firstElement: $firstElement)){
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.blue)
                            .frame(width: 358, height: 60)
                        Text("Next")
                            .foregroundColor(.white)
                    }.padding(.bottom, 50)
                    
                }
                .simultaneousGesture(TapGesture().onEnded{
                    
                    firstElement.reminder = ChoosedBtn
                    print("\(firstElement.goal)")
                    print("\(firstElement.reminder)")
                })
            }
      
    }
        var waterBalaceLogo:some View{
            
            
            
            VStack(spacing: 30){
                Spacer()
                
                Text("WATER BALANCE")
                    .font(Font.system(size: 24))
                    .italic()
                    .fontWeight(.heavy)
                    .foregroundColor(.blue)
            }
            
            
            
            
        }
        var whatIsYourGoal: some View{
            Text("Remind me each")
                .font(Font.system(size: 36))
            
            
            
        }
        
    }
    
    
    
    
    struct FrameTimeSetter:View{
        @State  var selected:Int = 1
        var ArrayOfTimeAmounts = ["15 minutes", "30 minutes", "45 minutes", "1 hour", "1,5 hours", "2 hours", "3 hours", "4 hours" ]
        @Binding var ChoosedBtn:String
        
        let gridLayout = Array(repeating: GridItem(.adaptive(minimum: 100)), count: 4)
        var body: some View{
            ZStack{
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color(red:83/255, green: 136/255,blue: 231/255, opacity: 0.3))
                    .frame(width: 350, height: 368)
                
                LazyHGrid(rows: gridLayout, spacing: 10){
                    ForEach(ArrayOfTimeAmounts, id: \.self){ time in
                        
                        ReusableContentTimeSetButtons(TimeAmount: time, ChoosedBtn: $ChoosedBtn)
                        
                        
                    }
                }
                
                
                //                Grid(horizontalSpacing: 14, verticalSpacing: 14){
                //                    GridRow{
                //                        ReusableContentTimeSetButtons(timeAmount: "15", timeDefinition: "minutes", choosedBtn: true )
                //                        ReusableContentTimeSetButtons(timeAmount: "30", timeDefinition: "minutes", choosedBtn: false )
                //                    }
                //                    GridRow{
                //                        ReusableContentTimeSetButtons(timeAmount: "45", timeDefinition: "minutes", choosedBtn: false )
                //                        ReusableContentTimeSetButtons(timeAmount: "1", timeDefinition: "hours", choosedBtn: false )
                //                    }
                //                    GridRow{
                //                        ReusableContentTimeSetButtons(timeAmount: "1,5", timeDefinition: "hours", choosedBtn: false )
                //                        ReusableContentTimeSetButtons(timeAmount: "2", timeDefinition: "hours", choosedBtn: false )
                //                    }
                //                    GridRow{
                //                        ReusableContentTimeSetButtons(timeAmount: "3", timeDefinition: "hours", choosedBtn: false )
                //                        ReusableContentTimeSetButtons(timeAmount: "4", timeDefinition: "hours", choosedBtn: false )
                //                    }
                //}
                
                
                
                
                
            }
            
            
        }
        
    }
    struct ReusableContentTimeSetButtons: View{
        
        @State var TimeAmount: String
        
        @Binding var ChoosedBtn:String
        
        
        var body: some View{
            ZStack{
                
                HStack(){
                    
                    
                    Button {
                        
                        ChoosedBtn = TimeAmount
                        
                    } label: {
                        ZStack{
                            
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.white)
                                .frame(width: 150, height: 60)
                            Text("\(TimeAmount)" )
                                .frame(alignment: .center)
                                .foregroundColor(.black)
                                .fontWeight(.medium)
                            if ChoosedBtn == TimeAmount {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.blue, lineWidth: 2)
                                    .frame(width: 150, height: 60)
                            }
                            
                            
                            
                            
                        }
                        
                        
                    }
                    
                    
                }
                
                
                
                
            }
        }
    }
    
    
    
//    
//    
//    struct RemidMeEach_Previews: PreviewProvider {
//        static var previews: some View {
//            RemidMeEach()
//        }
//    }
