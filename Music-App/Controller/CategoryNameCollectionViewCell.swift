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
    
    /*
     func setup(with artistNames : ArtistData) {
         categoryNameLabel.text = artistNames.name
         let processor = DownsamplingImageProcessor(size: categoryNameImageView.bounds.size)
         categoryNameImageView.kf.indicatorType = .activity

         if let imageUrl = URL(string: artistNames.pictureXl) {
             categoryNameImageView.kf.setImage(with: imageUrl,
                                        placeholder: UIImage(named: "placeholderImage"),
                                        options: [
                                         .processor(processor),
                                         .scaleFactor(UIScreen.main.scale),
                                         .transition(.fade(0)),
                                         .cacheOriginalImage
                                        ])
             
         }
       
     }

*/
