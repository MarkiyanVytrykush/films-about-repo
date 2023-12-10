//
//  MoviesListPresenter.swift
//  test-project
//
//  Created by DS on 10.12.2023.
//

import Foundation

class MoviesListPresenter {
    
    weak var view: MoviesListViewProtocol?
    
    private var apiClient: APIClient!
    private var movies: [Movie] = []
    private var coordinator: MoviesCoordinatorProtocol?
    
    var numberOfRows: Int {
        return movies.count
    }
    
    init(view: MoviesListViewProtocol, apiClient: APIClient, coordinator: MoviesCoordinator) {
        
        self.view = view
        self.apiClient = apiClient
        self.coordinator = coordinator
    }
    
    private func loadMovies() {
        
        apiClient.moviesClient.getMovies(page: 0) { [weak self] result in
            
            switch result {
            case .success(let moviesResult):
                self?.configureModels(moviesResult: moviesResult)
            case .failure(let error):
                self?.view?.showAlertWithError(message: error.localizedDescription)
            }
        }
    }
    
    private func configureModels(moviesResult: MovieResult) {
        
        self.movies = moviesResult.results
        self.view?.reloadTableView()
    }
}

extension MoviesListPresenter: MoviesListPresenterProtocol {

    func onViewDidLoad() {
        loadMovies()
    }
    
    func configure(_ cell: MoviesListTableViewCellProtocol, index: Int) {
        cell.configure(movie: movies[index])
    }
    
    func didSelectMoviesListCell(index: Int) {
        
        let selectedMovie = movies[index]
        coordinator?.showMovieDetails(for: selectedMovie)
    }
}
