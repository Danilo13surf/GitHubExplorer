//
//  GHEListRepositoryResponse.swift
//  GitHubExplorer
//
//  Created by Danilo Carlos Ribeiro on 23/06/23.
//  Copyright © 2023 GitHubExplorer. All rights reserved.
//

import Foundation

// MARK: - GHELicense
struct GHELicense: Codable {
    let key: String?
    let name: String?
    let spdxID: String?
    let url: String?
    let nodeID: String?
}

// MARK: - GHEListRepositoryResponse
struct GHEListRepositoryResponse: Codable {
    let id: Int?
    let node_id: String?
    let name: String?
    let fullName: String?
    let `private`: Bool?
    let owner: GHEResponse?
    let html_url: String?
    let welcome9Description: String?
    let fork: Bool?
    let url: String?
    let forks_url: String?
    let keys_url: String?
    let collaborators_url: String?
    let teams_url: String?
    let hooks_url: String?
    let issue_events_url: String?
    let events_url: String?
    let assignees_url: String?
    let branches_url: String?
    let tags_url: String?
    let blobs_url: String?
    let git_tags_url: String?
    let git_refs_url: String?
    let trees_url: String?
    let statuses_url: String?
    let languages_url: String?
    let stargazers_url: String?
    let contributors_url: String?
    let subscribers_url: String?
    let subscription_url: String?
    let commits_url: String?
    let git_commits_url: String?
    let comments_url: String?
    let issue_comment_url: String?
    let contents_url: String?
    let compare_url: String?
    let merges_url: String?
    let archive_url: String?
    let downloads_url: String?
    let issues_url: String?
    let pulls_url: String?
    let milestones_url: String?
    let notifications_url: String?
    let labels_url: String?
    let releases_url: String?
    let deployments_url: String?
    let created_at: String?
    let updated_at: String?
    let pushed_at: Date?
    let git_url: String?
    let ssh_url: String?
    let clone_url: String?
    let svn_url: String?
    let homepage: String?
    let size: Int?
    let stargazers_count: Int?
    let watchers_count: Int?
    let language: String?
    let has_issues: Bool?
    let has_projects: Bool?
    let has_downloads: Bool?
    let has_wiki: Bool?
    let has_pages: Bool?
    let has_discussions: Bool?
    let forks_count: Int?
    let mirror_url: String?
    let archived: Bool?
    let disabled: Bool?
    let open_issues_count: Int?
    let license: GHELicense?
    let allow_forking: Bool?
    let is_template: Bool?
    let web_commit_signoff_required: Bool?
    let topics: [String?]?
    let visibility: String?
    let forks: Int?
    let open_issues: Int?
    let watchers: Int?
    let default_branch: String?
}
