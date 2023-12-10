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
        
        imageLoadingTask?.cancel()
        posterImageView.image = nil
    }

    private func loadImage(movie: Movie) {
        
        imageLoadingTask = ImageLoader.shared.loadImage(from: movie.posterPath, placeholder: UIImage(named: "clapboard")!) { [weak self] image in
            
            guard 
                let self = self
            else {
                return
            }
            
            self.posterImageView.image = image
        }
    }
}

extension MoviesListTableViewCell: MoviesListTableViewCellProtocol {
    
    func configure(movie: Movie) {
        
        titleLabel.text = movie.title
        voteAverageLabel.text = "\(movie.overview)"
        loadImage(movie: movie)
    }
}
