//
//  OnBoarding.swift
//  FinalProject
//
//  Created by Abylay Duzel on 23.05.2023.
//

import SwiftUI

struct OnBoarding: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
struct TapViewOnBoard: View{
    @State var numberTabCounter:Int = 0
    @Binding var onBoardingBool:Bool
    
    var body: some View{
        
        TabView(selection: $numberTabCounter){
            ZStack{
                Image("1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 398, height:532)
                    .padding(.bottom, 300)
                    .padding(.trailing, 44)
                Image("2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 272, height: 192)
                    .padding(.bottom, 565)
                    .padding(.top, 124)
                    .padding(.leading, 162)
                Image("v1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 580, height: 442)
                    .padding(.top, 600)
                
                CostumTabBar(bottomSheetText: "Get all of your desired sneakers in one place.", buttonText: "Next", onBoardingBool: $onBoardingBool, numberTabCounter: $numberTabCounter)
                    .padding(.top, 595)
                
            }.tag(0)
            
            ZStack{
                Image("3")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 361, height:484)
                    .padding(.bottom, 326)
                    .padding(.trailing, 104)
                Image("4")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 272, height: 192)
                    .padding(.bottom, 565)
                    .padding(.top, 65)
                    .padding(.leading, 105)
                Image("v2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 580, height: 442)
                    .padding(.top, 400)
                CostumTabBar(bottomSheetText: "Get all of your desired sneakers in one place.", buttonText: "Next", onBoardingBool: $onBoardingBool, numberTabCounter: $numberTabCounter)
                    .padding(.top, 595)
                
            }.tag(1)
            
            ZStack{
                Image("5")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 398, height:532)
                    .padding(.bottom, 300)
                    .padding(.trailing, 44)
                Image("6")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 272, height: 192)
                    .padding(.bottom, 565)
                    .padding(.top, 124)
                    .padding(.leading, 162)
                Image("v3")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 580, height: 442)
                    .padding(.top, 400)
                    .clipped()
                CostumTabBar(bottomSheetText: "Get all of your desired sneakers in one place.", buttonText: "Finish", onBoardingBool: $onBoardingBool, numberTabCounter: $numberTabCounter)
                    .padding(.top, 595)
                
            }.tag(2)
            
        }.ignoresSafeArea()
            .tabViewStyle(PageTabViewStyle())
          
    }
}
// MARK: code for refactoring
//struct ImageSetter:View{
//    var imageName:String
//    var trailingPadding:CGFloat?
//    var leadingPadding:CGFloat?
//    var bottomPadding:CGFloat?
//    var topPadding:CGFloat?
//    var frameHeight:CGFloat?
//    var frameWidth:CGFloat?
//
//    var body: some View{
//        ZStack{
//            Image(imageName)
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width: frameWidth, height:frameWidth)
//                .padding(.bottom, bottomPadding)
//                .padding(.trailing, trailingPadding)
//            Image("6")
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width: 272, height: 192)
//                .padding(.bottom, 565)
//                .padding(.top, 124)
//                .padding(.leading, 162)
//            Image("v3")
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width: 580, height: 442)
//                .padding(.top, 400)
//                .clipped()
//            CostumTabBar(bottomSheetText: "Get all of your desired sneakers in one place.", buttonText: "Next")
//                .padding(.top, 545)
//
//        }
//    }
//}



struct CostumTabBar:View{
    var bottomSheetText: String
    var buttonText: String
    @Binding var onBoardingBool:Bool
    @Binding var numberTabCounter:Int
    
    var body: some View{
        
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .fill(.red)
                .frame(width: 390, height: 298)
            VStack(spacing: 16){
                Text("Fast Shipping")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(.system(size: 28))
                Text(bottomSheetText)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .font(.system(size: 17))
                ZStack{
                    Capsule()
                        .frame(width: 380, height: 50)
                    Text(buttonText)
                        .foregroundColor(.white)
                }.padding(.top, 24)
                    .onTapGesture {
                        numberTabCounter = numberTabCounter + 1
                        if numberTabCounter == 3{
                         onBoardingBool = false
                        }

                    }
            }
            
        }
        
    }
}

struct OnBoarding_Previews: PreviewProvider {
    static var previews: some View {
        OnBoarding()
    }
}
