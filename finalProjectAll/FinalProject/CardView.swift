//
//  CardView.swift
//  FinalProject
//
//  Created by Abylay Duzel on 29.05.2023.
//

import SwiftUI

var arrayOfCardItems = [SneakerOneEx]()

struct CardView: View {
    var body: some View {
        ZStack{
           
            List{
                ForEach(arrayOfCardItems) { cardSneaker in
                    CardItemEx(SC: cardSneaker)
                    
                }
            }
            
            Button {
//
            } label: {
                ZStack{
                    Capsule()
                        .fill(.black)
                        .frame(width: 380, height: 50)
                        
                    Text("Confirm Order")
                        .foregroundColor(.white)
                }
            }.padding(.top, 600)
       
        }

    }
}
struct CardItemEx:View{
    var SC: SneakerOneEx
    @State var sneakerAmout:Int = 1
    var body: some View{
        HStack{
            Image(SC.sneakerImage!)
                .resizable()
                .frame(width: 140, height: 140)
            VStack{
                Text(SC.sneakerName!)
                Text(SC.sneakerDescription!)
                Text(SC.sneakerPrice!)
                ZStack{
                    Capsule()
                        .frame(width: 150, height: 36)
                    HStack(alignment: .center, spacing: 40){
                        Text("+")
                            .foregroundColor(.white)
                            .onTapGesture {
                                sneakerAmout = sneakerAmout + 1
                                SC.sneakerAmount = sneakerAmout
                                print(SC.sneakerAmount)
                            }
    
                        Text("\(sneakerAmout)")
                            .foregroundColor(.white)
                           
                        
                        Text("-")
                            .foregroundColor(.white)
                            .onTapGesture {
                                if sneakerAmout > 1{
                                    sneakerAmout = sneakerAmout - 1
                                    SC.sneakerAmount = sneakerAmout
                                    SC.sneakerAmount = sneakerAmout
                                }
                               
                            }
                               
                    }
                  
                }

            }
        }
    
        
    }
}




struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
