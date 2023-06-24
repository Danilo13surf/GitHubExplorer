//
//  GHEUserProfileViewModel.swift
//  GitHubExplorer
//
//  Created by Danilo Carlos Ribeiro on 23/06/23.
//  Copyright © 2023 GitHubExplorer. All rights reserved.
//

import CoreSwift
import Foundation

enum GHEUserProfileStatus {
    case loading
    case loaded
    case error
    case popToRoot
}

protocol GHEUserProfileViewModelProtocol {
    var status: Dynamic<GHEUserProfileStatus?> { get }
    var model: GHEResponse? { get }
    var listRepository: [GHEListRepositoryResponse]? { get }
    var bottomSheetViewModel: BottomSheetViewModelProtocol? { get }
    var isDisplayingRepository: Dynamic<Bool> { get }
    
    init(manager: GHEUserProfileManagerProtocol?, model: GHEResponse?)
    
    func numberOfSections() -> Int
}

class GHEUserProfileViewModel: GHEUserProfileViewModelProtocol {
    
    // MARK: - Constants
    private enum Constants {
        static let iconClose: String = "icon_close"
        static let primaryButtonText: String = "Tentar novamente"
        static let alertMessage: String = "Error"
        static let alertDescription: String = "Erro ao buscar os dados!"
    }
    
    // MARK: - Properties
    private var manager: GHEUserProfileManagerProtocol?
    var status = Dynamic<GHEUserProfileStatus?>(.loading)
    var model: GHEResponse?
    var listRepository: [GHEListRepositoryResponse]?
    var isDisplayingRepository = Dynamic<Bool>(false)
    var bottomSheetViewModel: BottomSheetViewModelProtocol?
    
    // MARK: - Initialize
    required init(manager: GHEUserProfileManagerProtocol? = GHEUserProfileManager(), model: GHEResponse?) {
        self.manager = manager
        self.model = model
        setupBottonSheetViewModel()
        getRepositorys()
    }
    
    // MARK: - Open Methods
    func numberOfSections() -> Int {
        return self.isDisplayingRepository.value ? 2 : 1
    }
    
    // MARK: - Private Methods
    private func getRepositorys() {
        updateStatus(status: .loading)
        manager?.getRepositorys(user: model?.login) { [weak self] result in
            switch result {
            case .success(let model):
                self?.listRepository = model
                self?.updateStatus(status: .loaded)
                return
            case .failure:
                self?.updateStatus(status: .error)
                return
            }
        }
    }
    
    private func updateStatus(status: GHEUserProfileStatus) {
        self.status.value = status
    }
    
    private func setupBottonSheetViewModel() {
        self.bottomSheetViewModel = BottomSheetViewModel(model: setupBottonSheetModel(), primaryButtonFlow: primaryButtonFlow, rigthButtonFlow: rigthButtonFlow)
    }
    
    private func setupBottonSheetModel() -> BottomSheetModel {
        return BottomSheetModel(title: Constants.alertMessage, description: Constants.alertDescription, primaryButtonName: Constants.primaryButtonText)
    }
    
    private func primaryButtonFlow() {
        self.getRepositorys()
    }
    
    private func rigthButtonFlow() {
        updateStatus(status: .popToRoot)
    }
}
