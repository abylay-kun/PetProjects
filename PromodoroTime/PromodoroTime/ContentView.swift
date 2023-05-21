//
//  ContentView.swift
//  PromodoroTime
//
//  Created by Abylay Duzel on 06.04.2023.
//

import SwiftUI
import UIKit
// import Foundation

@MainActor class superClass: ObservableObject{
    @Published var timeFocus:Int = 0

    @Published var timeFocusCopy:Int = 0
    
    @Published var BreakTime:Int = 0
    @Published var BreakTimeCopy:Int = 0
    @Published var BackgroundImage:String = "Work"
    
    @Published var BackgroundColor:String = ".white"
    @Published var FontColorChanged:String = ".black"
    @Published var FontColor:String = "Color(red:243/255, green: 234/255, blue: 234/255)"
    

    
}


struct ContentView: View {
    @StateObject var Example = superClass()
    
    enum selectState{
        case main
        case settings
        case history
        
    }

    @State var focusButtonShow = false
    @State private var selectedTab: selectState  = .main
    @State private var showDetails = false

 
    

    init(){
        UITabBar.appearance().unselectedItemTintColor = .white
    
    }
    var body: some View {
        ZStack{
            TabView(selection: $selectedTab){
               
                
                MainScreen(focusButtonShow: $focusButtonShow)
                    .tabItem(){
                    Label("MainPage", systemImage: "house")
                        
                    }.tag(".main")
                  
                
                Settings()
                    .tabItem(){
                    Label("Settings", systemImage: "slider.horizontal.3")
                        
                    }.tag(".settings")
                
                historyView()
                    .tabItem(){
                    Label("History", systemImage: "doc.fill")
                        
                    }.tag(".history")
                    
                  
            }.tint(.blue)
            if focusButtonShow{
                Spacer()
                focusCategoryBar(focusButtonShow: $focusButtonShow)
                    .padding(.top, 470)
                 
     
            }
        }.environmentObject(Example)
        

    }

   }

enum btnState{
        case playing
        case paused
        case stopped
    
}




struct MainScreen: View {
    
    
    @State var currentStatusOfBtn:btnState = .paused
    @State var currentStatusOfBtnStop = true
    @Binding var focusButtonShow:Bool
    @EnvironmentObject var dataHolder: superClass

//
//    @Binding var FocusTime:String
//    @Binding  var BreakTime:String
    
//    var focus = DateFormatter()
//
//    let result = focus.string(from: focusTime)
//    print(result)
    
 
    var body: some View{
       
        ZStack(){
            background
            
            VStack(){
                btnFocus(focusButtonShow: $focusButtonShow)
                    .padding(.bottom, 52)
                    
                CircleWatch(currentStatusOfBtn: $currentStatusOfBtn, currentStatusOfBtnStop: $currentStatusOfBtnStop)
                    .padding(.bottom, 30)
                HStack(spacing: 80){
                    playAndPauseButtons(nameOfstate: changeStatusState, action: {checkStatusOfButtonImage()})
                    playAndPauseButtons(nameOfstate: "stop.fill", action: {
                        
                        currentStatusOfBtnStop = true
                    })
                    
                }
                .padding(.bottom, 80)
                
            }
          
            
        }
        
       
    }
    private func checkStatusOfButtonImage() {
        switch currentStatusOfBtn {
        case .playing:
            currentStatusOfBtn = .paused
            currentStatusOfBtnStop = false
        case .paused:
            currentStatusOfBtn = .playing
            currentStatusOfBtnStop = false
        case .stopped:
            currentStatusOfBtn = .stopped
            
        
        }
      
    }
    
    private var changeStatusState:String{
        switch currentStatusOfBtn {
        case .playing:
            return "pause.fill"
        case .paused:
            return "play.fill"
        case .stopped:
            return ""
        }
    }
    var background: some View{
    
        Image("\(dataHolder.BackgroundImage)")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea()
            .padding(0)
            
    }
    
   
    // circle Watch
  

}

struct btnFocus:View{
    @Binding var focusButtonShow:Bool
    @State private var offset: CGFloat = 0
    @State private var scaleValue: CGFloat = 1
    
