# CSVGeneratorSwift
A `really lightweight` library to easily export `any array or dictionary` to a CSV spreadsheet.\
It's also `customizable` and support  `Swift 5.1` !
#### Table of Contents  
1. [Installation](#import)  
2. [Make your class and struct compatible](#step1)
3. [Generate a CSV spreadsheet from any array or dictionary](#step2)
4. [Custom the CSV Generator](#step3)

<a name="import"/>

## Installation

#### Swift Package Manager
```swift
.package(url: "https://github.com/RomainPct/CSVGeneratorSwift", from: "1.0.0")
```

#### Carthage
```swift
github "RomainPct/CSVGeneratorSwift"
```

<a name="step1"/>

## How to generate a CSV spreadsheet ?
### 1. Use the CSVExportable protocol to make your classes and structs compatible.
Make any Struct or Class compatible with CSVGeneratorSwift by implementing the lightweight CSVExportable protocol.\
Just define a varget called CSVFields which return an array of the values you want in your output CSV file.\
Order values according to the output organization you want.
```swift
struct Car : CSVExportable {
    var CSVFields: [Any] {
        return [name,dimensions,engine]
    }
    
    let name:String
    let dimensions:[Int]
    let engine:Engine
}
```
If you use a subobject, make it also conform to CSVExportable protocol.\
In this exemple, the Car struct has a variable of type Engine, therefore we make Engine struct conform to CSVExportable protocole.
```swift
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
```

<a name="step2"/>

### 2. Generate a CSV spreadsheet from any array or dictionary of CSVExportable conform struct or class
1. Create a CSVGeneratorSwift instance
2. Call the generate function passing your array/dictionary as first parameter
3. Pass an optional file name to the generate function *Default is your struct/class name with a "s" (ex : The output of an array of Car instances is called "Cars")*
4. Read the result (which is a Swift.Result that help you to ensure a clean and readable code).
5. If the operation succed, do what you want with the file url (share it with the user, save it somewhere...)
6. Else, handle the error

```swift
let cars:[Car] = [
    Car(name: "Taycan", dimensions: [4684,1923,1624], engine: Engine(type: .electric, autonomy: 500)),
    Car(name: "C-HR", dimensions: [4360,1795,1565], engine: Engine(type: .hybrid, autonomy: 1132)),
    Car(name: "Model X", dimensions: [5052,1999,1684], engine: Engine(type: .electric, autonomy: 565))
]

let generator = CSVGeneratorSwift()

let csvResult = generator.generate(from: cars, name: "My cool cars !")

switch csvResult {

case .success(let url):
    print("Do what you want with the CSV file url : \(url)")
    
case .failure(let error):
    print("CSV generation failed : \(error.localizedDescription)")
}
```

<a name="step3"/>

### 3. Custom the CSV Generator
#### File destination
Choose the destination you want for the CSV File.\
*Default is temporary directory.*
```swift
generator.destination = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
```
#### String enconding
Each String.Encoding case is avalaible.\
*Default is .utf8.*
```swift
generator.encoding = .utf16
```
#### CSV format ( Column separator and line end symbols )
Edit the CSV format easily.\
*Default values are the more common patterns for CSV : a comma (,) as column separator and a line break (\n) as line end symbol.*
```swift
generator.columnSeparator = ";"
generator.lineEnd = "\n"
```
#### JSON writing options
Each JSONSerialization.WritingOptions case is avalaible. It's usefull if the object you whant to insert in your spreadsheet contains array or dictionnaries variables.\ 
*Default is .prettyPrinted.*
```swift
generator.jsonWritingOptions = .fragmentsAllowed
```
#### Date format
Customize the output for Date object you insert as CSVField.\
*Default is "yyyy-MM-dd HH:mm:ss +zzzz".*
```swift
generator.dateFormat = "dd-MM-YYYY"
```
