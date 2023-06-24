//
//  GHEListRepositorysOperation.swift
//  GitHubExplorer
//
//  Created by Danilo Carlos Ribeiro on 24/06/23.
//  Copyright © 2023 GitHubExplorer. All rights reserved.
//

import CoreSwift
import Foundation

class GHEListRepositorysOperation: NetworkingOperation {
    
    // MARK: - Properties
    private let business: GHEUserProfileBussinesProtocol?
    private let completion: GHEGetRepositorysCompletion
    private let user: String?
    private var urlPath: String {
        return String(format: GHEConstants.GHEPathApi().repos, user ?? String())
    }
    
    // MARK: Initialize
    init(user: String?, provider: ApiProviderProtocol? = nil, business: GHEUserProfileBussinesProtocol?, completion: @escaping GHEGetRepositorysCompletion) {
        self.user = user
        self.business = business
        self.completion = completion
        super.init(provider: provider)
    }
    
    // MARK: - Override Methods
    override func main() {
        super.main()
        provider?.baseRequest(requestData: buildRequestData()) { [weak self] result in
            guard let self = self else { return }
            self.business?.handleRepositorysGet(result: result, completion: self.completion)
            self.finish()
        }
    }
    
    // MARK: - Private Methods
    private func buildRequestData() -> NetworkingRequestData {
        return NetworkingRequestData(url: GHEConstants.GHEPathApi().users,
        return NetworkingRequestData(url: urlPath,
                                     httpMethod: .get,
                                     isAuthenticated: true)
    }
}
