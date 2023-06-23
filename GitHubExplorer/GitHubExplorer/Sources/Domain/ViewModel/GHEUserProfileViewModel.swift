//
//  GHEUserProfileViewModel.swift
//  GitHubExplorer
//
//  Created by Danilo Carlos Ribeiro on 23/06/23.
//  Copyright © 2023 GitHubExplorer. All rights reserved.
//

import CoreSwift
import Foundation

protocol GHEUserProfileViewModelProtocol {
    var model: GHEResponse? { get }
    var listRepository: GHEResponse? { get }
    
    init(model: GHEResponse?)
}

class GHEUserProfileViewModel: GHEUserProfileViewModelProtocol {
    var model: GHEResponse?
    var listRepository: GHEResponse?
    
    required init(model: GHEResponse?) {
        self.model = model
    }
}
