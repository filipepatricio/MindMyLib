@testable import MindMyLib
import XCTest

final class MindMyLibTests: XCTestCase {
    func testExample() throws {
        // XCTest Documentation
        // https://developer.apple.com/documentation/xctest

        // Defining Test Cases and Test Methods
        // https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods

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

        apiService.getOrganizations()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { data in
                XCTAssertEqual(data.toString(), mockData)
            }
    }
}
