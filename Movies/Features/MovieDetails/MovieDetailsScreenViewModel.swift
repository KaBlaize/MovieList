//
//  MovieDetailsScreenViewModel.swift
//  Movies
//
//  Created by Foundation on 2022. 02. 14..
//

import Combine
import Foundation

class MovieDetailsScreenViewModel: MovieDetailsScreenViewModelProtocol {
    @Published var movie: MovieVM

    private let markMovieUseCase: MarkMovieUseCase
    private var bag = Set<AnyCancellable>()

    init(movie: MovieVM, dependencies: MovieDetailsDependencies) {
        self.movie = movie
        self.markMovieUseCase = dependencies.makeMarkMovieUseCase()
    }

    func markMovie() {
        markMovieUseCase
            .execute(movie: movie)
            .receive(on: DispatchQueue.main)
        // FIXME: don't want to change the view due to time but I'd use the new model created for the use case to display loading and error states
            .sink(receiveValue: { [weak self] dataTask in
                switch dataTask {
                case .loaded(let isMarked):
                    self?.movie.isMarked = isMarked
                default: break
                }
            })
            .store(in: &bag)
    }
}
