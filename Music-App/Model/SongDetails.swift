//
//  SongModel.swift
//  Music-App
//
//  Created by Ayca Akman on 10.05.2023.
//

import Foundation

struct SongModelStruct: Codable {
    let id: Int
    let title: String
    let releaseDate: String
    let tracks: TracksStruct
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case releaseDate = "release_date"
        case tracks
    }
}

struct TracksStruct: Codable {
    let data: [SongStruct]
}

struct SongStruct: Codable {
    let id: Int
    let title: String
    let titleShort: String
    let duration: Int
    let preview: String
    let md5Image: String
    let album: SongsAlbumStruct
    
    enum CodingKeys: String, CodingKey {
        case id, title, duration, preview
        case titleShort = "title_short"
        case md5Image = "md5_image"
        case album
    }
} 

struct SongsAlbumStruct: Codable {
    let id: Int
    let title: String
    let picture: String
    let pictureMedium: String
    let pictureXl: String
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case picture = "cover"
        case pictureMedium = "cover_medium"
        case pictureXl = "cover_xl"
    }

}


