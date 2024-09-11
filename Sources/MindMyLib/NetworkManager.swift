//
//  File.swift
//
//
//  Created by Filipe Patricio on 10/09/2024.
//

import Combine
import Foundation

@available(iOS 13.0, *)
protocol NetworkManager {
    func download(url: URL) -> AnyPublisher<Data, Error>
}

@available(iOS 13.0, *)
public class NetworkManagerImpl: NetworkManager {
    func download(url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { output -> Data in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300
                else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

@available(iOS 13.0, *)
public class MockNetworkManager: NetworkManager {
    let mockData: String
    public init(mockData: String) {
        self.mockData = mockData
    }

    func download(url: URL) -> AnyPublisher<Data, Error> {
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
        let data = mockData.data(using: .utf8)!
        return Just(data)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
