//
//  MoviesListViewController.swift
//  test-project
//
//  Created by DS on 10.12.2023.
//

import Foundation
import UIKit

// MARK: -  MoviesListViewController
final class MoviesListViewController: BaseViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    
    var presenter: MoviesListPresenterProtocol!
    
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
        tableView.registerCell(xib: MoviesListTableViewCell.self)
    }
}

extension MoviesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: MoviesListTableViewCell = tableView.instiateCell(for: indexPath)
        presenter.configure(cell, index: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectMoviesListCell(index: indexPath.row)
    }
}

// MARK: -  MoviesListViewProtocol
extension MoviesListViewController: MoviesListViewProtocol {
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
