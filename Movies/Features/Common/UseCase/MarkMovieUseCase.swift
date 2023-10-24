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
    // Note to reviewer: I just made this complicated to be future proof. Usecase: receive a notification to open movie details.
    // if we navigate back to the list from the details we would see
    // - only one item if the prefetch of movies wasn't happen.
    // - or didn't see the result of the mark action
    //
    // I know the easy solution would be
    /*
     func execute(movie: MovieVM) -> Bool {
         repository.mark(movie: movie)
     }
     */
    func execute(movie: MovieVM) -> AnyPublisher<DataTask<Bool, ApiError>, Never> {
        repository
            .getTrending()
            .mapLoaded { [weak self] _ in
                self?.repository.mark(movie: movie) ?? false
            }

    }
}
