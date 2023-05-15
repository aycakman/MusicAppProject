//
//  ArtistPageViewController.swift
//  Music-App
//
//  Created by Ayca Akman on 8.05.2023.
//

import UIKit

class ArtistAlbumsViewController: UIViewController{
    
    
    @IBOutlet weak var albumsTableView: UITableView!
    @IBOutlet weak var artistImageView: UIImageView!
    
    var artistName: String?
    var artistImageUrl: String?
    
    var artistPage : ArtistPage!
    var tracklistData : [TracklistData]!
    var albums: [Album] = []
    var albumIDs: [Int] = []
    var artistID : Int!
    var selectedRowIndex : Int?
    var releaseDates: [Int: String] = [:]
    var releaseDate: String?
    var tracklist : String! = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        albumsTableView.dataSource = self
        albumsTableView.delegate = self
        
        if let artistImageUrl = artistImageUrl {
            loadImage(from: artistImageUrl)
        }

        tracklist = fetchData()
        fetchDataTracklist(tracklist)
        
        showSecondViewController()

    }
    
 
    func showSecondViewController() {
        let destinationVC = AlbumDetailsViewController()
        destinationVC.onReleaseDateReceived = { [weak self] albumID, releaseDate in
            self?.releaseDates[albumID] = releaseDate
            DispatchQueue.main.async {
                self?.albumsTableView.reloadData()
                
            }
        }
    }
    
    func loadImage(from urlString: String) {
        if let imageUrl = URL(string: urlString) {
            URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
                if let error = error {
                    print("Error downloading image: \(error)")
                } else if let data = data {
                    DispatchQueue.main.async {
                        self.artistImageView.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
    }
    
    
    func fetchData() -> String {
        guard let url = URL(string: "https://api.deezer.com/artist/\(artistID!)") else {
            return "invalid URL address"
        }
        NetworkService().downloadData(url: url) { (artists: ArtistPage?) in
            if let artists = artists {
                self.tracklist = artists.tracklist
                DispatchQueue.main.async {
                    self.albumsTableView.reloadData()
                }
            }
        }
        return tracklist!
    }
    
    
    func fetchDataTracklist(_ tracklist: String) {
        guard let url = URL(string: self.tracklist) else {
            print("invalid URL address")
            return
        }
        NetworkService().downloadData(url: url) { (tracklists: TracklistModel?) in
            if let tracklists = tracklists {
                for track in tracklists.data {
                    let albumId = track.album.id
                    if !self.albums.contains(where: { $0.id == albumId }) {
                        self.albums.append(track.album)
                        self.fetchReleaseDate(for: albumId) { (releaseDate) in
                            if let releaseDate = releaseDate {
                                DispatchQueue.main.async {
                                    self.releaseDates[albumId] = releaseDate
                                    self.albumsTableView.reloadData()
                                }
                            }
                        }
                    }
                }
                DispatchQueue.main.async {
                    self.albumsTableView.reloadData()
                }
            }
        }
    }
    
    func fetchReleaseDate(for albumID: Int, completion: @escaping (String?) -> Void) {
        guard let url = URL(string: "https://api.deezer.com/album/\(albumID)") else {
            print("invalid URL addres")
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error fetching release date: \(error)")
                completion(nil)
            } else if let data = data {
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                    if let dictionary = jsonObject as? [String: Any], let releaseDate = dictionary["release_date"] as? String {
                        print(releaseDate) 
                        completion(releaseDate)
                    } else {
                        print("Error parsing release date.")
                        completion(nil)
                    }
                } catch {
                    print("Error parsing release date: \(error)")
                    completion(nil)
                }
            }
        }.resume()
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGoDetailsOfAlbum" {
            if let destinationVC = segue.destination as? AlbumDetailsViewController,
               let index = selectedRowIndex {
                destinationVC.navigationItem.title = albums[index].title
                destinationVC.albumID = albums[index].id
            }
        }
    }
    
}

extension ArtistAlbumsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("albums.count: \(albums.count)")
        return albums.count
     
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = albumsTableView.dequeueReusableCell(withIdentifier: "artistCell", for: indexPath) as! ArtistAlbumsTableViewCell
        
        let album = albums[indexPath.row]
        let releaseDate = releaseDates[album.id] ?? "error"
      
        cell.setup(with: album, releaseDate: releaseDate)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRowIndex = indexPath.row
        performSegue(withIdentifier: "toGoDetailsOfAlbum", sender: nil)
    }
    
}

