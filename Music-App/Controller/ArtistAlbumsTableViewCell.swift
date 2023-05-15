//
//  ArtistPageTableViewCell.swift
//  Music-App
//
//  Created by Ayca Akman on 8.05.2023.
//

import UIKit
import Kingfisher
class ArtistAlbumsTableViewCell: UITableViewCell {

    @IBOutlet weak var albumNamesLabel: UILabel!
    @IBOutlet weak var albumDatesLabel: UILabel!
    @IBOutlet weak var albumImageView: UIImageView!
    
    override func awakeFromNib() {
        albumImageView.layer.cornerRadius = 10
        albumImageView.clipsToBounds = true
    }

    func setup(with album: Album, releaseDate: String?) {
        albumNamesLabel.text = album.title
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: releaseDate ?? "") {
            dateFormatter.dateFormat = "dd MMMM yyyy"  // Kullanıcıya göstermek istediğiniz tarih formatı
            let displayDate = dateFormatter.string(from: date)
            albumDatesLabel.text = displayDate
        }
        let imageUrlString = album.coverMedium
        let processor = DownsamplingImageProcessor(size: albumImageView.bounds.size)
        albumImageView.kf.indicatorType = .activity
        if let imageUrl = URL(string: imageUrlString ?? "nilImage") {
            albumImageView.kf.setImage(with: imageUrl,
                                       placeholder: UIImage(named: "placeholderImage"),
                                       options: [
                                        .processor(processor),
                                        .scaleFactor(UIScreen.main.scale),
                                        .transition(.fade(0.5)),
                                        .cacheOriginalImage
                                       ])
            
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
      
    }

   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
