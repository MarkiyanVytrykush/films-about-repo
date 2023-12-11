//
//  CharacterListPresenter.swift
//  test-project
//
//  Created by DS on 10.12.2023.
//

import Foundation

class CharacterListPresenter {
    
    weak var view: CharacterListViewProtocol?
    
    private var apiClient: APIClient!
    private var coordinator: MoviesCoordinatorProtocol?
    private var characters: [Character: Int] = [:]
    
    var numberOfRows: Int {
        return characters.count
    }
    
    init(view: CharacterListViewProtocol, apiClient: APIClient, coordinator: MoviesCoordinator, characters: [Character: Int] = [:]) {
        
        self.view = view
        self.apiClient = apiClient
        self.coordinator = coordinator
        self.characters = characters
    }
}

extension CharacterListPresenter: CharacterListPresenterProtocol {

    func onViewDidLoad() {}
    
    func configure(_ cell: CharacterListTableViewCellProtocol, index: Int) {
        
        let sortedCharacterArray = characters.sorted { $0.key < $1.key }


        let (character, count) = sortedCharacterArray[index]
        cell.configure(characterList: [character: count])
    }
}