    var body: some View{
        
        Button(action: {
         
            focusButtonShow = true
        }){
 
              ZStack{
                  Group{
                      ZStack(alignment: .leading){
                          Image(systemName: "pencil")
                              .foregroundColor(.white)
                              .fontWeight(.bold)
                              .padding(.leading, 8)
                          RoundedRectangle(cornerRadius:20)

                            .fill(Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255, opacity: 0.5))
                              .frame(width: 170, height: 35)
                             
                      }

                        Text("Focus Category")
                          .foregroundColor(.white)
                          .fontWeight(.bold)
                          .padding(.leading, 20)
                          
                  }
                      
                               
          
              
              }

        }
     
        
    }
}




struct CircleWatch:View{
    enum SwitchStateWatch{
        case Focused
        case BreakingBad
    }
    @State var StateOfWatch:SwitchStateWatch = .Focused
    
     @EnvironmentObject var dataHolder: superClass
    @State private var progress:CGFloat = 0
    
   
    
    @Binding var currentStatusOfBtn:btnState
    @Binding var currentStatusOfBtnStop:Bool
   
    @State var timeRemaining:String = ""
    @State var LabelFocusOrBreak = "Focus on your task"
    
    
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    

    var body: some View{
        
        ZStack(){
            
            Circle()
                .stroke(.green , lineWidth: 10 )
                .frame(width: 248, height: 248)
            
            Circle()
                .trim(from:  0, to: progress )
                .stroke(.white , lineWidth: 10 )
                .frame(width: 248, height: 248)
                .rotationEffect(Angle(degrees: -90))
            
            VStack(spacing: 20){
                Text("\(timeRemaining)")
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .font(.largeTitle)
                
                Text("\(LabelFocusOrBreak)")
                    .foregroundColor(.white)
                    .fontWeight(.heavy)
                
            } .onReceive(timer, perform: { value in
                
                switch StateOfWatch{
                    
                case .Focused:
                    LabelFocusOrBreak = "Focus on your task"
                    if currentStatusOfBtnStop{
                        progress = 0
                       dataHolder.timeFocus = dataHolder.timeFocusCopy
                      
                        //currentStatusOfBtn = .paused
                        
                        let futureDate = Date(timeIntervalSinceNow: TimeInterval(dataHolder.timeFocus))
                        UpdateTime(futureDate: futureDate)
                        
                    } else if currentStatusOfBtn == .playing && dataHolder.timeFocus > 1 {
                        currentStatusOfBtnStop = false
                        
                        dataHolder.timeFocus -= 1
                        progress = CGFloat(dataHolder.timeFocus)/CGFloat(dataHolder.timeFocus)
                        let futureDate = Date(timeIntervalSinceNow: TimeInterval(dataHolder.timeFocus))
                        UpdateTime(futureDate: futureDate)
                        
                    } else if currentStatusOfBtn == .paused && dataHolder.timeFocus > 1{
                        
                        dataHolder.timeFocus -= 0
                        
                        progress =  CGFloat(dataHolder.timeFocus)/CGFloat(dataHolder.timeFocus)
                        let futureDate = Date(timeIntervalSinceNow: TimeInterval(dataHolder.timeFocus))
                        UpdateTime(futureDate: futureDate)
                        
                    }else{
                        
                        progress =  CGFloat(dataHolder.timeFocus)/CGFloat(dataHolder.timeFocus)
                        dataHolder.BreakTime = dataHolder.BreakTimeCopy
                        StateOfWatch = .BreakingBad
                        
                    }
                    
                case .BreakingBad:
                    LabelFocusOrBreak = "Break time"
                    if currentStatusOfBtnStop == true{
                        progress =  0
                        dataHolder.BreakTime = dataHolder.BreakTimeCopy
                       // currentStatusOfBtn = .paused
                   
                        let futureDate = Date(timeIntervalSinceNow: TimeInterval(dataHolder.BreakTime))
                        UpdateTime(futureDate: futureDate)
                        
                    } else if currentStatusOfBtn == .playing && dataHolder.BreakTime > 1{
                        currentStatusOfBtnStop = false
                        dataHolder.BreakTime -= 1
                        progress =  -CGFloat(dataHolder.timeFocus)
                        let futureDate = Date(timeIntervalSinceNow: TimeInterval(dataHolder.BreakTime))
                        UpdateTime(futureDate: futureDate)
                   
                    } else if currentStatusOfBtn == .paused && dataHolder.BreakTime > 1{
                        progress =  -CGFloat(dataHolder.timeFocus)/10
                        dataHolder.BreakTime -= 0
                        let futureDate = Date(timeIntervalSinceNow: TimeInterval(dataHolder.BreakTime))
                        UpdateTime(futureDate: futureDate)
                     

                    }
                    else{
                        progress =  -CGFloat(dataHolder.timeFocus)/10
                        
                        dataHolder.timeFocus = dataHolder.timeFocusCopy
                        StateOfWatch = .Focused
                    }
                    
                    
                }
                
            })
            
            
        }
    }
    func UpdateTime(futureDate:Date){
        let remaining = Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: futureDate)
                let hour = remaining.hour ?? 0
                let minute = remaining.minute ?? 00
                let second = remaining.second ?? 00
        timeRemaining = "\(hour):\(minute):\(second)"
    }

  
}
struct playAndPauseButtons:View{
    
