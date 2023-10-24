//
//  MoviesViewModel.swift
//  Movies
//
//  Created by Foundation on 2022. 02. 14..
//

import Combine
import Foundation

class MovieListScreenViewModel: MovieListScreenViewModelProtocol {
    @Published var movies: [MovieVM] = []
    @Published var maxPopularity: Float = 10

    private let getTrendingMoviesUseCase: GetTrendingMoviesUseCase
    private let detailsDependencies: MovieDetailsDependencies
    private var bag = Set<AnyCancellable>()

    init(dependencies: MovieListDependencies) {
        getTrendingMoviesUseCase = dependencies.makeGetTrendingMoviesUseCase()
        detailsDependencies = dependencies
    }

    func load() {
        getTrendingMoviesUseCase
            .execute()
            .receive(on: DispatchQueue.main)
        // FIXME: don't want to change the view due to time but I'd use the new model created for the use case to display loading and error states
            .sink { [weak self] dataTask in
                switch dataTask {
                case .loaded(let model):
                    self?.maxPopularity = model.maxPopularity
                    self?.movies = model.movies
                default: break
                }
            }
            .store(in: &bag)
    }

    func getMovieDetailsScreenViewModel(for movie: MovieVM) -> MovieDetailsScreenViewModel {
        MovieDetailsScreenViewModel(movie: movie, dependencies: detailsDependencies)
    }
}
