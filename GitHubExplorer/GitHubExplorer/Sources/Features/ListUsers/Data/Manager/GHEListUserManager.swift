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
}
