//
//  File.swift
//  
//
//  Created by Romain Penchenat on 06/09/2019.
//

import Foundation

let quotes = [
    Quote(text: #""Dans la vie, on ne fait pas ce que l'on veut mais on est responsable de ce que l'on est.""#),
    Quote(text: #""There is nothing permanent; except change.""#),
    Quote(text: "Mieux vaut une conscience tranquille qu'une destinée prospère. J'aime mieux un bon sommeil qu'un bon lit."),
]

let CSVString_quotes:String = #"""
"""Dans la vie, on ne fait pas ce que l'on veut mais on est responsable de ce que l'on est.""","2001-01-01 07:13:20 +0000"
"""There is nothing permanent; except change.""","2001-01-01 07:13:20 +0000"
"Mieux vaut une conscience tranquille qu'une destinée prospère. J'aime mieux un bon sommeil qu'un bon lit.","2001-01-01 07:13:20 +0000"
"""#

let quotesDictionary:[String:Quote] = [
    "1DD5" : Quote(text: #""Dans la vie, on ne fait pas ce que l'on veut mais on est responsable de ce que l'on est.""#)
]

let CSVString_quotesDictionnary:String = #"""
"1DD5","""Dans la vie, on ne fait pas ce que l'on veut mais on est responsable de ce que l'on est.""","2001-01-01 07:13:20 +0000"
"""#

let dict = [
    "Lea" : "Tralalalalal"
]

let CSVString_dict:String = #"{""Lea"":""Tralalalalal""}"#

let cars:[Car] = [
    Car(name: "Taycan", dimensions: [4684,1923,1624], engine: Engine(type: .electric, autonomy: 500)),
    Car(name: "C-HR", dimensions: [4360,1795,1565], engine: Engine(type: .hybrid, autonomy: 1132)),
    Car(name: "Model X", dimensions: [5052,1999,1684], engine: Engine(type: .electric, autonomy: 565))
]

let CSVString_cars:String = #"""
"Taycan","[4684,1923,1624]","electric","500"
"C-HR","[4360,1795,1565]","hybrid","1132"
"Model X","[5052,1999,1684]","electric","565"
"""#

let users:[User] = [
    User(id: 0, firstName: "Romain", lastName: "Penchenat", cars: [cars[1],cars[2]]),
    User(id: 1, firstName: "Arthur", lastName: "Faure", cars: [cars[0]])
]

let CSVString_users:String = #"""
"0","Romain Penchenat","[""C-HR\"",\""[4360,1795,1565]\"",\""hybrid\"",\""1132"",""Model X\"",\""[5052,1999,1684]\"",\""electric\"",\""565""]"
"1","Arthur Faure","[""Taycan\"",\""[4684,1923,1624]\"",\""electric\"",\""500""]"
"""#

let trucks:[Truck] = [
    Truck(name: "Cybertruck", engine: Engine(type: .electric, autonomy: 400), optionalFields: ["style":"wahou", "color":"grey"]),
    Truck(name: "Rolls de José", engine: Engine(type: .combustion, autonomy: 800), optionalFields: ["style":"campagne"])
]

let CSVString_trucks:String = #"""
"Cybertruck","electric","400","{  ""color"" : ""grey"",  ""style"" : ""wahou""}"
"Rolls de José","combustion","800","{  ""style"" : ""campagne""}"
"""#
