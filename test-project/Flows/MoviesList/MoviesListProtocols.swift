//
//  MoviesListViewProtocol.swift
//  test-project
//
//  Created by DS on 10.12.2023.
//

import Foundation
import UIKit

protocol MoviesListViewProtocol: BaseViewController {
    func reloadTableView()
}

protocol MoviesListPresenterProtocol {
    
    var numberOfRows: Int { get }
    
    func onViewDidLoad()
    
    func configure(_ cell: MoviesListTableViewCellProtocol, index: Int)
    func didSelectMoviesListCell(index: Int)
    func didTapShowCharacterList()
}
