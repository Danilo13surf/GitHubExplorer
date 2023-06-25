//
//  GHEListUsersViewModelTests.swift
//  GitHubExplorer
//
//  Created by Danilo Carlos Ribeiro on 24/06/23.
//  Copyright © 2023 GitHubExplorer. All rights reserved.
//

import XCTest
@testable import GitHubExplorer

class GHEListUsersViewModelTests: XCTestCase {
    
    // MARK: - Properties
    var viewModel: GHEListUsersViewModelProtocol?
    var managerMock: GHEListUserManagerMock?
    var showNextFlowCalled: Bool = false
    var expectedResult: [GHEResponse] = []
    
    // MARK: - Override Methods
    override func setUp() {
        super.setUp()
        managerMock = GHEListUserManagerMock()
        expectedResult = setMockGHEResponse()
        viewModel = GHEListUsersViewModel(manager: managerMock, showNextFlow: { _ in
            self.showNextFlowCalled = true
        })
    }
    
    // MARK: - Tests Methods
    override func tearDown() {
        super.tearDown()
        viewModel = nil
        managerMock = nil
        showNextFlowCalled = false
    }
    
    func testFetchUsersSuccess() {
        managerMock?.result = .success(expectedResult)
        viewModel?.fetchUssers()
        XCTAssertNotNil(viewModel?.model)
        XCTAssertEqual(viewModel?.status.value, .loaded)
    }
    
    func testFetchUsersFailure() {
        managerMock?.result = .failure(MockListUserError.mockError)
        viewModel?.fetchUssers()
        XCTAssertNil(viewModel?.model)
        XCTAssertEqual(viewModel?.status.value, .error)
    }
    
    func testShowMoreInfo() {
        viewModel?.showMoreInfo(model: expectedResult.first)
        XCTAssertTrue(showNextFlowCalled)
    }
    
    // MARK: - Private Methods for set mock response
    private func setMockGHEResponse() -> [GHEResponse] {
        return [
            GHEResponse(login: "user1", id: 1, node_id: "node1", avatar_url: "avatar1", gravatar_id: "gravatar1", url: "url1", html_url: "html1", followers_url: "followers1", following_url: "following1", gists_url: "gists1", starred_url: "starred1", subscriptions_url: "subscriptions1", organizations_url: "organizations1", repos_url: "repos1", events_url: "events1", received_events_url: "received_events1", type: "type1", site_admin: false),
            GHEResponse(login: "user2", id: 2, node_id: "node2", avatar_url: "avatar2", gravatar_id: "gravatar2", url: "url2", html_url: "html2", followers_url: "followers2", following_url: "following2", gists_url: "gists2", starred_url: "starred2", subscriptions_url: "subscriptions2", organizations_url: "organizations2", repos_url: "repos2", events_url: "events2", received_events_url: "received_events2", type: "type2", site_admin: true)
        ]
    }
}
