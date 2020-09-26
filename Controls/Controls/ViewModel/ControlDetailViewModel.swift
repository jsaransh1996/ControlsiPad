//
//  ControlDetailViewModel.swift
//  Controls
//
//  Created by Saransh on 26/09/20.
//

import Foundation
class ControlDetailViewModel {
    var root: Root
    var isEditing = false
    
    init(root: Root) {
        self.root = root
    }
    
    func numberOfSections() -> Int {
        return root.controlSchemes.first?.gameControls.count ?? 0
    }
    
    func numberOfRows(for section: Int) -> Int {
        return root.controlSchemes.first?.gameControls[section].keyMapping.count ?? 0
    }
    
    func getSectionTitle(for section: Int) -> String {
        return root.controlSchemes.first?.gameControls[section].name ?? ""
    }
    
    func getTitle(for section: Int, row: Int) -> String {
        let key = getKey(for: section, row: row)
        if let retVal = root.controlSchemes.first?.gameControls[section].guidance[key] as? String { return retVal
        }
        return ""
    }
    
    func getKeyValue(for section: Int, row: Int) -> String {
        let key = getKey(for: section, row: row)
        if let retVal = root.controlSchemes.first?.gameControls[section].keyMapping[key] as? String { return retVal
        }
        return ""
    }
    
    func getKey(for section: Int, row: Int) -> String {
        return root.controlSchemes.first?.gameControls[section].keyValues[row] ?? ""
    }
    
    func validateReplacement(_ newKey: String) -> Bool {
        return findKey(for: newKey) == nil
    }
    
    func updateReplacement(_ newKey: String, _ oldKey: String) {
        guard
            let gameControls = root.controlSchemes.first?.gameControls,
            let key = findKey(for: oldKey) else { return }

        
        for control in gameControls {
            if control.keyMapping[key] != nil {
                control.keyMapping[key] = newKey
                break
            }
        }
    }
    
    func findKey(for value: String) -> String? {
        guard let gameControls = root.controlSchemes.first?.gameControls else { return nil }
        
        for control in gameControls {
            for (key, keyboardKey) in control.keyMapping {
                guard let keyboardKey = keyboardKey as? String  else { continue }
                if keyboardKey == value {
                    return key
                }
            }
        }
        return nil
    }
    
    func save() {
        FileHandler.save(root)
    }
}

