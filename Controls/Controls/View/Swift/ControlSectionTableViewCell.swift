//
//  ControlSectionTableViewCell.swift
//  Controls
//
//  Created by Saransh on 25/09/20.
//

import UIKit

class ControlSectionTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    static let identifier = "ControlSectionTableViewCellId"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        applyStyle(selected: false)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        applyStyle(selected: selected)
        // Configure the view for the selected state
    }
    
    func applyStyle(selected: Bool) {
        if selected {
            contentView.backgroundColor = .systemBlue
        } else {
            contentView.backgroundColor = UIColor(red: 58.0/255.0, green: 61.0/255.0, blue: 99.0/255.0, alpha: 1.0)
        }
    }
    
}
