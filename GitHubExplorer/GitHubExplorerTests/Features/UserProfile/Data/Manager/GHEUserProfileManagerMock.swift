//
//  GHEUserProfileManagerMock.swift
//  GitHubExplorerTests
//
//  Created by Danilo Carlos Ribeiro on 25/06/23.
//  Copyright © 2023 GitHubExplorer. All rights reserved.
//

import CoreSwift
@testable import GitHubExplorer

protocol GHEUserProfileMockManagerProtocol: GHEUserProfileManagerProtocol {
    var getMoreInfoUserCalled: Dynamic<Bool> {  get set  }
    var repositoryResult: Result<[GHEListRepositoryResponse], any Error>? {  get set  }
    var moreInfoResult: Result<GHEUserResponse, any Error>? {  get set  }

}

class GHEUserProfileManagerMock: GHEUserProfileMockManagerProtocol {
    var getMoreInfoUserCalled = Dynamic<Bool>(false)
    var repositoryResult: Result<[GHEListRepositoryResponse], Error>?
    var moreInfoResult: Result<GHEUserResponse, Error>?

    func getMoreInfoUser(user: String?, completion: @escaping GHEGetMoreInfoUserCompletion) {
        if let result = moreInfoResult {
            completion(result)
        } else {
            completion(.failure(MockUserProfileError.mockError))
        }
        getMoreInfoUserCalled.value = true
    }
    
    func getRepositorys(user: String?, completion: @escaping GHEGetRepositorysCompletion) {
        if let result = repositoryResult {
            completion(result)
        } else {
            completion(.failure(MockUserProfileError.mockError))
        }
    }
}

enum MockUserProfileError: Error {
    case mockError
}
