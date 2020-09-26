//
//  ControlDetailTableViewCell.swift
//  Controls
//
//  Created by Saransh on 26/09/20.
//

import UIKit

class ControlDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var actionLabel: UILabel!
    @IBOutlet weak var keyTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    var validateReplacement: ((String) -> Bool)?
    var updateReplacement: ((String, String) -> Void)?
    
    static let identifier = "ControlDetailTableViewCellId"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        applyStyle()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        applyStyle()
    }
    
    func applyStyle() {
        let bgColor = UIColor(red: 36.0/255.0, green: 39.0/255.0, blue: 66.0/255.0, alpha: 1.0)
        contentView.backgroundColor = bgColor

        let placeHolderColor = UIColor.white.withAlphaComponent(0.5)
        keyTextField.attributedPlaceholder = NSAttributedString(string: keyTextField.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : placeHolderColor])

        let textFieldBGColor = UIColor(red: 108.0/255.0, green: 110.0/255.0, blue: 127.0/255.0, alpha: 1.0)
        keyTextField.backgroundColor = textFieldBGColor
        
        
    }
    
    func populateData(from viewModel: ControlDetailViewModel, indexPath: IndexPath) {
        keyTextField.isUserInteractionEnabled = viewModel.isEditing
        actionLabel.text = viewModel.getTitle(for: indexPath.section, row: indexPath.row)
        keyTextField.text = viewModel.getKeyValue(for: indexPath.section, row: indexPath.row)
        keyTextField.placeholder = viewModel.getKeyValue(for: indexPath.section, row: indexPath.row)
        applyStyle()
    }
}

extension ControlDetailTableViewCell: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {

        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.systemBlue.cgColor
        textField.layer.cornerRadius = 10

        textField.text = ""
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newText =  (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
        
        if let newKey = newText?.first?.uppercased(), let oldKey = textField.placeholder {
            if newKey == oldKey || validateReplacement?(newKey) == true {
                updateReplacement?(newKey, oldKey)
                textField.text = newKey
                textField.placeholder = newKey
                applyStyle()
            } else {
                errorLabel.text = "\(newKey) is Already in Use"
                textField.shake()
                UIView.animate(withDuration: 1.0) {
                    self.errorLabel.alpha = 1.0
                } completion: { (completed) in
                    UIView.animate(withDuration: 1.0, delay: 2.0) {
                        self.errorLabel.alpha = 0.0
                    }
                }
            }
            
        }
        textField.endEditing(true)
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 0
        textField.layer.borderColor = UIColor.clear.cgColor
        textField.layer.cornerRadius = 0

        if textField.text?.isEmpty == true {
            textField.text = textField.placeholder
        }
    }
}
