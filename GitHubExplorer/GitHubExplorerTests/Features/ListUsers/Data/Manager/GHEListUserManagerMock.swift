//
//  GHEListUserManagerMock.swift
//  GitHubExplorerTests
//
//  Created by Danilo Carlos Ribeiro on 25/06/23.
//  Copyright © 2023 GitHubExplorer. All rights reserved.
//

@testable import GitHubExplorer

class GHEListUserManagerMock: GHEListUserManagerProtocol {
    var result: Result<[GHEUserResponse], Error>?
    
    func fetchUssers(completion: @escaping (Result<[GHEUserResponse], Error>) -> Void) {
        if let result = result {
            completion(result)
        } else {
            completion(.failure(MockListUserError.mockError))
        }
    }
}

enum MockListUserError: Error {
    case mockError
}
