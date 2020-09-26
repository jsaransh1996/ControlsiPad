//
//  FileHandler.swift
//  Controls
//
//  Created by Saransh on 25/09/20.
//

import Foundation
class FileHandler {
    
    static func copySampleFileIfNeeded() {
        guard let filePath = Bundle.main.path(forResource: "sample", ofType: "txt") else { return }

        let directoryFileURL = urlToSampleFile()
        if FileManager.default.fileExists(atPath: directoryFileURL.path) == false {
            do {
                let content = try String(contentsOf: URL(fileURLWithPath: filePath))
                try content.write(to: directoryFileURL, atomically: true, encoding: .utf8)
            } catch {
                print("Some error occured")
            }
        }
    }
    
    static func loadContentsFromFile() -> Root? {
        let directoryFileURL = urlToSampleFile()
        do {
            let content = try String(contentsOf: URL(fileURLWithPath: directoryFileURL.path))
            if
                let json = try JSONSerialization.jsonObject(with: Data(content.utf8), options: []) as? JSON,
                let schemes = json["ControlSchemes"] as? [JSON] {
                printJSON(json: json)
                return Root(json: schemes)
            }
        } catch {
            print("Some error occured")
        }
        return nil
    }
    
    static func save(_ root: Root) {
        let json = ["ControlSchemes": root.getJSON()]
        printJSON(json: json)
        
        let directoryFileURL = urlToSampleFile()
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json)
            if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                try JSONString.write(to: directoryFileURL, atomically: true, encoding: .utf8)
            }
        } catch {
            print("Some error occured")
        }
    }
    
    static func printJSON(json: JSON) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json)
            if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
               print(JSONString)
            }
        } catch {
            print("Some error occured")
        }
    }
    
    static func urlToSampleFile() -> URL {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return URL(fileURLWithPath: directoryURL.path).appendingPathComponent("sample.txt")
    }
}
