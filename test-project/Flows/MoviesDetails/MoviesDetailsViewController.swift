//
//  MoviesListViewController.swift
//  test-project
//
//  Created by DS on 10.12.2023.
//

import Foundation
import UIKit

// MARK: -  MoviesDetailsViewController
final class MoviesDetailsViewController: BaseViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var genresLabel: UILabel!
    @IBOutlet private weak var detailTextView: UITextView!
    
    // MARK: - Properties
    
    var presenter: MoviesDetailsPresenterProtocol!
    
    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.onViewDidLoad()
    }
}

// MARK: -  MoviesDetailsViewProtocol
extension MoviesDetailsViewController: MoviesDetailsViewProtocol {
    
    func startActivityIndicatorLoading() {
        activityIndicator.startAnimating()
    }
    
    func stopActivityIndicatorLoading() {
        activityIndicator.stopAnimating()
    }
    
    func setupTitle(title: String) {
        titleLabel.text = title
    }
    
    func setupDetails(details: String) {
        detailTextView.text = details
    }
    
    func setupPosterImage(posterImage: UIImage?) {
        posterImageView.image = posterImage
    }
    
    func setupReleaseDate(releaseDate: String) {
        releaseDateLabel.text = releaseDate
    }
    
    func setupGenerasLabel(generas: String) {
        genresLabel.text = generas
    }
}
