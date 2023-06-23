//
//  GHEListRepositoryResponse.swift
//  GitHubExplorer
//
//  Created by Danilo Carlos Ribeiro on 23/06/23.
//  Copyright © 2023 GitHubExplorer. All rights reserved.
//

import Foundation

// MARK: - GHEOwner
struct GHEOwner {
    let login: String?
    let id: Int?
    let nodeID: String?
    let avatarURL: String?
    let gravatarID: String?
    let url: String?
    let htmlURL: String?
    let followersURL: String?
    let followingURL: String?
    let gistsURL: String?
    let starredURL: String?
    let subscriptionsURL: String?
    let organizationsURL: String?
    let reposURL: String?
    let eventsURL: String?
    let receivedEventsURL: String?
    let type: String?
    let siteAdmin: Bool?
}

// MARK: - GHEListRepositoryResponse
struct GHEListRepositoryResponse {
    let id: Int?
    let nodeID: String?
    let name: String?
    let fullName: String?
    let welcome9Private: Bool?
    let owner: GHEOwner?
    let htmlURL: String?
    let welcome9Description: NSNull?
    let fork: Bool?
    let url: String?
    let forksURL: String?
    let keysURL: String?
    let collaboratorsURL: String?
    let teamsURL: String?
    let hooksURL: String?
    let issueEventsURL: String?
    let eventsURL: String?
    let assigneesURL: String?
    let branchesURL: String?
    let tagsURL: String?
    let blobsURL: String?
    let gitTagsURL: String?
    let gitRefsURL: String?
    let treesURL: String?
    let statusesURL: String?
    let languagesURL: String?
    let stargazersURL: String?
    let contributorsURL: String?
    let subscribersURL: String?
    let subscriptionURL: String?
    let commitsURL: String?
    let gitCommitsURL: String?
    let commentsURL: String?
    let issueCommentURL: String?
    let contentsURL: String?
    let compareURL: String?
    let mergesURL: String?
    let archiveURL: String?
    let downloadsURL: String?
    let issuesURL: String?
    let pullsURL: String?
    let milestonesURL: String?
    let notificationsURL: String?
    let labelsURL: String?
    let releasesURL: String?
    let deploymentsURL: String?
    let createdAt: String?
    let updatedAt: String?
    let pushedAt: Date?
    let gitURL: String?
    let sshURL: String?
    let cloneURL: String?
    let svnURL: String?
    let homepage: NSNull?
    let size: String?
    let stargazersCount: String?
    let watchersCount: Int?
    let language: String?
    let hasIssues: String?
    let hasProjects: String?
    let hasDownloads: String?
    let hasWiki: Bool?
    let hasPages: Bool?
    let hasDiscussions: Bool?
    let forksCount: Int?
    let mirrorURL: NSNull?
    let archived: Bool?
    let disabled: Bool?
    let openIssuesCount: Int?
    let license: NSNull?
    let allowForking: Bool?
    let isTemplate: Bool?
    let webCommitSignoffRequired: Bool?
    let topics: [Any??]
    let visibility: String?
    let forks: Int?
    let openIssues: Int?
    let watchers: Int?
    let defaultBranch: String?
}
