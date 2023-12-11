//
//  MoviesListTableViewCell.swift
//  test-project
//
//  Created by DS on 10.12.2023.
//

import UIKit
import Foundation

protocol CharacterListTableViewCellProtocol {
    func configure(characterList: [Character: Int])
}

class CharacterListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
}

extension CharacterListTableViewCell: CharacterListTableViewCellProtocol {
    
    func configure(characterList: [Character: Int]) {
    let formattedString = characterList.map { "\($0.key): \($0.value)" }.joined(separator: ", ")
    titleLabel.text = formattedString
    }
}
