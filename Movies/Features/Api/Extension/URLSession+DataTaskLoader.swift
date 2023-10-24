//
//  URLSession+DataTaskLoader.swift
//  Movies
//
//  Created by Balazs Kanyo on 22/10/2023.
//

import Combine
import Foundation
import OSLog

extension URLSession {
    // TODO: improve logging 
    func mapRequestToSubject<T: Codable>(request: URLRequest, type: T.Type) -> AnyPublisher<DataTask<T, ApiError>, Never> {
        let subject = CurrentValueSubject<DataTask<T, ApiError>, Never>(.loading)
        let session = self

        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            let logger = Logger.api
            if let error {
                logger.error("request failed: \(error.localizedDescription)")
                subject.send(.failed(error: ApiError.network))
                return
            }
            guard let data else {
                logger.error("request api error: No data")
                subject.send(.failed(error: ApiError.api))
                return
            }
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                logger.error("request api error: \(String(data: data, encoding: .utf8) ?? "No Data")")
                subject.send(.failed(error: ApiError.api))
                return
            }

            do {
                let trendingList = try JSONDecoder().decode(T.self, from: data)
                subject.send(.loaded(data: trendingList))
            } catch {
                subject.send(.failed(error: ApiError.serialization))
                logger.error("failed to serialize response")
            }
        })

        dataTask.resume()

        return subject.eraseToAnyPublisher()
    }
}
