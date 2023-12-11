//
//  CharacterListViewController.swift
//  test-project
//
//  Created by DS on 10.12.2023.
//

import Foundation
import UIKit

// MARK: -  CharacterListViewController
final class CharacterListViewController: BaseViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    
    var presenter: CharacterListPresenterProtocol!
    
    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.onViewDidLoad()
    }
    
    override func setupUI() {
        super.setupUI()
        configureTableView()
    }
    
    private func configureTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCell(xib: CharacterListTableViewCell.self)
    }
}

extension CharacterListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: CharacterListTableViewCell = tableView.instiateCell(for: indexPath)
        presenter.configure(cell, index: indexPath.row)
        
        return cell
    }
}

// MARK: -  CharacterListViewProtocol
extension CharacterListViewController: CharacterListViewProtocol {
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
