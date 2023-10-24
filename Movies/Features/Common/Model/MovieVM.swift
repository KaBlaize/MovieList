//
//  MovieVM.swift
//  Movies
//
//  Created by Foundation on 2022. 02. 14..
//

import Foundation

// TODO: due to time limit and the current requirements I skip the following step: split this model into 2 domain object that fits only the needs of one feature.
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
