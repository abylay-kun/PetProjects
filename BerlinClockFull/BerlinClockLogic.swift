//
//  main.swift
//  BerlinClock
//
//  Created by Abylay Duzel on 03.04.2023.
//

import Foundation

class BerlinClock{
    
    typealias completionType = ((TimeRepresentation) -> Void)?
    
    var hours:Int?{
        didSet {
            guard let hours = hours else{return}
            getHoursArray(hours)
        }
    }
    var minutes:Int?{
        didSet {
            guard let minutes = minutes else{return}
            getMinutesArray(minutes)
        }

    }
    var seconds:Int?{
        didSet {
            guard let seconds = seconds else{return}
            getSecondsArray(seconds)
        }
    }
    
    
    init() {
        print("Welcome to Berlin Clock")
        
        askForTime("hours", type: .hours(), completion: {[weak self] timeRep in self?.hours = timeRep.timeAmount
            
        })
        askForTime("minutes", type: .minutes(), completion: {[weak self] timeRep in self?.minutes = timeRep.timeAmount
        })
        askForTime("seconds", type: .seconds(), completion:{[weak self] timeRep in self?.seconds = timeRep.timeAmount
    
})
        
    }
    
    func askForTime(_ name: String, type: BerlinClockInput, completion: completionType) {
        print("please Enter the \(name): ")
        if let readLineInput = readLine(){
            do {
                let timeRepresentation =  try TimeRepresentation(type: type, readLineInput: readLineInput)
                completion?(timeRepresentation)
            } catch let error {
                guard let error = error as? inputError else { return }
                print("\(error.errorMessage)")
                askForTime(name, type: type, completion: nil)
                
                 
                
            }
            
            
        }
        
    }
    func getHoursArray(_ hours: Int){
        print("hours:")
            let fiveHoursRow = TimeConverter.getFiveHoursRow(hours)
            let singleHoursRow = TimeConverter.getSingleHoursRow(hours)
            
        
        print("\(fiveHoursRow)")
        print("\(singleHoursRow)")
        
   
        }
    
    func getMinutesArray(_ minutes: Int){
        print("minutes :")
        let fiveMinutesRow = TimeConverter.getFiveMinutesRow(minutes)
        let singleMinutesRow = TimeConverter.getSingleMinutesRow(minutes)
        
        print("\(fiveMinutesRow)")
        print("\(singleMinutesRow)")
        
    }
    func getSecondsArray(_ seconds: Int){
        print("seconds:")
        let secondsRow = TimeConverter.getSecondsRow(seconds)
        
        print("\(secondsRow)")
    }
}
    
    enum BerlinClockInput  {
        case hours(limit:Int = 24)
        case minutes(limit:Int = 60)
        case seconds(limit:Int = 60)
    }
    
    struct TimeRepresentation{
        
        let timeAmount: Int
        
        init(type: BerlinClockInput, readLineInput: String) throws {
            
            switch type{
                
            case .hours(let limit):
                timeAmount = try TimeRepresentation.checkReadLineValue(limit: limit, readLineValue: readLineInput)
            case .minutes(let limit):
                timeAmount = try TimeRepresentation.checkReadLineValue(limit: limit, readLineValue: readLineInput)
            case .seconds(let limit):
                timeAmount = try TimeRepresentation.checkReadLineValue(limit: limit, readLineValue: readLineInput)
                
            }
            
            
        }
        static func checkReadLineValue(limit: Int, readLineValue: String) throws -> Int {
            guard let timeAmount = Int(readLineValue) else { throw inputError.wrongInputType }
            if timeAmount >= 0 && timeAmount < limit{
                return timeAmount
            }
            else{
                throw inputError.exceededAmount
            }
        }
    }
    
    
    
    enum inputError: Error{
        case wrongInputType
        case exceededAmount
        
        var errorMessage: String{
            switch self {
            case.wrongInputType:
                return "Oops, Seems like you write incorrect input"
                
            case .exceededAmount:
                return "the amount is exceeded"
            }
        }
        
    }
    extension String{
        var isNumber:Bool{
            let digitsChar = CharacterSet(charactersIn: "1234567890")
            return CharacterSet(charactersIn: self).isSubset(of: digitsChar)
        }
    }

struct TimeConverter{
    
    static func getFiveHoursRow(_ hours: Int ) -> [Bool]{
            getLights(hours / 5, 4)
    }
    
    static func getSingleHoursRow(_ hours: Int ) -> [Bool]{
            getLights(hours % 5, 4)
    }
    
    static func getFiveMinutesRow(_ minutes: Int ) -> [Bool]{
            getLights(minutes / 5, 11)
    }
    static func getSingleMinutesRow(_ minutes: Int ) -> [Bool]{
            getLights(minutes % 5, 4)
    }
    static func getSecondsRow(_ seconds: Int ) -> [Bool]{
        if seconds % 2 == 0{
            return [true]
        }else {
            return [false]
        }

    }
    
    static func getLights(_ turnedOn: Int, _ totalCountsOfBulps: Int) -> [Bool]{
        let onBulps = Array(repeating: true, count: turnedOn)
        let offBulps = Array(repeating: false, count: totalCountsOfBulps - turnedOn)
        
        return onBulps + offBulps
        
    }
    
}
    
    
    
    
    
let bc = BerlinClock()



