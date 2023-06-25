//
//  GHEUserProfileManagerMock.swift
//  GitHubExplorerTests
//
//  Created by Danilo Carlos Ribeiro on 25/06/23.
//  Copyright © 2023 GitHubExplorer. All rights reserved.
//

@testable import GitHubExplorer

class GHEUserProfileManagerMock: GHEUserProfileManagerProtocol {
    var result: Result<[GHEListRepositoryResponse], any Error>?

    func getRepositorys(user: String?, completion: @escaping GHEGetRepositorysCompletion) {
        if let result = result {
            completion(result)
        } else {
            completion(.failure(MockUserProfileError.mockError))
        }
    }
}

enum MockUserProfileError: Error {
    case mockError
}
