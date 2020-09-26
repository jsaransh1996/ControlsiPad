//
//  ControlScheme.swift
//  Controls
//
//  Created by Saransh on 25/09/20.
//

import Foundation

typealias JSON = [String: Any]

class Root {
    var controlSchemes: [ControlScheme] = []
    init(json: [JSON]) {
        for schemeJSON in json {
            if let controlScheme = ControlScheme(json: schemeJSON) {
                controlSchemes.append(controlScheme)
            }
        }
    }
    
    func getJSON() -> [JSON] {
        var json: [JSON] = []
        for controlScheme in controlSchemes {
            json.append(controlScheme.getJSON())
        }
        return json
    }
    
}
class ControlScheme {
    var gameControls: [GameControls] = []
    init?(json: JSON) {
        guard let controls = json["GameControls"] as? [JSON] else { return nil }
        
        for controlJSON in controls {
            if let gameControl = GameControls(json: controlJSON) {
                gameControls.append(gameControl)
            }
        }
    }
    
    func getJSON() -> JSON {
        var json: [JSON] = []
        for gameControl in gameControls {
            json.append(gameControl.getJSON())
        }
        return ["GameControls": json]
    }
}

class GameControls {
    var keyMapping: JSON
    var guidance: JSON
    var name: String
    var keyValues: [String]
    
    init?(json: JSON) {
        guard
            let name = json["GuidanceCategory"] as? String,
            let guidance = json["Guidance"] as? JSON else { return nil }
        self.name = name
        self.guidance = guidance
        var selfJSON = json
        selfJSON.removeValue(forKey: "Guidance")
        selfJSON.removeValue(forKey: "GuidanceCategory")
        keyMapping = selfJSON
        keyValues = Array(selfJSON.keys).sorted()

    }
    
    
    func getJSON() -> JSON {
        var json: JSON = [:]
        json["GuidanceCategory"] = name
        json["Guidance"] = guidance
        for key in keyValues {
            json[key] = keyMapping[key]
        }
        return json
    }
}
