//
//  GHEListUsersViewModel.swift
//  GitHubExplorer
//
//  Created by Danilo Carlos Ribeiro on 23/06/23.
//  Copyright © 2023 GitHubExplorer. All rights reserved.
//

import CoreSwift
import Foundation

typealias GHENextFlow = (_ model: GHEResponse?) -> Void

enum GHEListUsersStatus {
    case loading
    case loaded
    case error
}

protocol GHEListUsersViewModelProtocol {
    var status: Dynamic<GHEListUsersStatus?> { get }
    var model: [GHEResponse]? { get }
    var listRepository: GHEResponse? { get }
    
    init(manager: GHEListUserManagerProtocol?, showNextFlow: @escaping GHENextFlow)
    
    func showMoreInfo(model: GHEResponse?)
    func fetchUssers()
}

class GHEListUsersViewModel: GHEListUsersViewModelProtocol {
    
    // MARK: - Properties
    private var manager: GHEListUserManagerProtocol?
    var status = Dynamic<GHEListUsersStatus?>(.loading)
    var model: [GHEResponse]?
    var listRepository: GHEResponse?
    var showNextFlow: GHENextFlow
    
    // MARK: - Initialize
    required init(manager: GHEListUserManagerProtocol? = GHEListUserManager(), showNextFlow: @escaping GHENextFlow) {
        self.manager = manager
        self.showNextFlow = showNextFlow
    }
    
    // MARK: - Open Methods
    func fetchUssers() {
        updateStatus(status: .loading)
        manager?.fetchUssers { [weak self] result in
            switch result {
            case .success(let model):
                self?.model = model
                self?.updateStatus(status: .loaded)
            case .failure:
                break
            }
            self?.updateStatus(status: .loaded)
        }
    }
    
    func showMoreInfo(model: GHEResponse?) {
        self.showNextFlow(model)
    }
    
    // MARK: - Private Methods
    private func updateStatus(status: GHEListUsersStatus) {
        self.status.value = status
    }
}