    let nameOfstate: String
    var action:() -> Void
    var body:some View{

        Button {
            action()
        } label: {
            ZStack{
                Circle()
                    .frame(width: 56, height: 56)
                    .foregroundColor(.white.opacity(0.3))
                Image(systemName: nameOfstate)
                    .foregroundColor(.white)

            }
        }
    }

}


struct focusCategoryBar:View{
    @State var isNight:Bool = false
    @State var variableTitle:String = "Work"
    @Binding var focusButtonShow:Bool
   
    let gridItems = ["Work", "Study", "Workout", "Reading", "Meditation", "Other"]
    
    let gridLayout = Array(repeating: GridItem(.adaptive(minimum: 100)), count: 2)
    
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .frame(width: .infinity, height: 362)

            VStack(spacing: 40){
                HStack{
                    Text("Focus Category")
                        .padding(.leading, 100)
                    Image(systemName: "multiply")
                        .padding(.leading, 70)
                        .onTapGesture {
                        focusButtonShow = false
                        }
                }
                
                LazyVGrid(columns: gridLayout, spacing: 20){
                    ForEach(gridItems, id: \.self) { myRow in
                       
                        MyButton(myRow: myRow, variableTitle: $variableTitle)
                        
                        
                    }
                }
                
                
            }
            
            
        }
        
        
    }
}

struct MyButton: View {
    @EnvironmentObject var dataHolder: superClass
   // @State private var didTap = false    // This will change the color

    let myRow: String    // I'm assuming it's a String, otherwise use the correct type
//    @Binding var BackgroundColor:Colors
//    @Binding var FontColor:Colors

    @Binding var variableTitle: String   // This will change the variable in the

    var body: some View {

                Button{
                    //didTap.toggle()
                   
                    self.variableTitle = self.myRow
                    dataHolder.BackgroundImage = variableTitle
                   
                } label:{
                    Text(myRow)
                        .frame(width: 174, height: 60)
                        .fontWeight(.black)
                        
                        
                }.background(self.variableTitle == self.myRow ? .black : Color(red:243/255, green: 234/255, blue: 234/255))
            .foregroundColor(self.variableTitle == self.myRow ? .white : .black)
                .cornerRadius(10)
    }
}




struct Settings:View{
    @EnvironmentObject var dataHolder: superClass
    
    @State var FocusTimeHours:Int = 0
    @State var FocusTimeMinutes:Int = 0
    @State var FocusTimeSeconds:Int = 0
    
