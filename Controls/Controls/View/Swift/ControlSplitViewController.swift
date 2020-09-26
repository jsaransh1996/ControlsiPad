//
//  ControlSplitViewController.swift
//  Controls
//
//  Created by Saransh on 25/09/20.
//

import UIKit

class ControlSplitViewController: UISplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        FileHandler.copySampleFileIfNeeded()
        guard let root = FileHandler.loadContentsFromFile() else { return }
        if let sectionViewController = sectionViewController {
            sectionViewController.bind(to: ControlSectionViewModel(root: root))
        }
        if let detailViewController = detailViewController  {
            detailViewController.bind(to: ControlDetailViewModel(root: root))
        }
    }
}

extension UISplitViewController {
    var primaryViewController: UIViewController? {
        return self.viewControllers.first
    }

    var secondaryViewController: UIViewController? {
        return self.viewControllers.count > 1 ? self.viewControllers[1] : nil
    }
    
    var sectionViewController: ControlSectionViewController? {
        return (primaryViewController as? UINavigationController)?.topViewController as? ControlSectionViewController
    }
    
    var detailViewController: ControlDetailViewController? {
        (secondaryViewController as? UINavigationController)?.topViewController as? ControlDetailViewController    }
}
