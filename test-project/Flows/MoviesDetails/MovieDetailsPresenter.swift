//
//  MoviesDetailsPresenter.swift
//  test-project
//
//  Created by DS on 10.12.2023.
//

import Foundation

class MoviesDetailsPresenter {
    
    weak var view: MoviesDetailsViewProtocol?
    
    private var apiClient: APIClient!
    private var movieId: String? = nil
    private var moviesDetails: MovieDetailsResult!
    private var coordinator: MoviesCoordinatorProtocol?
    
    init(view: MoviesDetailsViewProtocol, apiClient: APIClient, coordinator: MoviesCoordinator, movieId: String) {
        
        self.view = view
        self.apiClient = apiClient
        self.coordinator = coordinator
        self.movieId = movieId
    }
    
    private func loadMovieDetail() {
        
        guard
            let movieId = movieId
        else {
            return
        }
        
        apiClient.moviesClient.getMovieDetails(movieId: movieId) { [weak self] result in
            
            switch result {
            case .success(let moviesDetails):
                
                self?.moviesDetails = moviesDetails
                self?.setupUI(movieDetails: moviesDetails)
                
            case .failure(let error):
                self?.view?.showAlertWithError(message: error.localizedDescription)
            }
        }
    }
    
    private func loadAndSetupImage(movie: MovieDetailsResult) {
        
        view?.startActivityIndicatorLoading()
        
        ImageLoader.shared.loadImage(from: movie.posterPath) { [weak self] image in
            
            DispatchQueue.main.async {
                
                self?.view?.stopActivityIndicatorLoading()
                self?.view?.setupPosterImage(posterImage: image)
            }
        }
    }
    
    private func setupUI(movieDetails: MovieDetailsResult) {
        
        view?.setupTitle(title: movieDetails.title)
        view?.setupDetails(details: movieDetails.overview)
        view?.setupReleaseDate(releaseDate: movieDetails.releaseDate)
        view?.setupGenerasLabel(generas: movieDetails.genresTitle)
        
        loadAndSetupImage(movie: movieDetails)
    }
}

extension MoviesDetailsPresenter: MoviesDetailsPresenterProtocol {
    
    func onViewDidLoad() {
        loadMovieDetail()
    }
}