    @State var BreakTimeHours:Int = 0
    @State var BreakTimeMinutes:Int = 0
    @State var BreakTimeSeconds:Int = 0
    @State var editTextField:Bool = false
    
    
    @State private var formatter = NumberFormatter()
    
    
    var body: some View{
        
        VStack{
            HStack(spacing: 80){
                if editTextField{
                    Image(systemName: "arrowshape.turn.up.left")
                        .foregroundColor(.white)
                        .onTapGesture {
                            editTextField = false
                        }
                }
               
                Text("Settings")
                    .foregroundColor(.white)
                if editTextField{
                    Text("Save")
                        .foregroundColor(.white)
                        .onTapGesture {
                            dataHolder.timeFocus = (FocusTimeHours*3600)+(FocusTimeSeconds)+(FocusTimeMinutes*60)

                            dataHolder.timeFocusCopy = (FocusTimeHours*3600)+(FocusTimeSeconds)+(FocusTimeMinutes*60)
                           
                            dataHolder.BreakTime = (BreakTimeHours*3600)+(BreakTimeSeconds)+(BreakTimeMinutes*60)

                            dataHolder.BreakTimeCopy = (BreakTimeHours*3600)+(BreakTimeSeconds)+(BreakTimeMinutes*60)
                       
                                    editTextField = false
                                
                        }
                }
                
            }.background(.black)
            List {
                Section {
                    HStack(){
                        Text("Focus Time")
                            .foregroundColor(.white)
                        Spacer()
                       
                        TextField("fg", value: $FocusTimeHours, formatter:formatter)
                            .onTapGesture {
                                editTextField = true
                            }
                            .frame(width: 23)
                            .keyboardType(.numberPad)
                        
                        Text(":")
                     
                           
                        TextField("mm:", value: $FocusTimeMinutes, formatter: formatter)
                            .onTapGesture {
                                editTextField = true
                            }
                        
                            .frame(width: 23)
                            .keyboardType(.numberPad)
                        Text(":")
                        TextField("ss", value: $FocusTimeSeconds, formatter: formatter)
                            .onTapGesture {
                                editTextField = true
                            }
                            
                            .frame(width: 23)
                            .keyboardType(.numberPad)
                    }.background(.black)
                }.listRowBackground(Color.black)
                    .foregroundColor(editTextField ? .white : .gray)
                Section {
                    HStack(){
                        
                        Text("Break Time")
                            .foregroundColor(.white)
                            Spacer()
                        TextField("hh:", value: $BreakTimeHours, formatter: formatter)
                            .onTapGesture {
                                editTextField = true
                            }
                      
                            .frame(width: 23)
                            .keyboardType(.numberPad)
                        Text(":")
                        TextField("mm:", value: $BreakTimeMinutes, formatter: formatter)
                            .onTapGesture {
                                editTextField = true
                            }
                
                            .frame(width: 23)
                            .keyboardType(.numberPad)
                        Text(":")
                        TextField("ss", value: $BreakTimeSeconds, formatter: formatter)
                            
                            .onTapGesture {
                                editTextField = true
                            }
                           
                            .frame(width: 23)
                            .keyboardType(.numberPad)
                    }.background(.black)
                }.listRowBackground(Color.black)
                .foregroundColor(editTextField ? .white : .gray)
              
            }
            .background(.black)
            
            .scrollContentBackground(.hidden)


                
          
            
            
        }.background(.black)
        
        
    }
}
        
    
        






    


struct historyView:View{
    @State private var numOfPeople = "0"
    
    var body: some View{
        VStack{
            Text("History")
                .foregroundColor(.white)
            List{
                reusableContent(dateTime: "21.11.21", nameOfTime: "Focus Time", amountOfTime: "01:28:32")
                reusableContent(dateTime: "21.11.21", nameOfTime: "Focus Time", amountOfTime: "01:28:32")
                reusableContent(dateTime: "21.11.21", nameOfTime: "Focus Time", amountOfTime: "01:28:32")
                      
            }.listStyle(.plain)
              
        }.background(Color(red: 28/255, green: 28/255, blue: 30/255))
        
        
    }
}
struct reusableContent:View{
    @State private var numOfPeople = "0"
    let dateTime: String
    let nameOfTime: String
    let amountOfTime: String
    
    var body: some View{
        VStack(alignment: .leading){
            Text(dateTime)
                .foregroundColor(.white)
                .font(.system(size: 24, weight: .bold))
        HStack(spacing: 190){
            Text(nameOfTime)
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .bold))
            Text(amountOfTime)
                .foregroundColor(.white)
                .ignoresSafeArea()
                
                
        }.listRowBackground(Color(red: 28/255, green: 28/255, blue: 30/255))
            
        }.listRowBackground(Color(red: 28/255, green: 28/255, blue: 30/255))
        
       

    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {

        ContentView().environmentObject(superClass())
          
    }
}


//struct dateId:Identifiable{
//    let id: Int
//    let focus: Int
//    let breakT: Int
//}

//struct LisOfId: View {
//
//    private let historyList: [dateId] = [
//            .init(id: 1, focus: 25, breakT: 5)
//            .init(id: 1, focus: 25, breakT: 5))
//            .init(id: 1, focus: 25, breakT: 5)
//    ]
//
//}

//optional func textField(
//    _ textField: UITextField,
//    shouldChangeCharactersIn range: NSRange,
//    replacementString string: String
//) -> Bool
//
//struct settedTimes{
//    @Binding private var FocusTime = "0"
//
//    @Binding private var BreakTime = "0"
//
//}




