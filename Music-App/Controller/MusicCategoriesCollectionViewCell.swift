//
//  MusicCategoryCollectionViewCell.swift
//  Music-App
//
//  Created by Ayca Akman on 8.05.2023.
//

import UIKit
import Kingfisher

class MusicCategoriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var musicCategoriesImageView: UIImageView!
    @IBOutlet weak var musicCategoriesLabel: UILabel!
    
    override func awakeFromNib() {
  
    }
    
    func setup(with musicCategories: Data) {
        musicCategoriesLabel.text = musicCategories.name
        if let imageUrl = URL(string: musicCategories.pictureXl) {
            musicCategoriesImageView.kf.setImage(with: imageUrl)
        }
    }
}
