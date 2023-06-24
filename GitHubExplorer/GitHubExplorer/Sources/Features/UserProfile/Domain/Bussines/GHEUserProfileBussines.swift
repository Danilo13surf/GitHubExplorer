//
//  GHEUserProfileBussines.swift
//  GitHubExplorer
//
//  Created by Danilo Carlos Ribeiro on 24/06/23.
//  Copyright © 2023 GitHubExplorer. All rights reserved.
//

import CoreSwift
import Foundation

protocol GHEUserProfileBussinesProtocol {
    func handleRepositorysGet(result: NetworkingResponse, completion: @escaping GHEGetRepositorysCompletion)
}

struct GHEUserProfileBussines: GHEUserProfileBussinesProtocol {
    func handleRepositorysGet(result: () throws -> ResponseObject, completion: @escaping GHEGetRepositorysCompletion) {
        do {
            guard let response = try result().data else {
                completion(.failure(BaseError.parse("Error decoding data")))
                return
            }
            let model = try JSONDecoder().decode([GHEListRepositoryResponse].self, from: response)
            completion(.success(model))
        } catch {
            completion(.failure(error))
        }
    }
}
