//
//  ControlSectionViewModel.swift
//  Controls
//
//  Created by Saransh on 26/09/20.
//

import Foundation
class ControlSectionViewModel {
    var root: Root
    init(root: Root) {
        self.root = root
    }
    
    func numberOfRows() -> Int {
        return root.controlSchemes.first?.gameControls.count ?? 0
    }
    
    func getTitle(for index: Int) -> String {
        return root.controlSchemes.first?.gameControls[index].name ?? ""
    }
}
