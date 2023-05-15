//
//  FavoriteListViewController.swift
//  Music-App
//
//  Created by Ayca Akman on 11.05.2023.
//

import UIKit

class FavoriteSongsViewController: UIViewController {
    
    @IBOutlet weak var favoriteSongsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoriteSongsTableView.dataSource = self
        favoriteSongsTableView.delegate = self
        
        navigationItem.title = "Favorite Songs"
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        MusicPlayerManager.shared.stopMusic()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //for increase performance
        if FavoriteSongsService.changeFavoriteStatus {
            favoriteSongsTableView.reloadData()
            FavoriteSongsService.changeFavoriteStatus = false
        }
    }
}

extension FavoriteSongsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavoriteSongsService.getFavorites().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoriteSongsTableView.dequeueReusableCell(withIdentifier: "favoriteListCell") as! FavoriteSongsTableViewCell
        let favoriteSong = FavoriteSongsService.getFavorites()[indexPath.row]
        
        cell.setup(with: favoriteSong)
        //to see the new music added
        cell.onFavoriteButtonTapped = {
            FavoriteSongsService.removeFavoriteSong(favoriteSong.id)
            DispatchQueue.main.async {
                self.favoriteSongsTableView.reloadData()
                MusicPlayerManager.shared.stopMusic() //to stop the music when you press the favorite button in the favorite list
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favoriteSong = FavoriteSongsService.getFavorites()[indexPath.row]
        MusicPlayerManager.shared.playMusic(previewUrl: favoriteSong.preview)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


