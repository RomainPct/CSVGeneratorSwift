//
//  CSVGeneratorSwift.swift
//
//
//  Created by Romain Penchenat on 05/09/2019.
//

import Foundation

class CSVGeneratorSwift {
    
//    MARK: File options
    var encoding:String.Encoding = .utf8
    var destination:URL?
        
//    MARK: CSV rules options
    var columnSeparator = ","
    var lineEnd = "\n"
        
//    MARK: Formatting options
    var dateFormat:String?
    var jsonWritingOptions:JSONSerialization.WritingOptions = .prettyPrinted
    
//    MARK: CSV Generation functions for arrays
    func generate<T : CSVExportable>(from data:[T], name:String = "\(String(describing: T.self))s") -> Result<URL,Error> {
        let csvString = getCSVString(from: data)
        return saveCSV(text: csvString, name: name)
    }
    
    internal func getCSVString<T : CSVExportable>(from data:[T]) -> String {
        return data.map { (csvExportable) -> String in
            return getRow(fromFields: csvExportable.CSVFields)
        }.joined(separator: lineEnd)
    }
    
//    MARK: CSV Generation functions for dictionnaries
    func generate<T : CSVExportable>(from data:[AnyHashable:T], name:String = "\(String(describing: T.self))s") -> Result<URL,Error> {
        let csvString = getCSVString(from: data)
        return saveCSV(text: csvString, name: name)
    }
    
    internal func getCSVString<T : CSVExportable>(from data:[AnyHashable:T]) -> String {
        return data.map { (dict) -> String in
            var fields = dict.value.CSVFields
            fields.insert(dict.key, at: 0)
            return getRow(fromFields: fields)
        }.joined(separator: lineEnd)
    }
    
//    MARK: CSV Generation functions
    internal func getRow(fromFields fields: [Any]) -> String {
        return fields.map { (cell) -> String in
            return #""\#(self.getCSVExportableValue(cell))""#
        }.joined(separator: columnSeparator)
    }
    
    internal func getUnderRow(from csvExportable:CSVExportable) -> String {
        var underRow = csvExportable.CSVFields.map { (cell) -> String in
            return #""\#(self.getCSVExportableValue(cell))""#
        }
        .joined(separator: columnSeparator)
        underRow = String(underRow.dropFirst())
        underRow = String(underRow.dropLast())
        return underRow
    }
    
        internal func jsonEncodeObject(obj:Any) -> String {
            if let data = try? JSONSerialization.data(withJSONObject: obj, options: jsonWritingOptions) {
                return String(data: data, encoding: encoding)?.replacingOccurrences(of: "\"", with: "\"\"") ?? "serialized_obj_to_string_failed"
            } else {
                return "serialization_error"
            }
        }
        
        internal func getCSVExportableValue(_ obj:Any) -> String {
            switch obj {
            case is Array<CSVExportable>:
                let strArray = (obj as! Array<CSVExportable>).map { (csvExportable) -> String in
                    return getCSVExportableValue(csvExportable)
                }
                return jsonEncodeObject(obj: strArray)
            case is Dictionary<AnyHashable,CSVExportable>:
                let strDictionnary = (obj as! Dictionary<AnyHashable,CSVExportable>).map { (arg0) -> (AnyHashable,String) in
                    let (key, value) = arg0
                    return (key,getCSVExportableValue(value))
                }
                return jsonEncodeObject(obj: strDictionnary)
            case is Array<Any>:
                return jsonEncodeObject(obj: obj)
            case is Dictionary<AnyHashable,Any>:
                return jsonEncodeObject(obj: obj)
            case is CSVExportable:
                return getUnderRow(from: obj as! CSVExportable)
            case is Date:
                if let format = dateFormat {
                    let formatter = DateFormatter()
                    formatter.dateFormat = format
                    return formatter.string(from: obj as! Date).replacingOccurrences(of: "\"", with: "\"\"")
                } else {
                    return String(describing: obj).replacingOccurrences(of: "\"", with: "\"\"")
                }
            default:
                return String(describing: obj).replacingOccurrences(of: "\"", with: "\"\"")
            }
        }
        
    //    MARK: File management functions
    internal func getFileURL(named name:String) -> URL {
        let fileName = "\(name).csv"
        let path = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
        return path
    }
        
    internal func saveCSV(text:String, name:String) -> Result<URL,Error> {
        let url = destination ?? getFileURL(named: name)
        do {
            try text.write(to: url, atomically: true, encoding: encoding)
            return Result.success(url)
        } catch {
            return Result.failure(error)
        }
    }
    
}
