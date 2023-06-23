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
    var listRepository: [GHEResponse]? { get }
    var isDisplayingRepository: Dynamic<Bool> { get }
    
    init(model: GHEResponse?)
    
    func numberOfSections() -> Int
}

class GHEUserProfileViewModel: GHEUserProfileViewModelProtocol {
    
    // MARK: - Properties
    var model: GHEResponse?
    var listRepository: [GHEResponse]?
    var isDisplayingRepository = Dynamic<Bool>(false)
    
    // MARK: - Initialize
    required init(model: GHEResponse?) {
        self.model = model
    }
    
    // MARK: - Open Methods
    func numberOfSections() -> Int {
        return self.isDisplayingRepository.value ? 2 : 1
    }
}
