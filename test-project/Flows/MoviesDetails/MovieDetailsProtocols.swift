//
//  MoviesListViewProtocol.swift
//  test-project
//
//  Created by DS on 10.12.2023.
//

import Foundation
import UIKit

protocol MoviesDetailsViewProtocol: BaseViewController {
    
    func startActivityIndicatorLoading()
    func stopActivityIndicatorLoading()
    
    func setupTitle(title: String)
    func setupDetails(details: String)
    func setupPosterImage(posterImage: UIImage?)
    func setupReleaseDate(releaseDate: String)
    func setupGenerasLabel(generas: String)
}

protocol MoviesDetailsPresenterProtocol {
    
    func onViewDidLoad()
    
    func didTapShowCharacterList()
}
