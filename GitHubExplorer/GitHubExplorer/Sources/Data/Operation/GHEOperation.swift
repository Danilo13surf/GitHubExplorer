//
//  GHEOperation.swift
//  GitHubExplorer
//
//  Created by Danilo Carlos Ribeiro on 23/06/23.
//  Copyright © 2023 GitHubExplorer. All rights reserved.
//

import CoreSwift
import Foundation

class GHEOperation: NetworkingOperation {
    
    // MARK: - Properties
    private let business: GHEBusinessProtocol?
    private let completion: GHEGetUssersCompletion
    
    // MARK: Initialize
    init(provider: ApiProviderProtocol? = nil, business: GHEBusinessProtocol?, completion: @escaping GHEGetUssersCompletion) {
        self.business = business
        self.completion = completion
        super.init(provider: provider)
    }
    
    // MARK: - Override Methods
    override func main() {
        super.main()
        provider?.baseRequest(requestData: buildRequestData()) { [weak self] result in
            guard let self = self else { return }
            self.business?.handleUssersGet(result: result, completion: self.completion)
            self.finish()
        }
    }
    
    // MARK: - Private Methods
    private func buildRequestData() -> NetworkingRequestData {
        return NetworkingRequestData(url: GHEConstants.GHEPathApi().users,
                                     httpMethod: .get,
                                     isAuthenticated: true)
    }
}
