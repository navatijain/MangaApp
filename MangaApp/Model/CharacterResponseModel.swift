//
//  CharacterResponseModel.swift
//  MangaApp
//
//  Created by Navati Jain on 2021-02-10.
//

import Foundation

struct CharacterResponseModel: Codable {
    let requestHash: String
    let requestCached: Bool
    let requestCacheExpiry: Int
    let characters: [Characters]
}

struct Characters: Codable {
    let malId: Int
    let url: String
    let imageUrl: String
    let name: String
    let role: String
}

