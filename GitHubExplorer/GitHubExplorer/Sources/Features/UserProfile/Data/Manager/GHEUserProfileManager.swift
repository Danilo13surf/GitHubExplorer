//
//  GHEUserProfileManager.swift
//  GitHubExplorer
//
//  Created by Danilo Carlos Ribeiro on 24/06/23.
//  Copyright © 2023 GitHubExplorer. All rights reserved.
//

import CoreSwift
import Foundation

typealias GHEGetRepositorysCompletion = (Result<[GHEListRepositoryResponse], Error>) -> Void
typealias GHEGetMoreInfoUserCompletion = (Result<GHEUserResponse, Error>) -> Void

protocol GHEUserProfileManagerProtocol {
    func getRepositorys(user: String?, completion: @escaping GHEGetRepositorysCompletion)
    func getMoreInfoUser(user: String?, completion: @escaping GHEGetMoreInfoUserCompletion)
}

class GHEUserProfileManager: BaseManager, GHEUserProfileManagerProtocol {
    
    // MARK: - Properties
    var provider: ApiProviderProtocol?
    var business: GHEUserProfileBussinesProtocol?
    
    // MARK: - Initialize
    
    required init(provider: ApiProviderProtocol? = nil, business: GHEUserProfileBussinesProtocol = GHEUserProfileBussines()) {
        self.provider = provider
        self.business = business
        super.init()
    }
    
    // MARK: - Public Methods
    func getRepositorys(user: String?, completion: @escaping GHEGetRepositorysCompletion) {
        cancelAllOperations()
        let operation = GHEListRepositorysOperation(user: user, provider: provider, business: business, completion: completion)
        addOperation(operation)
    }
    
    func getMoreInfoUser(user: String?, completion: @escaping GHEGetMoreInfoUserCompletion) {
        cancelAllOperations()
        let operation = GHEUserMoreInfoOperation(user: user, provider: provider, business: business, completion: completion)
        addOperation(operation)
    }
}