//struct myButton:View{
//    @State var tapped = false
//
//    var body: some View{
////        UID(title: myRow, textColor: .black, backgroundColor: didTap ? .red : .green)
//        Text("hello")
//            .foregroundColor(.black)
//            .font(.system(size: 16))
//            .fontWeight(.black)
//            .frame(width:172, height: 60)
//            .backgroundColor: tapped ? .red : .green
//            .cornerRadius(10)
//            .onTapGesture {
//
//            }
//    }
//}


//===========Lazy Grid Example below ================================================
//    let gridItems = ["Work", "Study", "Workout", "Reading", "Meditation", "Other"]
//
//    let gridLayout = Array(repeating: GridItem(.adaptive(minimum: 100)), count: 2)
//
//        ZStack{
//            RoundedRectangle(cornerRadius: 10)
//                .fill(.green)
//                .frame(width: .infinity, height: 362)
//            VStack(alignment: .center){
//                HStack(){
//                    Text("Focus Category")
//                        .font(.system(size: 16))
//                        .fontWeight(.semibold)
//                        .padding(.leading, 120)
//
//                    Image(systemName: "multiply")
//                        .padding(.leading, 100)
//
//
//                }.padding(.bottom, 40)
//
//
//                LazyVGrid(columns: gridLayout, spacing: 20){
//                    ForEach((gridItems), id: \.self){item in
//                        Button {
//                                print(item)
//                        } label: {
//                            if tapped{
//                                Text(item)
//                                    .foregroundColor(.white)
//                                    .font(.system(size: 16))
//                                    .fontWeight(.black)
//                                    .frame(width:172, height: 60)
//                                    .background(Color(red:244/255, green:244/255, blue:244/255))
//                                    .cornerRadius(10)
//                            }
//                            else{
//                                Text(item)
//                                    .foregroundColor(.black)
//                                    .font(.system(size: 16))
//                                    .fontWeight(.black)
//                                    .frame(width:172, height: 60)
//                                    .background(Color(red:244/255, green:244/255, blue:244/255))
//                                    .cornerRadius(10)
//                            }
//
//
//                        }
//                    }
//
//            }
//
//            }
//
//
//        }
//
//
    

//Picker("", selection: $FocusTimeHours){
//                        ForEach(0..<24, id: \.self) { i in
//                            Text("\(i) h").tag(i)
//                                .foregroundColor(.white)
//                        }
//                    }.pickerStyle(WheelPickerStyle())
//
//                    Picker("", selection: $FocusTimeMinutes){
//                        ForEach(0..<60, id: \.self) { i in
//                            Text("\(i) m").tag(i)
//                                .foregroundColor(.white)
//                        }
//                    }.pickerStyle(WheelPickerStyle())
//
//                    Picker("", selection: $FocusTimeSeconds){
//                        ForEach(0..<60, id: \.self) { i in
//                            Text("\(i) s").tag(i)
//                                .foregroundColor(.white)
//                        }
//                    }.pickerStyle(WheelPickerStyle())
//                }.listRowBackground(Color(red: 28/255, green: 28/255, blue: 30/255))
//
//
//                HStack(){
//
//                    Text("Break Time")
//                        .foregroundColor(.white)
//                    Picker("", selection: $BreakTimeHours){
//                        ForEach(0..<24, id: \.self) { i in
//                            Text("\(i) h").tag(i)
//                                .foregroundColor(.white)
//                        }
//                    }.pickerStyle(WheelPickerStyle())
//                    Picker("", selection: $BreakTimeMinutes){
//                        ForEach(0..<60, id: \.self) { i in
//                            Text("\(i) m").tag(i)
//                                .foregroundColor(.white)
//                        }
//                    }.pickerStyle(WheelPickerStyle())
//
//                    Picker("", selection: $BreakTimeSeconds){
//                        ForEach(0..<60, id: \.self) { i in
//                            Text("\(i) s").tag(i)
//                                .foregroundColor(.white)
//                        }
//
//                    }.pickerStyle(MenuPickerStyle())

       
//            Button {
//                focustime = (FocusTimeHours/360)+(FocusTimeSeconds)+(FocusTimeMinutes/60)
//                breaktime = (BreakTimeHours/360)+(BreakTimeMinutes/60)+(BreakTimeSeconds)
//                print(focustime)
//                print(breaktime)
//
//            } label: {
////
//                    Text("save")
//                    .foregroundColor(.white)
//            }

          
