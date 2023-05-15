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
    let duration: Int
    let preview: String?
    let artist: Artist
    let album: Album

    enum CodingKeys: String, CodingKey {
        case id, title
        case titleShort = "title_short"
        case duration
        case preview
        case artist, album
    }
}

struct Album: Codable {
    let id: Int
    let title: String
    let cover: String
    let coverSmall, coverMedium, coverBig, coverXl: String?
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




