//
//  ControlSectionViewController.swift
//  Controls
//
//  Created by Saransh on 25/09/20.
//

import UIKit

class ControlSectionViewController: UIViewController {
    
    @IBOutlet weak var sectionTableView: UITableView!
    @IBOutlet weak var footerView: UIView!
    
    var viewModel: ControlSectionViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: String(describing: ControlSectionTableViewCell.self), bundle: .main)
        sectionTableView.register(nib, forCellReuseIdentifier: ControlSectionTableViewCell.identifier)
        applyStyle()
    }
    
    func bind(to viewModel: ControlSectionViewModel) {
        self.viewModel = viewModel
    }
    
    func applyStyle() {
        let bgColor = UIColor(red: 58.0/255.0, green: 61.0/255.0, blue: 99.0/255.0, alpha: 1.0)
        
        sectionTableView.backgroundColor = bgColor
        footerView.backgroundColor = bgColor
        view.backgroundColor = bgColor
    }
}

extension ControlSectionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ControlSectionTableViewCell.identifier, for: indexPath) as? ControlSectionTableViewCell else { return UITableViewCell() }
        cell.titleLabel.text = viewModel?.getTitle(for: indexPath.row)
        return cell
    }
}

extension ControlSectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailViewController = splitViewController?.detailViewController else { return }
        detailViewController.scrollToSection(section: indexPath.row)
    }
}
