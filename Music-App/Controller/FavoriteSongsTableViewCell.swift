//
//  FavoriteListTableViewCell.swift
//  Music-App
//
//  Created by Ayca Akman on 11.05.2023.
//

import UIKit
import Kingfisher
class FavoriteSongsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var favoriteSongDurationLabel: UILabel!
    @IBOutlet weak var favoriteSongNameLabel: UILabel!
    @IBOutlet weak var favoriteSongImageView: UIImageView!
    
    var isChecked : Bool = true
    var song : SongStruct!
    var onFavoriteButtonTapped: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func setup(with song : SongStruct ) {
        self.song = song
        favoriteSongNameLabel.text = song.title
        let convertDuration = Int(song.duration)
        if (convertDuration % 60) < 10 {
            favoriteSongDurationLabel.text = "\(convertDuration / 60):0\(convertDuration % 60)''"
        }else {
            favoriteSongDurationLabel.text = "\(convertDuration / 60):\(convertDuration % 60)''"
        }
        let processor = DownsamplingImageProcessor(size: favoriteSongImageView.bounds.size)
        favoriteSongImageView.kf.indicatorType = .activity
        if let imageUrl = URL(string: song.album.pictureXl) {
            favoriteSongImageView.kf.setImage(with: imageUrl,
                                              placeholder: UIImage(named: "placeholderImage"),
                                              options: [
                                               .processor(processor),
                                               .scaleFactor(UIScreen.main.scale),
                                               .transition(.fade(0.2)),
                                               .cacheOriginalImage
                                            ])
        }
        
        isChecked = FavoriteSongsService.favoriteSongs(song.id)
        favoriteButton.setImage(UIImage(systemName: isChecked ? "suit.heart.fill" : "suit.heart"), for: .normal)
    }

    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
        if isChecked {
            FavoriteSongsService.removeFavoriteSong(song.id)
        } else {
            FavoriteSongsService.addFavoriteSong(song)
        }
        isChecked = !isChecked
        favoriteButton.setImage(UIImage(systemName: isChecked ? "suit.heart.fill" : "suit.heart"), for: .normal)
        onFavoriteButtonTapped?()
        FavoriteSongsService.changeFavoriteStatus = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
