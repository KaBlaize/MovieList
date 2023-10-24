//
//  MovieDetailsScreenViewModel.swift
//  Movies
//
//  Created by Foundation on 2022. 02. 14..
//

import Foundation

class MovieDetailsScreenViewModel: ObservableObject, MovieDetailsScreenViewModelProtocol {
    @Published var movie: MovieVM

    init(movie: MovieVM) {
        self.movie = movie
    }

    func markMovie() {}
}
