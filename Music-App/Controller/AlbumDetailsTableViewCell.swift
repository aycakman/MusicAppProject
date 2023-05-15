//
//  SongsListTableViewCell.swift
//  Music-App
//
//  Created by Ayca Akman on 10.05.2023.
//

import UIKit
import Kingfisher
class AlbumDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var songImageView: UIImageView!
    @IBOutlet weak var songDurationLabel: UILabel!
    @IBOutlet weak var songNameLabel: UILabel!
    
    @IBOutlet weak var favoriteButton: UIButton!
    var favoriteListService: FavoriteSongsService!
    
    var isChecked : Bool = true
    var song : SongStruct!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        songImageView.layer.cornerRadius = 10
        songImageView.clipsToBounds = true
    }
    
    func setup(with song : SongStruct ) {
        self.song = song
        songNameLabel.text = song.title
        let convertDuration = Int(song.duration)
        if (convertDuration % 60) < 10 {
            songDurationLabel.text = "\(convertDuration / 60):0\(convertDuration % 60)''"
        }else {
            songDurationLabel.text = "\(convertDuration / 60):\(convertDuration % 60)''"
        }
        let processor = DownsamplingImageProcessor(size: songImageView.bounds.size)
        songImageView.kf.indicatorType = .activity
        if let imageUrl = URL(string: song.album.pictureXl) {
            songImageView.kf.setImage(with: imageUrl,
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
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
}


