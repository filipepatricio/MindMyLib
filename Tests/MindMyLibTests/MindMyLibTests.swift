import Combine
@testable import MindMyLib
import XCTest

final class MindMyLibTests: XCTestCase {
    func testGetOrganizationDataSuccessfully() throws {
        let mockData = """
                [
                    {
                        "login": "errfree",
                            "id": 44,
                            "node_id": "MDEyOk9yZ2FuaXphdGlvbjQ0",
                            "url": "https://api.github.com/orgs/errfree",
                            "repos_url": "https://api.github.com/orgs/errfree/repos",
                            "events_url": "https://api.github.com/orgs/errfree/events",
                            "hooks_url": "https://api.github.com/orgs/errfree/hooks",
                            "issues_url": "https://api.github.com/orgs/errfree/issues",
                            "members_url": "https://api.github.com/orgs/errfree/members{/member}",
                            "public_members_url": "https://api.github.com/orgs/errfree/public_members{/member}",
                            "avatar_url": "https://avatars.githubusercontent.com/u/44?v=4",
                            "description": null
                    }
                ]
        """
        let mockNetworkManager = MockNetworkManager(mockData: mockData)
        let apiService = ApiService(networkManager: mockNetworkManager)
        var cancellables = Set<AnyCancellable>()

        try apiService.getOrganizations()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { data in
                let dataString = String(decoding: data, as: UTF8.self)
                XCTAssertEqual(dataString, mockData)
            }
            .store(in: &cancellables)
    }
}
