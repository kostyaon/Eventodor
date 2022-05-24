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
    
    // MARK: - Properties
    private var categories: [CategoryEVENTODOR] = []
    private var selectedIndexes: [Int] = []
    private let viewModel = CategoryPickerViewModel(isRequestGroup: true)
    
    // MARK: - Lifecycle method's
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadData()
    }
    
    // MARK: - Override handlers
    override func handleError() {
        viewModel.presentError = { [weak self] message in
            guard let this = self else { return }
            this.showError(title: "error_title".localized(), message: message)
        }
    }
    
    override func handleUpdateUI() {
        viewModel.updateUI = { [weak self] in
            guard let this = self else { return }
            this.categories = this.viewModel.availableCategories ?? []
            this.tableView.reloadData()
        }
    }
}

// MARK: - Private method's
private
extension CategoryPickerViewController {
    
    func loadData() {
        viewModel.getCategories()
    }
    
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
        nextButton.onTap = { [weak self] in
            guard let this = self else { return }
            
        }
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
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withType: CategoryTableViewCell.self, for: indexPath)
        cell.selectionStyle = .none
        cell.configureCell(with: categories[indexPath.row].name ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? CategoryTableViewCell else { return }
        cell.isSelected = true
        selectedIndexes.append(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? CategoryTableViewCell else { return }
        cell.isSelected = false
        selectedIndexes.removeAll(where: { $0 == indexPath.row })
    }
}
