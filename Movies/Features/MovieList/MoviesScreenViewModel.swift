//
//  MoviesViewModel.swift
//  Movies
//
//  Created by Foundation on 2022. 02. 14..
//

import Combine
import Foundation

class MoviesScreenViewModel: MoviesScreenViewModelProtocol {
    @Published var movies: [MovieVM] = []

    private let api: TmdbApi
    private var bag = Set<AnyCancellable>()

    init() {
        api = TmdbApiImpl()
    }

    func load() {
        api
            .getTrending()
            .receive(on: DispatchQueue.main)
            .map { [weak self] dataTask in
                if case let .loaded(data) = dataTask {
                    return data
                        .results
                        .map {
                            MovieVM(
                                id: "\($0.id)",
                                title: $0.title,
                                genres: $0.genreIDS.map { "\($0)" }.joined(),
                                overView: $0.overview,
                                image: .init(
                                    small: "https://image.tmdb.org/t/p/w200/\($0.posterPath)", // TODO: https://developer.themoviedb.org/reference/configuration-details
                                    large: "https://image.tmdb.org/t/p/original/\($0.posterPath)"
                                ),
                                popularity: Float($0.popularity),
                                isMarked: false
                            )
                        }
                }
                return []
            }
            .receive(on: DispatchQueue.main)
            .assign(to: \.movies, on: self)
            .store(in: &bag)
    }
}
