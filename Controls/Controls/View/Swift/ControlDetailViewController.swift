//
//  ControlDetailViewController.swift
//  Controls
//
//  Created by Saransh on 25/09/20.
//

import UIKit

class ControlDetailViewController: UIViewController {

    @IBOutlet weak var controlTableView: UITableView!
    @IBOutlet weak var footerView: UIView!
    
    var viewModel: ControlDetailViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(edit))
        applyStyle()
        registerNibs()
    }
    
    func bind(to viewModel: ControlDetailViewModel) {
        self.viewModel = viewModel
    }
    
    func applyStyle() {
        let bgColor = UIColor(red: 36.0/255.0, green: 39.0/255.0, blue: 66.0/255.0, alpha: 1.0)
        
        controlTableView.backgroundColor = bgColor
        footerView.backgroundColor = bgColor
        view.backgroundColor = bgColor
        
    }
    
    func registerNibs() {
        let nib1 = UINib(nibName: String(describing: ControlDetailTableViewCell.self), bundle: .main)
        controlTableView.register(nib1, forCellReuseIdentifier: ControlDetailTableViewCell.identifier)
        let nib2 = UINib(nibName: String(describing: ControlDetailHeaderTableViewCell.self), bundle: .main)
        controlTableView.register(nib2, forCellReuseIdentifier: ControlDetailHeaderTableViewCell.identifier)
    }
    
    func scrollToSection(section: Int) {
        let indexPath = IndexPath(row: NSNotFound, section: section)
        controlTableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    @objc
    func edit() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(save))
        viewModel?.isEditing = true
        controlTableView.reloadData()
    }

    @objc
    func save() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(edit))
        viewModel?.isEditing = false
        controlTableView.reloadData()
        viewModel?.save()
    }
}

extension ControlDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numberOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerTableViewCell = tableView.dequeueReusableCell(withIdentifier: ControlDetailHeaderTableViewCell.identifier) as? ControlDetailHeaderTableViewCell else { return UITableViewCell() }
        headerTableViewCell.titleLabel.text = viewModel?.getSectionTitle(for: section)
        return headerTableViewCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows(for: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: ControlDetailTableViewCell.identifier, for: indexPath) as? ControlDetailTableViewCell,
            let viewModel = viewModel else { return UITableViewCell() }
        
        cell.populateData(from: viewModel, indexPath: indexPath)
        
        cell.validateReplacement = {(newKey) in
            return viewModel.validateReplacement(newKey)
        }
        
        cell.updateReplacement = {(newKey, oldKey) in
            viewModel.updateReplacement(newKey, oldKey)
        }
        
        return cell
    }
}

extension ControlDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
