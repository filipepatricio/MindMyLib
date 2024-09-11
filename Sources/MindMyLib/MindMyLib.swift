// The Swift Programming Language
// https://docs.swift.org/swift-book

import Combine
import Foundation

@available(iOS 13.0, *)
public class ApiService {
    let networkManager: NetworkManager
    public init() {
        self.networkManager = NetworkManagerImpl()
    }

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }

    public func getOrganizations() throws -> AnyPublisher<Data, Error> {
        let urlString = "https://api.github.com/organizations"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        return networkManager.download(url: url)
    }

    public func getImage(url: URL) -> AnyPublisher<Data, Error> {
        return networkManager.download(url: url)
    }
}
