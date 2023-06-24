//
//  GHE.swift
//  GitHubExplorer
//
//  Created by Danilo Carlos Ribeiro on 24/06/23.
//  Copyright © 2023 GitHubExplorer. All rights reserved.
//

import CoreSwift
import Foundation

typealias GHEGetRepositorysCompletion = (Result<[GHEListRepositoryResponse], Error>) -> Void

protocol GHEUserProfileManagerProtocol {
    func getRepositorys(completion: @escaping GHEGetRepositorysCompletion)
}

class GHEUserProfileManager: BaseManager, GHEUserProfileManagerProtocol {
    
}
