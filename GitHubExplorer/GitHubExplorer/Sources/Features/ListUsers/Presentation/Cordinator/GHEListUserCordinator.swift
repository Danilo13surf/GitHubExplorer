//
//  GHEListUserCordinator.swift
//  GitHubExplorer
//
//  Created by Danilo Carlos Ribeiro on 23/06/23.
//  Copyright © 2023 GitHubExplorer. All rights reserved.
//

import UIKit

public class GHEListUserCordinator {
    
    // MARK: - Properties
    private var navigationController: UINavigationController?

    // MARK: - Initialize
    
    public init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    // MARK: - Public Methods
    
    public func start() {
        let viewModel = GHEListUsersViewModel(showNextFlow: showNextFlow)
        guard let viewController = GHEListUsersViewController.instantiate(viewModel: viewModel) else { return }
        viewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    // MARK: - Private Methods
    private func showNextFlow(model: GHEUserResponse?) {
        let coordinator = GHEUserProfileCordinator(navigationController: navigationController)
           coordinator.start(model: model)
    }
}
