//
//  MoviesViewModel.swift
//  Movies
//
//  Created by Foundation on 2022. 02. 14..
//

import Foundation

class MoviesScreenViewModel: MoviesScreenViewModelProtocol {
    @Published var movies: [MovieVM] = []
}
