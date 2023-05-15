//
//  MusicCategory.swift
//  Music-App
//
//  Created by Ayca Akman on 8.05.2023.
//

import Foundation

struct MusicCategory : Codable {
    let data: [Data]
}

struct Data : Codable {
    let id: Int
    let name: String
    let picture: String
    let pictureSmall, pictureMedium, pictureBig, pictureXl: String

    enum CodingKeys: String, CodingKey {
        case id, name, picture
        case pictureSmall = "picture_small"
        case pictureMedium = "picture_medium"
        case pictureBig = "picture_big"
        case pictureXl = "picture_xl"
    }
}


