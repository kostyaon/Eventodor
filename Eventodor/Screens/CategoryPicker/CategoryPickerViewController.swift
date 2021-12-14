//
//  CategoryPickerViewController.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 14.12.21.
//

import UIKit

class CategoryPickerViewController: BaseViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextButton: EVENTODORButton!
    
    // MARK: - Lifecycle method's
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
}

// MARK: - Private method's
private
extension CategoryPickerViewController {
    
    func setupUI() {
        setupTableView()
        setupButton()
        setupLabel()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 36
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(nibWithClass: CategoryTableViewCell.self)
    }
    
    func setupButton() {
        nextButton.setTitle(with: "category_next".localized())
    }
    
    func setupLabel() {
        categoryLabel.font = .systemFont(ofSize: 30)
        categoryLabel.textColor = .black
        categoryLabel.text = "category_title".localized()
    }
}

// MARK: - TableView method's
extension CategoryPickerViewController: UITableViewDataSource, UITableViewDelegate {
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withType: CategoryTableViewCell.self, for: indexPath)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? CategoryTableViewCell
        cell?.isSelected.toggle()
    }
}
