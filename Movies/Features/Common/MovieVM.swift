//
//  MovieVM.swift
//  Movies
//
//  Created by Foundation on 2022. 02. 14..
//

import Foundation

struct MovieVM: Identifiable {
    struct Image {
        let small: String
        let large: String
    }

    let id: String
    let title: String
    let genres: String
    let overView: String
    let image: Image
    let popularity: Float
    var isMarked: Bool
}
