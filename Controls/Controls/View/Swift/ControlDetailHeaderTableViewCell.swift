//
//  ControlDetailHeaderTableViewCell.swift
//  Controls
//
//  Created by Saransh on 26/09/20.
//

import UIKit

class ControlDetailHeaderTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    static let identifier = "ControlDetailHeaderTableViewCellId"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        applyStyle()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func applyStyle() {
        titleLabel.textColor = .systemBlue
        self.backgroundColor = UIColor(red: 36.0/255.0, green: 39.0/255.0, blue: 66.0/255.0, alpha: 1.0)
    }
}
