//
//  TmdbApi.swift
//  Movies
//
//  Created by Balazs Kanyo on 22/10/2023.
//

import Combine
import Foundation
import OSLog

protocol TmdbApi {
    func getTrending() -> AnyPublisher<DataTask<TrendingListResponse, ApiError>, Never>
    func getGenres() -> AnyPublisher<DataTask<GenreListResponse, ApiError>, Never>
}

final class TmdbApiImpl {
    private enum Constants {
        static let baseUrl = "https://api.themoviedb.org/3/"

        static let parameters = "?language=en-US&api_key=\(APIkey)"
    }

    private enum ApiUrl: String {
        case trending = "trending/movie/day"
        case genre = "genre/movie/list"
    }

    private let session = URLSession.shared
}

extension TmdbApiImpl: TmdbApi {
    func getTrending() -> AnyPublisher<DataTask<TrendingListResponse, ApiError>, Never> {
        get(url: .trending)
    }

    func getGenres() -> AnyPublisher<DataTask<GenreListResponse, ApiError>, Never> {
        get(url: .genre)
    }
}

extension TmdbApiImpl {
    private func get<T: Codable>(url: ApiUrl) -> AnyPublisher<DataTask<T, ApiError>, Never> {
        session
            .mapRequestToSubject(
                request: createGetRequest(apiUrl: url),
                type: T.self
            )
    }

    private func createGetRequest(apiUrl: ApiUrl) -> URLRequest {
        guard let url = URL(string: "\(Constants.baseUrl)\(apiUrl.rawValue)\(Constants.parameters)") else {
            return NSURLRequest() as URLRequest
        }

        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "accept": "application/json",
        ]

        return request as URLRequest
    }
}
