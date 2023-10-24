//
//  MarkMovieUseCase.swift
//  Movies
//
//  Created by Balazs Kanyo on 23/10/2023.
//

import Combine
import Foundation

protocol MarkMovieUseCase {
    func execute(movie: MovieVM) -> AnyPublisher<DataTask<Bool, ApiError>, Never>
}

final class MarkMovieUseCaseImpl {
    private let repository: MovieRepository

    init(repository: MovieRepository) {
        self.repository = repository
    }
}

extension MarkMovieUseCaseImpl: MarkMovieUseCase {
    func execute(movie: MovieVM) -> AnyPublisher<DataTask<Bool, ApiError>, Never> {
        Just(.loaded(
            data: repository.mark(movie: movie)
        ))
        .eraseToAnyPublisher()
    }
}
