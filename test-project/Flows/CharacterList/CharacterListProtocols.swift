//
//  MoviesListViewProtocol.swift
//  test-project
//
//  Created by DS on 10.12.2023.
//

import Foundation
import UIKit

protocol CharacterListViewProtocol: BaseViewController {
    func reloadTableView()
}

protocol CharacterListPresenterProtocol {
    
    var numberOfRows: Int { get }
    
    func onViewDidLoad()
    
    func configure(_ cell: CharacterListTableViewCellProtocol, index: Int)
}
