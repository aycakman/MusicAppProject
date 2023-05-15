//
//  FavoriteListService.swift
//  Music-App
//
//  Created by Ayca Akman on 11.05.2023.
//

import CoreData
import UIKit


class FavoriteSongsService {
    
    static var changeFavoriteStatus: Bool = false
    static let shared = FavoriteSongsService()
    
    static var context: NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    static func favoriteSongs(_ id: Int) -> Bool {
        let fetchRequest: NSFetchRequest<SongEntity> = SongEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        do {
            let songs = try context.fetch(fetchRequest)
            return !songs.isEmpty
        } catch {
            print("Error fetching: \(error)")
            return false
        }
    }
    
    static func addFavoriteSong(_ song: SongStruct) {
        let songEntity = SongEntity(context: context)
        songEntity.id = Int64(song.id)
        songEntity.title = song.title
        songEntity.titleShort = song.titleShort
        songEntity.duration = Int32(song.duration)
        songEntity.preview = song.preview
        songEntity.md5Image = song.md5Image
        songEntity.picture = song.album.picture
        songEntity.pictureMedium = song.album.pictureMedium
        songEntity.pictureXl = song.album.pictureXl
        do {
            try context.save()
            changeFavoriteStatus = true
        } catch {
            print("Error saving: \(error)")
        }
        
      
    }
    
    static func removeFavoriteSong(_ id: Int) {
        let fetchRequest: NSFetchRequest<SongEntity> = SongEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        do {
            let songs = try context.fetch(fetchRequest)
            for song in songs {
                context.delete(song)
            }
            try context.save()
            changeFavoriteStatus = true
        } catch {
            print("Error deleting: \(error)")
        }
    }
    
    static func getFavorites() -> [SongStruct] {
        let fetchRequest: NSFetchRequest<SongEntity> = SongEntity.fetchRequest()
        do {
            let songEntities = try context.fetch(fetchRequest)
            var songs: [SongStruct] = []
            for songEntity in songEntities {
                let album = SongsAlbumStruct(id: Int(songEntity.id), title: songEntity.title ?? "", picture: songEntity.picture ?? "", pictureMedium: songEntity.pictureMedium ?? "", pictureXl: songEntity.pictureXl ?? "")
                let song = SongStruct(id: Int(songEntity.id), title: songEntity.title ?? "", titleShort: songEntity.titleShort ?? "", duration: Int(songEntity.duration), preview: songEntity.preview ?? "", md5Image: songEntity.md5Image ?? "", album: album)
                songs.append(song)
            }
            return songs
        } catch {
            print("Error fetching: \(error)")
            return []
        }
    }
}
