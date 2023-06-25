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
    func handleMoreInfoUserGet(result: NetworkingResponse, completion: @escaping GHEGetMoreInfoUserCompletion)
}

struct GHEUserProfileBussines: GHEUserProfileBussinesProtocol {
    func handleRepositorysGet(result: () throws -> ResponseObject, completion: @escaping GHEGetRepositorysCompletion) {
        do {
            guard let response = try result().data else {
                completion(.failure(BaseError.parse("Error decoding data")))
                return
            }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
            let model = try decoder.decode([GHEListRepositoryResponse].self, from: response)
            completion(.success(model))
        } catch {
            completion(.failure(error))
        }
    }
    
    func handleMoreInfoUserGet(result: () throws -> ResponseObject, completion: @escaping GHEGetMoreInfoUserCompletion) {
        do {
            guard let response = try result().data else {
                completion(.failure(BaseError.parse("Error decoding data")))
                return
            }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
            let model = try decoder.decode(GHEResponse.self, from: response)
            completion(.success(model))
        } catch {
            completion(.failure(error))
        }
    }
}
