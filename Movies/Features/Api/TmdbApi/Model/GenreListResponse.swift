//
//  GenreList.swift
//  Movies
//
//  Created by Balazs Kanyo on 23/10/2023.
//

import Foundation

// MARK: - GenreList
struct GenreListResponse: Codable {
    let genres: [Genre]
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}
