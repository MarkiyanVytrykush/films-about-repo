//
//  MoviesCoordinator.swift
//  test-project
//
//  Created by DS on 10.12.2023.
//

import Foundation
import UIKit

// MARK: - Coordinator
protocol MoviesCoordinatorProtocol: AnyObject {
    func start()
    func showMovieDetails(for movie: Movie)
    func showCharacterList(for characterList: [Character: Int])
}

final class MoviesCoordinator: MoviesCoordinatorProtocol {
    
    weak var navigationController: CustomNavigationController?
    
    private let apiClient: APIClient
    
    init(navigationController: CustomNavigationController) {
        
        self.navigationController = navigationController
        self.apiClient = APIClient()
    }
    
    func start() {
        
        let moviesListView: MoviesListViewController = UIStoryboard(.moviesList).instantiateViewController()
        let presenter = MoviesListPresenter(view: moviesListView, apiClient: apiClient, coordinator: self)
        moviesListView.presenter = presenter

        navigationController?.pushViewController(moviesListView, animated: true)
    }

    func showMovieDetails(for movie: Movie) {
        
        let movieDetailsViewController: MoviesDetailsViewController = UIStoryboard(.movieDetails).instantiateViewController()
        let presenter = MoviesDetailsPresenter(view: movieDetailsViewController, apiClient: apiClient, coordinator: self, movieId: "\(movie.id)")
        movieDetailsViewController.presenter = presenter
        
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.pushViewController(movieDetailsViewController, animated: true)
    }
    
    func showCharacterList(for characterList: [Character: Int]) {
        
        let characterListViewController: CharacterListViewController = UIStoryboard(.characterList).instantiateViewController()
        let presenter = CharacterListPresenter(view: characterListViewController, apiClient: apiClient, coordinator: self, characters: characterList)
        characterListViewController.presenter = presenter
        
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.pushViewController(characterListViewController, animated: true)
    }
}
