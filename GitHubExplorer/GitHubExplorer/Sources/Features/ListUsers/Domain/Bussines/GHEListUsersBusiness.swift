//
//  GHEBusiness.swift
//  GitHubExplorer
//
//  Created by Danilo Carlos Ribeiro on 23/06/23.
//  Copyright © 2023 GitHubExplorer. All rights reserved.
//

import CoreSwift
import Foundation

protocol GHEListUsersBusinessProtocol {
    func handleUssersGet(result: NetworkingResponse, completion: @escaping GHEGetUssersCompletion)
}

struct GHEListUsersBusiness: GHEListUsersBusinessProtocol {
    func handleUssersGet(result: () throws -> ResponseObject, completion: @escaping GHEGetUssersCompletion) {
        do {
            guard let response = try result().data else {
                completion(.failure(BaseError.parse("Error decoding data")))
                return
            }
            let model = try JSONDecoder().decode([GHEResponse].self, from: response)
            completion(.success(model))
        } catch {
            completion(.failure(error))
        }
    }
}
