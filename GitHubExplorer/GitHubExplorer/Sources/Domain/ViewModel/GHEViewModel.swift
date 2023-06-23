//
//  GHEViewModel.swift
//  GitHubExplorer
//
//  Created by Danilo Carlos Ribeiro on 23/06/23.
//  Copyright © 2023 GitHubExplorer. All rights reserved.
//

import CoreSwift
import Foundation

typealias GHENextFlow = (_ model: GHEListRepositoryResponse?) -> Void

enum GHEStatus {
    case loading
    case loaded
    case error
}

protocol GHEViewModelProtocol {
    var status: Dynamic<GHEStatus?> { get }
    var model: [GHEResponse]? { get }
    var listRepository: GHEListRepositoryResponse? { get }
    
    init(manager: GHEManagerProtocol?, showNextFlow: @escaping GHENextFlow)
    
    func fetchUssers()
}

class GHEViewModel: GHEViewModelProtocol {
    
    // MARK: - Properties
    private var manager: GHEManagerProtocol?
    var status = Dynamic<GHEStatus?>(.loading)
    var model: [GHEResponse]?
    var listRepository: GHEListRepositoryResponse?
    var showNextFlow: GHENextFlow
    
    // MARK: - Initialize
    required init(manager: GHEManagerProtocol? = GHEManager(), showNextFlow: @escaping GHENextFlow) {
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
    
    // MARK: - Private Methods
    private func updateStatus(status: GHEStatus) {
        self.status.value = status
    }
}