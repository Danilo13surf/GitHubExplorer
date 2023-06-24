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
    case popToRoot
}

protocol GHEListUsersViewModelProtocol {
    var status: Dynamic<GHEListUsersStatus?> { get }
    var model: [GHEResponse]? { get }
    var filteredModel: [GHEResponse]? { get }
    var listRepository: GHEResponse? { get }
    var bottomSheetViewModel: BottomSheetViewModelProtocol? { get }
    
    init(manager: GHEListUserManagerProtocol?, showNextFlow: @escaping GHENextFlow)
    
    func showMoreInfo(model: GHEResponse?)
    func filterUsers(byLogin login: String)
    func clearFilter()
    func fetchUssers()
}

class GHEListUsersViewModel: GHEListUsersViewModelProtocol {
    
    // MARK: - Properties
    private var manager: GHEListUserManagerProtocol?
    var filteredModel: [GHEResponse]?
    var status = Dynamic<GHEListUsersStatus?>(.loading)
    var model: [GHEResponse]?
    var listRepository: GHEResponse?
    var showNextFlow: GHENextFlow
    var bottomSheetViewModel: BottomSheetViewModelProtocol?
    
    // MARK: - Initialize
    required init(manager: GHEListUserManagerProtocol? = GHEListUserManager(), showNextFlow: @escaping GHENextFlow) {
        self.manager = manager
        self.showNextFlow = showNextFlow
        self.setupBottonSheetViewModel()
    }
    
    // MARK: - Open Methods
    func fetchUssers() {
        updateStatus(status: .loading)
        manager?.fetchUssers { [weak self] result in
            switch result {
            case .success(let model):
                self?.model = model
                self?.updateStatus(status: .loaded)
                return
            case .failure:
                self?.updateStatus(status: .error)
                return
            }
        }
    }
    
    func showMoreInfo(model: GHEResponse?) {
        self.showNextFlow(model)
    }
    
    func filterUsers(byLogin login: String) {
        if login == String() {
            clearFilter()
            return
        }
        filteredModel = model?.filter { $0.login?.range(of: login, options: .caseInsensitive) != nil }
        updateStatus(status: .loaded)
    }

    func clearFilter() {
        filteredModel = nil
        updateStatus(status: .loaded)
    }

    // MARK: - Private Methods
    private func updateStatus(status: GHEListUsersStatus) {
        self.status.value = status
    }
    
    private func setupBottonSheetViewModel() {
        self.bottomSheetViewModel = BottomSheetViewModel(model: setupBottonSheetModel(), primaryButtonFlow: primaryButtonFlow, rigthButtonFlow: rigthButtonFlow)
    }
    
    private func setupBottonSheetModel() -> BottomSheetModel {
        return BottomSheetModel(title: GHEConstants.Constants.alertMessage, description: GHEConstants.Constants.alertDescription, primaryButtonName: GHEConstants.Constants.primaryButtonText)
    }
    
    private func primaryButtonFlow() {
        self.fetchUssers()
    }
    
    private func rigthButtonFlow() {
        updateStatus(status: .popToRoot)
    }
}
