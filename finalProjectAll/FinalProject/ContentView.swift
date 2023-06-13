//
//  ContentView.swift
//  FinalProject
//
//  Created by Abylay Duzel on 21.05.2023.
//

import SwiftUI


struct ContentView: View {
    @AppStorage("shouldShowOnBoardingPage") var onBoardingBool = true
    
    var body: some View {
        NavigationView{
            SignUpPage()
        }
        .fullScreenCover(isPresented: $onBoardingBool, content: {
            TapViewOnBoard(onBoardingBool: $onBoardingBool)
            })
            
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
