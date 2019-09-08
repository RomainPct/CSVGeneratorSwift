//
//  File.swift
//  
//
//  Created by Romain Penchenat on 08/09/2019.
//

import Foundation
@testable import CSVGeneratorSwift

struct Car : CSVExportable {
    
    var CSVFields: [Any] {
        return [name,dimensions,engine]
    }
    
    let name:String
    let dimensions:[Int]
    let engine:Engine
    
}

struct Engine : CSVExportable {
    
    var CSVFields: [Any] {
        return [type,autonomy]
    }
    
    enum EngineType : String {
        case electric
        case hybrid
        case combustion
        
    }
    
    let type:EngineType
    let autonomy:Int // Kilometers
}

class User: CSVExportable {
    
    init(id:Int, firstName:String, lastName:String, cars:[Car]) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.cars = cars
    }
    
    var CSVFields: [Any] {
        return [id,fullName,cars]
    }
    
    let id:Int
    let firstName:String
    let lastName:String
    let cars:[Car]
    
    var fullName: String {
        return "\(firstName) \(lastName)"
    }

}

struct Quote : CSVExportable {
    
    var CSVFields: [Any] {
        return [text,writtingDate]
    }
    
    let writtingDate = Date(timeIntervalSinceReferenceDate: 26000)
    let text:String
}
