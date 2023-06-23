//
//  GHEManager.swift
//  GitHubExplorer
//
//  Created by Danilo Carlos Ribeiro on 23/06/23.
//  Copyright © 2023 GitHubExplorer. All rights reserved.
//

import CoreSwift
import Foundation

typealias GHEGetUssersCompletion = (Result<[GHEResponse], Error>) -> Void

protocol GHEManagerProtocol {
    func fetchUssers(completion: @escaping GHEGetUssersCompletion)
}

class GHEManager: BaseManager, GHEManagerProtocol {
    
    // MARK: - Properties
    var provider: ApiProviderProtocol?
    var business: GHEBusinessProtocol?
    
    // MARK: - Initialize
    
    required init(provider: ApiProviderProtocol? = nil, business: GHEBusinessProtocol = GHEBusiness()) {
        self.provider = provider
        self.business = business
        super.init()
    }
    
    // MARK: - Public Methods
    
    func fetchUssers(completion: @escaping GHEGetUssersCompletion) {
        cancelAllOperations()
        let operation = GHEOperation(provider: provider, business: business, completion: completion)
        addOperation(operation)
    }
}
