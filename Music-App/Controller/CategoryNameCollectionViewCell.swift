//
//  CategoryNameCollectionViewCell.swift
//  Music-App
//
//  Created by Ayca Akman on 8.05.2023.
//

import UIKit
import Kingfisher
class CategoryNameCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryNamesImageView: UIImageView!
    @IBOutlet weak var categoryNamesLabel: UILabel!
    
    func setup(with artistNames : ArtistData) {
        categoryNamesLabel.text = artistNames.name
        if let imageUrl = URL(string: artistNames.pictureXl) {
            categoryNamesImageView.kf.setImage(with: imageUrl)
        }
    }
}
    

