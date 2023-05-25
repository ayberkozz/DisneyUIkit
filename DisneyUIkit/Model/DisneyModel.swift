//
//  DisneyModel.swift
//  DisneyUIkit
//
//  Created by Ayberk Öz on 24.05.2023.
//

import Foundation

struct DisneyModel: Codable {
    let data: [DisneyModel1]
}

// MARK: - DisneyModel1
struct DisneyModel1: Codable {
    let id: Int
    let films, shortFilms, tvShows, videoGames: [String]
    let parkAttractions: [String]
    let allies, enemies: [String]
    let name: String
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case films, shortFilms, tvShows, videoGames, parkAttractions, allies, enemies
        case name
        case imageURL = "imageUrl"
    }
}
