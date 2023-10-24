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
    func getTrending() -> AnyPublisher<DataTask<TrendingList, ApiError>, Never>
}

final class TmdbApiImpl {
    private let trendingUrl: URL
    private let session = URLSession.shared

    private var bag = Set<AnyCancellable>()

    init() {
        self.trendingUrl =  URL(string: "https://api.themoviedb.org/3/trending/movie/day?language=en-US&api_key=\(APIkey)")!
    }
}

extension TmdbApiImpl: TmdbApi {
    func getTrending() -> AnyPublisher<DataTask<TrendingList, ApiError>, Never> {

        let headers = [
            "accept": "application/json",
        ]

        let request = NSMutableURLRequest(url: trendingUrl as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 100.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        return session.mapRequestToSubject(request: request as URLRequest, type: TrendingList.self)
    }
}
