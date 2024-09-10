// The Swift Programming Language
// https://docs.swift.org/swift-book

import Combine
import Foundation

@available(iOS 13.0, *)
public class GithubService {
    public init() {}
    public func getOrganizations() throws -> AnyPublisher<Data, Error> {
        let urlString = "https://api.github.com/organizations"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
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
