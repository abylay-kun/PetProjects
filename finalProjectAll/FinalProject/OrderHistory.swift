//
//  OrderHistory.swift
//  FinalProject
//
//  Created by Abylay Duzel on 30.05.2023.
//

import SwiftUI
struct OrderHistoryData:Identifiable{

    
    var id = UUID().uuidString
    
    
    var historyOrderImage: String
    var historyOrderName:String
    var historyOrderDate:String
    var historyOrderAmount:Int?
    var historySneakerPrice: String
    
    var historyOrderedSneakerModel:String?
    var historyOrderedSneakerPrice:String?
    var historyOrderedSneakerDescriprion:String?
}
struct OrderHistoryModel:Identifiable{
    
    var id = UUID().uuidString
    var historyOrderImage: String
    var historyOrderedSneakerModel:String?
    var historyOrderedSneakerPrice:String?
    var historyOrderedSneakerDescriprion:String?
    
}

var historySneakersArray = [
    
    OrderHistoryData(historyOrderImage: "1", historyOrderName: "#123", historyOrderDate: "11.12.22", historyOrderAmount: 4, historySneakerPrice: "445$", historyOrderedSneakerModel: "Nuke", historyOrderedSneakerPrice: "200$", historyOrderedSneakerDescriprion: "new shoe with cool looking")
]

struct OrderHistory: View {
    var body: some View {
        
            List{
                
                ForEach(historySneakersArray) { sneaker in
                    NavigationLink(destination: DetailsOfHistory(HS: sneaker)){
                        OrderEx(HS: sneaker)
                    }
                   
                }.padding(.top, 16)
            }.listStyle(.grouped)
              
        
      
        
    }
}

struct OrderEx:View{
    
    var HS:OrderHistoryData
    
    var body: some View{
        HStack{
            ZStack{
                Rectangle()
                    .fill(.gray)
                    .frame(width: 120, height: 100)
                    
                ZStack{
                    Image(HS.historyOrderImage)
                        .resizable()
                        .cornerRadius(100)
                        .frame(width: 44, height: 44)
                        .padding(.trailing, 70)
                    Image(HS.historyOrderImage)
                        .resizable()
                        .cornerRadius(100)
                        .frame(width: 44, height: 44)
                    Image(HS.historyOrderImage)
                        .resizable()
                        .cornerRadius(100)
                        .frame(width: 44, height: 44)
                        .padding(.leading, 70)
                }
            }
            VStack{
                Text(HS.historyOrderName)
                Text(HS.historyOrderDate)
                let hsOrderAmount = String(HS.historyOrderAmount!)
                Text("\(hsOrderAmount)")
            }
           
            
        }
    }
}

struct DetailsOfHistory:View{
    var HS:OrderHistoryData
    
//    var historyOrderedSneakerModel:String?
//    var historyOrderedSneakerPrice:String?
//    var historyOrderedSneakerDescriprion:String?
    
    var body: some View{
        
        List{
            HStack{
                Text("Ordered")
                Text(HS.historyOrderDate)
            }.frame(width: .infinity, height: 50)
            HStack{
                Text("5 items:Total (Including Delivery) \(HS.historySneakerPrice)")
                
            }.frame(width: .infinity, height: 50)
            VStack{
                ForEach(arrayOfCardItems) { sneaker in
                    CardItemEx(SC: sneaker)
                }
            }
            
        }.listStyle(.inset)
    }
}

struct OrderHistory_Previews: PreviewProvider {
    static var previews: some View {
        OrderHistory()
    }
}
