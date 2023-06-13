//
//  SneakerCollection.swift
//  FinalProject
//
//  Created by Abylay Duzel on 25.05.2023.
//

import SwiftUI
struct costomBtn:View{
    var text:String
    var body: some View{
       
            ZStack{
                Capsule()
                    .fill(.black)
                    .frame(width: 380, height: 50)
                    
                Text(text)
                    .foregroundColor(.white)
            }
        
    }
}


struct SneakerCollection: View {
    var body: some View {
        TabView{
           listOfSneakers()
                .tabItem{
                    Image(systemName: "pencil")
                    Text("Catalog")
                }
            CardView()
                .tabItem{
                    Image(systemName: "pencil")
                    Text("Card")
                }
            UserProfile()
                .tabItem{
                    Image(systemName: "square.and.arrow.up")
                    Text("Profile")
                }
        }
        
    }
}

// MARK: ARRAY SHOULD FILLED FROM DATABASE
var SneakersArray = [
    
    SneakerOneEx(sneakerImage: "Sneaker1", sneakerName: "nuke", sneakerDescription: "coolShoes", sneakerPrice: "200$"),
    SneakerOneEx(sneakerImage: "Sneaker2", sneakerName: "nuke", sneakerDescription: "coolShoes", sneakerPrice: "200$"),
    SneakerOneEx(sneakerImage: "Sneaker3", sneakerName: "nuke", sneakerDescription: "coolShoes", sneakerPrice: "200$"),
    SneakerOneEx(sneakerImage: "Sneaker4", sneakerName: "nuke", sneakerDescription: "coolShoes", sneakerPrice: "200$"),
    SneakerOneEx(sneakerImage: "Sneaker5", sneakerName: "nuke", sneakerDescription: "coolShoes", sneakerPrice: "200$"),
    SneakerOneEx(sneakerImage: "Sneaker6", sneakerName: "nuke", sneakerDescription: "coolShoes", sneakerPrice: "200$"),

]

// MARK: Shows arrayof sneaker to user
struct listOfSneakers:View{
  
    var body: some View{
        
        ScrollView{
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 2), spacing: 15){
                ForEach(SneakersArray) { sneaker in
                    SneakerModel(sneakersModel: sneaker)
                }
            }
        }.background(.gray)
        
       
    }
}

// MARK: State of buttom refers to
enum stateOfBtn:String{
    case add = "Add to Cart"
    case remove = "Remove"
}


struct SneakerModel:View{

    var sneakersModel: SneakerOneEx
    @State var buttonStatus:stateOfBtn = .add
    
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .frame(width: 174, height: 282)
                
            VStack{
                Image(sneakersModel.sneakerImage!)
                    .resizable()
                    .frame(width: 166, height: 166)
                Text(sneakersModel.sneakerName!)
                    .foregroundColor(.black)
                    .font(.system(size: 13))
                Text(sneakersModel.sneakerDescription!)
                    .foregroundColor(.gray)
                    .font(.system(size: 12))
                Text(sneakersModel.sneakerPrice!)
                    .foregroundColor(.black)
                    .font(.system(size: 12))
             
                   
                    Button {
                        switch buttonStatus{
                        case .add:
                            buttonStatus = .remove
                            changeButtonText(itemToAdd: sneakersModel, addOrRemove: .add)
                            
                        case .remove:
                            buttonStatus = .add
                            changeButtonText(itemToAdd: sneakersModel, addOrRemove: .remove)
                           
                        
                        }
                        
                        
                    } label: {
                       
                        ZStack{
                            Capsule()
                            .fill(.black)
                            .frame(width: 166, height: 40)
                        Text(sneakersModel.buttonState.rawValue)
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                        }
                    }
            }
        
        }
       
    }
}

func changeButtonText(itemToAdd:SneakerOneEx, addOrRemove:stateOfBtn){
    if addOrRemove == .add{
        arrayOfCardItems.append(itemToAdd)
    }
    else if addOrRemove == .remove{
        arrayOfCardItems.removeLast()
    }
    
}

// MARK: One example sneaker 
struct SneakerOneEx:Identifiable{
    var id = UUID().uuidString
    
    
    var sneakerImage: String?
    var sneakerName:String?
    var sneakerDescription:String?
    var sneakerPrice:String?
    @State var sneakerAmount:Int = 1
    
    @State var buttonState:stateOfBtn = .add
    
}


    
struct SneakerCollection_Previews: PreviewProvider {
    static var previews: some View {
        SneakerCollection()
    }
}
