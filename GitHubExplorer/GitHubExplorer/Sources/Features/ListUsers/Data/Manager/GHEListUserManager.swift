//
//  GHEListUserManager.swift
//  GitHubExplorer
//
//  Created by Danilo Carlos Ribeiro on 23/06/23.
//  Copyright © 2023 GitHubExplorer. All rights reserved.
//

import CoreSwift
import Foundation

typealias GHEGetUssersCompletion = (Result<[GHEResponse], Error>) -> Void

protocol GHEListUserManagerProtocol {
    func fetchUssers(completion: @escaping GHEGetUssersCompletion)
}

class GHEListUserManager: BaseManager, GHEListUserManagerProtocol {
    
    // MARK: - Properties
    var provider: ApiProviderProtocol?
    var business: GHEListUsersBusinessProtocol?
    
    // MARK: - Initialize
    
    required init(provider: ApiProviderProtocol? = nil, business: GHEListUsersBusinessProtocol = GHEListUsersBusiness()) {
        self.provider = provider
        self.business = business
        super.init()
    }
    
    // MARK: - Public Methods
    
    func fetchUssers(completion: @escaping GHEGetUssersCompletion) {
        cancelAllOperations()
        let operation = GHEListUsersOperation(provider: provider, business: business, completion: completion)
        addOperation(operation)
    }
}
