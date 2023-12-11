//
//  MoviesListTableViewCell.swift
//  test-project
//
//  Created by DS on 10.12.2023.
//

import UIKit

protocol MoviesListTableViewCellProtocol {
    func configure(movie: Movie)
}

class MoviesListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!

    private var imageLoadingTask: Operation?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
    }

    private func loadImage(movie: Movie) {
        posterImageView.loadImage(from: movie.posterPath, placeholder: UIImage(named: "clapboard")!)
    }
}

extension MoviesListTableViewCell: MoviesListTableViewCellProtocol {
    
    func configure(movie: Movie) {
        
        titleLabel.text = movie.title
        voteAverageLabel.text = "\(movie.overview)"
        loadImage(movie: movie)
    }
}
