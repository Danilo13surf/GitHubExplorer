//
//  GHEUserProfileViewModelTests.swift
//  GitHubExplorerTests
//
//  Created by Danilo Carlos Ribeiro on 24/06/23.
//  Copyright © 2023 GitHubExplorer. All rights reserved.
//

import XCTest
@testable import GitHubExplorer

class GHEUserProfileViewModelTests: XCTestCase {
    
    // MARK: - Properties
    var viewModel: GHEUserProfileViewModelProtocol?
    var managerMock: GHEUserProfileMockManagerProtocol?
    var showNextFlowCalled: Bool = false
    var model: GHEUserResponse?
    var listModel: [GHEListRepositoryResponse] = []
    
    // MARK: - Override Methods
    override func setUp() {
        super.setUp()
        managerMock = GHEUserProfileManagerMock()
        model = setMockGHEResponse()
        listModel.append(setMockListRepositoryResponse())
        viewModel = GHEUserProfileViewModel(manager: managerMock, model: model)
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
        managerMock = nil
        showNextFlowCalled = false
    }
    
    // MARK: - Tests Methods
    func testGetRepositorysSuccess() {
        managerMock?.repositoryResult = .success(listModel)
        managerMock?.moreInfoResult = .success(model ?? setMockGHEResponse())
        viewModel?.getRepositorys()
        XCTAssertNotNil(viewModel?.model)
        XCTAssertNotNil(viewModel?.listRepository)
        XCTAssertNotNil(viewModel?.currentUser)
        XCTAssertTrue(managerMock?.getMoreInfoUserCalled.value == true)
    }
    
    func testGetRepositorysSuccessWithFailureGetMoreInfoUser() {
        managerMock?.repositoryResult = .success(listModel)
        viewModel?.getRepositorys()
        XCTAssertNotNil(viewModel?.model)
        XCTAssertNotNil(viewModel?.listRepository)
        XCTAssertNil(viewModel?.currentUser)
        XCTAssertTrue(managerMock?.getMoreInfoUserCalled.value == true)
    }
    
    func testGetRepositorysFailure() {
        managerMock?.repositoryResult = .failure(MockListUserError.mockError)
        viewModel?.getRepositorys()
        XCTAssertEqual(viewModel?.status.value, .error)
    }
    
    // MARK: - Private Methods for set mock response
    private func setMockGHEResponse() -> GHEUserResponse {
        return GHEUserResponse(login: "user1", id: 1, node_id: "node1", avatar_url: "avatar1", gravatar_id: "gravatar1", url: "url1", html_url: "html1", followers_url: "followers1", following_url: "following1", gists_url: "gists1", starred_url: "starred1", subscriptions_url: "subscriptions1", organizations_url: "organizations1", repos_url: "repos1", events_url: "events1", received_events_url: "received_events1", type: "type1", site_admin: false, name: "name", blog: "blog")
    }
    
    private func setMockListRepositoryResponse() -> GHEListRepositoryResponse {
        return GHEListRepositoryResponse(
            id: 1,
            node_id: "repository_node_id",
            name: "Repository Name",
            fullName: "Repository Full Name",
            private: false,
            owner: nil,
            html_url: "repository_html_url",
            welcome9Description: "Repository Description",
            fork: false,
            url: "repository_url",
            forks_url: "repository_forks_url",
            keys_url: "repository_keys_url",
            collaborators_url: "repository_collaborators_url",
            teams_url: "repository_teams_url",
            hooks_url: "repository_hooks_url",
            issue_events_url: "repository_issue_events_url",
            events_url: "repository_events_url",
            assignees_url: "repository_assignees_url",
            branches_url: "repository_branches_url",
            tags_url: "repository_tags_url",
            blobs_url: "repository_blobs_url",
            git_tags_url: "repository_git_tags_url",
            git_refs_url: "repository_git_refs_url",
            trees_url: "repository_trees_url",
            statuses_url: "repository_statuses_url",
            languages_url: "repository_languages_url",
            stargazers_url: "repository_stargazers_url",
            contributors_url: "repository_contributors_url",
            subscribers_url: "repository_subscribers_url",
            subscription_url: "repository_subscription_url",
            commits_url: "repository_commits_url",
            git_commits_url: "repository_git_commits_url",
            comments_url: "repository_comments_url",
            issue_comment_url: "repository_issue_comment_url",
            contents_url: "repository_contents_url",
            compare_url: "repository_compare_url",
            merges_url: "repository_merges_url",
            archive_url: "repository_archive_url",
            downloads_url: "repository_downloads_url",
            issues_url: "repository_issues_url",
            pulls_url: "repository_pulls_url",
            milestones_url: "repository_milestones_url",
            notifications_url: "repository_notifications_url",
            labels_url: "repository_labels_url",
            releases_url: "repository_releases_url",
            deployments_url: "repository_deployments_url",
            created_at: "repository_created_at",
            updated_at: "repository_updated_at",
            pushed_at: Date(),
            git_url: "repository_git_url",
            ssh_url: "repository_ssh_url",
            clone_url: "repository_clone_url",
            svn_url: "repository_svn_url",
            homepage: "repository_homepage",
            size: 100,
            stargazers_count: 10,
            watchers_count: 5,
            language: "repository_language",
            has_issues: true,
            has_projects: true,
            has_downloads: true,
            has_wiki: true,
            has_pages: true,
            has_discussions: true,
            forks_count: 2,
            mirror_url: "repository_mirror_url",
            archived: false,
            disabled: false,
            open_issues_count: 3,
            license: setMockLicense(),
            allow_forking: true,
            is_template: false,
            web_commit_signoff_required: true,
            topics: ["topic1", "topic2"],
            visibility: "repository_visibility",
            forks: 4,
            open_issues: 5,
            watchers: 6,
            default_branch: "main"
        )
    }
    
    private func setMockLicense() -> GHELicense {
        return GHELicense(key: "license_key", name: "License Name", spdxID: "license_spdx_id", url: "license_url", nodeID: "license_node_id")
    }
}
