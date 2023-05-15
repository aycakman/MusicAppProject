//
//  SongsListViewController.swift
//  Music-App
//
//  Created by Ayca Akman on 10.05.2023.
//

import UIKit

class AlbumDetailsViewController: UIViewController{
    
    var songModel : SongModelStruct!
    var songs : [SongStruct]!
    var releaseDate: String?
    var albumID : Int!
    var selectedRowIndex : Int?
    var onReleaseDateReceived: ((Int, String) -> Void)?
    var favoriteListService: FavoriteSongsService!

    @IBOutlet weak var albumDetailsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        albumDetailsTableView.dataSource = self
        albumDetailsTableView.delegate = self
        
        fetchData(albumID)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        MusicPlayerManager.shared.stopMusic() //to stop music when open new page
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //for increase performance
        if FavoriteSongsService.changeFavoriteStatus {
            albumDetailsTableView.reloadData()
            FavoriteSongsService.changeFavoriteStatus = false
        }
    }
    
    func fetchData(_ albumID: Int) {
        let url = URL(string: "https://api.deezer.com/album/\(albumID)")
        NetworkService().downloadData(url: url!) { [self] (songModel: SongModelStruct?) in
            if let songModel = songModel {
                DispatchQueue.main.async { [self] in
                    self.onReleaseDateReceived?(albumID, songModel.releaseDate)
                    self.songs = songModel.tracks.data
                    self.albumDetailsTableView.reloadData()
                }
            }
        }
    }
}

extension AlbumDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = albumDetailsTableView.dequeueReusableCell(withIdentifier: "songCell") as! AlbumDetailsTableViewCell
        cell.favoriteListService = favoriteListService
        cell.setup(with: songs[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let song = songs[indexPath.row]
        MusicPlayerManager.shared.stopMusic()
        MusicPlayerManager.shared.playMusic(previewUrl: song.preview) // to start new song
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


