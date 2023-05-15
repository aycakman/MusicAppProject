//
//  TracklistModel.swift
//  Music-App
//
//  Created by Ayca Akman on 8.05.2023.
//

import Foundation

struct TracklistModel: Codable {
    let data: [TracklistData]
}

struct TracklistData: Codable {
    let id: Int
    let title, titleShort: String
    let link: String
    let duration: Int
    let preview: String?
    let contributors: [Contributor]
    let artist: Artist
    let album: Album

    enum CodingKeys: String, CodingKey {
        case id, title
        case titleShort = "title_short"
        case link, duration
        case preview, contributors
        case artist, album
    }
}

struct Album: Codable {
    let id: Int
    let title: String
    let cover: String
    let coverSmall, coverMedium, coverBig, coverXl: String
    let tracklist: String

    enum CodingKeys: String, CodingKey {
        case id, title, cover
        case coverSmall = "cover_small"
        case coverMedium = "cover_medium"
        case coverBig = "cover_big"
        case coverXl = "cover_xl"
        case tracklist
    }
}

struct Artist: Codable {
    let id: Int
    let name: String
    let tracklist: String
}



struct Contributor: Codable {
    let id: Int
    let name: String
    let picture: String
    let pictureSmall, pictureMedium, pictureBig, pictureXl: String
    let tracklist: String
   

    enum CodingKeys: String, CodingKey {
        case id, name, picture
        case pictureSmall = "picture_small"
        case pictureMedium = "picture_medium"
        case pictureBig = "picture_big"
        case pictureXl = "picture_xl"
        case tracklist
    }
}


